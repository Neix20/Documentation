local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

local M = {}

-- Tab Label
vim.cmd([[
    function MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let fileName = bufname(buflist[winnr - 1])

        " Only Get Tail of Path
        let fileName = fnamemodify(fileName, ":t")

        " Check if Filename is Empty
        let fileName = strlen(fileName) > 0 ? fileName : '[No Name]'

        return fileName
    endfunction
]])

-- Tab Line
vim.cmd([[
    function MyTabLine()
        let s = ''
        for i in range(tabpagenr('$'))
            " select the highlighting
            if i + 1 == tabpagenr()
                let s .= '%#ActiveTab#'
            else
                let s .= '%#InactiveTab#'
            endif

            " set the tab page number (for mouse clicks)
            " let s .= ' ' . (i + 1)

            " the label is made by MyTabLabel()
            let l:tabLabel = MyTabLabel(i + 1)
            let l:modified = gettabwinvar(i + 1, 1, '&modified')
            let s .= ' ' . WebDevIconsGetFileTypeSymbol(l:tabLabel) . ' ' . l:tabLabel . ' ' . ( l:modified == 1 ? '[+] ' : '') . ' '
        endfor

        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabBuffer#%T'

        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
            let s .= '%=%#InactiveTab#%999XX'
        endif

        return s
    endfunction
]])


