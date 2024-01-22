-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.automatically_reload_config = true
config.color_scheme = "Ayu Mirage"
config.front_end = "WebGpu"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.initial_rows = 40
config.initial_cols = 120

-- Text rendering
config.font_size = 14.0
config.font = wezterm.font("CommitMono400w")
config.line_height = 1.2
config.freetype_load_target = "Light"
config.default_prog = { "/bin/zsh", "-lc", "zellij" }

-- Speed up ^ and ~ processing
config.use_dead_keys = false

-- Support complex key combinations like Ctrl+Enter in Zellij
config.enable_csi_u_key_encoding = true

-- Keybinds, start from zero
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = true

local act = wezterm.action
config.keys = {
	{ key = "k", mods = "CTRL", action = act.ClearScrollback("ScrollbackOnly") },

	{ key = "q", mods = "SUPER", action = act.QuitApplication },
	{ key = "n", mods = "SUPER", action = act.SpawnWindow },
	{ key = "h", mods = "SUPER", action = act.HideApplication },
	{ key = "r", mods = "SUPER", action = act.ReloadConfiguration },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },

	{ key = "p", mods = "SUPER|SHIFT", action = act.ActivateCommandPalette },
}

-- and finally, return the configuration to wezterm
return config
