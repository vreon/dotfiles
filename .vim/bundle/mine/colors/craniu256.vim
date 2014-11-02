" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	craniu <From Reddit>
" Last Change:	2011 February 11
" 256 color terminal only

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "craniu256"

hi Normal         ctermbg=232  ctermfg=250   cterm=none
hi SpecialKey     ctermbg=232  ctermfg=176   cterm=none
hi VertSplit      ctermbg=232  ctermfg=227   cterm=none
hi SignColumn     ctermbg=232  ctermfg=141   cterm=none
hi NonText        ctermbg=232  ctermfg=204   cterm=none
hi Directory      ctermbg=232  ctermfg=227   cterm=none 
hi Title          ctermbg=232  ctermfg=84    cterm=bold

" -> Cursor 
hi Cursor         ctermbg=227  ctermfg=232   cterm=none
hi CursorIM       ctermbg=227  ctermfg=232   cterm=none
hi CursorColumn   ctermbg=235                cterm=none
hi CursorLine     ctermbg=235                cterm=none

" -> Folding
hi FoldColumn     ctermbg=232  ctermfg=25    cterm=none
hi Folded         ctermbg=232  ctermfg=25    cterm=none

" -> Line info  
hi LineNr         ctermbg=0    ctermfg=240   cterm=none
hi StatusLine     ctermbg=0    ctermfg=241   cterm=none
hi StatusLineNC   ctermbg=237  ctermfg=241   cterm=none

" -> Messages
hi ErrorMsg       ctermbg=124  ctermfg=252   cterm=none
hi Question       ctermbg=232  ctermfg=214   cterm=none
hi WarningMsg     ctermbg=214  ctermfg=0     cterm=none
hi MoreMsg        ctermbg=232  ctermfg=214   cterm=none
hi ModeMsg        ctermbg=232  ctermfg=214   cterm=none

" -> Search 
hi Search         ctermbg=241  ctermfg=227   cterm=none 
hi IncSearch      ctermbg=241  ctermfg=227   cterm=none

" -> Diff
hi DiffAdd        ctermbg=22   ctermfg=208   cterm=none
hi DiffChange     ctermbg=235  ctermfg=130   cterm=none
hi DiffDelete     ctermbg=232  ctermfg=208   cterm=none
hi DiffText       ctermbg=24   ctermfg=208   cterm=underline

" -> Menu
hi Pmenu          ctermbg=0    ctermfg=52    cterm=none
hi PmenuSel       ctermbg=208  ctermfg=52    cterm=none
hi PmenuSbar      ctermbg=52                 cterm=none
hi PmenuThumb     ctermbg=52                 cterm=none
hi PmenuSel       ctermbg=208  ctermfg=52    cterm=none

" -> Tabs
hi TabLine        ctermbg=000  ctermfg=240   cterm=underline
hi TabLineFill    ctermbg=000  ctermfg=240   cterm=underline
hi TabLineSel     ctermbg=240  ctermfg=252   cterm=bold 
"
" -> Visual Mode
hi Visual         ctermbg=208  ctermfg=232   cterm=none 
hi VisualNOS      ctermbg=0    ctermfg=208   cterm=none

" -> Code
hi Comment        ctermbg=232  ctermfg=240   cterm=bold
hi Constant       ctermbg=232  ctermfg=208   cterm=bold
hi String         ctermbg=232  ctermfg=136   cterm=none
hi Error          ctermbg=232  ctermfg=203   cterm=none
hi Identifier     ctermbg=232  ctermfg=106   cterm=bold
hi Function       ctermbg=232  ctermfg=108   cterm=bold
hi Ignore         ctermbg=232  ctermfg=232   cterm=none
hi MatchParen     ctermbg=214  ctermfg=232   cterm=bold
hi PreProc        ctermbg=232  ctermfg=229   cterm=bold
hi Special        ctermbg=232  ctermfg=228   cterm=none
hi Todo           ctermbg=232  ctermfg=203   cterm=bold
hi Underlined     ctermbg=232  ctermfg=203   cterm=underline
hi Statement      ctermbg=232  ctermfg=220   cterm=bold
hi Operator       ctermbg=232  ctermfg=193   cterm=bold
hi Delimiter      ctermbg=232  ctermfg=095   cterm=bold
hi Type           ctermbg=232  ctermfg=58    cterm=bold
hi Exception      ctermbg=232  ctermfg=210   cterm=bold 

" -> HTML-specific
hi htmlBold                 ctermbg=232  ctermfg=252   cterm=bold
hi htmlBoldItalic           ctermbg=232  ctermfg=252   cterm=bold,italic
hi htmlBoldUnderline        ctermbg=232  ctermfg=252   cterm=bold,underline
hi htmlBoldUnderlineItalic  ctermbg=232  ctermfg=252   cterm=bold,underline,italic
hi htmlItalic               ctermbg=232  ctermfg=252   cterm=italic
hi htmlUnderline            ctermbg=232  ctermfg=252   cterm=underline
hi htmlUnderlineItalic      ctermbg=232  ctermfg=252   cterm=underline,italic
