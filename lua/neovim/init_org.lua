
-- Setup orgmode
require('orgmode').setup({
    org_agenda_files = {'~/EmacsOrg/**/*', '~/notes/**/*'},
    org_default_notes_file = '~/EmacsOrg/inbox.org',
    -- org_indent_mode = 'noindent',
    org_startup_folded = "showeverything",
    org_adapt_indentation = false,
    -- org_insert_heading_respect_content = 
    mappings = {
        org = {
            org_toggle_checkbox = "<C-c><C-c>",
            org_do_promote = "<A-left>",
            org_do_demote = "<A-right>",
            org_meta_return = "<A-enter>",
            org_deadline = "<C-c><C-d>",
            org_schedule = "<C-c><C-s>",
            org_todo = "<C-right>",
            org_todo_prev = "<C-left>",
            org_time_stamp = "<C-c>.",
            org_time_stamp_inactive = "<C-c>!",
            -- org_insert_todo_heading = "<C-c><C-t>"
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
            org_capture_finalize = '<Leader>w',
            org_capture_refile = 'R',
            org_capture_kill = 'Q'
        },
        org_return_uses_meta_return = true,
    }
})
