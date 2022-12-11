<h1 align="center">Anomaly Tower</h1>

## Description:
* The map "Anomaly" aims to be an instanced map with tower climb like features. The map is fixed, but the difficulty and monsters on each floor are gradually stronger from the previous floor. Every 5th floor will contain an extra monster that will be a mini-boss and every 10th floor will be a boss floor.
* Players can enter solo or get help as a team, but only the players that are at that floor level will get the floor completion.
  * It can be customized how many players can enter the instance at once just in case.
* The monsters are chosen at random, they are set within a database so all players can expect the same monsters in that specific floor.

## Customization:
* Designate how many players can enter the instance:
  * `Anomaly.Conf.Players = 1`
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
* Monsters are chosen at random from their respective file where their base attribute are configured.
  * Monster File: `Anomaly Attribute Monster`.
  * Mini-Boss File: `Anomaly Attribute MiniBoss`.
  * Boss File: `Anomaly Attribute Boss`.

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
3. Create an NPC with the following that contains the following function:
  * `AnomalyNPC`
4. Look for the following function: `MsgProc`.
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
5. Look for the following function: `ActionsProc`.
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
6. Look for the following function: `GetExp_PKM`.
  * At the end of that function, add this:
    ```lua
    Anomaly.PKM(dead, atk)
    ```

## Requirements:
* Serialize.lua
* The map must be loaded in the same map where the NPC will be located.
* The name of the NPC must match whatever is placed in the variable `Anomaly.Conf.NameNPC`.

## Notes:
* Map will left as-is. No support will be given, unless I notice something is wrong with the installation process (something missing) or an issue with the main script. If you modified it and have issues with your added code, that's not an issue I will fix.
* Hopefully this gets something unique into public servers instead of all that copy paste stuff. We all know that won't happen, but never hurts to try.