#The CS2D Dynamic Menu Library 0.2 stable
Author - [http://unrealsoftware.de/profile.php?userid=116310](Nighthawk [#116310])

The CS2D Dynamic Menu Library (TCDML for short) is what you'd expect it to be. With the table structure and parsing being based on Engin33r & VADemon's unimenu, it provides many functionalities for full control over your menu(s). It's been tested and works great with Inventory Menus or any menu that is dynamic and requires rapid updates to its contents.
TCDML is still stable and working as any other menu script but I plan to add more functionality. 

If you want to have a quick look at how TCDML works, check out [main.lua](main.lua).

###Installation
Like any other LUA script for CS2D, include `dmenu.lua` to `/sys/lua/server.lua` or drop it in `sys/lua/autorun/`.

###Rolling it out
You need to hook 3 functions or simply include these functions in their respective hooks.
`dmenu.Construct(id)` needs to be added in the Join hook.
````--recommended method
addhook("join", "_join")
function _join(id)
	dmenu.Construct(id)
end

--or
addhook("join", "dmenu.Construct")
````
`dmenu.Destruct(id)` needs to be added in the Leave hook.
````--recommended method
addhook("leave", "_leav")
function _leave(id)
	dmenu.Destruct(id)
end

--or
addhook("leave", "dmenu.Destruct")
````
`dmenu.Hook` can directly be added as a hook function.
````--recommended method
addook("menu", "dmenu.Hook")
````

You're done setting it up! Now lets head to the functions TCDML provides!


###Documentation

#####dmenu:display
**Function** | `dmenu:display(id, menuName {,page})`
------------ | -----------------------------------
**Parameters** | `id` (integer, player ID), `menuName` (internal name of the menu), `page` (you know what this is)
**Return** | ***brings up the menu in-game*** or ***false***
