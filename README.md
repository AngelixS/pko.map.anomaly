<h1 align="center">Anomaly Tower</h1>

The map "Anomaly" aims to be an instanced map with tower climb like features. The map is fixed, but the difficulty and monsters on each floor are generated and saved each time the floor maximum limit is increased.

## Customizable:
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
1. Client:
  1. Place contents from `Client` into your client folder.
  2. Add the following line into your `MapInfo.txt`, adjust the number according to your file and compile directly from your client.
    * ```XX	Anomaly	Anomaly Tower	1	50,50	3,50,50	255,255,255```
