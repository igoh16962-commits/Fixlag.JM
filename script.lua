-- Extreme Anti Lag Script (Table Flip Cleaner)

settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

-- Bright but lightweight lighting
Lighting.GlobalShadows = false
Lighting.Brightness = 2
Lighting.Ambient = Color3.fromRGB(210,210,210)
Lighting.OutdoorAmbient = Color3.fromRGB(210,210,210)
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.Technology = Enum.Technology.Compatibility
Lighting.FogEnd = 100000

-- Terrain optimization
local terrain = workspace:FindFirstChildOfClass("Terrain")
if terrain then
    terrain.CastShadow = false
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
end

-- Clean existing effects
for _,v in ipairs(workspace:GetDescendants()) do

    if v:IsA("Texture") or v:IsA("Decal") then
        v.Texture = ""

    elseif v:IsA("ParticleEmitter") then
        v.Lifetime = NumberRange.new(0)

    elseif v:IsA("Beam") or v:IsA("Trail") then
        v.Enabled = false

    elseif v:IsA("PointLight")
    or v:IsA("SpotLight")
    or v:IsA("SurfaceLight") then
        v.Enabled = false
    end

end

-- Remove debris created by skills
workspace.DescendantAdded:Connect(function(v)

    if v:IsA("ParticleEmitter") then
        v.Lifetime = NumberRange.new(0)

    elseif v:IsA("Beam") or v:IsA("Trail") then
        v.Enabled = false

    elseif v:IsA("BasePart") then
        
        -- detect table flip debris
        if v.Size.Magnitude > 20 and not v.Anchored then
            task.delay(0.05,function()
                if v and v.Parent then
                    v:Destroy()
                end
            end)
        end

    end

end)

-- Notification
pcall(function()
    StarterGui:SetCore("SendNotification",{
        Title = "Extreme Anti Lag",
        Text = "Table Flip debris remover active",
        Duration = 6
    })
end)
