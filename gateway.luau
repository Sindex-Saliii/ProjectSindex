---- soon
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local workspace = game.workspace
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events"):WaitForChild("To_Server")

local Window = Rayfield:CreateWindow({
   Name = "[ Anime Eternal ] Albiology Hub",
   Icon = "biohazard",
   LoadingTitle = "Anime Eternal - Next Gen",
   LoadingSubtitle = "Powered by Albiology Hub",
   ShowText = "Gayfield",
   Theme = "Serenity",
   ToggleUIKeybind = "K",
   ConfigurationSaving = {Enabled = true, FileName = "Albiology Hub"},
   KeySystem = true,
   KeySettings = {Title = "Albiology Hub V1", Subtitle = "Key System", Note = "Key is EternalV1", FileName = "Enter Key", SaveKey = true, GrabKeyFromSite = false, Key = {"EternalV1"}}
})

local Main = Window:CreateTab("Main","compass")

getgenv().AutoClick = false
getgenv().AutoFarm = false
getgenv().FarmMethod = "Instant"

local function Click()
    pcall(function()
        Events:FireServer({Action = "_Mouse_Click"})
    end)
end

task.spawn(function()
    while task.wait() do
        if getgenv().AutoClick then
            Click()
        end
    end
end)

local Enemies = {}
local Selected = {}

local function RefreshEnemies()
    Enemies = {}
    for _, v in pairs(workspace:WaitForChild("Debris"):WaitForChild("Monsters"):GetChildren()) do
        local title = v:GetAttribute("Title") or v.Name
        if not table.find(Enemies, title) then
            table.insert(Enemies, title)
        end
    end
end

RefreshEnemies()

local EnemyDropdown = Main:CreateDropdown({
    Name = "🎯 Select Enemy",
    Options = Enemies,
    MultipleOptions = true,
    Callback = function(opt) Selected = opt end
})

Main:CreateButton({
    Name = "🔄 Refresh Enemy List",
    Callback = function()
        RefreshEnemies()
        EnemyDropdown:Refresh(Enemies)
    end
})

Main:CreateDropdown({
    Name = "⚔️ Farming Method",
    Options = {"Instant","Tween","Walk"},
    CurrentOption = "Instant",
    Callback = function(opt) getgenv().FarmMethod = opt end
})

Main:CreateToggle({
    Name = "🤖 Auto Farm",
    CurrentValue = false,
    Callback = function(v) getgenv().AutoFarm = v end
})

local function NoClip()
    local c = Players.LocalPlayer.Character
    if not c then return end
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = false end
    end
end

local function Clip()
    local c = Players.LocalPlayer.Character
    if not c then return end
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = true end
    end
end

local function CreatePath(pos)
    local p = Instance.new("Part")
    p.Size = Vector3.new(6, 0.5, 6)
    p.Anchored = true
    p.CanCollide = false
    p.Transparency = 0.3
    p.Color = Color3.fromRGB(50,255,100)
    p.CFrame = CFrame.new(pos - Vector3.new(0,3,0))
    p.Parent = workspace
    game:GetService("Debris"):AddItem(p,1)
end

local function IsAlive(m)
    if not m or not m.Parent then return false end
    local h = m:GetAttribute("Health")
    if h and h > 0 then return true end
    local hum = m:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

local function FindNearest()
    local p = Players.LocalPlayer
    local c = p.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local nearest, dist = nil, math.huge
    for _, m in pairs(workspace:WaitForChild("Debris"):WaitForChild("Monsters"):GetChildren()) do
        local t = m:GetAttribute("Title") or m.Name
        if table.find(Selected,t) and IsAlive(m) then
            local root = m:FindFirstChild("HumanoidRootPart")
            if root then
                local d = (hrp.Position - root.Position).Magnitude
                if d < dist then dist = d nearest = m end
            end
        end
    end
    return nearest
end

local function TeleportInstant(hrp,target)
    hrp.CFrame = CFrame.new(target.Position) + Vector3.new(0,3,0)
    CreatePath(hrp.Position)
end

local function TweenTarget(hrp,target)
    local info = TweenInfo.new(0.6, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(target.Position) + Vector3.new(0,3,0)})
    tween:Play()
    tween.Completed:Wait()
    CreatePath(hrp.Position)
end

local function WalkTarget(humanoid,targetPos)
    NoClip()
    humanoid:MoveTo(targetPos)
    local t = tick()
    while tick()-t < 10 do
        if (humanoid.RootPart.Position - targetPos).Magnitude < 5 then break end
        task.wait(0.2)
    end
    Clip()
end

local function AttackTarget(m)
    while IsAlive(m) and getgenv().AutoFarm do
        Click()
        task.wait(0.15)
    end
end

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().AutoFarm and next(Selected) then
            local p = Players.LocalPlayer
            local c = p.Character
            if not c then continue end
            local hrp = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then continue end
            local target = FindNearest()
            if target then
                local root = target:FindFirstChild("HumanoidRootPart")
                if root then
                    if getgenv().FarmMethod == "Instant" then
                        TeleportInstant(hrp,root)
                    elseif getgenv().FarmMethod == "Tween" then
                        TweenTarget(hrp,root)
                    elseif getgenv().FarmMethod == "Walk" then
                        WalkTarget(hum,root.Position)
                    end
                    AttackTarget(target)
                end
            end
        end
    end
end)

local Gacha = Window:CreateTab("🎰 Gacha","star")

local Stars = {}
for i=1,28 do table.insert(Stars,"Star_"..i) end
local StarSelected = "Star_1"

Gacha:CreateDropdown({
    Name="Select Star",
    Options=Stars,
    CurrentOption="Star_1",
    Callback=function(opt) StarSelected = opt end
})

getgenv().AutoOpenStar = false

local function OpenStar()
    while getgenv().AutoOpenStar do
        local args = {{Open_Amount=999999,Action="_Stars",Name=StarSelected}}
        Events:FireServer(unpack(args))
        task.wait(0.3)
    end
end

Gacha:CreateToggle({
    Name="⭐ Auto Open Max Star",
    CurrentValue=false,
    Callback=function(v)
        getgenv().AutoOpenStar = v
        if v then
            task.spawn(OpenStar)
        end
    end
})
