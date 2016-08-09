#The CS2D Dynamic Menu Library 0.2 stable
Author - [Nighthawk [#116310]](http://unrealsoftware.de/profile.php?userid=116310)

The CS2D Dynamic Menu Library (TCDML for short) is what you'd expect it to be. With the table structure and parsing being based on Engin33r & VADemon's unimenu, it provides many functionalities for full control over your menu(s). It's been tested and works great with Inventory Menus or any menu that is dynamic and requires rapid updates to its contents.
TCDML is still stable and working as any other menu script but I plan to add more functionality. 

If you want to have a quick look at how TCDML works, check out [main.lua](main.lua).

##Installation
Like any other LUA script for CS2D, include `dmenu.lua` to ***/sys/lua/server.lua*** or drop it in ***sys/lua/autorun/***

##Rolling it out
You need to hook 3 functions or simply include these functions in their respective hooks.

`dmenu.Construct(id)` needs to be added in the Join hook.
```
**Recommended**
addhook("join", "_join")
function _join(id)
	dmenu.Construct(id)
end
**or**
addhook("join", "dmenu.Construct")
```

`dmenu.Destruct(id)` needs to be added in the Leave hook.
```
**Recommended**
addhook("leave", "_leav")
function _leave(id)
	dmenu.Destruct(id)
end
**or**
addhook("leave", "dmenu.Destruct")
```

`dmenu.Hook` can directly be added as a hook function.
`addook("menu", "dmenu.Hook")`

You're done setting it up! Now lets head to the functions TCDML provides!


##Documentation

####dmenu:display
**Function** | `dmenu:display(id, menuName {,page})`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `page` (integer, you know what this is)
**Returns** | ***brings up the menu in-game*** or ***false***
**Info** | This function is usually added in the **serveraction** hook and as button functions to bring up other menus (such as the next page)
**Example** | `dmenu:display(id, "Inventory")`

####dmenu:add
**Function** | `dmenu:add(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true***
**Info** | Before utilizing a menu, you need to construct it. `menuName` becomes the internal ID of the menu and you can further on access the menu with other functions with this ID
**Example** | `dmenu:add(id, "Inventory")` `dmenu:add(id, "main-menu")`

####dmenu:remove
**Function** | `dmenu:remove(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true*** or ***false***
**Info** | Removes a menu.
**Example** | `dmenu:remove(id, "Inventory")`

####dmenu:push
**Function** | `dmenu:push(id, menuName, itemArr)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `itemArr` a valid TCDML menu array
**Returns** | ***true*** or ***false***
**Info** | This method **deepcopies** a valid TCDML menu array to a menu
**Example**
``` 
dmenu:push(id, "Inventory", {
	{"Heal Player", "Description", function(id) 
		dmenu:display(id, "Player List")
	end, true, {id}},	
	{"Medkit", nil, function() print('used medkit') end, true},	
	{"HE", "Disabled button", function() print('equipped HE') end, false},	
	{"Primary Ammo", "Description", function() print('added ammo') end, true},	
})
```

####dmenu:link
**Function** | `dmenu:link(id, menuName, itemArr)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `itemArr` a valid TCDML menu array
**Returns** | ***true*** or ***false***
**Info** | This method **link** a valid TCDML menu array to a menu. **If you use a local menu array in a function, it will be destroyed once the function ends so the link will become a nil value.** So use this for pre-set or global menu arrays.
**Example**
``` 
dmenu:link(id, "Menu", {
	{"Heal Player", "Description", function(id) 
		dmenu:display(id, "Player List")
	end, true, {id}},	
	{"Medkit", nil, function() print('used medkit') end, true},	
	{"HE", "Disabled button", function() print('equipped HE') end, false},	
	{"Primary Ammo", "Description", function() print('added ammo') end, true},
})
```

####dmenu:empty
**Function** | `dmenu:empty(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true*** or ***false***
**Info** | This method will empty the items/buttons from a valid TCDML menu array
**Example**
``` 
--updating the list of players
dmenu:empty(id, "Players List")
for _,pid in ipairs(player(0, "table")) do
	dmenu:addButton(id, "Players List", player(pid, "name"), player(pid, "usgn"), nil, false, id)
end
```

####dmenu:exists
**Function** | `dmenu:exists(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true*** or ***false***
**Info** | Checks whether if a menu with the internal menu id `menuName` exists
**Example**
``` 
if dmenu:exists(id, "Inventory") do
	print('Inventory exists!')
else
	print('or does it?')
end
```

####dmenu:addButton
**Function** | `dmenu:addButton(id, menuName, buttonName, buttonDesc, buttonFunc, buttonState, ...)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `buttonName` (string|nil, give it a name), `buttonDesc` (string, give the button a description, nil for no description), `buttonFunc` (function|nil), `buttonState` (boolean, enable/disable the button), `...` (whichever external variables you use in `buttonFunc` add them here to pass on the values)
**Returns** | ***true*** or ***false***
**Info** | Add a button to your menu!
**Example** | `dmenu:addButton(id, "Inventory", "Secondary Ammo", "Qty:5", function(id) print(player(id, "name").."has 5 secondary ammo packs") end, id)

####dmenu:removeButton
**Function** | `dmenu:removeButton(id, menuName, offset)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array)
**Returns** | ***true*** or ***false***
**Info** | Remove a button from your menu!
**Example** | `dmenu:removeButton(id, "Inventory", 4)`

####dmenu:editButton
**Function** | `dmenu:editButton(id, menuName, offset, buttonName, buttonDesc, buttonFunc, buttonState, ...)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array, `buttonName` (string|nil, give it a name), `buttonDesc` (string, give the button a description, nil for no description), `buttonFunc` (function|nil), `buttonState` (boolean, enable/disable the button), `...` (whichever external variables you use in `buttonFunc` add them here to pass on the values)
**Returns** | ***true*** or ***false***
**Info** | Edit the values of your button by offset
**Example** | `dmenu:editButton(id, "Inventory", 4, "Secondary Ammo", "Qty:5", function(id) print(player(id, "name").."has 5 secondary ammo packs") end, id)`

####dmenu:switchButton
**Function** | `dmenu:switchButton(id, menuName, offset, state)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array, `state` (boolean, enable/disable the button)
**Returns** | ***true*** or ***false***
**Info** | Enable/Disable the button by offset
**Example** | `dmenu:switchButton(id, "Inventory", 4, false) --disable this button`

####dmenu:getButtonPropertyByOffset
**Function** | `dmenu:getButtonPropertyByOffset(id, menuName, offset)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array
**Returns** | ***true*** or ***false***
**Info** | returns all button values (name, description, function, state) by offset
**Example** | `local property = dmenu:getButtonPropertyByOffset(id, "Inventory", 4)`

####dmenu:buttonExists
**Function** | `dmenu:buttonExists(id, menuName, offset)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array
**Returns** | ***true*** or ***false***
**Info** | Checks if a button exists by offset
**Example**
```
if dmenu:buttonExists(id, "Inventory", 4) then
	print('This button exists!')
else
	print('or does it?')
end
```

####dmenu:getButtonCount
**Function** | `dmenu:getButtonCount(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***integer***
**Info** | Get the number of items/buttons in a menu
**Example** | `local buttonCount = dmenu:getButtonCount(id, "Inventory")`
