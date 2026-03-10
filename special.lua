-- Ultra Debris Destroyer

if _G.TSB_DEBRIS_KILLER then return end
_G.TSB_DEBRIS_KILLER = true

local workspace = workspace
local lighting = game:GetService("Lighting")

-- Graphics tối thiểu
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

lighting.GlobalShadows = false
lighting.EnvironmentDiffuseScale = 0
lighting.EnvironmentSpecularScale = 0
lighting.Brightness = 2

-- function xoá debris
local function destroyDebris(v)

    if not v then return end

    if v:IsA("BasePart") then
        
        -- debris thường không anchored
        if not v.Anchored then
            
            -- part to (table flip rock)
            if v.Size.Magnitude > 6 then
                v:Destroy()
            end
            
        end
        
    end

    if v:IsA("ParticleEmitter") then
        v.Lifetime = NumberRange.new(0)
    end

    if v:IsA("Trail") or v:IsA("Beam") then
        v.Enabled = false
    end

    if v:IsA("Explosion") then
        v:Destroy()
    end

end

-- xoá debris hiện tại
for _,v in ipairs(workspace:GetDescendants()) do
    destroyDebris(v)
end

-- xoá debris mới spawn
workspace.DescendantAdded:Connect(function(v)
    destroyDebris(v)
end)

print("TSB Ultra Debris Killer Loaded")
