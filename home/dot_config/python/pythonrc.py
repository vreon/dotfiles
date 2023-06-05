#!/usr/bin/env python

import sys
import os
import atexit

# color prompt
# sys.ps1 = '\001\033[1;36m\002>>> \001\033[0m\002'

# version prompt
sys.ps1 = "%d.%d>>> " % (sys.version_info.major, sys.version_info.minor)

# tab completion
try:
    import readline
except ImportError:
    # Silently ignore missing readline module
    pass
else:
    import rlcompleter

    readline.parse_and_bind("tab: complete")

# history
histfile = os.path.join(os.environ["HOME"], ".python_history")
try:
    readline.read_history_file(histfile)
except Exception:
    pass


def _write_history_file(histfile):
    try:
        readline.write_history_file(histfile)
    except Exception:
        pass


atexit.register(_write_history_file, histfile)
del os, histfile
