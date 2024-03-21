
local bind = require("common.bind")

local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map = vim.keymap
-- local api = require("nvim-tree.api")

-- print('hello')

-- local function open_dir(path)
--     if api.tree.is_visible() then
--         -- 如果不是一个有效的目录, 则会切换到当前工作目录
--         api.tree.change_root(path)
--         api.tree.focus()
--     else
--         api.tree.open(path)
--     end
-- end

-- local function add_new_line()
--     local pos = vim.api.nvim_win_get_cursor(0)
--     local line = pos[1]
--     vim.api.nvim_buf_set_lines(
--         0, line, line, true, {""}
--     )
-- end

-- vim.keymap.set("n", "<leader>o", function() add_new_line() end, {noremap = true})

-- vim.api.nvim_create_user_command(
--     'NvimTreeOpenDir',
--     function(opts)
--         open_dir(opts.args)
--     end,
--     { nargs = 1, complete = 'file_in_path'}
-- )
-- vim.api.nvim_create_user_command("EditSnippets",
--     function()
--         require("luasnip.loaders").edit_snippet_files()
--     end,
--     {}
-- )

-- vim.api.nvim_create_autocmd(
--     { "WinEnter" },
--     {
--         pattern = "*",
--         callback = function (...)
--             -- print("args is " .. vim.inspect(...))
--             number = vim.api.nvim_win_get_number(0)
--             -- print("number is " .. tostring(number))
--             tabpage = vim.api.nvim_win_get_tabpage(0)
--             -- print("tabpage is " .. tostring(tabpage))
--         end
--     }
--     -- pattern
-- )

-- L: goto bottom
-- M: goto medium
-- H: goto top

local native_map = {

    ["n|Q"] = map_cr("qa!"):with_silent():with_noremap(),
    ["n|<leader>q"] = map_cr("quit"):with_noremap():with_silent(),
    ["n|<leader>w"] = map_cr("write"):with_noremap():with_silent(),
    -- window focus move
    ["n|<A-h>"] = map_cmd("<C-w>h"):with_silent():with_noremap(),
    ["n|<A-j>"] = map_cmd("<C-w>j"):with_silent():with_noremap(),
    ["n|<A-k>"] = map_cmd("<C-w>k"):with_silent():with_noremap(),
    ["n|<A-l>"] = map_cmd("<C-w>l"):with_silent():with_noremap(),
    ["n|<A-o>"] = map_cr("only"):with_silent():with_noremap(),

    -- use system clipboard
    ["n|<leader>p"] = map_cmd([["+p]]):with_noremap(),
    ["v|<leader>y"] = map_cmd([["+y]]):with_noremap(),
    ["n|<leader>a"] = map_cmd([[ggVG]]):with_noremap(),
    ["n|<C-a>"] = map_cmd([[ggVG]]):with_noremap(),

    -- move when insert 
    ["i|<C-f>"] = map_cmd("<right>"):with_silent():with_noremap(),
    ["i|<C-b>"] = map_cmd("<left>"):with_silent():with_noremap(),

    ["v|>"] = map_cmd(">gv"):with_silent():with_noremap():with_nowait(),
    ["v|<"] = map_cmd("<gv"):with_silent():with_noremap():with_nowait(),

    ["n|<leader>k"] = map_cu("move -2"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>j"] = map_cu("move +1"):with_silent():with_noremap():with_nowait(),
    ["n|<C-l>"] = map_cu(">"):with_silent():with_noremap():with_nowait(),
    ["n|<C-h>"] = map_cu("<"):with_silent():with_noremap():with_nowait(),


    ["i|<C-t><C-t>"] = map_cmd([[<C-r>=strftime("%Y-%m-%d")]]):with_silent():with_noremap():with_nowait(),




    -- ["n|<leader>o"] = map_cmd("o<ESC>k"):with_silent():with_noremap():with_nowait(),
    -- ["n|j"] = map_cmd("gj"):with_silent():with_noremap():with_nowait(),
    -- ["n|k"] = map_cmd("gk"):with_silent():with_noremap():with_nowait(),
}

local plugin_map = {

    -- some usefull key
    -- zz: center the current line
    -- zt: top
    -- zb: bottom
    -- <C-y>: line focus hold, but move up
    -- <C-e>: line foucs hold, but move down
    -- Hop 
--     ["n|<leader><leader>w"] = map_cu("HopWord"):with_noremap(),
--     ["n|<leader><leader>j"] = map_cu("HopLine"):with_noremap(),
--     ["n|<leader><leader>k"] = map_cu("HopLine"):with_noremap(),
--     ["n|<leader><leader>c"] = map_cu("HopChar1"):with_noremap(),
--     ["n|<leader><leader>c"] = map_cu("HopChar2"):with_noremap(),
    
    
    -- It means use C-/
    ["n|<C-_>"] = map_cmd("<Plug>(comment_toggle_linewise_current)"):with_silent():with_noremap(),
    ["v|<C-_>"] = map_cmd("<Plug>(comment_toggle_linewise_visual)"):with_silent():with_noremap(),
    ["i|<C-_>"] = map_cmd("<C-[><Plug>(comment_toggle_linewise_current)"):with_silent():with_noremap(),



    -- Plugin nvim-suround
    -- visual mode key: S
    --[[ Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    functi*on calls     dsf             function calls ]]

---------------------------------------------------------------------------------
    -- delete
    -- dse: delete suround environment
    -- dsc: delete suround commands
    -- dsd: delete suround delimiters: (), [], left-begin
    -- ds$: delete suround math: $$, equation
    -- change
    -- csd: change suround delimiters
    -- cs$: change suround math: $$ to equation
    -- cse: change suround environment
    -- csc: change suround commands
    -- toggle
    -- tsc or tse: change starred commands and environment: section <-> section*(tsc), equation <-> equation*(tse)
    -- ts$: toggle inline and display math
    -- tsd: () <-> left(\right) <-> \big(\big)

    -- -- Plugin nvim-tree
    ["n|<leader>nn"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
    ["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
    ["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
    ["n|sl"] = map_cu("HopLineStart"):with_noremap():with_silent(),
    ["n|sk"] = map_cu("HopLine"):with_noremap():with_silent(),
    -- ["n|sc"] = map_cu("HopWord"):with_noremap():with_silent(),
    -- Done: 在已经打开窗口的情况下, 可以切换目录
    -- ["n|<Leader>no"] = map_cmd(":NvimTreeOpenDir "):with_noremap(),
    -- ["n|<Leader>ni"] = map_cmd(":NvimTreeOpenDir ./"):with_noremap(),

    -- bufferline
    -- ["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent(),
    -- ["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent(),
    -- ["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent(),
    -- ["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent(),
    -- ["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent(),
    -- ["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent(),
    -- ["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent(),
    -- ["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent(),
    -- ["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent(),

    ["n|<C-p>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
    ["n|<C-n>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),

    -- -- Packer
    -- ["n|<leader>ss"] = map_cr("PackerSync"):with_silent():with_noremap():with_nowait(),
    -- ["n|<leader>su"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait(),
    -- ["n|<leader>si"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait(),
    -- ["n|<leader>sc"] = map_cr("PackerClean"):with_silent():with_noremap():with_nowait(),

    ["n|<leader>st"] = map_cr("Startify"):with_silent():with_noremap():with_nowait(),
}

bind.nvim_load_mapping(native_map)
bind.nvim_load_mapping(plugin_map)
