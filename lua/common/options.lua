local export = {}

local vim = vim
local ui_options = {
    number = true,
    termguicolors = true,
    showmode = false,
    background = 'dark',
    signcolumn = 'yes:1',
    pumheight = 10,
    -- nowrap = true,
    relativenumber = true,
    cursorline = true,
    cursorcolumn = true,
    cmdheight = 2,
    showcmd = false,
    ruler = true
}
local control_options = {
    mouse = "a",
    errorbells = true,
    visualbell = true,
    hidden = true,
    backup = false,
    swapfile = false,
    autochdir = true,
    autoread = true,
    autowrite = true
}
local tab_options = {
    smarttab = true,
    expandtab = true,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4
}
local search_options = {
    ignorecase = true,
    smartcase = true,
    infercase = true,
    incsearch = true
}

local opt_map = {}

opt_map["ui"] = ui_options
opt_map["tab"] = tab_options
opt_map["search"] = search_options
opt_map["control"] = control_options

local function load_opt(opts)
    for name, value in pairs(opts) do
        vim.o[name] = value
    end
end

function export.load_all()
    for _, opts in pairs(opt_map) do
        load_opt(opts)
    end
end

function export.load_opt_by_name(names)
    for _, name in ipairs(names) do
        load_opt(opt_map[name])
    end
end

vim.cmd("set nowrap")
vim.cmd("rightbelow")


return export
