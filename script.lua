-- SEAT DISABLER, NEW METHOD
-- PRESS E TO RE-ENABLE THE SEAT
-- 1 SEAT ONLY!!! i have no idea on how to potentially make it better
-- YOUR CHARACTER WILL DESYNC WHEN DISABLING A SEAT

local uis = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local selected
local running = false

mouse.Move:Connect(function()
	local target = mouse.Target
	for _, seat in ipairs(workspace:GetDescendants()) do
		if seat:IsA("Seat") then
			if seat == target then
				if not seat:FindFirstChild("Highlight") then
					local highlight = Instance.new("Highlight")
					highlight.FillColor = Color3.new(1, 0, 0)
					highlight.Parent = seat
				end
			elseif seat:FindFirstChild("Highlight") then
				seat.Highlight:Destroy()
			end
		end
	end
end)

mouse.Button1Down:Connect(function()
	local target = mouse.Target
	if target and (target:IsA("Seat") or target:IsA("VehicleSeat")) then
		if running and selected == target then return end
		running = false
		task.wait()
		selected = target
		running = true
		while running and task.wait() do
			if not selected then break end
			replicatesignal(selected.RemoteCreateSeatWeld, game.Players.LocalPlayer.Character.Humanoid)
			replicatesignal(selected.RemoteDestroySeatWeld)
		end
	end
end)

uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.E then
		running = false
		selected = nil
	end
end)
