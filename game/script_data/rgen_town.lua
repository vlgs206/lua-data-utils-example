town_prefix = {
	"New",
	"Far",
	"North",
	"West",
	"South",
	"East",
	"Mount",
	"Downtown",
}

town_suffix = {
	" Yorkshire",
	" Brunswick",
	" Lebanon",
	" Way",
	" Greenville",
	" Briston",
	" Worthshire",
	" Hampton",
	" Lisbon",
	" London",
	"dale",
	" Foxstead",
	" Addison",
	" Hope"
}

town_prefix_ex = {
	"Hope",
	"Pensacola",
	"Alma",
	"Coso",
	"Hearst"
}

town_suffix_ex = {
	" County",
	" City"
}

h = io.open("output2.file","w")
for i = 1, 20 do 
	os.sleep(100)
	math.randomseed(os.clock()*1000000)
	x = math.random(0,1)
	if x == 0 then
		x = math.random(1,#town_prefix)
		x2 = math.random(1,#town_suffix)
		choice_1 = town_prefix[x]
		choice_2 = town_suffix[x2]
		id = choice_1..choice_2
		id = id:lower()
		id = id:gsub(" ","_")
		et = math.random(100,300)
		h:write("game.town."..id.." = {}\n")
		h:write("game.town."..id..".display_name = '"..choice_1..choice_2.."'\n")
		h:write("game.town."..id..".desc = '"..choice_1..choice_2.."'\n")
		h:write("game.town."..id..".entrance_tax = "..et.."\n")
		h:write("game.town"..id..".npc = {}".."\n")
	else
		x = math.random(1,#town_prefix_ex)
		x2 = math.random(1,#town_suffix_ex)
		choice_1 = town_prefix_ex[x]
		choice_2 = town_suffix_ex[x2]
		id = choice_1..choice_2
		id = id:lower()
		id = id:gsub(" ","_")
		et = math.random(100,300)
		h:write("game.town."..id.." = {}\n")
		h:write("game.town."..id..".display_name = '"..choice_1..choice_2.."'\n")
		h:write("game.town."..id..".desc = '"..choice_1..choice_2.."'\n")
		h:write("game.town."..id..".entrance_tax = "..et.."\n")
		h:write("game.town"..id..".npc = {}".."\n")
	end
end
h:close()