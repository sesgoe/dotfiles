-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- [[autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyrightconfig.json'] ]]

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*.py",
--   callback = function()
--     vim.cmd(
--       "python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyrightconfig.json']"
--     )
--   end,
-- })

vim.lsp.set_log_level("debug")
