local Player = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RF = RS:WaitForChild("RemoteFunction")
local Id = 4914494
local Counter = 0
local Towers = {}
if Player:IsInGroup(Id) == false then
  setclipboard("https://www.roblox.com/groups/4914494/Paradoxum-Games#!/about")
  Player:Kick("Join the Paradoxum Group for 100 extra starting cash!")
end
local Tds = {}

function Tds:Buy(Tower)
  RF:InvokeServer("Shop", "Purchase", "tower", Tower)
end

function Tds:Equip(a, b, c, d, e)
  local Towers = {a, b, c, d, e}
  local Count = 1
  while Count <= 5 do
    RF:InvokeServer("Inventory", "Equip", "tower", Towers[Count])
    Count += 1
  end
end

function Tds:Vote(Mode)
  RF:InvokeServer("Difficulty", "Vote", Mode)
end

function Tds:Ready()
  RF:InvokeServer("Difficulty", "Ready")
end

function Tds:Skip()
  RF:InvokeServer("Voting", "Skip")
end

function Tds:Place(Tower, Position)
  RF:InvokeServer("Troops", "Place", Tower, {["Rotation"] = CFrame.new(0, 0, 0), ["Position"] = Position})
  Counter += 1
  v.Name = tostring(Counter)
end

function Tds:Upgrade(Tower)
  local Tower_Upgrade = workspace.Towers:WaitForChild(Tower)
  RF:InvokeServer("Troops", "Upgrade", "Set", {["Troop"] = workspace:WaitForChild("Towers"):WaitForChild(tostring(Tower))})
end
  
return Tds

