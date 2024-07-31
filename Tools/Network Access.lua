if getgenv().NETWORK_ACTIVATED = true then return end
getgenv().NETWORK_ACTIVATED = true
settings().Physics.AllowSleep = false
local Player = game:GetService("Players").LocalPlayer
while game:GetService("RunService").RenderStepped:Wait() do
  for _, plr in next, game:GetService("Players"):GetPlayers() do
    if plr ~= Player then
      sethiddenproperty(plr, "MaximumSimulationRadius", 0)
      sethiddenproperty(plr, "SimulationRadius", 0)
    end
  end
  sethiddenproperty(Player, "MaximumSimulationRadius", 99999)
  sethiddenproperty(Player, "SimulationRadius", 99999)
end
