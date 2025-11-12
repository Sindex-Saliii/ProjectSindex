local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local Events = ReplicatedStorage:WaitForChild("Events"):WaitForChild("To_Server")

local Window = Rayfield:CreateWindow({
   Name = "[ Anime Eternal ] Albiology Hub",
   Icon = "biohazard",
   LoadingTitle = "Anime Eternal - Next Gen",
   LoadingSubtitle = "Powered by Albiology Hub",
   ShowText = "Gayfield",
   Theme = "Serenity",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "Albiology Hub"},
   Discord = {Enabled = false, Invite = "noinvitelink", RememberJoins = true},
   KeySystem = true,
   KeySettings = {Title = "Albiology Hub V1", Subtitle = "Key System", Note = "Key for Albiology hub is EternalV1", FileName = "Enter Key", SaveKey = true, GrabKeyFromSite = false, Key = {"EternalV1"}}
})

local randomTime = math.random(500, 2000) / 100
warn("[ Sindex Client ] - Loaded in " .. string.format("%.2f", randomTime) .. " ms")
Rayfield:Notify({Title = "🎉 Welcome to AlBiology Hub", Content = "Script Successfully Loaded!", Duration = 6.5, Image = "box"})

local Main = Window:CreateTab("Main","compass")
local CombatSection = Main:CreateSection("⚔️ Features")

getgenv().AutoClick = false
getgenv().AutoFarm = false
getgenv().FarmMethod = "Instant"
getgenv().SelectedEnemyNames = {}
getgenv().AutoAddStats = false
getgenv().SelectedStats = {}
getgenv().AutoJoinDungeon = false
getgenv().AutoFarmDungeon = false
getgenv().AutoOpenStar = false
getgenv().SelectedStar = "Star_1"
getgenv().StarOpenDelay = 0.25
getgenv().StarOpenAmount = 9999

local function Click()
    pcall(function()
        Events:FireServer({Action = "_Mouse_Click"})
    end)
end

Main:CreateToggle({Name = "🖱️ Auto Clicker", CurrentValue = false, Flag = "AutoClicker", Callback = function(v) getgenv().AutoClick = v end})
task.spawn(function()
    while task.wait(0.12) do
        if getgenv().AutoClick then
            Click()
        end
    end
end)

local EnemyLists = {}
local function UpdateEnemyLists()
    EnemyLists = {}
    local success,mons = pcall(function()
        return Workspace:FindFirstChild("Debris") and Workspace.Debris:FindFirstChild("Monsters") and Workspace.Debris.Monsters:GetChildren() or {}
    end)
    for _,monster in pairs(mons) do
        local title = monster:GetAttribute("Title") or monster.Name
        if not table.find(EnemyLists, title) then table.insert(EnemyLists, title) end
    end
end
UpdateEnemyLists()

local SelectEnemy = Main:CreateDropdown({
    Name = "🎯 Select Enemy",
    Options = EnemyLists,
    CurrentOption = nil,
    MultipleOptions = true,
    Flag = "Dropdown1",
    Callback = function(Options)
        getgenv().SelectedEnemyNames = Options or {}
        Rayfield:Notify({Title = "🎯 Enemy Selection", Content = "Selected: " .. (table.concat(Options, ", ") or ""), Duration = 4, Image = "box"})
    end,
})
Main:CreateButton({Name = "🔄 Refresh Enemy Lists", Callback = function() UpdateEnemyLists(); SelectEnemy:Refresh(EnemyLists); Rayfield:Notify({Title="✅ Enemy List Updated", Content="Monster list has been refreshed!", Duration=4, Image="box"}) end})

Main:CreateDropdown({Name = "🚶 Farming Method", Options = {"Instant","Tween","Walk"}, CurrentOption = "Instant", MultipleOptions = false, Flag = "FarmingMethod", Callback = function(opt) getgenv().FarmMethod = opt end})
Main:CreateToggle({Name = "🤖 Auto Farm Monster", CurrentValue = false, Flag = "AutoFarmMonster", Callback = function(v) getgenv().AutoFarm = v end})

