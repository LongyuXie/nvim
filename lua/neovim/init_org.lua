-- Setup orgmode
require('orgmode').setup({
    org_agenda_files = {'~/EmacsOrg/**/*', '~/notes/**/*'},
    org_default_notes_file = '~/EmacsOrg/inbox.org',
    -- org_indent_mode = 'noindent',
    org_startup_folded = "showeverything",
    org_adapt_indentation = false,
    org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)'},

    mappings = {
        org = {
            org_toggle_checkbox = "<C-c><C-c>",
            org_do_promote = "<A-left>",
            org_do_demote = "<A-right>",
            org_meta_return = "<A-enter>",
            org_deadline = "<C-c><C-d>",
            org_schedule = "<C-c><C-s>",
            org_todo = "<C-c><C-t>",
            org_time_stamp = "<C-c>.",
            org_time_stamp_inactive = "<C-c>!",
        },
        global = {
            org_agenda = '<C-c>a',
            org_capture = '<C-c>c'
        },
        agenda = {
            -- org_agenda_later = '>',
            -- org_agenda_earlier = '<',
            org_agenda_goto_today = {'.', 'T'}
        },
        capture = {
            -- org_capture_finalize = '<Leader>w',
            -- org_capture_refile = 'R',
            -- org_capture_kill = 'Q'
        },
        org_return_uses_meta_return = false,
    }
})

local function uses_meta_return_wraper()
    require("orgmode").action("org_mappings.meta_return")
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'org',
  callback = function()
    vim.keymap.set('i', '<M-CR>', uses_meta_return_wraper, {
      silent = true,
      buffer = true,
    })
  end,
})
