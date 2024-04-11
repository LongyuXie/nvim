
local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
-- local lspkind = require('lspkind')
local ELLIPSIS_CHAR = '...'
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 30

-- 注意参数需要使用引号包裹, 不然会识别成变量
local _set_snippets = 'let g:UltiSnipsSnippetDirectories=' .. '["' .. vim.fn.stdpath("config") .. "/UltiSnips" .. '"]'

vim.cmd(
_set_snippets
)

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = false
        }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ,["<Tab>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ["<S-Tab>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
    }),
    sources = cmp.config.sources(
    {
        {
            name = 'nvim_lsp',
            entry_filter = function(entry)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
        }, 
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, 
    {
        { name = 'buffer' }
    },
    {
        { name = 'orgmode' }
    },
    {
        { name = 'vimtex' }
    }
    ),
    formatting = {
        format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
                local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                vim_item.abbr = label .. padding
            end
            vim_item.menu = ""
            --   vim_item.kind = ""
            return vim_item
        end,
    },
})


require('java').setup()
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    cmd = {'clangd', '--header-insertion-decorators=false'}    
}


require('lspconfig')['jdtls'].setup {
    capabilities = capabilities,
    handlers = {
        -- By assigning an empty function, you can remove the notifications
        -- printed to the cmd
        ["$/progress"] = function(_, result, ctx) end,
    },
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
