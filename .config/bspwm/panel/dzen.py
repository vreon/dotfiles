#!/usr/bin/env python

import io
import os
import sys
from contextlib import contextmanager

FG = WHITE = '#D0D0D0'
BG = BLACK = '#101010'
RED = '#960050'
GREEN = '#66AA11'
YELLOW = '#C47F2C'
BLUE = '#30309B'
MAGENTA = '#7E40A5'
CYAN = '#3579A8'
LIGHTGRAY = '#9999AA'
DARKGRAY = '#303030'
BRIGHTRED = '#FF0090'
BRIGHTGREEN = '#80FF00'
BRIGHTYELLOW = '#FFBA68'
BRIGHTBLUE = '#5F5FEE'
BRIGHTMAGENTA = '#BB88DD'
BRIGHTCYAN = '#4EB4FA'

FONT_FAMILY = 'Fantasque Sans Mono'
FONT_SIZE = 9
FONT_CHAR_WIDTH = 8  # determined experimentally >_>

REGULAR = '%s-%d' % (FONT_FAMILY, FONT_SIZE)
BOLD = REGULAR + ':Bold'

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ICON_DIR = os.path.join(BASE_DIR, 'icons')

def _icon(name, ext='xbm'):
    return '^i(%s)' % os.path.join(ICON_DIR, '%s.%s' % (name, ext))

def _color(str_, color):
    return '^fg(%s)%s^fg()' % (color, str_)

def _bg_color(str_, color):
    return '^bg(%s)%s^bg()' % (color, str_)

def _font(str_, font):
    return '^fn(%s)%s^fn(%s)' % (font, str_, REGULAR)

def _clickable(str_, button, cmd):
    return '^ca(%d,%s)%s^ca()' % (button, cmd, str_)

class Bar(object):
    LEFT = 0
    RIGHT = 1

    def __init__(self, widgets=[]):
        self.widgets = {
            self.LEFT: [],
            self.RIGHT: [],
        }

        self._prefix_to_widgets = {}
        self._default_side = Bar.LEFT

        for widget, side in widgets:
            self.add_widget(widget, side)

    @contextmanager
    def select_side(self, side):
        original_side = self._default_side
        self._default_side = side
        yield
        self._default_side = original_side

    def add_widget(self, widget, side=None):
        if side is None:
            side = self._default_side
        if widget.prefix:
            self._prefix_to_widgets.setdefault(widget.prefix, []).append(widget)
        self.widgets[side].append(widget)

    def update(self, line):
        line = line.strip()
        for prefix, widgets in self._prefix_to_widgets.items():
            if line.startswith(prefix):
                for widget in widgets:
                    widget.update(line[len(prefix):])

    def render(self):
        rendered = []

        for widget in self.widgets[self.LEFT]:
            rendered.append(widget.render())

        right_width = 0
        right_rendered = []
        for widget in self.widgets[self.RIGHT]:
            right_rendered.append(widget.render())
            right_width += widget.width

        right_width += FONT_CHAR_WIDTH  # ???

        rendered.append(
            '^p(_RIGHT)^p(-%d)%s' % (right_width, ''.join(right_rendered))
        )

        return ''.join(rendered) + '\n'


class Widget(object):
    prefix = None

    def __init__(self):
        self.width = 0

    def update(self, line):
        pass

    def render(self):
        return ''


class TextWidget(Widget):
    """Display plain text."""
    def __init__(self, text, color=WHITE):
        self.text = text
        self.color = color
        self.width = len(self.text) * FONT_CHAR_WIDTH

    def render(self):
        return _color(self.text, self.color)


class EchoWidget(TextWidget):
    """Display plain text that updates periodically."""
    def __init__(self, prefix, color, icon=None, max_length=None):
        self.color = color
        self.prefix = prefix
        self.max_length = max_length
        self.icon = icon
        self.update('')

    def update(self, line):
        if self.max_length and len(line) > self.max_length:
            line = line[:(self.max_length - 3)] + '...'

        self.width = len(line) * FONT_CHAR_WIDTH
        self.text = line

        if self.icon:
            self.width += FONT_CHAR_WIDTH + 8
            self.text = '%s %s' % (_icon(self.icon), self.text)


