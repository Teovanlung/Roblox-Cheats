if game:GetService("CoreGui"):FindFirstChild("Fly_Gui_Holder") then return end
if gethui() then if gethui():FindFirstChild("Fly_Gui_Holder") then return end end

local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character
local Hum = Char:WaitForChild("Humanoid")
local Hrp = Char:WaitForChild("HumanoidRootPart")
local tpWalking = true
local Torso
if Hum.RigType == Enum.HumanoidRigType.R6 then
  Torso = Char:WaitForChild("Torso")
else
  Torso = Char:WaitForChild("UpperTorso")
end

local main = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local plus = Instance.new("TextButton")
local minus = Instance.new("TextButton")
local display = Instance.new("TextLabel")
local switch = Instance.new("TextButton")
local credits = Instance.new("TextLabel")

local Cam = workspace.CurrentCamera
local Hb = game:GetService("RunService").Heartbeat
local Speed = 1
local Enabled = false
local flying = true
local deb = true
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0

main.Name = "Fly_Gui_Holder"
main.ResetOnSpawn = false
main.Parent = gethui()
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

frame.Parent = main
frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
frame.Position	 = UDim2.new(0.100320168, 0, 0.379746825, 0)
frame.Size = UDim2.new(0, 190, 0, 57)
frame.Active = true
frame.Draggable = true

up.Name = "up"
up.Parent = frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "UP"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "DOWN"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

switch.Name = "switch"
switch.Parent = frame
switch.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
switch.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
switch.Size = UDim2.new(0, 56, 0, 28)
switch.Font = Enum.Font.SourceSans
switch.Text = "Fly"
switch.TextColor3 = Color3.fromRGB(0, 0, 0)
switch.TextSize = 14.000

credits.Parent = frame
credits.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
credits.Position = UDim2.new(0.469327301, 0, 0, 0)
credits.Size = UDim2.new(0, 100, 0, 28)
credits.Font = Enum.Font.SourceSans
credits.Text = "gui by me_ozoneYT"
credits.TextColor3 = Color3.fromRGB(0, 0, 0)
credits.TextScaled = true
credits.TextSize = 14.000
credits.TextWrapped = true

plus.Name = "plus"
plus.Parent = frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

display.Name = "display"
display.Parent = frame
display.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
display.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
display.Size = UDim2.new(0, 44, 0, 28)
display.Font = Enum.Font.SourceSans
display.Text = "1"
display.TextColor3 = Color3.fromRGB(0, 0, 0)
display.TextScaled = true
display.TextSize = 14.000
display.TextWrapped = true

minus.Name = "minus"
minus.Parent = frame
minus.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
minus.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
minus.Size = UDim2.new(0, 45, 0, 29)
minus.Font = Enum.Font.SourceSans
minus.Text = "-"
minus.TextColor3 = Color3.fromRGB(0, 0, 0)
minus.TextScaled = true
minus.TextSize = 14.000
minus.TextWrapped = true

function setState(state, bool)
  Hum:SetStateEnabled(state, bool)
end

function setAllState(bool)
  setState(Enum.HumanoidStateType.Climbing,bool)
  setState(Enum.HumanoidStateType.FallingDown,bool)
  setState(Enum.HumanoidStateType.Flying,bool)
  setState(Enum.HumanoidStateType.Freefall,bool)
  setState(Enum.HumanoidStateType.GettingUp,bool)
  setState(Enum.HumanoidStateType.Jumping,bool)
  setState(Enum.HumanoidStateType.Landed,bool)
  setState(Enum.HumanoidStateType.Physics,bool)
  setState(Enum.HumanoidStateType.PlatformStanding,bool)
  setState(Enum.HumanoidStateType.Ragdoll,bool)
  setState(Enum.HumanoidStateType.Running,bool)
  setState(Enum.HumanoidStateType.RunningNoPhysics,bool)
  setState(Enum.HumanoidStateType.Seated,bool)
  setState(Enum.HumanoidStateType.StrafingNoPhysics,bool)
  setState(Enum.HumanoidStateType.Swimming,bool)
end

