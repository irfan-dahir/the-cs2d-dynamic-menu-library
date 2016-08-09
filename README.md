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
**Parameters** | `id` (integer, player ID), `menuName` (internal name of the menu), `page` (you know what this is)
**Returns** | ***brings up the menu in-game*** or ***false***
**Info** | This function is usually added in the **serveraction** hook and as button functions to bring up other menus (such as the next page)
**Example** | `dmenu:display(id, "Inventory")`

####dmenu:add
**Function** | `dmenu:add(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (internal name of the menu)
**Returns** | ***true***
**Info** | Before utilizing a menu, you need to construct it. `menuName` becomes the internal ID of the menu and you can further on access the menu with other functions with this ID
**Example** | `dmenu:add(id, "Inventory")` `dmenu:add(id, "main-menu")`

####dmenu:remove
**Function** | `dmenu:remove(id, menuName)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (internal name of the menu)
**Returns** | ***true*** or ***false***
**Info** | Removes a menu.
**Example** | `dmenu:remove(id, "Inventory")`

####dmenu:push
**Function** | `dmenu:push(id, menuName, itemArr)`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (internal name of the menu), `itemArr` a valid TCDML menu array
**Returns** | ***true*** or ***false***
**Info** | This method **deepcopies** a valid TCDML menu array to a menu
**Example** | ```
dmenu:push(id, "Menu", {
	{"Button 1", "Description", function(id) 
		dmenu:display(id, "Second Menu")
	end, true, {id}},	
	{"Button 2", nil, function() print('le function') end, true},	
	{"Button 3", "Disabled button", function() print('le function') end, false},	
	{"Button 4", "Description", function() print('le function') end, true},	
	{"Button 5", "Description", function() print('le function') end, true},	
})
```