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
    * Formula: `Anomaly.Conf.Attribute.Normal * FloorLevel`