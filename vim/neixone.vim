let s:cyan = '#56b6c2'
let s:blue = '#61afef'
let s:dark_blue = '#3e4452'
let s:purple = '#c678dd'
let s:green = '#98c379'
let s:red = '#e06c75'
let s:dark_red = '#be5046'
let s:orange = '#d19a66'
let s:dark_orange = '#e5c07b'
let s:black = '#282c34'
let s:pure_black = "#000000"
let s:white = '#abb2bf'
let s:gray = "#c0c0c0"
let s:pure_white = '#ffffff'
let s:silver = '#C0C0C0'

function! crystalline#theme#neixone#set_theme() abort
    if &background ==# 'dark'
        call crystalline#generate_theme({
            \ 'NormalMode':  [[235, 114], [s:pure_black, s:green]],
            \ 'InsertMode':  [[235, 39],  [s:pure_black, s:blue]],
            \ 'VisualMode':  [[235, 170], [s:pure_black, s:purple]],
            \ 'ReplaceMode': [[235, 204], [s:pure_black, s:blue]],
            \ '':            [[145, 236], [s:pure_white, s:dark_blue]],
            \ 'Inactive':    [[235, 145], [s:pure_black, s:white]],
            \ 'Fill':        [[114, 236], [s:pure_black, s:silver]],
            \ 'Tab':         [[145, 236], [s:pure_white, s:black]],
            \ 'TabType':     [[235, 170], [s:pure_black, s:purple]],
            \ 'TabSel':      [[235, 114], [s:pure_black, s:green]],
            \ 'TabFill':     [[114, 236], [s:pure_white, s:dark_blue]],
            \ })
    else
        call crystalline#generate_theme({
            \ 'NormalMode':  [[235, 114], [s:pure_black, s:green]],
            \ 'InsertMode':  [[235, 39],  [s:pure_black, s:blue]],
            \ 'VisualMode':  [[235, 170], [s:pure_black, s:purple]],
            \ 'ReplaceMode': [[235, 204], [s:pure_black, s:blue]],
            \ '':            [[145, 236], [s:pure_white, s:dark_blue]],
            \ 'Inactive':    [[235, 145], [s:pure_black, s:white]],
            \ 'Fill':        [[114, 236], [s:pure_white, s:pure_black]],
            \ 'Tab':         [[145, 236], [s:pure_white, s:black]],
            \ 'TabType':     [[235, 170], [s:pure_black, s:purple]],
            \ 'TabSel':      [[235, 114], [s:pure_black, s:green]],
            \ 'TabFill':     [[114, 236], [s:pure_white, s:dark_blue]],
            \ })
    endif
endfunction

" vim:set et sw=2 ts=2 fdm=marker:
