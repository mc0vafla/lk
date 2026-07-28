hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@74.973",
    position = "1440x0",
    scale    = "auto",
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@165.0",
    position = "0x0",
    scale    = "1.33",
})

hl.on("hyprland.start", function () 
     hl.exec_cmd("noctalia")
end)

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(d98880ee)", "rgba(e6b0aaee)"}, angle = 45 }, 
            inactive_border = "rgba(7b5e59aa)", 
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 15, 
        rounding_power = 2,

        active_opacity   = 0.98,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 14,
            render_power = 3,
            color        = 0x73000000, 
            offset       = "5 10",    
        },

        blur = {
            enabled   = true,
            size      = 6,      
            passes    = 2,        
            vibrancy  = 0.1696,
            new_optimizations = true,
            xray = true,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.workspace_rule({ workspace = 1, monitor = "eDP-1" })
for i = 2, 10 do
    hl.workspace_rule({ workspace = i, monitor = "HDMI-A-1" })
end

hl.curve("easeOutQuad",    { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })
hl.curve("niriWorkspace",  { type = "spring", mass = 1, stiffness = 1400, dampening = 55 })
hl.curve("niriWinOpen",    { type = "spring", mass = 1, stiffness = 1200, dampening = 50 })
hl.curve("niriMove",       { type = "spring", mass = 1, stiffness = 1200, dampening = 55 })
hl.curve("niriResize",     { type = "spring", mass = 1, stiffness = 1500, dampening = 60 })
hl.curve("niriLayers",     { type = "spring", mass = 1, stiffness = 1300, dampening = 50 })

hl.animation({ leaf = "global",        enabled = true,  speed = 5,    bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4,    spring = "niriMove" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4,    spring = "niriWinOpen", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4,    spring = "niriMove", style = "popin 80%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 4,    spring = "niriLayers" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    spring = "niriLayers", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 4,    spring = "niriLayers", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 5,    bezier = "easeOutQuad" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4,   spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4,   spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4,   spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    bezier = "easeOutQuad" })

hl.config({
    dwindle = {
        preserve_split = true, 
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 1,    
        disable_hyprland_logo   = true, 
    },
})

hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- keybinds

local mod = "SUPER" 
local alt = "ALT"

hl.bind(mod .. " + c", hl.dsp.exec_cmd("hyprctl eval 'hl.config({ general = { layout = \"dwindle\" } })'"))
hl.bind(mod .. " + x", hl.dsp.exec_cmd("hyprctl eval 'hl.config({ general = { layout = \"scrolling\" } })'"))

hl.bind(alt .. " + q", function()
    hl.dispatch(hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
end)

hl.bind(alt .. " + w", function()
    hl.dispatch(hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
end)

hl.bind(mod .. " + z", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mod .. " + w", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + s", hl.dsp.focus({ workspace = "+1" }))

hl.bind(mod .. " + CTRL + w", hl.dsp.window.move({ workspace = "-1", focus = true }))
hl.bind(mod .. " + CTRL + s", hl.dsp.window.move({ workspace = "+1", focus = true }))

hl.bind(alt .. " + x", hl.dsp.exec_cmd("playerctl next"))
hl.bind(alt .. " + z", hl.dsp.exec_cmd("playerctl previous"))

hl.bind(mod .. " + escape", hl.dsp.exec_cmd("pcmanfm"))
hl.bind(mod .. " + return", hl.dsp.exec_cmd("alacritty"))
hl.bind(alt .. " + 1", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
local closeWindowBind = hl.bind(mod .. " + q", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-open launcher"))
hl.bind(mod .. " + SHIFT + e", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))    

hl.bind(mod .. " + a",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + d", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mod .. " + w",    hl.dsp.focus({ direction = "up" }))
-- hl.bind(mod .. " + s",  hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + CTRL + a", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + CTRL + d", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + CTRL + w", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + CTRL + s", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 
    hl.bind(mod .. " + " .. key,               hl.dsp.focus({ workspace = i}))
    hl.bind(mod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, focus = true }))
end

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
