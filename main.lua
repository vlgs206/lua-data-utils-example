io.old_read = io.read
function io.read()
	x = io.old_read()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	print()
	return x
end

dofile("api/events.lua")
dofile("api/data-utils.lua")

function clearInstance(id)
	for k,v in pairs(game.player.inv) do
		if v[2].id == id then
			game.player.inv[k] = nil
		end
	end
	for k,v in pairs(game.trader) do
		for k2,v2 in pairs(v) do
			if v2[2].id == id then
				game.trader[k][k2] = nil
			end
		end
	end
end

while true do
	math.randomseed(os.time())

	function table.serialize(tbl)
	end
	dofile("api/events.lua")
	dofile("api/data-utils.lua")
	dofile("data/hooks.lua")
	game = {}
	
	config = dofile("user/game.cfg")
	script_reg = dofile("game/script_data.lua")
	----------
	game = table.deep_merge( game , dofile ("game/game_data.lua") )
	----------

	for k,v in pairs(game.item) do
		v.id = k
	end
	
	for k,v in pairs(game.npc) do
		v.id = k
	end	
	
	for k,v in pairs(game.town) do
		v.id = k
	end
		
	function save()
		h = io.open("user/save.dat","w")
		h:write("return "..table.serialize(game.player))
		h:close()
		h = io.open("user/trader.dat","w")
		h:write("return "..table.serialize(game.trader))
		h:close()
	end
	if io.exists("user/save.dat") then
		game.player = dofile("user/save.dat")
		print("[USER LOADED FROM SAVE]")
	else
		game.player = {}
		game.player.barter = config.start_barter
		game.player.gold = config.start_gold
		game.player.inv = {}
		game.player.location = game.town[config.default_location]
	end

	function game:fillTraders()
		math.randomseed(os.time())
		for k,v in pairs(self.trader) do
			for k2,v2 in pairs(self.item) do	
				chance = math.random(1,100)
				if chance <= v2.total_gen then
					rgen = math.random(v2.min_generate, v2.max_generate)
					if rgen > 0 then -- rgen > 0
						ret = nil
						for k3,v3 in pairs(v) do
							if v3[2] == v2 then
								ret = k3
							end
						end
						if ret ~= nil then
							v[ret][1] = v[ret][1] + rgen
						else
							table.insert(v,{rgen,v2})
						end
					end
				end
			end
		end
	end

	if io.exists("user/trader.dat") then
		game.trader = dofile("user/trader.dat")
		print("[TRADERS LOADED FROM SAVE]")
	else
		game.trader = {}
		for k,v in pairs(game.npc) do
			game.trader[k] = {}
		end
		game:fillTraders()
	end

	function inTable(tbl, val)
		for k,v in pairs(tbl) do
			if v == val then
				return true
			end
		end 
		return false
	end

	for k,v in pairs(game.npc) do
		for k2,v2 in pairs(v.locations) do
			table.insert(game.town[v2].npc,v)
		end
	end

	function transfer(source, target, id, quantity, iter)
		for k,v in pairs(source) do
			if v[2].id == id then
				curritm = k
			end
	 	end
		if curritm == nil then
			return "err01"
		end
		if source[curritm][1] < quantity then
			return "err02"
		end
		for k,v in pairs(target) do
			if v.id == id then
				ovw = k
			end
		end
		if ovw == nil then
			target[curritm] = {}
			table.deep_merge(target[curritm],source[curritm])
			target[curritm][1] = quantity
			source[curritm][1] = source[curritm][1] - quantity
			if source[curritm][1] == 0 then
				source[curritm] = nil
			end
			return source, target
		elseif ovw ~= nil then
			print(target[curritm][1])
			print(source[curritm][1])
			target[ovw][1] = target[ovw][1] + quantity
			source[curritm][1] = source[curritm][1] - quantity
			if source[curritm][1] == 0 then
				source[curritm] = nil
			end
			return source, target
		end
	end

	function shop(trader)
		while true do
			print(trader.desc)
			print("1: Exit")
			print("2: Buy")
			print("3: Sell")
			local inp = io.read()
			if inp == "1" then
				break
			elseif inp == "2" then
				while true do
					print("0: Exit")
					for k,v in pairs(game.trader[trader.id]) do
						print(k..": "..v[2].display_name..", Amt: "..v[1])
					end
					inp = io.read()
					if inp == "0" then
						break
					elseif game.trader[trader.id][tonumber(inp)] ~= nil then
						item_ref = game.trader[trader.id][tonumber(inp)]
						while true do
							print("Amount: ("..item_ref[1].." in stock)")
							amt = tonumber(io.read())
							if amt ~= nil and amt <= item_ref[1] then
								if amt ~= 0 and amt == math.abs(amt) then
									break
								else
									print("Input is 0 or negative!")
								end
							elseif amt == nil then
								print("Not a number!")
							elseif amt >= item_ref[1] then
								print("There's only "..item_ref[1])
							else
								print("Not a number!")
							end
						end
						local val = ( config.item_buy_multiplier * item_ref[2].value * (trader.value/25) ) / (game.player.barter/25)
						local chance = config.trade_guess_chances
						while true do
							if chances == 0 then
								print("No chances left!")
								break
							end
							print("Guess price - Chances: "..chance)
							inp = io.read()
							if tonumber(inp) >= val then
								if amt*tonumber(inp) <= game.player.gold then
									print("Sold! You bought "..amt.." '"..item_ref[2].display_name.."' for "..amt*tonumber(inp).." gold!")
									game.trader[trader.id], game.player.inv = transfer(game.trader[trader.id], game.player.inv, item_ref[2].id, amt)
									game.player.gold = game.player.gold - amt*tonumber(inp)
									game.player.barter = game.player.barter + config.barter_increase
								else
									print("You only have "..game.player.gold.." gold!")
								end
								break
							else
								chance = chance - 1
								print("That's too low for the trader!")
							end
						end
					end
				end
			elseif inp == "3" then
				while true do
					print("0: Exit")
					for k,v in pairs(game.player.inv) do
						print(k..": "..v[2].display_name..", Amt: "..v[1])
					end
					inp = io.read()
					if inp == "0" then
						break
					elseif game.player.inv[tonumber(inp)] ~= nil then
						item_ref = game.player.inv[tonumber(inp)]
						while true do
							print("Amount: ("..item_ref[1].." in stock)")
							amt = tonumber(io.read())
							if amt ~= nil and amt <= item_ref[1] then
								if amt ~= 0 and amt == math.abs(amt) then
									break
								else
									print("Input is 0 or negative!")
								end
							elseif amt == nil then
								print("Not a number!")
							elseif amt >= item_ref[1] then
								print("There's only "..item_ref[1])
							else
								print("Not a number!")
							end
						end
						local val = ( config.item_buy_multiplier * item_ref[2].value * (trader.value/25) ) / (game.player.barter/25)
						local chance = config.trade_guess_chances
						while true do
							if chance == 0 then
								print("No chances left!")
								break
							end
							print("Guess price - Chances: "..chance)
							inp = io.read()
							if tonumber(inp) <= val then
								print("Sold! You sold "..amt.." '"..item_ref[2].display_name.."' for "..amt*tonumber(inp).." gold!")
								game.player.inv, game.trader[trader.id] = transfer(game.player.inv, game.trader[trader.id], item_ref[2].id, amt)
								game.player.gold = game.player.gold + amt*tonumber(inp)
								game.player.barter = game.player.barter + config.barter_increase
								break
							else
								chance = chance - 1
								print("That's too high for the trader!")
							end
						end
					end
				end
			end
		end
	end

	function inventory()
		while true do
			print("0: Exit")
			for k,v in pairs(game.player.inv) do
				print(k..": "..v[2].display_name..", Amt: "..v[1])
			end
			inp = io.read()
			if inp == "0" then
				break
			end
		end
	end

	while true do
		print(game.player.location.desc)
		print("1: Travel to another location.")
		print("2: Talk with traders.")  
		print("3: Open your pack.")
		print("4: Save")
		print("5: Status")
		print("6: Reload Game")
		print("9999: Delete Save")
		print("0: Exit")
		inp = io.read()
		if inp == "1" then
			print("0: Exit")
			loctbl = {}
			for k,v in pairs(game.town) do
				if v ~= game.player.location then
					table.insert(loctbl, v)
				end
			end
			for k,v in pairs(loctbl) do
				print(k..": "..v.display_name..", Entrance tax: "..v.entrance_tax)
			end
			inp2 = io.read()
			if loctbl[tonumber(inp2)] ~= nil then
				local loc_ref = loctbl[tonumber(inp2)]
				if loc_ref.entrance_tax <= game.player.gold then
					print("Travelling... ")
					print(config.travel_time.." seconds.")
					os.sleep(config.travel_time*1000)
					game.player.location = loctbl[tonumber(inp2)]
					game:fillTraders()
				else
					print("You don't have enough money to enter!")
				end
			elseif inp2 == "0" then
			else
				print("That's not a location!")
			end
		elseif inp == "2" then
			print("0: Exit")
			local tbl = {}
			for k,v in pairs(game.player.location.npc) do
				table.insert(tbl, v)
			end
			for k,v in pairs(tbl) do
				print(k..": "..v.display_name)
			end
			inp2 = io.read()
			if tbl[tonumber(inp2)] ~= nil then -- place shop here
				shop(tbl[tonumber(inp2)])
			elseif inp2 == "0" then
			else
				print("That's not a trader!")
			end
		elseif inp == "3" then
			inventory()
		elseif inp == "4" then
			h = io.open("user/save.dat","w")
			h:write("return "..table.serialize(game.player))
			h:close()
			h = io.open("user/trader.dat","w")
			h:write("return "..table.serialize(game.trader))
			h:close()
		elseif inp == "5" then
			print("Gold: "..game.player.gold)
			print("Barter Skill: "..game.player.barter)
		elseif inp == "9999" then
			os.remove("user/save.dat")
			os.remove("user/trader.dat")
		elseif inp == "6" then
			event:callEvent("reload",game.player,game.trader)
			break
		elseif inp == "lua" then
			lh = io.read()
			if pcall(load(lh)) then
			else
				bool, error = pcall(load(lh))
				print("ERROR: '"..error.."'")
			end
		elseif inp == "0" then
			_G.return_code = 0
			break
		elseif inp == '/generate' then
			dofile("game/script_dat/rgen.lua")
		elseif inp == '/gentown' then
			dofile("game/script_data/rgen_town.lua")
		else
			print("Not a choice!")
		end
	end
	if _G.return_code == 0 then
		break
	end
end