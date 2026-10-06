
---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,ua,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "altwin:swap_alt_win,grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.2,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name          = "compx-nearlink-mouse-dongle-1",
    sensitivity   = 0,
    accel_profile = "flat",
})

hl.device({
    name          = "compx-atk-a9-2.0-nk-1",
    sensitivity   = 0,
    accel_profile = "flat",
})
