local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.front_end = 'OpenGL'

local dark_colors = {
  foreground = '#d8dee9',
  background = '#0b1020',
  cursor_bg = '#82aaff',
  cursor_border = '#82aaff',
  cursor_fg = '#0b1020',
  selection_bg = '#25345c',
  selection_fg = '#f4f7ff',

  ansi = {
    '#171c2c', -- black
    '#e06c75', -- red
    '#7fba7a', -- green
    '#d9b65d', -- yellow
    '#6f9de8', -- blue
    '#b48ead', -- magenta
    '#65b8c4', -- cyan
    '#d8dee9', -- white
  },
  brights = {
    '#536078', -- bright black
    '#ef7f89', -- bright red
    '#91c98c', -- bright green
    '#e8c66c', -- bright yellow
    '#84adf0', -- bright blue
    '#c39bc0', -- bright magenta
    '#7bc9d3', -- bright cyan
    '#f4f7ff', -- bright white
  },
  tab_bar = {
    background = '#080c18',
    inactive_tab_edge = '#26314a',
    active_tab = {
      bg_color = '#0b1020',
      fg_color = '#f4f7ff',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#11182b',
      fg_color = '#8e9bb3',
    },
    inactive_tab_hover = {
      bg_color = '#202c49',
      fg_color = '#d8dee9',
    },
    new_tab = {
      bg_color = '#11182b',
      fg_color = '#8e9bb3',
    },
    new_tab_hover = {
      bg_color = '#202c49',
      fg_color = '#d8dee9',
    },
  },
}

local light_colors = {
  foreground = '#273142',
  background = '#f4f6fb',
  cursor_bg = '#315fa8',
  cursor_border = '#315fa8',
  cursor_fg = '#f4f6fb',
  selection_bg = '#cddcff',
  selection_fg = '#1c2940',

  ansi = {
    '#273142', -- black
    '#b42335', -- red
    '#2f7d4a', -- green
    '#8a6400', -- yellow
    '#315fa8', -- blue
    '#7a4d9d', -- magenta
    '#277983', -- cyan
    '#e7eaf1', -- white
  },
  brights = {
    '#5d687a', -- bright black
    '#d14355', -- bright red
    '#3d9660', -- bright green
    '#a57a0a', -- bright yellow
    '#4678c5', -- bright blue
    '#9564b6', -- bright magenta
    '#35929d', -- bright cyan
    '#ffffff', -- bright white
  },
  tab_bar = {
    background = '#e6eaf2',
    inactive_tab_edge = '#c6ccd8',
    active_tab = {
      bg_color = '#f4f6fb',
      fg_color = '#273142',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#e6eaf2',
      fg_color = '#687386',
    },
    inactive_tab_hover = {
      bg_color = '#d8dfeb',
      fg_color = '#273142',
    },
    new_tab = {
      bg_color = '#e6eaf2',
      fg_color = '#687386',
    },
    new_tab_hover = {
      bg_color = '#d8dfeb',
      fg_color = '#273142',
    },
  },
}

local time = tonumber(wezterm.time.now():format '%H%M')
local is_dark = time >= 1800 or time < 800
config.colors = is_dark and dark_colors or light_colors
config.window_frame = {
  active_titlebar_bg = is_dark and '#080c18' or '#e6eaf2',
  inactive_titlebar_bg = is_dark and '#0b1020' or '#edf0f6',
}

wezterm.time.call_after(60, function()
  wezterm.reload_configuration()
end)

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
