event = {} -- event table
event.eventTable = {}

function event:regEvent(eventname) -- adds an event which will contain functions that will be called whenever callEvent is ran
	if self.eventTable[eventname] == nil then -- if the event does not exist (equals nil), then
		self.eventTable[eventname] = {} -- set the event "key" to an empty table
		return true -- return the state of true
	else -- if the event already exists
		return false
	end
end

function event:regHook(eventname, func) -- will add a function to the event table
	if self.eventTable[eventname] ~= nil then
		table.insert(self.eventTable[eventname], func)
	end
end

function event:callEvent(eventname, ...) -- calls all events in the event, passing the arguments to the functions
	if type(self.eventTable[eventname]) == 'table' then --if  the type of the event is a table
		for _,v in pairs(self.eventTable[eventname]) do -- for every value in the event
			if type(v) == "function" then
				v(...) -- call the value's function
			end
		end
		return true
	else
		return false
	end
end