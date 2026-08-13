-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Optimized for the laptop's retina-class display and 2x scaling.
hl.env("GDK_SCALE", "2")
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Mirror an external display at 2x scaling.
-- hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "0x0", scale = 2 })
-- hl.monitor({ output = "HDMI-A-1", mode = "2880x1800@60", position = "0x0", scale = 2, mirror = "eDP-1" })

-- Use only an external display with fractional scaling.
-- hl.monitor({ output = "eDP-1", disabled = true })
-- hl.env("GDK_SCALE", "1.75")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6 })

-- Straight 1x setup for lower-resolution displays.
-- hl.env("GDK_SCALE", "1")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
