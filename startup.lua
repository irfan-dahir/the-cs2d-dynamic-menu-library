--[[
	Y.A.T.E.S Plugin Support

	NOTICE!
	startup.lua is the plugin name for Y.A.T.E.S. All you have to do to install this rather than going for vanilla installation is drag and drop the 'dmenu' folder as a whole into the plugins folder in Y.A.T.E.S
]]
yates.plugin["dmenu"]["title"] = "Dynamic CS2D Menu Library"
yates.plugin["dmenu"]["author"] = "Nighthawk"
yates.plugin["dmenu"]["usgn"] = "116310"
yates.plugin["dmenu"]["version"] = "1.3.0.0"
yates.plugin["dmenu"]["description"] = "An awesome & dynamic cs2d menu management library!"

dofileLua(yates.plugin["dmenu"]["dir"].."dmenu.lua")