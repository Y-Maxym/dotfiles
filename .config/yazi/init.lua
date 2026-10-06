-- Yazi 26.9.x: startup script, runs once when yazi starts.
-- UI plugins are enabled here with require("name"):setup().

-- git: status signs next to files. Needs the fetchers registered in yazi.toml
require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
