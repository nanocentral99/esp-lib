local Camera = game.Workspace.CurrentCamera
local RunService = game:GetService("RunService")
local GetChildren = game.GetChildren
local RenderStepped = RunService.RenderStepped

local resume = coroutine.resume 
local create = coroutine.create
local ToggleTable = {
    Visuals = {
        BoxEnabled = true,
        NamesEnabled = false,
        EquiptedEnabled = false,
        HealthEnabled = false,
        HealthBasedVisuals = false,
        HitSound = false,
        Chams = false,
        InvintoryViewer = false,
        BoxColor = Color3.new(1,1,1),
        NameColor = Color3.new(1,1,1),
        EquiptedColor= Color3.new(1,1,1)
    },
    Combat = {},
    Movement = {}
}

function Draw()
local square = Drawing.new("Square") 
square.Thickness = 1
square.Size = Vector2.new(150,100) 
square.Filled = false 
square.Color = Color3.new(1,0,0)

return square 
end
function HealthBar()
local Line = Drawing.new("Line") --- the drawing for the square to be made
Line.Visible = false
Line.From = Vector2.new(0, 0)
Line.To = Vector2.new(200, 200)
Line.Color = Color3.fromRGB(255, 255, 255)
Line.Thickness = 4
Line.Transparency = 1


return Line 
end
function RenderText()
    local outline = Drawing.new("Text") 
outline.Outline = true
outline.Size = 15
outline.Color = Color3.new(1,1,1)
outline.Font = Drawing.Fonts.Monospace
outline.Center = true
return outline
end

function OpenRServ(Plr)
if Plr and  Plr.Character ~= nil then
print("Opened service for " .. Plr. Name)
local PastName = Plr.Name
local esp = Draw()
local esp2 = RenderText()
local esp3 = RenderText()
local esp5 = HealthBar()
local esp4 = HealthBar()
game:GetService("RunService").Stepped:Connect(function()


if Plr and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then 
    
    local RootPosition = Plr.Character.HumanoidRootPart.Position
local Size = (game.Workspace.CurrentCamera:WorldToViewportPoint(RootPosition - Vector3.new(0, 3, 0)).Y - game.Workspace.CurrentCamera:WorldToViewportPoint(RootPosition + Vector3.new(0, 2.6, 0)).Y) / 2 
local w2s,OnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(Plr.Character.HumanoidRootPart.Position)
local Equipped = Plr.Character:FindFirstChildOfClass("Tool") and Plr.Character:FindFirstChildOfClass("Tool").Name or "None"
local humanoid = Plr.Character.Humanoid
local c = Color3.new((1 - humanoid.Health/humanoid.MaxHealth) * 2.55, (humanoid.Health/humanoid.MaxHealth) * 2.55, 0)
esp.Visible = OnScreen and humanoid.Health > 0  and Plr.Character ~= nil and ToggleTable.Visuals.BoxEnabled -- boom!
esp.Size = Vector2.new(math.floor(Size * 1.5), math.floor(Size * 1.9)) 
esp.Position = Vector2.new(math.floor(w2s.X - Size*1.5 / 2), math.floor(w2s.Y - Size*1.6 / 2)) 
esp.Color = c

esp4.From = Vector2.new((esp.Position.X - 5), esp.Position.Y + esp.Size.Y)
esp4.To = Vector2.new(esp4.From.X, esp4.From.Y - (humanoid.Health / humanoid.MaxHealth) * esp.Size.Y)
esp4.Color = c
esp4.Visible = OnScreen and humanoid.Health > 0 and Plr.Character ~= nil and ToggleTable.Visuals.HealthEnabled

esp5.From = Vector2.new((esp.Position.X - 5), esp.Position.Y + esp.Size.Y)
esp5.To = Vector2.new(esp5.From.X, esp5.From.Y - (humanoid.MaxHealth/ humanoid.MaxHealth) * esp.Size.Y)
esp5.Color = Color3.new(0,0,0)
esp5.Visible = OnScreen and humanoid.Health > 0  and Plr.Character ~= nil and ToggleTable.Visuals.HealthEnabled

esp2.Visible = OnScreen and humanoid.Health > 0  and Plr.Character ~= nil and ToggleTable.Visuals.NamesEnabled
esp2.Position =Vector2.new(esp.Size.X /2 + esp.Position.X, esp.Position.Y - 16) -- see we added it
esp3.Visible = OnScreen and humanoid.Health > 0  and Plr.Character ~= nil and ToggleTable.Visuals.EquiptedEnabled -- boom!
esp3.Position =Vector2.new(esp.Size.X / 2 + esp.Position.X, esp.Size.Y + esp.Position.Y + 1)  -- see we added it
local tool_heald

        esp2.Text = PastName
        esp3.Text = "Holding : " .. Equipped


else
    if Plr then
esp2.Visible = false
esp.Visible  = false
esp3.Visible = false
esp4.Visible = false
esp5.Visible = false
        else
        
    esp2:Remove()
esp:Remove()
esp3:Remove()
esp4:Remove()
esp5:Remove()
end
end
end)

end
end

for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer then
OpenRServ(v)
end
end

game.Players.PlayerAdded:Connect(function(v)
if v ~= game.Players.LocalPlayer then
OpenRServ(v)
end
end)
