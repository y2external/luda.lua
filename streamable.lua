
 /$$                 /$$               /$$                    
| $$                | $$              | $$                    
| $$ /$$   /$$  /$$$$$$$  /$$$$$$     | $$ /$$   /$$  /$$$$$$ 
| $$| $$  | $$ /$$__  $$ |____  $$    | $$| $$  | $$ |____  $$
| $$| $$  | $$| $$  | $$  /$$$$$$$    | $$| $$  | $$  /$$$$$$$
| $$| $$  | $$| $$  | $$ /$$__  $$    | $$| $$  | $$ /$$__  $$
| $$|  $$$$$$/|  $$$$$$$|  $$$$$$$ /$$| $$|  $$$$$$/|  $$$$$$$
|__/ \______/  \_______/ \_______/|__/|__/ \______/  \_______/
                                                              
                                                          


local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/y2external/luda.lua-main/main/silent.lua"))()
Aiming.TeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    SilentAim = true,
    AimLock = false,
    Prediction = 0.148357,
    AimLockKeybind = Enum.KeyCode.E
}
getgenv().DaHoodSettings = DaHoodSettings

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
    end)

    local cframeSpheedhotkeyXd1 = "l" -- toggle key
    local mouse = game.Players.LocalPlayer:GetMouse()
    
    
    
    mouse.KeyDown:Connect(function(value)
    if value == cframeSpheedhotkeyXd1 then
    if DaHoodSettings.SilentAim == true then
        DaHoodSettings.SilentAim = false
    else
        DaHoodSettings.SilentAim = true
    end
    end
    end)
