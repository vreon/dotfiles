" Malachite
" 16-color scheme for vim, loosely based on molokai.
"
" Author: Jesse Dubay <jesse@jessedubay.com>

set background=dark
hi clear
syntax reset

let g:colors_name = "malachite"

hi Boolean         ctermfg=5
hi Character       ctermfg=11
hi ColorColumn                  ctermbg=8
hi Comment         ctermfg=8
hi Conditional     ctermfg=1                 cterm=bold
hi Constant        ctermfg=6
hi Cursor          ctermfg=0    ctermbg=15
hi CursorColumn                 ctermbg=0
hi CursorLine                   ctermbg=0    cterm=none
hi CursorLine                   ctermbg=0    cterm=none
hi Debug           ctermfg=5                 cterm=bold
hi Define          ctermfg=14
hi Delimiter       ctermfg=8
hi DiffAdd         ctermfg=2    ctermbg=0
hi DiffChange      ctermfg=3    ctermbg=0
hi DiffDelete      ctermfg=1    ctermbg=0
hi DiffText        ctermfg=3    ctermbg=0    cterm=none
hi Directory       ctermfg=10                cterm=bold
hi Error           ctermfg=15   ctermbg=1
hi ErrorMsg        ctermfg=15   ctermbg=1    cterm=bold
hi Exception       ctermfg=10                cterm=bold
hi Float           ctermfg=5
hi FoldColumn      ctermfg=4    ctermbg=0
hi Folded          ctermfg=4    ctermbg=0
hi Function        ctermfg=10
hi Identifier      ctermfg=11                cterm=none
hi Ignore          ctermfg=7    ctermbg=0
hi IncSearch       ctermfg=3    ctermbg=0
hi Keyword         ctermfg=1                 cterm=bold
hi Label           ctermfg=11                cterm=none
hi LineNr          ctermfg=8
hi Macro           ctermfg=6
hi MatchParen      ctermfg=11   ctermbg=16   cterm=bold
hi ModeMsg         ctermfg=11
hi MoreMsg         ctermfg=11
hi NonText         ctermfg=7
hi Normal          ctermfg=15
hi Number          ctermfg=5
hi Operator        ctermfg=1                 cterm=bold
hi Pmenu           ctermfg=7    ctermbg=8
hi PmenuSbar                    ctermbg=8
hi PmenuSel        ctermfg=15   ctermbg=4    cterm=bold
hi PmenuThumb      ctermfg=7
hi PreCondit       ctermfg=10                cterm=bold
hi PreProc         ctermfg=10
hi Question        ctermfg=14
hi Repeat          ctermfg=1                 cterm=bold
hi Search          ctermfg=0    ctermbg=11
hi SignColumn      ctermfg=10   ctermbg=none
hi Special         ctermfg=14
hi SpecialChar     ctermfg=1                 cterm=bold
hi SpecialComment  ctermfg=8                 cterm=bold
hi SpecialKey      ctermfg=12
hi SpecialKey      ctermfg=14
hi Statement       ctermfg=1                 cterm=bold
hi StatusLine      ctermfg=8    ctermbg=7
hi StatusLineNC    ctermfg=0    ctermbg=8
hi StorageClass    ctermfg=11
hi String          ctermfg=11
hi Structure       ctermfg=14
hi Tag             ctermfg=1
hi Title           ctermfg=3
hi Todo            ctermfg=0    ctermbg=11
hi Type            ctermfg=14                cterm=none
hi Typedef         ctermfg=14
hi Underlined      ctermfg=7                 cterm=underline
hi VertSplit       ctermfg=0                 cterm=bold
hi Visual          ctermfg=15   ctermbg=4
hi WarningMsg      ctermfg=11
hi WildMenu        ctermfg=14   ctermbg=0
