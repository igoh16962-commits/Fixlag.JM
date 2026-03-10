-- Optimized Bright Anti-Lag Script

-- Lower render quality
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

-- Improve lighting while keeping performance
Lighting.GlobalShadows = false
Lighting.Brightness = 2
Lighting.Ambient = Color3.fromRGB(200,200,200)
Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.Technology = Enum.Technology.Compatibility
Lighting.FogEnd = 100000

-- Optimize terrain
local terrain = workspace:FindFirstChildOfClass("Terrain")
if terrain then
    terrain.CastShadow = false
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
end

-- Optimize existing objects
for _,v in ipairs(workspace:GetDescendants()) do

    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
        v.CastShadow = false

    elseif v:IsA("Texture") or v:IsA("Decal") then
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

-- Handle new effects that appear later
workspace.DescendantAdded:Connect(function(v)

    if v:IsA("ParticleEmitter") then
        v.Lifetime = NumberRange.new(0)

    elseif v:IsA("Beam") or v:IsA("Trail") then
        v.Enabled = false
    end

end)

-- Notification
pcall(function()
    StarterGui:SetCore("SendNotification",{
        Title = "Anti Lag Loaded",
        Text = "Optimized Bright Anti-Lag Script Activated",
        Duration = 6
    })
end)
