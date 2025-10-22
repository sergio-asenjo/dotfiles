local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night Moon'

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
