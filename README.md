## A simple solution
Cooldown is my personal way of managing cooldowns of any type. It avoids using wait or any sort of yielding to provide performant results. On top of that, it uses a key based system for managing individual cooldowns under the main Cooldown class.

## Example

This is an example of how to utilize Cooldown:
```lua
local Players = game:GetService("Players")
local cooldown = Cooldown.new(5) -- Create a new cooldown of 5 seconds

part.Touched:Connect(function(hit)
	local player = Players:GetPlayerFromCharacter(hit.Parent)
	if not player then -- Make sure what the part is touching is a player
		return
	end
	
	cooldown:DoTask(player, function(onCooldown, timeLeft) -- Will fire with information about the cooldown
		if onCooldown then -- Handle the outcome
			timeLeft = math.floor(timeLeft * 10) / 10 -- Format the time
			print("There are", timeLeft, "second(s) left!")
		else
			print("Activated!")
		end
	end)
end)
```
This will print "Activated!" whenever you touch "part" only every 5 seconds.

## Code Documentation

```lua
Cooldown.new()
```

**Description** <div>
Creates and returns a new Cooldown object.

**Parameters**
| Name | Type | Default | Description |
| --- | --- | --- | --- |
| Length | number | 1 | The length in seconds for this Cooldown object. |

**Returns**
| Name | Type | Description |
| --- | --- | --- |
| Cooldown | table | A new Cooldown object. |

---

### Cooldown Object
