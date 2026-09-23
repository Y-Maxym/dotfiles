
-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Workspaces per monitor
-- External monitor: 1–3
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })

-- Laptop screen: 4–6
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1", persistent = true })

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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
    name    = "btop-float",
    match   = { class = "^(btop)$" },
    float   = true,
    center  = true,
    size = "1400 900"
})

hl.window_rule({
    name   = "bluetui-float",
    match  = { class = "^(bluetui)$" },
    float  = true,
    center = true,
    size   = "1000 600",
})

hl.window_rule({
    name   = "wiremix-float",
    match  = { class = "^(wiremix)$" },
    float  = true,
    center = true,
    size   = "1000 600",
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
