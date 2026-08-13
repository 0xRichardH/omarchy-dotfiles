-- Keep personal keybinding overrides here. Omarchy's default application
-- bindings are loaded before this file.

-- Monitor and display management.
o.bind(
  "SUPER + ALT + M",
  "External monitor mode",
  [[hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = true }); hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1.6 })']]
)
o.bind("SUPER + ALT + R", "Reload Hyprland config", "hyprctl reload")

-- Override Omarchy's Google Maps binding with the screenshot command.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")

-- Move Quattro's clipboard manager from SUPER + CTRL + V to SUPER + SHIFT + P.
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + SHIFT + P", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")
