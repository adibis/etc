home = os.getenv("HOME")
themedir = home .. "/.config/awesome/theme"

theme = {}

--theme.font = "Dejavu Sans Mono 8"
theme.font = "Monaco Bold 10"

primary = "#232c31"
secondary = primary

theme.wallpaper = home .. "/Pictures/arch.png"
--theme.wallpaper_cmd = { "nitrogen --restore" }

theme.fg_normal = "#bcbcbc"
theme.fg_focus = "#7e9ab7"

theme.bg_normal = primary
theme.bg_focus = primary

theme.border_width = 2
theme.border_normal = primary
theme.border_focus = theme.fg_focus

theme.awesome_icon = themedir .. "/../icons/archlogo.png"

return theme
