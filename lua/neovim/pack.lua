require("lazy").setup({ 
    -------------------------------------------
    --      ui and themes
    -------------------------------------------
    {
        'mhinz/vim-startify'
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end
    }, 
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            lazy = true
        },
        config = function()
            require("lualine").setup({})
        end
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup()
        end
    }, 
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }, 
    {
        "kylechui/nvim-surround",
        config = function()
            require('nvim-surround').setup({})
        end
    }, 
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {}
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require("nvim-tree").setup {
                git = {
                    enable = false
                }
            }
        end
    }, 
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }, 
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end
    }, 
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    }, 
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end
    }, 
    {
        'neovim/nvim-lspconfig'
    }, 
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-buffer',
            "hrsh7th/cmp-nvim-lsp",
            'SirVer/ultisnips',
            'quangnguyen30192/cmp-nvim-ultisnips',
            'honza/vim-snippets'
        }
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",
            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
            cn = { -- leetcode.cn
                enabled = true, ---@type boolean
                translator = true, ---@type boolean
                translate_problems = true, ---@type boolean
            },
        },
    },
})


