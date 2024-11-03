
# Vim Notes

## Links

- <https://thevaluable.dev/vim-advanced/>
- <https://vim.rtorr.com/>
- <https://github.com/gnperdue/CheatSheets/blob/master/VIM.markdown>
- <https://stackoverflow.com/questions/1694392/vim-store-output-of-external-command-into-a-register>
- <https://vi.stackexchange.com/questions/4307/multiple-cursors-at-desired-location>
- <https://vi.stackexchange.com/questions/29603/how-to-multi-select-for-the-purpose-of-copy-operation>
- <https://stackoverflow.com/questions/19883917/execute-current-line-in-bash-from-vim>
- <https://www.reddit.com/r/vim/comments/6uvu5w/how_are_you_using_autocomplete_and_snippets/>

## Thoughts

- [ ] Learn Vim
  - [x] Tasks
  - [ ] Snippets
    - [ ] Replace without variables
      - [ ] Only Variables is Selected Text
  - [x] Search and Replace
    - [x] `:g/.*name.*/ norm @a`
  - [x] Multi-Cursor
  - [x] Code Macros
    - [x] Using Bash
    - [x] `https://www.reddit.com/r/vim/comments/otnba9/how_do_i_build_custom_text_filterstransformations/`
  - [x] Getting Used to Vim
  - [x] Search and Select all Words (Multi Cursor)
    - [x] `cgn`
    - [x] Use Macros
    - [x] :global/foo/yank C <https://vi.stackexchange.com/questions/29603/how-to-multi-select-for-the-purpose-of-copy-operation>
- [x] VimGolf
  - [ ] `:g/f/,+3m0<CR>@:ZZ` Move 3 Lines to Top
  - [ ] `Ctrl V` to Move Lines then Prepend (Multi-Cursor!!!) (Can't Edit in Real Time Though)
  - [ ] `d/<term><CR>` This is to delete to that character (Multi-Line)
  - [ ] `*`, `#` to Select Character (Similar to `F2`)
  - [ ] `/`, `?` to find characters from top or bottom
  - [ ] <https://github.com/bkbncn/VimGolf-solutions>
  - [ ] Select All Non-Empty Lines
    - [ ] `:g/./norm I*`
    - [ ] `:%s/\v(^.)/*\1/g`
    - [ ] `:%s/^\ze./*`
    - [ ] `:%s/^./*&/`
    - [ ] `:%s/./*&`
    - [ ] `<C-V>GyP<C-V>Gr*ZZ`
  - [ ] Redirect Command Line Output To Variable
    - [ ] `:r !python ~/Documents/Helper/rand-int.py`, then save to register a, `"ay` then execute, @a
    - [ ] Highlight the text `echo "Hello World"`, then `:.!!` to Execute, this will output on terminal
    - [ ] Highlight the text, then `:.w !bash`, this will write to a bash shell
  - [ ] Count Characters
    - [ ] `=len("-----")`
  - [ ] To Save Characters on macro that is double decimal
    - [ ] `q15@q` => `@qq@q` (Benefit is that you dont need to count the number of macros!!!)
  - [ ] Run Macro On Selected Lines
    - [ ] '<,'>norm @q
  - [ ] Snipepts

" ===============================================
" Skeletons
" ===============================================

nnoremap ,html :-1read $HOMEPATH/.vim/skeleton/html<CR>3jwf>a
nnoremap ,php :-1read $HOMEPATH/.vim/skeleton/php<CR>2ja
