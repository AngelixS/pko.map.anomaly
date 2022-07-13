<h1 align="center">Anomaly Tower</h1>

The map "Anomaly" aims to be an instanced map with tower climb like features. The map is fixed, but the difficulty and monsters on each floor are generated and saved each time the floor maximum limit is increased.

## Customization:
* Enable/disable the whole map script with just a variable.
  * `Anomaly.Conf.Enable = true` or `Anomaly.Conf.Enable = false`
* Enable/disable test mode, which makes all monster not attack.
  * `Anomaly.Conf.Test = true` or `Anomaly.Conf.Test = false`
* Increase the floor limit by just changing a variable.
  * `Anomaly.Conf.FloorLimit = 10`
* Increase the number of instances available at a single time.
  * `Anomaly.Conf.Instances = 5`
* Adjust the monster's attribute modifiers:
  * Increases the monster's attribute per level.
    * Adjust: `Anomaly.Conf.Attribute.Normal = 0.010`
    * Formula: `1 + (Anomaly.Conf.Attribute.Normal * FloorLevel)`
  * Increases the miniboss' attribute (every 5th level).
    * Adjust: `Anomaly.Conf.Attribute.Medium = 0.025`
    * Formula: `1 + (Anomaly.Conf.Attribute.Normal * FloorLevel) + Anomaly.Conf.Attribute.Medium`
  * Increases the boss' attribute (every 10th level).
    * Adjust: `Anomaly.Conf.Attribute.Final = 0.050`
    * Formula: `1 + (Anomaly.Conf.Attribute.Normal * FloorLevel) + Anomaly.Conf.Attribute.Final`

## Installation:
### Client:
1. Place contents from `Client` into your client folder.
2. Add the following line into your `MapInfo.txt`.
  * `XX	Anomaly	Anomaly Tower	1	50,50	3,50,50	255,255,255`
3. Compile the client text files.
### Server:
1. Place contents from `Server` into your resource folder from your server.
2. Call the functions file to load the functions into the server.
  * Add the following line into the last file loaded in your server.
    ```lua
    dofile(GetResPath("Anomaly/Anomaly Function.lua"))
    ```
3. The map must be loaded in the same map where the NPC will be located.
4. Create an NPC with the following function:
  * `AnomalyNPC`
    * The name of the NPC must match whatever is placed in the variable `Anomaly.Conf.NameNPC`.
5. Look for the following function: `MsgProc`.
  * Look for this:
  	```lua
    elseif item.func == ChangeItem then
			return ChangeItem(character,npc)
    ```
  * Add this below that:
  	``` lua
    elseif item.func == Anomaly.Register then
      return Anomaly.Register(character, npc)
    ```
6. Look for the following function: `ActionsProc`.
  * Look for this:
    ```lua 
    elseif actions[i].func == AddExp_6 then
			PRINT( "ActionProc: AddExp_6, p1 = ", actions[i].p1)
			local ret = AddExp_6( character,npc, actions[i].p1)
		  if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddExp_6 = false" )
				return LUA_FALSE
			end
    ```
  * Add this below that:
    ```lua
    elseif actions[i].func == NpcInfoReload then
			NpcInfoReload(actions[i].p1, actions[i].p2)
			return
    ```



### Requirements:
* Serialize.lua
