
local sysname = vim.loop.os_uname().sysname

if sysname == "Linux" then
    vim.api.nvim_create_autocmd(
        { "InsertLeave" },
        {
            pattern = {"*"},
            callback = function ()
                os.execute("fcitx5-remote -c")
            end,
            desc = "inactivate fcitx5 when leaving insert mode"
        }
    )
end
