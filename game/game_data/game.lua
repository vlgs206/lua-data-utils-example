game = {}
game.town = {}
---- towns
game.town.town_start = {}
game.town.town_start.display_name = 'Greenwood Village'
game.town.town_start.desc = [[Greenwood Village.]]
game.town.town_start.entrance_tax = 0 -- in gold (starting is 100 gold, we can change that though.)
game.town.town_start.npc = {}
-----
game.town.town_frostland = {}
game.town.town_frostland.display_name = 'The Frostlands' --so cold!
game.town.town_frostland.desc = [[The Frostlands.]]
game.town.town_frostland.entrance_tax = 100
game.town.town_frostland.npc = {} 
-----
game.town.town_southerland = {}
game.town.town_southerland.display_name = 'Southerland' --generic countryside town
game.town.town_southerland.desc = [[Southerland]]
game.town.town_southerland.entrance_tax = 150
game.town.town_southerland.npc = {}
-----
game.town.town_middleton = {}
game.town.town_middleton.display_name = 'Middleton' --middle class town
game.town.town_middleton.desc = [[Middleton]]
game.town.town_middleton.entrance_tax = 250
game.town.town_middleton.npc = {} 
-----
game.town.town_belhaven = {} -- Rich city with good traders
game.town.town_belhaven.display_name = 'Belhaven'
game.town.town_belhaven.entrance_tax = 500
game.town.town_belhaven.desc = [[Belhaven]]
game.town.town_belhaven.npc = {}
-----
----- npcs
game.npc = {}
game.npc.trade01 = {}
game.npc.trade01.display_name = "John Staton"
game.npc.trade01.desc = [[John Staton]]
game.npc.trade01.value = 25 -- between 1 and 100, determines item price multiplier.
game.npc.trade01.locations = {}
game.npc.trade01.locations[1] = "town_start"
-----
game.npc.trade02 = {}
game.npc.trade02.display_name = "Jerry MacGruber"
game.npc.trade02.desc = [[Jerry MacGruber]]
game.npc.trade02.value = 32
game.npc.trade02.locations = {}
game.npc.trade02.locations[1] = "town_start"
-----
game.npc.trade03 = {}
game.npc.trade03.display_name = "Benjamin Wilkes"
game.npc.trade03.desc = [[Benjamin Wilkes]]
game.npc.trade03.value = 37
game.npc.trade03.locations = {}
game.npc.trade03.locations[1] = "town_start"
-----
game.npc.trade03 = {}
game.npc.trade03.display_name = "Helen Barr"
game.npc.trade03.desc = [[Helen Barr]]
game.npc.trade03.value = 50
game.npc.trade03.locations = {}
game.npc.trade03.locations[1] = "town_middleton"
-----
game.npc.trade03 = {}
game.npc.trade03.display_name = "Joseph Farmer"
game.npc.trade03.desc = [[Joseph Farmer]]
game.npc.trade03.value = 45
game.npc.trade03.locations = {}
game.npc.trade03.locations[1] = "town_southerland"
-----
----- items
game.item = {}
game.item.wood_log = {}
game.item.wood_log.display_name = "Wood Log"
game.item.wood_log.total_gen = 75 -- % of 100 that this item will be in a trader's inventory
game.item.wood_log.min_generate = 5
game.item.wood_log.max_generate = 30
game.item.wood_log.value = 10
-----
game.item.wheat = {}
game.item.wheat.display_name = "Wheat"
game.item.wheat.total_gen = 90
game.item.wheat.min_generate = 1
game.item.wheat.max_generate = 20
game.item.wheat.value = 12
-----
game.item.flagstone = {}
game.item.flagstone.display_name = "Flagstone"
game.item.flagstone.total_gen = 60
game.item.flagstone.min_generate = 1
game.item.flagstone.max_generate = 10
game.item.flagstone.value = 50
-----
game.item.glass = {}
game.item.glass.display_name = "Glass"
game.item.glass.total_gen = 40 
game.item.glass.min_generate = 1
game.item.glass.max_generate = 15
game.item.glass.value = 80
-----
game.item.gold_medal = {}
game.item.gold_medal.display_name = "Golden Medallion"
game.item.gold_medal.total_gen = 5
game.item.gold_medal.min_generate = 1
game.item.gold_medal.max_generate = 1
game.item.gold_medal.value = 5000
-----
game.item.wood_board = {}
game.item.wood_board.display_name = "Finished Wooden Boards"
game.item.wood_board.total_gen = 50
game.item.wood_board.min_generate = 20
game.item.wood_board.max_generate = 55
game.item.wood_board.value = 15
-----
game.item.scrap_metal = {}
game.item.scrap_metal.display_name = "Scrap Metal"
game.item.scrap_metal.total_gen = 40
game.item.scrap_metal.min_generate = 2
game.item.scrap_metal.max_generate = 25
game.item.scrap_metal.value = 45
-----
game.item.lyre = {}
game.item.lyre.display_name = "Lyre"
game.item.lyre.total_gen = 18
game.item.lyre.min_generate = 1
game.item.lyre.max_generate = 2
game.item.lyre.value = 125
-----
game.item.iron_sword = {}
game.item.iron_sword.display_name = "Iron Sword"
game.item.iron_sword.total_gen = 20
game.item.iron_sword.min_generate = 1
game.item.iron_sword.max_generate = 7
game.item.iron_sword.value = 70
-----
game.item.copper_ingots = {}
game.item.copper_ingots.display_name = "Copper Ingots"
game.item.copper_ingots.total_gen = 30
game.item.copper_ingots.min_generate = 5
game.item.copper_ingots.max_generate = 15
game.item.copper_ingots.value = 40
-----
game.item.baked_bread = {}
game.item.baked_bread.display_name = "Loaf of Bread"
game.item.baked_bread.total_gen = 70
game.item.baked_bread.min_generate = 1
game.item.baked_bread.max_generate = 20
game.item.baked_bread.value = 15
-----
game.item.helmet = {}
game.item.helmet.display_name = "Helmet"
game.item.helmet.total_gen = 25
game.item.helmet.min_generate = 1
game.item.helmet.max_generate = 20
game.item.helmet.value = 100
return game