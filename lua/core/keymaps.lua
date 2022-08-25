function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Replace Undo
nmap('<C-z>', 'u')
imap('<C-z>', 'u')
vmap('<C-z>', 'u')

-- Toggle TagBar
nmap('<F8>', ':TagbarToggle<CR>')

-- Format File
nmap('<C-F>', ':lua vim.lsp.buf.formatting()<CR>')

-- NERDTree
-- nmap('<C-n>', ':NERDTreeToggle<CR>')            -- open/close
nmap('<C-n>', ':NvimTreeToggle<CR>')            -- open/close
