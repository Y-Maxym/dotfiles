
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            -- active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            active_border = "rgba(8ab4f8ff)",
            inactive_border = "rgba(55555566)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 12,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.08,

        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            color        = 0x66000000,
        },

        blur = {
            enabled   = true,
            size      = 5,
            passes    = 2,
            vibrancy  = 0.1696,
        },
    },
})

