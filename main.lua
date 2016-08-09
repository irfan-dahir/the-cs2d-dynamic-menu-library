--[[
	This is just a code example script to show you what DMENU/TCDML can do. You don't need this file to run it.
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
	-- this must be added in the join/team hook
	dmenu.Construct(id)
	-- the rest here can be added anywhere
	dmenu:add(id, "Menu")
	dmenu:add(id, "Second Menu")
	dmenu:add(id, "Third Menu")
	dmenu:add(id, "Fourth Menu")
	dmenu:add(id, "Fifth Menu")
	dmenu:add(id, "Sixth Menu")
	dmenu:add(id, "Final Menu")

	--Fill in the first menu with a custom item array
	dmenu:push(id, "Menu", {
		{"Button 1", "Description", function(id) 
			dmenu:display(id, "Second Menu")
		end, true, {id}},	
		{"Button 2", nil, function() print('le function') end, true},	
		{"Button 3", "Disabled button", function() print('le function') end, false},	
		{"Button 4", "Description", function() print('le function') end, true},	
		{"Button 5", "Description", function() print('le function') end, true},	
	})

	--Now let us use :addButton which does the same thing but makes it easier for you
	--We shall add some buttons into our Second Menu
	for i=1,5 do
		dmenu:addButton(id, "Second Menu", "Button "..i, "description", function(i) print(i) end, true, i)
	end
	-- Let's change the function property of the first button to make it display the third menu
	dmenu:editButton(id, "Second Menu", 1, "Button 1", "version 2", function(id)
		dmenu:display(id, "Third Menu")
	end, true, id)

	--add stuff to the third, fourth, fifth & sixth menu
	for i=1,24 do
		--lets add 24 buttons to each menu
		dmenu:addButton(id, "Third Menu", "Button "..i, nil, nil, true)
		dmenu:addButton(id, "Fourth Menu", "Button "..i, nil, nil, true)
		dmenu:addButton(id, "Fifth Menu", "Button "..i, nil, nil, true)
		dmenu:addButton(id, "Sixth Menu", "Button "..i, nil, nil, true)
	end

	--lets link the first button of every menu to it's sub menu
	dmenu:editButton(id, "Third Menu", 1--[[ this is the button offset btw ]], "Fourth Menu", nil, function(id) dmenu:display(id, "Fourth Menu") end, true, id --[[and whatever arguments come after the boolean argument are arguments that are passed on to the function of thue btton]])
	dmenu:editButton(id, "Fourth Menu", 1, "Fifth Menu", nil, function(id) dmenu:display(id, "Fifth Menu") end, true, id)
	dmenu:editButton(id, "Fifth Menu", 1, "Sixth Menu", nil, function(id) dmenu:display(id, "Sixth Menu") end, true, id)

	--lets have some fun and disable all the buttons in the sixth menu except for the first one
	for i=2, dmenu:getButtonCount(id, "Sixth Menu") do
		dmenu:switchButton(id, "Sixth Menu", i, false)
	end

	--now let us finally link the first button in the sixth menu to our final menu
	dmenu:editButton(id, "Sixth Menu", 1, "Clicky", nil, function(id) dmenu:display(id, "Final Menu") end, true, id)

	--lets construct our final menu now.
	dmenu:addButton(id, "Final Menu", "First Menu", nil, function(id) dmenu:display(id, "Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Second Menu", nil, function(id) dmenu:display(id, "Second Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Third Menu", nil, function(id) dmenu:display(id, "Third Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Fourth Menu", nil, function(id) dmenu:display(id, "Fourth Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Fifth Menu", nil, function(id) dmenu:display(id, "Fifth Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Sixth Menu", nil, function(id) dmenu:display(id, "Sixth Menu") end, true, id)
	dmenu:addButton(id, "Final Menu", "Final Menu", nil, function(id) dmenu:display(id, "Final Menu") end, true, id)

	-- oh wait, the last button is an extra, lets go ahead and remove it
	dmenu:removeButton(id, "Final Menu", 7)
end

function _leave(id)
	dmenu.Destruct(id)
end

function _svaction(id, action)
	if action == 1 then
		dmenu:display(id, "Menu")
	end
end