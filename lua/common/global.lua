local utils = vim.fn
local sysname = vim.loop.os_uname().sysname

vim.g.is_win = (sysname == "Windows_NT")
vim.g.is_linux = (sysname == "Linux")
vim.g.is_mac  = (sysname == "Darwin")

if vim.g.is_linux then
    vim.g.config = "~/.config/nvim"
elseif vim.g.is_win then
    -- print("is win")
    vim.g.config = "~/AppData/Local/nvim"
end

vim.g.template_path = vim.g.config .. "/templates"
vim.g.snippte_path = vim.g.config .. "/snippets"
vim.g.dict_path = vim.g.config .. "/dicts"

