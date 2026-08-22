hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@144",
    position = "1920x0",
    scale = 1,
})

local terminal = "wezterm"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local reloadWaybar = "pkill waybar; waybar"

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 1,
        border_size = 1,
        col = {
            active_border = "rgba(ffffffee)",
            inactive_border = "rgba(444444aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 2,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 3,
            render_power = 2,
            color = "rgba(00000080)",
        },
        blur = {
            enabled = true,
            size = 2,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        middle_click_paste = false,
    },
    input = {
        kb_layout = "latam",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 35,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 0.5, bezier = "snappy" })
hl.animation({ leaf = "windows", enabled = true, speed = 0.7, bezier = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 0.6, bezier = "snappy", style = "popin 95%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.4, bezier = "linear", style = "popin 95%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.5, bezier = "snappy" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.3, bezier = "linear" })
hl.animation({ leaf = "fade", enabled = true, speed = 0.5, bezier = "snappy" })
hl.animation({ leaf = "layers", enabled = true, speed = 0.6, bezier = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 0.5, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 0.3, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.4, bezier = "snappy" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.3, bezier = "linear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.5, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.4, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 0.4, bezier = "snappy", style = "fade" })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Y", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + M", hl.dsp.window.float())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(reloadWaybar))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --show dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("~/.local/bin/hypr-screenshot"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("mkdir -p ~/Pictures/Screenshots && grim - | tee ~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy --type image/png"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("~/.local/bin/wofi-calc.sh"))
hl.bind(mainMod .. " + A", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind(mainMod .. " + A", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace, on_current_monitor = true }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