local StatsSection = Main:CreateSection("📊 Stats Management")
local StatsList = {"Damage", "Energy", "Coins", "Luck"}
local SelectedStats = {}
local StatsDropdown = Main:CreateDropdown({Name = "📈 Auto Add Stats", Options = StatsList, CurrentOption = nil, MultipleOptions = true, Flag = "StatsDropdown", Callback = function(Options) SelectedStats = Options end})
Main:CreateToggle({Name = "⚡ Auto Add Stats", CurrentValue = false, Flag = "AutoStatsToggle", Callback = function(v) getgenv().AutoAddStats = v end})
task.spawn(function()
    while task.wait(0.6) do
        if getgenv().AutoAddStats and next(SelectedStats) ~= nil then
            for _, statName in pairs(SelectedStats) do
                pcall(function()
                    Events:FireServer({Name = "Primary_" .. statName, Action = "Assign_Level_Stats", Amount = 1})
                end)
            end
        end
    end
end)

local DungeonSection = Main:CreateSection("🏰 Dungeon Features")
local DungeonList = {"Easy", "Medium", "Hard", "Insane", "Crazy", "Nightmare", "Leaf"}
local SelectedDungeons = {}
local DungeonDropdown = Main:CreateDropdown({Name = "🎪 Select Dungeon", Options = DungeonList, CurrentOption = nil, MultipleOptions = true, Flag = "DungeonDropdown", Callback = function(Options)
    SelectedDungeons = {}
    for _, dungeonName in pairs(Options or {}) do
        if dungeonName == "Leaf" then table.insert(SelectedDungeons, "Leaf_Raid") else table.insert(SelectedDungeons, "Dungeon_" .. dungeonName) end
    end
end})
Main:CreateToggle({Name = "🚪 Auto Join Dungeon", CurrentValue = false, Flag = "AutoJoinToggle", Callback = function(v) getgenv().AutoJoinDungeon = v end})
Main:CreateToggle({Name = "⚔️ Auto Farm Dungeon", CurrentValue = false, Flag = "AutoFarmToggle", Callback = function(v) getgenv().AutoFarmDungeon = v end})

task.spawn(function()
    while task.wait(5) do
        if getgenv().AutoJoinDungeon and next(SelectedDungeons) ~= nil then
            for _, dungeonName in pairs(SelectedDungeons) do
                pcall(function()
                    Events:FireServer({Action = "_Enter_Dungeon", Name = dungeonName})
                end)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().AutoFarmDungeon then
            local player = Players.LocalPlayer
            local character = player and player.Character
            if not (character and character:FindFirstChild("HumanoidRootPart")) then continue end
            local hrp = character.HumanoidRootPart
            local nearest, nd = nil, math.huge
            local mons = Workspace:FindFirstChild("Debris") and Workspace.Debris:FindFirstChild("Monsters") and Workspace.Debris.Monsters:GetChildren() or {}
            for _, m in pairs(mons) do
                local prim = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
                if prim then
                    local d = (hrp.Position - prim.Position).Magnitude
                    if d < nd then nd = d; nearest = prim end
                end
            end
            if nearest then
                pcall(function()
                    hrp.CFrame = nearest.CFrame
                end)
            end
        end
    end
end)

local GachaTab = Window:CreateTab("🎮 Gacha & Stats", "gamepad")
local StarList = {}
for i=1,28 do table.insert(StarList, "Star_"..i) end
local SelectedStar = "Star_1"
GachaTab:CreateDropdown({Name = "📦 Select Star Type", Options = StarList, CurrentOption = "Star_1", MultipleOptions = false, Flag = "GachaDropdown", Callback = function(opt) SelectedStar = opt end})
GachaTab:CreateToggle({Name = "⭐ Auto Open Star (Max)", CurrentValue = false, Flag = "AutoOpenStar", Callback = function(v) getgenv().AutoOpenStar = v if v then task.spawn(function() while getgenv().AutoOpenStar do pcall(function() Events:FireServer({Open_Amount = getgenv().StarOpenAmount, Action = "_Stars", Name = SelectedStar}) end); task.wait(getgenv().StarOpenDelay) end end) end end})

local function CreatePathAt(position)
    local part = Instance.new("Part")
    part.Size = Vector3.new(5,1,5)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.3
    part.Color = Color3.fromRGB(50,255,100)
    part.CFrame = CFrame.new(position - Vector3.new(0,3,0))
    part.Parent = Workspace
    Debris:AddItem(part, 1)
