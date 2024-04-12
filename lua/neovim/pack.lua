require("lazy").setup({
    -------------------------------------------
    --      ui and themes
    -------------------------------------------
    {
        "mhinz/vim-startify",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            lazy = true,
        },
        config = function()
            require("lualine").setup({})
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
    },
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                git = {
                    enable = false,
                },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function(_, opts)
            local conf = vim.tbl_deep_extend("keep", opts, {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            require("mason").setup(conf)
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "SirVer/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
            -- "honza/vim-snippets",
        },
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
            -- "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
            cn = { -- leetcode.cn
            enabled = true, ---@type boolean
            translator = true, ---@type boolean
            translate_problems = true, ---@type boolean
        },
        lang = 'java',
        ---@type lc.storage
        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
    },
},
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-orgmode/orgmode",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        event = "VeryLazy",
        config = function() end,
    },
    {
        "nvim-java/nvim-java",
        dependencies = {
            "nvim-java/lua-async-await",
            "nvim-java/nvim-java-core",
            "nvim-java/nvim-java-test",
            "nvim-java/nvim-java-dap",
            "MunifTanjim/nui.nvim",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            {
                "williamboman/mason.nvim",
                opts = {
                    registries = {
                        "github:nvim-java/mason-registry",
                        "github:mason-org/mason-registry",
                    },
                },
            },
        },
    },
    {
        "folke/neoconf.nvim",
        config = function()
            require("neoconf").setup()
        end,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({})
        end,
    },
    { "mhartington/formatter.nvim" },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            -- "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    {
        "lervag/vimtex",
        init = function()
            -- Use init for configuration, don't use the more common "config".
        end
    },
    {
        "micangl/cmp-vimtex",
    }
})

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == "special.lua" then
                    return nil
                end

                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },

})

-- Load treesitter grammar for org
-- require("orgmode").setup_ts_grammar()

-- Setup treesitter
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    ensure_installed = { "org", "java", "c", "cpp", "python", "lua" },
})
