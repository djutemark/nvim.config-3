call plug#begin()

" LSP 
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'j-hui/fidget.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'Issafalcon/lsp-overloads.nvim'

" Other
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

Plug 'navarasu/onedark.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mbbill/undotree'

Plug 'sbdchd/neoformat'

Plug 'folke/persistence.nvim'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'ggandor/leap.nvim'

Plug 'github/copilot.vim'

Plug 'numToStr/Comment.nvim'

Plug 'RRethy/vim-illuminate'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

Plug 'lewis6991/gitsigns.nvim'

call plug#end()