end

local function IsMonsterAlive(monster)
    if not monster or not monster.Parent then return false end
    local att = monster:GetAttribute("Health")
    if typeof(att) == "number" then
        if att <= 0 then return false end
        return true
    end
    local hum = monster:FindFirstChildOfClass("Humanoid")
    if hum then
        return hum.Health > 0
    end
    return true
end

local function FindTargetFromNames(names)
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return nil end
    local hrp = char.HumanoidRootPart
    local nearest = nil
    local nd = math.huge
    local mons = Workspace:FindFirstChild("Debris") and Workspace.Debris:FindFirstChild("Monsters") and Workspace.Debris.Monsters:GetChildren() or {}
    for _, m in pairs(mons) do
        local title = m:GetAttribute("Title") or m.Name
        if table.find(names, title) and IsMonsterAlive(m) then
            local prim = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
            if prim then
                local d = (hrp.Position - prim.Position).Magnitude
                if d < nd then nd = d; nearest = m end
            end
        end
    end
    return nearest
end

local OriginalCollides = {}
local function NoClip()
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not char then return end
    OriginalCollides = {}
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            OriginalCollides[part] = part.CanCollide
            part.CanCollide = false
        end
    end
end

local function Clip()
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not char then return end
    for part, v in pairs(OriginalCollides) do
        if part and part:IsA("BasePart") then
            pcall(function() part.CanCollide = v end)
        end
    end
    OriginalCollides = {}
end

local function TeleportTarget(targetPrim)
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = char.HumanoidRootPart
    pcall(function()
        hrp.CFrame = CFrame.new(targetPrim.Position) + Vector3.new(0,3,0)
    end)
    CreatePathAt(hrp.Position)
end

local function TweenTarget(targetPrim)
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = char.HumanoidRootPart
    local info = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
    local ok, tween = pcall(function() return TweenService:Create(hrp, info, {CFrame = CFrame.new(targetPrim.Position) + Vector3.new(0,3,0)}) end)
    if ok and tween then
        tween:Play()
        local suc = pcall(function() tween.Completed:Wait() end)
        CreatePathAt(hrp.Position)
    else
        pcall(function() hrp.CFrame = CFrame.new(targetPrim.Position) + Vector3.new(0,3,0) end)
        CreatePathAt(hrp.Position)
    end
end

local function WalkTargetTo(targetPos)
    local player = Players.LocalPlayer
    local char = player and player.Character
    if not (char and char:FindFirstChildOfClass("Humanoid")) then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    NoClip()
    humanoid:MoveTo(targetPos)
    local start = tick()
    while tick() - start < 12 do
        if (char.PrimaryPart and (char.PrimaryPart.Position - targetPos).Magnitude or 0) < 6 then
            Clip()
            return true
        end
        task.wait(0.18)
    end
    Clip()
    return false
end

local function AttackTarget(monster)
    if not monster or not monster.Parent then return end
    while getgenv().AutoFarm and IsMonsterAlive(monster) do
        Click()
        task.wait(0.14)
    end
end

task.spawn(function()
    while task.wait(0.12) do
        if getgenv().AutoFarm and next(getgenv().SelectedEnemyNames) ~= nil then
            local target = FindTargetFromNames(getgenv().SelectedEnemyNames)
            if target and target.Parent then
                local prim = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
                if prim then
                    if getgenv().FarmMethod == "Instant" then
                        TeleportTarget(prim)
                    elseif getgenv().FarmMethod == "Tween" then
                        NoClip()
                        TweenTarget(prim)
                        Clip()
                    else
                        WalkTargetTo(prim.Position)
                    end
                    AttackTarget(target)
                end
            else
                task.wait(0.6)
            end
        else
            task.wait(0.4)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().AutoFarm then
            local player = Players.LocalPlayer
            local char = player and player.Character
            if not (char and char:FindFirstChild("HumanoidRootPart")) then continue end
            if getgenv().FarmMethod == "Walk" then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end)

local function RefreshLoop()
    while task.wait(5) do
        UpdateEnemyLists()
        SelectEnemy:Refresh(EnemyLists)
    end
end
task.spawn(RefreshLoop)
