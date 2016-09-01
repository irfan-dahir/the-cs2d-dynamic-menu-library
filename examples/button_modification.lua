--[[
	This is just a code example script to show you what DMENU/TCDML can do. You don't need this file to run it.

	This script is example code for the new features in version 1.3.0.0
]]

-- include dmenu if it's not in autorun or already included in server.lua
-- dofile("sys/lua/dmenu/dmenu.lua")

--[[
	Hooks
]]

addhook("join", "_join")
addhook("leave", "_leave")
addhook("menu", "dmenu.Hook")
addhook("serveraction", "_svaction")

function _join(id)
	dmenu.Construct(id)
	dmenu:add(id, "Menu")
	dmenu:add(id, "Empty Menu")
	dmenu:addButton(id, "Menu", "Button 1", "Button Desc", nil, true);
	dmenu:addButton(id, "Menu", "Button 2", "Button Desc", nil, true);
	dmenu:addButton(id, "Menu", "Button 3", "Button Desc", nil, true);
	dmenu:addButton(id, "Menu", "Button 4", "Button Desc", nil, true);
	dmenu:addButton(id, "Menu", "Item 5", "Button Desc", nil, true);
	print(#dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "Button ").." buttons start with the name \"Button\"!")
	--Change the 'Button 1's name to 'Ayy'
	-- Note the 3rd parameter here is the offset so getButtonPropertyByButtonNameMatch returns the button offset
	-- NOTE & REMEMBER FOR YOUR SANITY! IF IT MATCHES MULTIPLE BUTTONS THEN IT WILL RETURN AN ARRAY SO BECAREFUL THERE!
	dmenu:setButtonName(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "Button 1"), "Ayy")
	dmenu:setButtonDescription(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "Ayy"), "Lmao")
	dmenu:setButtonState(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "Ayy"), false)

	if (dmenu:isEmpty(id, "Empty Menu")) then
		print('Empty Menu is Empty!')
	else
		print('Empty Menu is not empty??!1 :O')
	end

	print(player(id, "name")..' has '..dmenu:getPlayerMenuCount(id)..' menu objects')
end

function _leave(id)
	dmenu.Destruct(id)
end

function _svaction(id, action)
	if action == 1 then --if someone presses F2
		dmenu:display(id, "Menu")
	end
end