local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local totalMass = 0
local FloatAnim = Instance.new("Animation")
local HoldAnim = Instance.new("Animation")
local Connection = {}
if Character:WaitForChild("Humanoid").RigType == Enum.HumanoidRigType.R6 then
  HoldAnim.AnimationId = "http://www.roblox.com/asset/?id=148831127"
  FloatAnim.AnimationId = "http://www.roblox.com/asset/?id=148840371"
  else
  HoldAnim.AnimationId = "http://www.roblox.com/asset/?id=569125949"
  FloatAnim.AnimationId = "http://www.roblox.com/asset/?id=569145055"
end
FloatAnim = Character:FindFirstChild("Humanoid"):LoadAnimation(FloatAnim)
HoldAnim = Character:FindFirstChild("Humanoid"):LoadAnimation(HoldAnim)
--Balloon--
local Balloon = Instance.new("Tool")
Balloon.RequiresHandle = true
Balloon.TextureId = "rbxassetid://27471616"
Balloon.Grip = CFrame.new(0, -1, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0)
Balloon.Name = "GreenBalloon"

local Handle = Instance.new("Part")
Handle.Size = Vector3.new(1, 3, 1)
Handle.Transparency = 0
Handle.CanCollide = false
Handle.Name = "Handle"

local BalloonMesh = Instance.new("SpecialMesh")
BalloonMesh.MeshType = Enum.MeshType.FileMesh
BalloonMesh.MeshId = "rbxassetid://25498565"
BalloonMesh.TextureId = "rbxassetid://27471524"

BalloonMesh.Parent = Handle
Handle.Parent = Balloon
Balloon.Parent = Player.Backpack
function onEquip()
  for _, part in pairs(Character:GetDescendants()) do
    if part:IsA("BasePart") and part.Massless ~= true then
      totalMass = totalMass + part:GetMass()
    end
  end
  bodyForce = Instance.new("BodyForce")
  local force = totalMass * 147
  bodyForce.Force = Vector3.new(0, force, 0)
  bodyForce.Parent = Character.HumanoidRootPart
  HoldAnim:Play()
  if Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
    FloatAnim:Play()
  end
end
table.insert(Connection,Character.Humanoid.StateChanged:Connect(function()
  if Character:FindFirstChild("GreenBalloon") == nil then return end
  if Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
    FloatAnim:Stop()
  end
  if Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
    FloatAnim:Play()
  end
end))
function onUnequip()
  HoldAnim:Stop()
  FloatAnim:Stop()
  totalMass = 0
  bodyForce:Destroy()
end
function onDied()
  for _,v in Connection do
    v:Disconnect()
  end
  table.clear(Connection)
end
table.insert(Connection,Balloon.Equipped:Connect(onEquip))
table.insert(Connection,Balloon.Unequipped:Connect(onUnequip))
Character.Humanoid.Died:Connect(onDied)
