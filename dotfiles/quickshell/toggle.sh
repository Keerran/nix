#!/bin/sh
hyprctl eval "
hl.config({ ['general.gaps_in'] = $1})
hl.workspace_rule({ workspace = 'w[tv1]', gaps_out = $1, gaps_in = 0 })
hl.workspace_rule({ workspace = 'f[1]',   gaps_out = $1, gaps_in = 0 })
hl.window_rule({
    name  = 'no-gaps-wtv1',
    match = { float = false, workspace = 'w[tv1]' },
    border_size = 0,
    rounding    = $2,
})
hl.window_rule({
    name  = 'no-gaps-f1',
    match = { float = false, workspace = 'f[1]' },
    border_size = 0,
    rounding    = $2,
})
" -r
