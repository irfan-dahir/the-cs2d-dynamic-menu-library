# The CS2D Dynamic Menu Library 1.3.0.0
Author - [Nighthawk [#116310]](http://unrealsoftware.de/profile.php?userid=116310)

The CS2D Dynamic Menu Library (TCDML for short) is what you'd expect it to be. With the table structure and parsing being based on Engin33r & VADemon's unimenu, it provides many functionalities for full control over your menu(s). It's been tested and works great with Inventory Menus or any menu that is dynamic and requires rapid updates to its contents.
TCDML is still stable and working as any other menu script but I plan to add more functionality. 

If you want to have a quick look at how TCDML works, check out [main.lua](main.lua).

## Contents
1. [Installation](#)
	- [Vanilla](#)
	- [Y.A.T.E.S. Plugin](#)
2. [Configuration](#)
3. [Rolling It Out](#)
	- [dmenu.Construct(id)](#)
	- [dmenu.Destruct(id)](#)
	- [dmenu.Hook()](#)
4. [Documentation](#)
	- [dmenu:display(id, menu, {,page})](#)
	- [dmenu:add(id, menuName)](#)
	- [dmenu:remove(id, menuName)](#)
	- [dmenu:push(id, menuName, itemArr)](#)
	- [dmenu:link(id, menuName, itemArr)](#)
	- [dmenu:empty(id, menuName)](#)
	- [dmenu:exists(id, menuName)](#)
	- [dmenu:addButton(id, menuName, buttonName{, buttonDesc, buttonFunc, buttonState, ...})](#)
	- [dmenu:removeButton(id, menuName, offset)](#)
	- [dmenu:editButton(id, menuName, offset, buttonName{, buttonDesc, buttonFunc, buttonState, ...})](#)
	- [dmenu:setButtonName(id, menuName, offset, newName)](#)
	- [dmenu:setButtonDescription(id, menuName, offset, newDescription)](#)
	- [dmenu:setButtonState(id, menuName, offset, newState)](#)
	- [dmenu:setButtonFunction(id, menuName, offset, function() newFunction() end{, args})](#)
	- [dmenu:getButtonPropertyByOffset(id, menuName, offset)](#)
	- [dmenu:buttonExists(id, menuName, offset)](#)
	- [dmenu:getButtonCount(id, menuName)](#)
	- [dmenu:getPlayerMenuCount(id)](#)
	- [dmenu:playerMenuObjectExists(id)](#)
	- [dmenu:isEmpty(id, menuName)](#)


## Installation
## #Vanilla Installation
Like any other LUA script for CS2D, include **dmenu.lua** to ***/sys/lua/server.lua*** or drop it in ***sys/lua/autorun/***
***startup.lua*** is for the Y.A.T.E.S. plugin so it's not required.

## #Y.A.T.E.S. Admin Script Plugin Installation
Y.A.T.E.S. has a plugin feature which **DMenu** now supports. 
All you need to do is drop **dmenu** folder (yes, the whole folder) in Y.A.T.E.S. plugin directory. By default that should here **sys/lua/yates/plugins/**. Once you've done so, the **dmenu** folder in the plugin directory there only requires the ***startup.lua*** file so you can delete the rest.


## Configuration
The only configuration in here is logging. Open **dmenu.lua** and check out lines 9-11 (it won't melt your steel beams).
```
dmenu.log = true
dmenu.debug = true
dmenu.error = true
```
`dmenu.log` will switch the whole log process on/off. Logs are done by using print() and the log text can be found in your server console or your cs2d log files.
`dmenu.debug` will/will not log debug messages
`dmenu.error` will/will not log error messages
if `dmenu.log` is false then neither will it log debug or error messages!

## Rolling it out
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


## Documentation

## ## dmenu:display
**Function** | `dmenu:display(id, menuName {,page})`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `page` (integer, you know what this is)
**Returns** | ***brings up the menu in-game*** or ***false***
**Info** | This function is usually added in the **serveraction** hook and as button functions to bring up other menus (such as the next page)
**Example** | `dmenu:display(id, "Inventory")`

## ## dmenu:add
**Function** | `dmenu:add(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true***
**Info** | Before utilizing a menu, you need to construct it. `menuName` becomes the internal ID of the menu and you can further on access the menu with other functions with this ID
**Example** | `dmenu:add(id, "Inventory")` `dmenu:add(id, "Main Menu")`
**NOTE** | your second parameter will also be your menu's title at the top when it shows up, so make it look nice

## ## dmenu:remove
**Function** | `dmenu:remove(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***true*** or ***false***
**Info** | Removes a menu.
**Example** | `dmenu:remove(id, "Inventory")`

## ## dmenu:push
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

## ## dmenu:link
**Function** | `dmenu:link(id, menuName, itemArr)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `itemArr` a valid TCDML menu array
**Returns** | ***true*** or ***false***
**Info** | This method **link** a valid TCDML menu array to a menu. **If you use a local menu array in a function, it will be destroyed once the function ends so the link will become a nil value.** So use this for pre-set or global menu arrays.
**Example**
``` 
_a_valid_tcdml_button_array = {
		{"Heal Player", "Description", function(id) 
			dmenu:display(id, "Player List")
		end, true, {id}},	
		{"Medkit", nil, function() print('used medkit') end, true},	
		{"HE", "Disabled button", function() print('equipped HE') end, false},	
		{"Primary Ammo", "Description", function() print('added ammo') end, true},
}
dmenu:link(id, "Menu", _a_valid_tcdml_button_array)
```

## ## dmenu:empty
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

## ## dmenu:exists
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

## ## dmenu:addButton
**Function** | `dmenu:addButton(id, menuName, buttonName, buttonDesc, buttonFunc, buttonState, ...)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `buttonName` (string|nil, give it a name), `buttonDesc` (string, give the button a description, nil for no description), `buttonFunc` (function|nil), `buttonState` (boolean, enable/disable the button), `...` (whichever external variables you use in `buttonFunc` add them here to pass on the values)
**Returns** | ***true*** or ***false***
**Info** | Add a button to your menu!
**Example** | `dmenu:addButton(id, "Inventory", "Secondary Ammo", "Qty:5", function(id) print(player(id, "name").."has 5 secondary ammo packs") end, id)

## ## dmenu:removeButton
**Function** | `dmenu:removeButton(id, menuName, offset)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array)
**Returns** | ***true*** or ***false***
**Info** | Remove a button from your menu!
**Example** | `dmenu:removeButton(id, "Inventory", 4)`

## ## dmenu:editButton
**Function** | `dmenu:editButton(id, menuName, offset, buttonName, buttonDesc, buttonFunc, buttonState, ...)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array, `buttonName` (string|nil, give it a name), `buttonDesc` (string, give the button a description, nil for no description), `buttonFunc` (function|nil), `buttonState` (boolean, enable/disable the button), `...` (whichever external variables you use in `buttonFunc` add them here to pass on the values)
**Returns** | ***true*** or ***false***
**Info** | Edit the values of your button by offset
**Example** | `dmenu:editButton(id, "Inventory", 4, "Secondary Ammo", "Qty:5", function(id) print(player(id, "name").."has 5 secondary ammo packs") end, id)`

## ## dmenu:setButtonName
**Function** | `dmenu:setButtonName(id, menuName, offset, state)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array, `state` (boolean, enable/disable the button)
**Returns** | ***true*** or ***false***
**Info** | Enable/Disable the button by offset
**Example** | `dmenu:setButtonName(id, "Inventory", 4, false) --disable this button`

## ## dmenu:getButtonPropertyByOffset
**Function** | `dmenu:getButtonPropertyByOffset(id, menuName, offset)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array
**Returns** | ***true*** or ***false***
**Info** | returns all button values (name, description, function, state) by offset
**Example** | `local property = dmenu:getButtonPropertyByOffset(id, "Inventory", 4)`

## ## dmenu:setButtonDescription
**Function** | `dmenu:setButtonDescription(id, menuName, offset, newDescription)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array), new description (string)
**Returns** | ***true*** or ***false***
**Related** | [dmenu:getButtonPropertyByButtonNameMatch](#)
**Example**
```
dmenu:setButtonDescription(id, "Menu", 1, "New Description")
dmenu:setButtonDescription(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "This Unique Button"), "New Description")
```

## ## dmenu:setButtonState
**Function** | `dmenu:setButtonState(id, menuName, offset, newDescription)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array), new state (boolean)
**Returns** | ***true*** or ***false***
**Related** | [dmenu:getButtonPropertyByButtonNameMatch](#)
**Example**
```
dmenu:setButtonDescription(id, "Menu", 1, false)
dmenu:setButtonDescription(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "This Unique Button"), false)
```

## ## dmenu:setButtonFunction
**Function** | `dmenu:setButtonFunction(id, menuName, offset, function)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), `offset` (integer, the item/button offset in the menu array), new function
**Returns** | ***true*** or ***false***
**Related** | [dmenu:getButtonPropertyByButtonNameMatch](#)
**Example**
```
dmenu:setButtonDescription(id, "Menu", 1, function() print('x+y='..(x+y)) end, x, y)
dmenu:setButtonDescription(id, "Menu", dmenu:getButtonPropertyByButtonNameMatch(id, "Menu", "This Unique Button"), function() print('x+y='..(x+y)) end, x, y)
```

## ## dmenu:buttonExists
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

## ## dmenu:getButtonCount
**Function** | `dmenu:getButtonCount(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu)
**Returns** | ***integer***
**Info** | Get the number of items/buttons in a menu
**Example** | `local buttonCount = dmenu:getButtonCount(id, "Inventory")`

## ## dmenu:getButtonPropertyByButtonNameMatch
**Function** | `dmenu:getButtonPropertyByButtonNameMatch(id, menuName, buttonNameMatch)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string, internal name of the menu), buttonNameMatch (string, regex)
**Returns** | ***integer*** | ***array***
**Info** | Matches string or regex from the list of buttons in a menu and returns the offset of the button
**Note!** | Multiple matches return offsets in an array!
**Example** | `local matches = dmenu:getButtonPropertyByButtonNameMatch(id, menuName, "Button")`

## ## dmenu:playerMenuObjectExists
**Function** | `dmenu:playerMenuObjectExists(id)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID)
**Returns** | ***boolean***
**Info** | Checks if the *main* menu array of a player is set
**Note!** | Not the same as dmenu:exists!
**Example** | `print('player menu initialization is '..tostring(dmenu:playerMenuObjectExists(id)))`

## ## dmenu:isEmpty
**Function** | `ddmenu:isEmpty(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (string)
**Returns** | ***boolean***
**Info** | Checks whether a menu is empty or not
**Example**
```
if dmenu:isEmpty(id, "Inventory") then
	msg('Inventory is empty!')
else
	dmenu:display(id, "Inventory")
end
```



## Changelog
**1.3.0.0 {**
	- Made README.md more easier to navigate
	- Added an **example** directory filled with some common usage examples and scripts
	- Fixed documentation errors
	- Added ***Y.A.T.E.S.*** plugin support
	- Added more configuration options
	- Error and Debug Log Prints are colored in the console
	- **dmenu:switchButton** is renamed to **dmenu:setButtonState**
	- Added moar functions
		- **dmenu:setButtonName**
		- **dmenu:setButtonDescription**
		- **dmenu:setButtonFunction**
		- **dmenu:getButtonPropertyByButtonNameMatch(id, menuName, buttonNameMatch)** *(This supports regex matching!)*
		- **dmenu:getPlayerMenuCount(id)**
		- **dmenu:playerMenuObjectExists(id)**
		- **dmenu:isEmpty(id, menuName)**
**}**
**1.2.0.0 {**
	- Stable release
**}**
**0.1.0.0 {**
	- Initial Git alpha release
**}**
