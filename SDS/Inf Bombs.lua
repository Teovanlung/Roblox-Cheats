local Rem = game:GetService("ReplicatedStorage"):WaitForChild("SIGNAL_REMOTE")
local Player = game:GetService("Players").LocalPlayer
local Hrp = Player.Character:WaitForChild("HumanoidRootPart")
Player.CharacterAdded:Connect(function(char)
  Hrp = char:WaitForChild("HumanoidRootPart")
end)
local Mouse = Player:GetMouse()Mouse.Button1Down:Connect(function()
  local args = {
    [1] = "CreateRemoteBomb",
    [2] = "Remote Detonator",
    [3] = Hrp.Position,
    [4] = Mouse.Hit.p,
    [5] = true
  }
  Rem:FireServer(unpack(args))
end)
