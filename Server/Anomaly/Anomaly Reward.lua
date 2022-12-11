--  Type:   Corresponds to being the main player or support. Main = 01 / Support = 02
--  Floor:  Corresponds to the floor type. Normal = 01 / Mini-Boss = 02 / Boss = 03
--  Random: Is this reward guaranteed? Yes = true / No = false.

--  Reward: Floor 1 - 50.
Anomaly.Reward[01] = {
    --  Main Player, Normal Floor, Guaranted.
    {Allow = true, Type = 01, Floor = 01, Random = false, Gold = 001000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Main Player, Normal Floor, Random.
    {Allow = true, Type = 01, Floor = 01, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Main Player, Mini-Boss Floor, Guaranted.
    {Allow = true, Type = 01, Floor = 02, Random = false, Gold = 002000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Main Player, Mini-Boss Floor, Random.
    {Allow = true, Type = 01, Floor = 02, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Main Player, Boss Floor, Guaranted.
    {Allow = true, Type = 01, Floor = 03, Random = false, Gold = 003000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Main Player, Boss Floor, Random.
    {Allow = true, Type = 01, Floor = 03, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Normal Floor, Guaranted.
    {Allow = true, Type = 02, Floor = 01, Random = false, Gold = 000500, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Normal Floor, Random.
    {Allow = true, Type = 02, Floor = 01, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Mini-Boss Floor, Guaranted.
    {Allow = true, Type = 02, Floor = 02, Random = false, Gold = 001000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Mini-Boss Floor, Random.
    {Allow = true, Type = 02, Floor = 02, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Boss Floor, Guaranted.
    {Allow = true, Type = 02, Floor = 03, Random = false, Gold = 001500, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
    --  Support Player, Boss Floor, Random.
    {Allow = true, Type = 02, Floor = 03, Random = true, Gold = 000000, Item = 0000, Quantity = 01, Quality = 000, Rate = 0001},
                    }