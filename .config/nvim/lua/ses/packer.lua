-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'navarasu/onedark.nvim'
    -- Bottom Status Bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- harpoon to commonly used files
    use('theprimeagen/harpoon')
    -- local file histories w/ branches
    use('mbbill/undotree')
    -- git commands
    use('tpope/vim-fugitive')

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- adds file tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- LSP progress indicator bottom right
    use { 'j-hui/fidget.nvim' }
    -- highlights word under cursor and all instances
    use { 'RRethy/vim-illuminate' }
    -- shows line of open buffers @ top
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    -- Auto-close HTML tags
    use { 'windwp/nvim-ts-autotag' }
    -- cs' = change surrounding parens/brackets/etc to `'`
    use { 'tpope/vim-surround' }
    -- better substitution
    use { 'tpope/vim-abolish' }
    use { 'christoomey/vim-tmux-navigator' }

    -- Language AST parser for 10x highlighting capabilities
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use { 'nvim-treesitter/nvim-treesitter-refactor' }
    -- LSP + Highlighting
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    -- Adds module icons to LSP Popups
    use { 'onsails/lspkind-nvim' }
    -- rust-analyzer QoL
    use { 'simrat39/rust-tools.nvim' }
    -- rainbow brackets!
    use { 'p00f/nvim-ts-rainbow' }
    -- use LSP status `diagnostics()` in places like lualine
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'glepnir/lspsaga.nvim' }
    -- adds nifty matchup features for things like ifs, blocks, etc.
    use { 'andymass/vim-matchup' }
    -- comment line bindings (based on LSP)
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- auto-pair parens + brackets
    use { 'windwp/nvim-autopairs' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
end)
