let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/AppData/Local/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +143 init.vim
badd +1 ./
argglobal
%argdel
$argadd ./
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit init.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
3wincmd h
wincmd w
wincmd w
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 39 + 106) / 213)
exe '2resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 59 + 106) / 213)
exe '3resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 79 + 106) / 213)
exe '4resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 33 + 106) / 213)
exe '5resize ' . ((&lines * 35 + 25) / 50)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
131
normal! zo
142
normal! zo
let s:l = 180 - ((18 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 180
normal! 02|
wincmd w
argglobal
if bufexists(fnamemodify("init.vim", ":p")) | buffer init.vim | else | edit init.vim | endif
if &buftype ==# 'terminal'
  silent file init.vim
endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
131
normal! zo
142
normal! zo
let s:l = 162 - ((0 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 162
normal! 02|
wincmd w
argglobal
if bufexists(fnamemodify("init.vim", ":p")) | buffer init.vim | else | edit init.vim | endif
if &buftype ==# 'terminal'
  silent file init.vim
endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
131
normal! zo
142
normal! zo
let s:l = 162 - ((23 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 162
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("init.vim", ":p")) | buffer init.vim | else | edit init.vim | endif
if &buftype ==# 'terminal'
  silent file init.vim
endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
131
normal! zo
142
normal! zo
let s:l = 162 - ((23 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 162
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("init.vim", ":p")) | buffer init.vim | else | edit init.vim | endif
if &buftype ==# 'terminal'
  silent file init.vim
endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
81
normal! zo
82
normal! zo
131
normal! zo
142
normal! zo
181
normal! zo
199
normal! zo
239
normal! zo
let s:l = 162 - ((31 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 162
normal! 024|
wincmd w
5wincmd w
exe '1resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 39 + 106) / 213)
exe '2resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 59 + 106) / 213)
exe '3resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 79 + 106) / 213)
exe '4resize ' . ((&lines * 11 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 33 + 106) / 213)
exe '5resize ' . ((&lines * 35 + 25) / 50)
tabnext
argglobal
enew
balt init.vim
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
