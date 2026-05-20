-- WezTerm configuration — ported from kitty.conf
-- Theme: Tokyo Night (folke/tokyonight.nvim)

local wezterm = require("wezterm")
local config = wezterm.config_builder()

------------------------------------------------------------
-- Font
------------------------------------------------------------
config.font = wezterm.font_with_fallback({
  -- { family = "Hack Nerd Font Mono", weight = "Regular", style = "Normal" },
  { family = "DejaVuSansM Nerd Font Mono", weight = "Regular", style = "Normal" },
})
config.font_size = 16.0
config.line_height = 1.1
-- font_features FiraCode-Regular +zero +onum from kitty (kept for parity if you swap to Fira)
config.harfbuzz_features = { "zero", "onum" }

------------------------------------------------------------
-- Window / appearance
------------------------------------------------------------
config.window_decorations = "RESIZE" -- hide titlebar, keep resize
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.window_close_confirmation = "AlwaysPrompt" -- kitty's confirm_os_window_close -1
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 4, right = 4, top = 2, bottom = 2 }

-- Inactive window/pane dimming (kitty's inactive_text_alpha 0.5)
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.5 }

------------------------------------------------------------
-- Tabs (powerline, bottom)
------------------------------------------------------------
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 60

-- Custom title: "{index}: {title}" / active "{index}[{num_panes}]: {title}"
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local index = tab.tab_index + 1
  -- Prefer a manually-set tab title; fall back to the active pane's title.
  local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
  -- tab.panes hides panes when one is zoomed; query the mux for the true count.
  local num_panes = #tab.panes
  local mux_tab = wezterm.mux.get_tab(tab.tab_id)
  if mux_tab then
    num_panes = #mux_tab:panes()
  end
  local text
  if tab.is_active then
    text = string.format(" %d[%d]: %s ", index, num_panes, title)
  else
    text = string.format(" %d: %s ", index, title)
  end
  if #text > max_width then
    text = wezterm.truncate_right(text, max_width - 1) .. "…"
  end
  return text
end)

------------------------------------------------------------
-- Scrollback / mouse / bell
------------------------------------------------------------
config.scrollback_lines = 200000
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
  target = "BackgroundColor",
}
config.exit_behavior = "Close"

------------------------------------------------------------
-- Colors — Tokyo Night (built-in scheme + tab_bar overrides)
------------------------------------------------------------
config.color_scheme = "Tokyo Night"
config.colors = {
  tab_bar = {
    background = "#1a1b26",
    active_tab = {
      bg_color = "#7aa2f7",
      fg_color = "#16161e",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#292e42",
      fg_color = "#545c7e",
    },
    inactive_tab_hover = {
      bg_color = "#3b4261",
      fg_color = "#c0caf5",
    },
    new_tab = { bg_color = "#1a1b26", fg_color = "#545c7e" },
    new_tab_hover = { bg_color = "#292e42", fg_color = "#c0caf5" },
  },
}

------------------------------------------------------------
-- Key bindings — kitty_mod = cmd
------------------------------------------------------------
local act = wezterm.action
config.keys = {
  -- Font size: cmd+= / cmd+- / cmd+0
  { key = "=",          mods = "ALT",       action = act.IncreaseFontSize },
  { key = "+",          mods = "ALT|SHIFT", action = act.IncreaseFontSize },
  { key = "-",          mods = "ALT",       action = act.DecreaseFontSize },
  { key = "0",          mods = "ALT",       action = act.ResetFontSize },

  -- New pane / window with current cwd: cmd+s
  { key = "s",          mods = "ALT",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s",          mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  -- Cycle to next pane: cmd+]
  { key = "]",          mods = "ALT",       action = act.ActivatePaneDirection("Next") },
  { key = "[",          mods = "ALT",       action = act.ActivatePaneDirection("Prev") },

  -- Go to tab N: cmd+1..5
  { key = "1",          mods = "ALT",       action = act.ActivateTab(0) },
  { key = "2",          mods = "ALT",       action = act.ActivateTab(1) },
  { key = "3",          mods = "ALT",       action = act.ActivateTab(2) },
  { key = "4",          mods = "ALT",       action = act.ActivateTab(3) },
  { key = "5",          mods = "ALT",       action = act.ActivateTab(4) },

  -- Word navigation: alt+left/right send ESC b / ESC f
  { key = "LeftArrow",  mods = "OPT",       action = act.SendString("\x1bb") },
  { key = "RightArrow", mods = "OPT",       action = act.SendString("\x1bf") },

  -- Zoom toggle current pane (kitty kitty_mod+z)
  { key = "z",          mods = "ALT",       action = act.TogglePaneZoomState },

  -- Scrollback search / pipe to less (rough equivalents of kitty_mod+b)
  { key = "b",          mods = "ALT",       action = act.ActivateCopyMode },

  -- Quick selection (kitty_mod+f hints word) → wezterm's quick-select
  { key = "f",          mods = "ALT",       action = act.QuickSelect },

  -- Rename current tab (kitty's shift+cmd+i / kitty_mod+alt+t)
  {
    key = "i",
    mods = "ALT|SHIFT",
    action = act.PromptInputLine({
      description = "Enter new tab title",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Standard macOS shortcuts (kept explicit for clarity)
  { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "n", mods = "ALT", action = act.SpawnWindow },
  { key = "c", mods = "CTRL", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
}

return config
