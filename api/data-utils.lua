function io.exists(name)
	local f = io.open(name,"r")
	if f ~= nil then 
		f:close() 
		return true 
	else 
		return false 
	end
end
function os.sleep(time) -- in milliseconds
	time = time / 1000
	orig = os.clock()
	timer = orig + time
	while true do
		if os.clock() >= timer or os.clock() >= timer + 0.00001 then
			break
		end
	end
end

os.sleep(10)

function string.insert_at_end(o_str, i_str, back_offset)
	if back_offset == nil then -- inserts at end of string backwards eg. ("ABC", "123", 1) returns AB123C, 2 return A123BC, ect.
		back_offset = 0
	end
	c_str = string.sub(o_str,1,#o_str - back_offset)
	c_str = c_str..i_str..string.sub(o_str,#o_str-back_offset+1,#o_str)
	return c_str
end

function table.count(tbl) --added this because # iteration doesn't count square bracket defined tables eg. #{["abc"]={}} doesn't work for some reason, note: sumbit a report or look it up
	count = 0 --counter
	for k,v in pairs(tbl) do
		count = count + 1 --iteration
	end
	return count -- numeric return
end
	
function table.serialize(tbl)
	-- localized so nested iterations of the function don't overwrite this original value
	local str = "{}"
	-- same as above, count used to check where to put commas, see below (iterative counter)
	local count = 1
	local fcount = table.count(tbl)
	for k,v in pairs(tbl) do
		-- removes commas if the keypair is the last in the table
		if fcount == count then -- none add to the count since they are the final values
			if type(v) == "string" then
				if type(k) == "string" then	 -- different keys
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..'"'..v..'"', 1)
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..'"'..v..'"', 1)
				end
			elseif type(v) == "number" then -- different keys
				if type(k) == "string" then
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..v..'', 1)
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..v..'', 1)
				end
			elseif type(v) == "table" then
				out = table.serialize(v) -- repeats itself to index the table value
				if type(k) == "string" then -- inserts table
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..out..'', 1) -- values for different keys
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..out..'', 1) -- values for different keys
				end
				count = count + 1
			end
		else
			if type(v) == "string" then
				if type(k) == "string" then	
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..'"'..v..'",', 1)
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..'"'..v..'",', 1)
				end
				count = count + 1 -- adds to count
			elseif type(v) == "number" then
				if type(k) == "string" then
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..v..',', 1)
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..v..',', 1)
				end
				count = count + 1 -- adds to count
			elseif type(v) == "table" then
				out = table.serialize(v) -- repeats itself to index the table value
				if type(k) == "string" then -- inserts table with commas
					str = string.insert_at_end(str, '["'..k..'"]'..' = '..out..',', 1)
				elseif type(k) == "number" then
					str = string.insert_at_end(str, '['..k..']'..' = '..out..',', 1)
				end
				count = count + 1
			end
		end
	end
	return str
end

function table.gentab(len, tfo)
	local x = {}
	math.randomseed(os.clock()*1000000)
	for i = 1, len do
		rnd = math.random(1, 100)
		os.sleep(0.01)
		if rnd <= 50 and tfo ~= true then
			rnd_2 = math.random(1,100)
			if rnd_2 > 25 then
				x[i] = table.gentest(math.random(5, 10), true)
			else
				x[i] = table.gentest(math.random(5, 10))
			end
		else
			x[i] = math.random(1,100)
		end
	end
	return x
end

function table.deep_merge(original, overwrite)
	for k,v in pairs(overwrite) do
		if v ~= nil then
			if type(v) == "table" and type(original[k]) == "table" then
				original[k] = table.deep_merge(original[k], v)
			elseif original[k] ~= v then
				original[k] = v
			end
		end
	end
	return original
end

function table.deep_print(tbl, prefix)
	if prefix == nil then
		prefix = ""
	end
	for k,v in pairs(tbl) do
		os.sleep(0.000000001)
		if type(v) == "table" then
			if type(k) == "number" then
				table.deep_print(v, prefix.."["..k.."]")
			else
				table.deep_print(v, prefix.."['"..k.."']")
			end
		else
			if type(k) == "number" then
				print(prefix.."["..k.."]".." = "..v)
			else
				print(prefix.."['"..k.."']".." = "..v)
			end
		end
	end
end