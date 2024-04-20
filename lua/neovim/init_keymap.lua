local bind = require("common.bind")

local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map = vim.keymap
local map_func = bind.map_lua_function

local telescope_builtin = require('telescope.builtin')

local function nvim_tree_open_dir(path)
    if api.tree.is_visible() then
        -- 如果不是一个有效的目录, 则会切换到当前工作目录
        api.tree.change_root(path)
        api.tree.focus()
    else
        -- TODO: can not open dir corresponding path
        api.tree.open(path)
    end
end

local function add_new_line()
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = pos[1]
    vim.api.nvim_buf_set_lines(
        0, line, line, true, {""}
    )
end


local function add_delemitor(char) 
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local current_line = vim.api.nvim_get_current_line()
    local len = #current_line
    vim.api.nvim_buf_set_text(
        0, row-1, len, row-1, len, {char}
    )

end



-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
-- vim.keymap.set('n', 'sw', function()
-- end)
-- vim.keymap.set('n', 'sc', function()
-- end)

vim.keymap.set("n", "<leader>o", add_new_line, {noremap = true, nowait=true})

vim.api.nvim_create_user_command(
    'MyOpenDir',
    function(opts)
        nvim_tree_open_dir(opts.args)
    end,
    { nargs = 1, complete = 'file_in_path'}
)

-- L: goto bottom

-- M: goto medium
-- H: goto top
--
-- vim.keymap.set({"n", "v", "c"}, "<A-x>", ":", {})

local native_map = {

    ["n|Q"] = map_cr("qa!"),
    ["n|<leader>q"] = map_cr("quit"),
    ["n|<leader>w"] = map_cr("write"),
    -- window focus move
    ["n|<A-h>"] = map_cmd("<C-w>h"),
    ["n|<A-j>"] = map_cmd("<C-w>j"),
    ["n|<A-k>"] = map_cmd("<C-w>k"),
    ["n|<A-l>"] = map_cmd("<C-w>l"),
    ["n|<A-o>"] = map_cr("only"),

    ["c,i|<A-BS>"] = map_cmd("<C-w>"):with_nowait():with_not_silent(),

    -- use system clipboard
    ["n|<leader>p"] = map_cmd([["+p]]),
    ["v|<leader>y"] = map_cmd([["+y]]),
    ["n|<leader>a"] = map_cmd([[ggVG]]),
    -- ["n|<C-a>"] = map_cmd([[ggVG]]),
-- vim.keymap.set({"n", "i"}, "<A-;>", function () add_delemitor(";") end, {})
-- vim.keymap.set({"n", "i"}, "<A-,>", function () add_delemitor(",") end, {})
    ["n,i|<A-;>"] = map_func(function () add_delemitor(";") end),
    ["n,i|<A-,>"] = map_func(function () add_delemitor(",") end),

    ["n,v|,"] = map_cmd(";"):with_nowait(),

    -- move when insert 
    ["i|<C-f>"] = map_cmd("<right>"),
    ["i|<C-b>"] = map_cmd("<left>"),
    ["i|<C-p>"] = map_cmd("<up>"),
    ["i|<C-n>"] = map_cmd("<down>"),

    ["n|<C-k>"] = map_cu("move -2"):with_nowait(),
    ["n|<C-j>"] = map_cu("move +1"):with_nowait(),
    ["n|<C-l>"] = map_cu(">"):with_nowait(),
    ["n|<C-h>"] = map_cu("<"):with_nowait(),
    ["v|<C-l>"] = map_cmd(">gv"):with_nowait(),
    ["v|<C-h>"] = map_cmd("<gv"):with_nowait(),

}

local plugin_map = {

    -- some usefull key
    -- zz: center the current line
    -- zt: top
    -- zb: bottom
    -- <C-y>: line focus hold, but move up
    -- <C-e>: line foucs hold, but move down
    
    ["n|<leader>ff"] = map_func(telescope_builtin.find_files),
    ["n|<leader>fg"] = map_func(telescope_builtin.live_grep),
    ["n|<leader>fb"] = map_func(telescope_builtin.buffers),
    ["n|<leader>fh"] = map_func(telescope_builtin.help_tags),
    
    -- It means use C-/
    -- 在终端中不能直接使用 C-/
    ["n|<C-_>"] = map_cmd("<Plug>(comment_toggle_linewise_current)"),
    ["v|<C-_>"] = map_cmd("<Plug>(comment_toggle_linewise_visual)"),
    ["i|<C-_>"] = map_cmd("<C-[><Plug>(comment_toggle_linewise_current)"),



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
    ["n|<leader>nn"] = map_cr("NvimTreeToggle"),
    ["n|<Leader>nf"] = map_cr("NvimTreeFindFile"),
    ["n|<Leader>nr"] = map_cr("NvimTreeRefresh"),
    ["n,v|sk"] = map_func(function () hop.hint_lines() end),
    ["n,v|sl"] = map_func(function () hop.hint_lines_skip_whitespace() end),
    ["n,v|sc"] = map_func(function () hop.hint_char1({ current_line_only = true }) end),
    ["n,v|sw"] = map_func(function () hop.hint_words({ current_line_only = true }) end),
    -- ["n|sc"] = map_cu("HopWord"),
    -- Done: 在已经打开窗口的情况下, 可以切换目录
    -- ["n|<Leader>no"] = map_cmd(":NvimTreeOpenDir "),
    -- ["n|<Leader>ni"] = map_cmd(":NvimTreeOpenDir ./"),

    -- bufferline
    -- ["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"),
    -- ["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"),
    -- ["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"),
    -- ["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"),
    -- ["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"),
    -- ["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"),
    -- ["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"),
    -- ["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"),
    -- ["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"),

    ["n|<C-p>"] = map_cr("BufferLineCyclePrev"),
    ["n|<C-n>"] = map_cr("BufferLineCycleNext"),

    -- ["n|<leader>st"] = map_cr("Startify"):with_nowait(),
}

bind.nvim_load_mapping(native_map)
bind.nvim_load_mapping(plugin_map)
