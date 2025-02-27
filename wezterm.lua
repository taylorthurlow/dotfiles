-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Assumes terminfo entry for wezterm is installed in ~/.terminfo (or other
-- applicable terminfo path). It is installable with:
-- tempfile=$(mktemp) \
--   && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
--   && tic -x -o ~/.terminfo $tempfile \
--   && rm $tempfile
config.term = "wezterm"

config.automatically_reload_config = true
config.scrollback_lines = 20000
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.initial_rows = 40
config.initial_cols = 120
config.enable_kitty_keyboard = true

-- Theme
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Ayu Mirage"
	else
		-- return "ayu_light"
		return "Ayu Light (Gogh)"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())

-- Text rendering
config.font_size = 14.0
config.line_height = 1.2
config.freetype_load_target = "Light"
config.underline_thickness = 2
config.underline_position = "-2pt"

function font_for_appearance(appearance)
	if appearance:find("Dark") then
		return wezterm.font("CommitMono")
	else
		return wezterm.font("CommitMono")
	end
end

config.font = font_for_appearance(get_appearance())

-- Speed up ^ and ~ processing
config.use_dead_keys = false

-- Show which key table is active in the status area
wezterm.on("update-status", function(window, pane)
	local name = window:active_key_table()
	window:set_right_status(name or "")
end)

-- Support complex key combinations like Ctrl+Enter in Zellij
-- config.enable_csi_u_key_encoding = true

-- Disable window shadow due to performance issues:
-- https://github.com/wez/wezterm/issues/2669
-- config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.window_decorations = "TITLE | RESIZE"

-- Style and show tabs
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- Dim and desaturate inactive panes
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- Keybinds, start from zero
config.disable_default_key_bindings = true

local act = wezterm.action

config.keys = {
	-- Key tables
	{
		key = "t",
		mods = "ALT",
		action = act.ActivateKeyTable({ name = "tab_mode" }),
	},
	{
		key = "p",
		mods = "ALT",
		action = act.ActivateKeyTable({ name = "pane_mode" }),
	},
	{
		key = "r",
		mods = "ALT",
		action = act.ActivateKeyTable({
			name = "resize_mode",
			one_shot = false,
		}),
	},

	{ key = "n", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "ALT | SHIFT", action = act.ActivateTabRelative(-1) },

	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

	{ key = "q", mods = "SUPER", action = act.QuitApplication },
	{ key = "n", mods = "SUPER", action = act.SpawnWindow },
	{ key = "h", mods = "SUPER", action = act.HideApplication },
	{ key = "r", mods = "SUPER", action = act.ReloadConfiguration },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },

	-- Disable some key combinations that otherwise send useless garbage
	-- { key = "Enter", mods = "SHIFT", action = act.SendKey({ key = "Enter" }) },
	-- { key = "Backspace", mods = "SHIFT", action = act.SendKey({ key = "Backspace" }) },
	-- { key = "LeftArrow", mods = "SHIFT", action = act.SendKey({ key = "LeftArrow" }) },
	-- { key = "RightArrow", mods = "SHIFT", action = act.SendKey({ key = "RightArrow" }) },
	-- { key = "UpArrow", mods = "SHIFT", action = act.SendKey({ key = "UpArrow" }) },
	-- { key = "DownArrow", mods = "SHIFT", action = act.SendKey({ key = "DownArrow" }) },

	{ key = "/", mods = "ALT", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "?", mods = "ALT | SHIFT", action = act.QuickSelect },
	{ key = "c", mods = "CTRL | SHIFT", action = act.ActivateCopyMode },
	-- { key = "t", mods = "CTRL | SHIFT", action = act.ToggleAlwaysOnTop }, -- nightlies only

	{ key = "p", mods = "SUPER | SHIFT", action = act.ActivateCommandPalette },
}

config.key_tables = {
	tab_mode = {
		{ key = "Escape", action = act.PopKeyTable },

		{ key = "c", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "n", action = act.ActivateTabRelative(1) },
		{ key = "p", action = act.ActivateTabRelative(-1) },

		{ key = "1", action = act.ActivateTab(0) },
		{ key = "2", action = act.ActivateTab(1) },
		{ key = "3", action = act.ActivateTab(2) },
		{ key = "4", action = act.ActivateTab(3) },
		{ key = "5", action = act.ActivateTab(4) },
		{ key = "6", action = act.ActivateTab(5) },
		{ key = "7", action = act.ActivateTab(6) },
		{ key = "8", action = act.ActivateTab(7) },

		{ key = "]", action = act.MoveTabRelative(1) },
		{ key = "[", action = act.MoveTabRelative(-1) },

		{ key = "x", action = act.CloseCurrentTab({ confirm = true }) },
	},

	pane_mode = {
		{ key = "Escape", action = act.PopKeyTable },

		{ key = "s", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
		{ key = "s", mods = "SHIFT", action = act.SplitPane({ direction = "Up", size = { Percent = 50 } }) },
		{ key = "v", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
		{ key = "v", mods = "SHIFT", action = act.SplitPane({ direction = "Left", size = { Percent = 50 } }) },

		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },

		{ key = "z", action = "TogglePaneZoomState" },
		{ key = "r", action = act.RotatePanes("Clockwise") },
		{ key = "r", mods = "SHIFT", action = act.RotatePanes("CounterClockwise") },

		{ key = "x", action = act.CloseCurrentPane({ confirm = true }) },
	},

	resize_mode = {
		{ key = "Escape", action = act.PopKeyTable },
		{ key = "Enter", action = act.PopKeyTable },

		{ key = "h", action = act.AdjustPaneSize({ "Left", 10 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 10 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 10 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 10 }) },

		{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 2 }) },
	},
}

config.mouse_bindings = {
	-- Unbind normal click-to-follow-link, rebind to SUPER
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

function colors_for_tab_bar(appearance)
	if appearance:find("Dark") then
		return {
			compose_cursor = "purple",
			tab_bar = {
				background = "#0b0022",
				active_tab = {
					bg_color = "#2b2042",
					fg_color = "#c0c0c0",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab = {
					bg_color = "#1b1032",
					fg_color = "#808080",
				},
				inactive_tab_hover = {
					bg_color = "#3b3052",
					fg_color = "#909090",
					italic = true,
				},
				new_tab = {
					bg_color = "#1b1032",
					fg_color = "#808080",
				},
				new_tab_hover = {
					bg_color = "#3b3052",
					fg_color = "#909090",
					italic = true,
				},
			},
		}
	else
		return {
			compose_cursor = "purple",
			tab_bar = {
				background = "#eeeeee",
				active_tab = {
					bg_color = "#e0e0e0",
					fg_color = "#333333",
					intensity = "Normal",
					underline = "None",
					italic = false,
					strikethrough = false,
				},
				inactive_tab = {
					bg_color = "#eeeeee",
					fg_color = "#808080",
				},
				inactive_tab_hover = {
					bg_color = "#cccccc",
					fg_color = "#222222",
					italic = true,
				},
				new_tab = {
					bg_color = "#e0e0e0",
					fg_color = "#333333",
				},
				new_tab_hover = {
					bg_color = "#cccccc",
					fg_color = "#222222",
					italic = true,
				},
			},
		}
	end
end

config.colors = colors_for_tab_bar(get_appearance())

-- and finally, return the configuration to wezterm
return config
