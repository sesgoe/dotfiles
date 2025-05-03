-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

config.keys = {
	{
		key = "q",
		mods = "CTRL|SHIFT",
		action = act.SwitchWorkspaceRelative(1),
	},
}

-- I love OneDarkPro-related themes, this is the closest thing
config.color_scheme = "OneHalfDark"

-- default background is a little light, need to darken for opacity
config.colors = {
	background = "#111111",
}

config.window_background_opacity = 0.9

-- I wanna be like fasterthanlime
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")

-- reduces window buttons
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.freetype_load_target = "HorizontalLcd"

-- I'm old
config.font_size = 14

-- default open WSL instead of Powershell
config.default_domain = "WSL:Ubuntu"

return config
