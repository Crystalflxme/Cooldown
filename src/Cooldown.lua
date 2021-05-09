local Cooldown = {}
Cooldown.__index = Cooldown

-- Create a new Cooldown object
function Cooldown.new(length)
	local cooldown = {}
	setmetatable(cooldown, Cooldown)
	
	cooldown.Length = length or 1
	cooldown.Data = {}
	
	return cooldown
end

-- Used to clean up any completed cooldowns
-- Useful for instances acting as keys that need to be garbage collected
function Cooldown:Cleanup()
	for index in pairs(self.Data) do
		local onCooldown = self:GetStatus(index)
		
		if not onCooldown then
			self.Data[index] = nil
		end
	end
end

-- Used to get information about a certain key
function Cooldown:GetStatus(key)
	local lastUsed = self.Data[key] or 0
	local onCooldown = tick() - lastUsed <= self.Length
	
	return onCooldown, lastUsed
end

-- Used to complete a task based off a cooldown
function Cooldown:DoTask(key, callback)
	local now = tick()
	local onCooldown, lastUsed = self:GetStatus(key)
	local timeLeft = lastUsed + self.Length - now
	
	if not onCooldown then
		self.Data[key] = now
	end
	
	callback(onCooldown, timeLeft)
	self:Cleanup()
end

return Cooldown