class MusicWidget(Widget):
    """Display plain text that updates periodically."""
    prefix = 'M'

    def __init__(self, max_length=None):
        self.max_length = max_length
        self.update('')

    def update(self, line):
        if self.max_length and len(line) > self.max_length:
            line = line[:(self.max_length - 3)] + '...'

        self.width = len(line) * FONT_CHAR_WIDTH + 8
        self.text = line

        if self.text:
            self.width += FONT_CHAR_WIDTH

    def render(self):
        space = ''
        color = DARKGRAY

        if self.text:
            space = ' '
            color = MAGENTA

        return _color(_icon('phones') + space + self.text, color)


class UpdatesWidget(Widget):
    """Display number of outdated packages."""
    prefix = 'U'

    def __init__(self):
        self.update('0')

    def update(self, line):
        self.width = (len(line) + 1) * FONT_CHAR_WIDTH + 8
        self.num_updates = int(line)

    def render(self):
        color = BRIGHTCYAN if self.num_updates else DARKGRAY
        return _color('%s %s' % (_icon('pacman'), self.num_updates), color)


class DiskUsageWidget(Widget):
    """Display percentage of root partition used."""
    prefix = 'D'

    def __init__(self):
        self.update('0%')

    def update(self, line):
        self.width = (len(line) + 1) * FONT_CHAR_WIDTH + 8
        self.percentage = line

    def render(self):
        return _color('%s %s' % (_icon('hdd'), self.percentage), DARKGRAY)


class GliderWidget(Widget):
    """Display a pretty glider icon."""
    def __init__(self):
        self.width = (FONT_CHAR_WIDTH * 4) + 8

    def render(self):
        icon = _color(_icon('glider'), WHITE)
        return _bg_color(' %s ' % icon, MAGENTA)


class WorkspacesWidget(Widget):
    """Display bspwm workspaces."""
    prefix = 'W'

    STATE_COLOR = {
        'O': MAGENTA,
        'F': MAGENTA,
        'U': MAGENTA,
        'o': LIGHTGRAY,
        'f': DARKGRAY,
        'u': BRIGHTRED,
    }

    def __init__(self):
        self.desktops = []
        self.width = 0

    @classmethod
    def _render_desktop(cls, name, state):
        return _clickable(
            _color(_icon('big/square_workspace'), cls.STATE_COLOR[state]),
            1, 'bspc desktop -f %s' % name
        )

    def update(self, line):
        bits = line.split(':')
        self.desktops = [
            (bit[1:], bit[0])
            for bit in line.split(':')
            if bit.startswith(('O', 'o', 'F', 'f', 'U', 'u'))
        ]
        self.width = len(self.desktops) * 13

    def render(self):
        rendered = ''.join(
            self._render_desktop(name, state)
            for name, state in self.desktops
        )
        return _clickable(
            _clickable(
                rendered,
                4, 'bspc desktop -f prev'
            ),
            5, 'bspc desktop -f next'
        )


class LayoutWidget(Widget):
    """Display bspwm layout."""
    prefix = 'W'

    def __init__(self):
        self.width = FONT_CHAR_WIDTH
        self.layout = '?'

    def update(self, line):
        bits = line.split(':')
        for bit in bits:
            if bit.startswith('L'):
                self.layout = bit[1]

    def render(self):
        return _clickable(
            _color(self.layout, DARKGRAY),
            1, 'bspc desktop -l next'
        )


def main():
    space = TextWidget(' ')
    separator = TextWidget('  ')

    bar = Bar()

    with bar.select_side(Bar.LEFT):
        bar.add_widget(space)
        bar.add_widget(GliderWidget())
        bar.add_widget(space)
        bar.add_widget(WorkspacesWidget())
        # bar.add_widget(space)
        # bar.add_widget(LayoutWidget())  # Not actually all that useful...
        bar.add_widget(separator)
        bar.add_widget(EchoWidget('T', DARKGRAY, max_length=60))

    with bar.select_side(Bar.RIGHT):
        bar.add_widget(MusicWidget(max_length=60))
        bar.add_widget(separator)
        bar.add_widget(DiskUsageWidget())
        bar.add_widget(separator)
        bar.add_widget(UpdatesWidget())
        bar.add_widget(separator)
        bar.add_widget(EchoWidget('S', LIGHTGRAY, icon='clock'))
        bar.add_widget(space)

    for line in io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8'):
        bar.update(line)
        sys.stdout.write(bar.render())
        sys.stdout.flush()


if __name__ == '__main__':
    main()