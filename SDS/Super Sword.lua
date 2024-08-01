local SIGNAL_REMOTE = game:GetService("ReplicatedStorage"):WaitForChild("SIGNAL_REMOTE")
while true do
  SIGNAL_REMOTE:FireServer("ActivateHitbox", "Lunge")
  task.wait(0.3)
  SIGNAL_REMOTE:FireServer("ActivateHitbox", "Strike")
  task.wait(0.4)
end
