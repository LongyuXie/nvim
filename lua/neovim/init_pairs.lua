local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')
local bracket_creator = require('nvim-autopairs.rules.basic').bracket_creator

-- npairs.add_rule(Rule("$$","$$","tex"))


local textMarker = {"/", "_", "+", "~", "="}
local markers = {}


npairs.setup {
  enable_check_bracket_line = false
}

-- npairs.add_rule(Rule("*", "*"))
-- Rule("*", "*")
local bracket = bracket_creator(npairs.config)
for _, marker in ipairs(textMarker) do 
    markers[marker .. marker] = true
    npairs.add_rule (
        bracket(marker, marker, {"org"}):with_pair(cond.before_text(' '))
    )
end
npairs.add_rules {
    bracket("\\(", "\\)", {"org"}),
    -- bracket("(", ")")
}
-- print(vim.inspect(markers))

local group = vim.api.nvim_create_augroup("orgmode_autocommands", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"org"}, -- here you can add additional filetypes
    callback = function(ev)
        vim.keymap.set("i", "<space>", function ()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local current_line = vim.api.nvim_get_current_line()
            local around = current_line:sub(col, col+1)
            local matched = markers[around] or false
            if matched then
                vim.api.nvim_buf_set_text(0, row-1, col, row-1, col+1, {' '})
                vim.api.nvim_win_set_cursor(0, {row,col+1})
            else
                vim.api.nvim_put({' '}, "c", false, true)
            end
        end, {nowait=true, silent=true, noremap=true, buffer=0})
    end,
    group = group 
})

-- npairs.clear_rules()
--
-- for _,bracket in pairs { { '(', ')' }, { '[', ']' }, { '{', '}' } } do
-- end

npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp" }
npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))
npairs.get_rules("(")[1]:with_pair(cond.not_before_text("\\"))
npairs.get_rules("[")[1]:with_pair(cond.not_before_text("\\"))
npairs.get_rules("{")[1]:with_pair(cond.not_before_text("\\"))
npairs.get_rules("/")[1]:with_pair(cond.not_before_regex('[-+]?[0-9]+[.]?[0-9]*', 10))
