--[[
	Online Players
	An example script which utilizes TCDML/DMenu to create a dynamic list of players and display their information
]]
if p == nil then p = {} end
function p.initArray(endset,value) if value == nil then value = 0 end local array = {} for i=1, endset do array[i] = value end return array end

--[[
	If dmenu is NOT in autorun or loaded as a plugin in Y.A.T.E.S. admin script then include it
	dofile("sys/lua/dmenu.lua")
]]

--[[
	Hooks
]]
addhook("join", "p.Join")
addhook("leave", "p.Leave")
addhook("serveraction", "p.Serveraction")
addhook("menu", "dmenu.Hook")

--[[
	Hook Methods
]]
function p.Join(id)
	-- construct the player's menu object
	dmenu.Construct(id)
	-- make the online players menu for the user
	dmenu:add(id, "Online Players")
end

function p.Leave(id)
	-- destruc tthe player's menu object
	dmenu.Destruct(id)
end

function p.Serveraction(id, cmdbutton)
	if cmdbutton == 1 then -- F2
		--Refresh his menu object
		dmenu:empty(id, "Online Players")
		-- Make a TCDML array
		local buttonArray = {}
		for _,id2 in pairs(player(0, "table")) do
			local team = ""
			if player(id2, "team") == 0 then team = "Spectator" elseif player(id2, "team") == 1 then team = "Terrorist" elseif player(id2, "team") == 2 then team = "Counter Terrorist" end
			-- add the button
			dmenu:addButton(id, "Online Players", player(id2, "name"), team, function(id)
				msg("[WHOIS] Name: "..player(id2, "name").." USGN: "..player(id2, "usgn").." IP: "..player(id2, "ip"))
			end, true, id, id2)
			-- Add a valid TCDML entry to the TCDML button array
			--[[buttonArray[ #buttonArray+1 ] = {player(id2, "name"), team, function(id, id2)
				msg2(id, "[WHOIS] Name: "..player(id2, "name").." USGN: "..player(id2, "usgn").." IP: "..player(id2, "ip"))
			end, true, {id, id2}}]]
		end
		-- Push the button array into the menu
		dmenu:push(id, "Online Players", buttonArray)
		-- show it to him
		dmenu:display(id, "Online Players")
	end
end