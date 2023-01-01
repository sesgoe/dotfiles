local opt = vim.opt

-- line numbers
opt.nu = true
opt.relativenumber = true

-- tabs and indentation
opt.tabstop = 4 -- spaces for tabs
opt.softtabstop = 4 -- spaces for tabs
opt.shiftwidth = 4 -- spaces for indent width
opt.expandtab = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true -- if you include mixed case in search, assumes case-sensitive

-- cursor line
opt.cursorline = true

-- theme
opt.termguicolors = true
opt.signcolumn = "yes" -- always show sign column so editor doesn't shift
opt.colorcolumn = "80" -- keep 80 col highlighted for reference for long text
opt.scrolloff = 12 -- always keep at least X lines at bottom/top of buffer

-- splitting should be more intuitive
opt.splitright = true
opt.splitbelow = true

-- search
opt.hlsearch = false
opt.incsearch = true

-- backspace
opt.backspace = "indent,eol,start"

--misc
opt.isfname:append("@-@") -- files can have @ in filenames
opt.updatetime = 50
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
