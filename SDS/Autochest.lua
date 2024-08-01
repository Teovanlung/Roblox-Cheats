local Head = game:GetService("Players").LocalPlayer.Character:WaitForChild("Head")
for _,v in pairs(workspace.Chests:GetChildren()) do
  if v and v.Parent == workspace.Chests and v.Name == "DailyChest" then
    local Hbox = v:WaitForChild("Hitbox")
    firetouchinterest(Head, Hbox, 0)
  end
end
