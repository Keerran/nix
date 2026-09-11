local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = { 'nu' }
local font = "Google Sans Code"
config.font = wezterm.font { family = font, weight = "DemiBold" }
config.font_rules = {
    {
        intensity = 'Bold',
        italic = false,
        font = wezterm.font(font, { weight = "Bold", stretch = "Normal", style = "Normal" })
    },
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font(font, { weight = "Bold", stretch = "Normal", style = "Italic" })
    },
}

config.font_size = 18
config.line_height = 0.95

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

config.background = {
    {
        source = {
            Color = "#1E1E2E",
        },
        opacity = 1,
        height = '100%',
        width = '100%',
    },
    {
        source = {
            File = "/mnt/shared/Wallpapers/nomai.jpeg"
        },
        opacity = 0.2
    },
}

config.color_scheme = "Catppuccin Mocha"

wezterm.on("toggle-fullscreen", function (window, _pane)
    local overrides = window:get_config_overrides() or {}
    if overrides.window_decorations == "TITLE | RESIZE" then
        overrides.window_decorations = "RESIZE"
    else
        overrides.window_decorations = "TITLE | RESIZE"
    end
    window:set_config_overrides(overrides)
end)

wezterm.on("toggle-tab-bar", function (window, _pane)
    local overrides = window:get_config_overrides() or {}
    overrides.enable_tab_bar = not overrides.enable_tab_bar
    window:set_config_overrides(overrides)
end)

config.keys = {
    {
        key = "F11",
        action = wezterm.action.EmitEvent "toggle-tab-bar"
    },
    {
        key = "F11",
        mods = "CTRL",
        action = wezterm.action.EmitEvent "toggle-fullscreen"
    },
    {
        key = "Enter",
        mods = "ALT",
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = "H",
        mods = "ALT|SHIFT",
        action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
        key = "L",
        mods = "ALT|SHIFT",
        action = wezterm.action.ActivatePaneDirection "Right",
    },
    {
        key = "K",
        mods = "ALT|SHIFT",
        action = wezterm.action.ActivatePaneDirection "Up",
    },
    {
        key = "J",
        mods = "ALT|SHIFT",
        action = wezterm.action.ActivatePaneDirection "Down",
    },
}

return config