switch.MouseButton1Down:connect(function()
  if Enabled then
    Enabled = false
    setAllState(true)
    Hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
  else
    Enabled = true
    for i = 1, Speed do
      spawn(function()
        tpWalking = true
        while tpWalking and Hb:Wait() and Char and Hum and Hum.Parent do
          if Hum.MoveDirection.Magnitude > 0 then
            Char:TranslateBy(Hum.MoveDirection)
          end
        end
      end)
    end
    Char.Animate.Disabled = true
    for _, v in next, Hum:GetPlayingAnimationTracks() do
      v:AdjustSpeed(0)
    end
    setAllState(false)
    Hum:ChangeState(Enum.HumanoidStateType.Swimming)
  end
  local bg = Instance.new("BodyGyro", Torso)
  bg.P = 9e4
  bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
  bg.CFrame = Torso.CFrame
  local bv = Instance.new("BodyVelocity", Torso)
  bv.Velocity = Vector3.new(0,0.1,0)
  bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
  if Enabled == true then
    Hum.PlatformStand = true
  end
  while Enabled == true or Hum.Health <= 0 do
    task.wait()
    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
      speed = speed + 0.5 + (speed / maxspeed)
      if speed > maxspeed then
        speed = maxspeed
      end
    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
      speed -= 1
      if speed < 0 then
        speed = 0
      end
    end
      if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
        bv.Velocity = ((Cam.CFrame.LookVector * (ctrl.f + ctrl.b)) + ((Cam.CFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - Cam.CFrame.p)) * speed
        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
      elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
        bv.Velocity = ((Cam.CFrame.LookVector * (lastctrl.f + lastctrl.b)) + ((Cam.CFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2,0).p) - Cam.CFrame.p)) * speed
      else
        bv.Velocity = Vector3.new(0,0,0)
      end
      --	game.Players.LocalPlayer.Character.Animate.Disabled = true
    bg.CFrame = Cam.CFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
  end
  ctrl = {f = 0, b = 0, l = 0, r = 0}
  lastctrl = {f = 0, b = 0, l = 0, r = 0}
  speed = 0
  bg:Destroy()
  bv:Destroy()
  Hum.PlatformStand = false
  Char.Animate.Disabled = false
  tpWalking = false
end)

up.MouseButton1Down:connect(function()
  Hrp.CFrame = Hrp.CFrame * CFrame.new(0,2,0)
end)

down.MouseButton1Down:connect(function()
  Hrp.CFrame = Hrp.CFrame * CFrame.new(0,-2,0)
end)

Player.CharacterAdded:Connect(function(char)
  task.wait(0.7)
  Enabled = false
  Char = char
  Hum = char:WaitForChild("Humanoid")
  Hrp = char:WaitForChild("HumanoidRootPart")
  if Hum.RigType == Enum.HumanoidRigType.R6 then
    Torso = char:WaitForChild("Torso")
  else
    Torso = char:WaitForChild("UpperTorso")
  end
  Hum.PlatformStand = false
  Char.Animate.Disabled = false
end)

plus.MouseButton1Down:connect(function()
  Speed += 1
  display.Text = Speed
  if Enabled == true then
    tpWalking = false
    for i = 1, Speed do
      spawn(function()
        tpWalking = true
        while tpWalking and Hb:Wait() and Char and Hum and Hum.Parent do
          if Hum.MoveDirection.Magnitude > 0 then
            Char:TranslateBy(Hum.MoveDirection)
          end
        end
      end)
    end
  end
end)
minus.MouseButton1Down:connect(function()
  if Speed <= 1 then
    display.Text = 'can not be less than 1'
    task.wait(1)
    display.Text = Speed
  else
    Speed -= 1
    display.Text = Speed
    if Enabled == true then
      tpWalking = false
      for i = 1, Speed do
        spawn(function()
          tpWalking = true
          while tpWalking and Hb:Wait() and Char and Hum and Hum.Parent do
            if Hum.MoveDirection.Magnitude > 0 then
              Char:TranslateBy(Hum.MoveDirection)
            end
          end
        end)
      end
    end
  end
end)
