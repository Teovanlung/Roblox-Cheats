getgenv().INFCROWN_ACTIVE = true
local SIGNAL_REMOTE = game:GetService("ReplicatedStorage"):WaitForChild("SIGNAL_REMOTE")
local Player_Gui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local GotItem = Player_Gui:WaitForChild("GotItem")
game:GetService("StarterGui"):WaitForChild("REFERENCE"):WaitForChild("ElementReference"):WaitForChild("SparkleBase").Transparency = 1
Player_Gui:WaitForChild("REFERENCE"):WaitForChild("ElementReference"):WaitForChild("SparkleBase").Transparency = 1
Player_Gui:WaitForChild("REFERENCE"):WaitForChild("Sounds"):WaitForChild("GetItem").Volume = 0
for _, v in pairs(GotItem:GetDescendants()) do
  if v:IsA("GuiObject") then
    v.ZIndex = 0
    v.Visible = false
    v.Transparency = 1
    v.Size = UDim2.new(0,0,0,0)
    v.BackgroundTransparency = 1
  end
end

while getgenv().INFCROWN_ACTIVE == true do
  SIGNAL_REMOTE:FireServer("ClaimRewardForTask", "ko3")
  task.wait(0.15)
end
