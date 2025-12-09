local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.colors = {
  foreground = '#ffffff',
  background = '#0a0e27',
  cursor_bg = '#ffffff',
  cursor_border = '#ffffff',
  cursor_fg = '#0a0e27',
  selection_bg = '#4a6fa5',
  selection_fg = '#ffffff',
  
  ansi = {
    '#1a1a2e', -- black
    '#ff4444', -- red
    '#44ff44', -- green
    '#ffdd44', -- yellow
    '#4488ff', -- blue
    '#ff44ff', -- magenta
    '#44ffff', -- cyan
    '#ffffff', -- white
  },
  brights = {
    '#555555', -- bright black
    '#ff6666', -- bright red
    '#66ff66', -- bright green
    '#ffff66', -- bright yellow
    '#6699ff', -- bright blue
    '#ff66ff', -- bright magenta
    '#66ffff', -- bright cyan
    '#ffffff', -- bright white
  },
}

config.font = wezterm.font_with_fallback {
  'Zenbones Mono',
  'Noto Color Emoji'
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  
  if cwd then
    local path = cwd.file_path or cwd.path or cwd
    local folder = path:match("([^/]+)/?$") or path
    return folder
  end
  
  return tab.active_pane.title
end)

return config
