local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local workspace = game.workspace

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
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Albiology Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Albiology Hub V1",
      Subtitle = "Key System",
      Note = "Key for Albiology hub is EternalV1",
      FileName = "Enter Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"EternalV1"},
   }
})

local randomTime = math.random(500, 2000) / 100
warn("[ Sindex Client ] - Loaded in " .. string.format("%.2f", randomTime) .. " ms")
Rayfield:Notify({
   Title = "🎉 Welcome to AlBiology Hub",
   Content = "Script Successfully Loaded!",
   Duration = 6.5,
   Image = "box",
})

local Main = Window:CreateTab("Main","compass")

local CombatSection = Main:CreateSection("⚔️ Features")

local AutoHit = Main:CreateToggle({
   Name = "🖱️ Auto Clicker",
   CurrentValue = false,
   Flag = "AutoClicker",
   Callback = function(Value)
        getgenv().autoclicker = Value
   end,
})

getgenv().autoclicker = false
spawn(function()
    while task.wait() do
        if getgenv().autoclicker then
            pcall(function()
                local args = {{Action = "_Mouse_Click"}}
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
            end)
        end
    end
end)

local EnemyLists = {}
local SelectedEnemyNames = {}

local function UpdateEnemyLists()
    EnemyLists = {}
    for _, monster in pairs(workspace.Debris.Monsters:GetChildren()) do
        local title = monster:GetAttribute("Title") or monster.Name
        if not table.find(EnemyLists, title) then
            table.insert(EnemyLists, title)
        end
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
        SelectedEnemyNames = Options
        Rayfield:Notify({
            Title = "🎯 Enemy Selection",
            Content = "Selected: " .. table.concat(Options, ", "),
            Duration = 6.5,
            Image = "box",
        })
    end,
})

local RefreshButton = Main:CreateButton({
    Name = "🔄 Refresh Enemy Lists",
    Callback = function()
        UpdateEnemyLists()
        SelectEnemy:Refresh(EnemyLists)
        Rayfield:Notify({
            Title = "✅ Enemy List Updated",
            Content = "Monster list has been refreshed!",
            Duration = 6.5,
            Image = "box",
        })
    end,
})

getgenv().autofarmmonster = false

local AutoFarmMonster = Main:CreateToggle({
    Name = "🤖 Auto Farm Monster",
    CurrentValue = false,
    Flag = "AutoFarmMonster",
    Callback = function(Value)
        getgenv().autofarmmonster = Value
    end,
})

spawn(function()
    while task.wait(0.1) do
        if getgenv().autofarmmonster and #SelectedEnemyNames > 0 then
            local player = game.Players.LocalPlayer
            local char = player and player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, monster in pairs(workspace.Debris.Monsters:GetChildren()) do
                    local monsterTitle = monster:GetAttribute("Title") or monster.Name
                    if table.find(SelectedEnemyNames, monsterTitle) then
                        local primary = monster:FindFirstChild("HumanoidRootPart") or monster.PrimaryPart
                        if primary then
                            pcall(function()
                                local pos = primary.Position * Vector3.new(1, 1, 1)
                                hrp.CFrame = CFrame.new(pos)
                                local part = Instance.new("Part")
                                part.Size = Vector3.new(6, 0.5, 6)
                                part.Anchored = true
                                part.CanCollide = false
                                part.Transparency = 0.3
                                part.Color = Color3.fromRGB(50, 255, 100)
                                part.CFrame = CFrame.new(hrp.Position - Vector3.new(0, hrp.Size.Y/2 + 2, 0))
                                part.Parent = workspace
                                game.Debris:AddItem(part, 1)
                            end)
                            break
                        end
                    end
                end
            end
        end
    end
end)

local StatsSection = Main:CreateSection("📊 Stats Management")

local StatsList = {"Damage", "Energy", "Coins", "Luck"}
local SelectedStats = {}

local StatsDropdown = Main:CreateDropdown({
    Name = "📈 Auto Add Stats",
    Options = StatsList,
    CurrentOption = nil,
    MultipleOptions = true,
    Flag = "StatsDropdown",
    Callback = function(Options)
        SelectedStats = Options
    end,
})

local AutoStatsToggle = Main:CreateToggle({
    Name = "⚡ Auto Add Stats",
    CurrentValue = false,
    Flag = "AutoStatsToggle",
    Callback = function(Value)
        getgenv().autoaddstats = Value
    end,
})

spawn(function()
    while task.wait(0.5) do
        if getgenv().autoaddstats and next(SelectedStats) ~= nil then
            for _, statName in pairs(SelectedStats) do
                pcall(function()
                    local args = {{
                        Name = "Primary_" .. statName,
                        Action = "Assign_Level_Stats",
                        Amount = 1
                    }}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
                end)
            end
        end
    end
end)

local DungeonSection = Main:CreateSection("🏰 Dungeon Features")

local DungeonList = {"Easy", "Medium", "Hard", "Insane", "Crazy", "Nightmare", "Leaf"}
local SelectedDungeons = {}

local DungeonDropdown = Main:CreateDropdown({
    Name = "🎪 Select Dungeon",
    Options = DungeonList,
    CurrentOption = nil,
    MultipleOptions = true,
    Flag = "DungeonDropdown",
    Callback = function(Options)
        SelectedDungeons = {}
        for _, dungeonName in pairs(Options) do
            if dungeonName == "Leaf" then
                table.insert(SelectedDungeons, "Leaf_Raid")
            else
                table.insert(SelectedDungeons, "Dungeon_" .. dungeonName)
            end
        end
    end,
})

local AutoJoinToggle = Main:CreateToggle({
    Name = "🚪 Auto Join Dungeon",
    CurrentValue = false,
    Flag = "AutoJoinToggle",
    Callback = function(Value)
        getgenv().autojoindungeon = Value
    end,
})

local AutoFarmToggle = Main:CreateToggle({
    Name = "⚔️ Auto Farm Dungeon",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        getgenv().autofarmdungeon = Value
    end,
})

spawn(function()
    while task.wait(5) do
        if getgenv().autojoindungeon and next(SelectedDungeons) ~= nil then
            for _, dungeonName in pairs(SelectedDungeons) do
                pcall(function()
                    local args = {{Action = "_Enter_Dungeon", Name = dungeonName}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("To_Server"):FireServer(unpack(args))
                end)
            end
        end
    end
end)

spawn(function()
    while task.wait(0.2) do
        if getgenv().autofarmdungeon then
            local nearestMonster = nil
            local nearestDistance = math.huge
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                for _, monster in pairs(workspace.Debris.Monsters:GetChildren()) do
                    local humanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local distance = (hrp.Position - humanoidRootPart.Position).Magnitude
                        if distance < nearestDistance then
                            nearestDistance = distance
                            nearestMonster = humanoidRootPart
                        end
                    end
                end
                if nearestMonster then
                    pcall(function()
                        hrp.CFrame = nearestMonster.CFrame
                    end)
                end
            end
        end
    end
end)

local GachaStatsTab = Window:CreateTab("🎮 Gacha & Stats", "gamepad")

local StatsSection = GachaStatsTab:CreateSection("📊 Player Statistics")

local LevelLabel = GachaStatsTab:CreateLabel("🎯 Level: Loading...")
local RankLabel = GachaStatsTab:CreateLabel("🏆 Rank: Loading...")
local EnergyLabel = GachaStatsTab:CreateLabel("⚡ Energy: Loading...")

spawn(function()
    while task.wait(2) do
        pcall(function()
            local player = game.Players.LocalPlayer
            if player then
                local leaderstats = player:FindFirstChild("leaderstats")
                if leaderstats then
                    local level = leaderstats:FindFirstChild("Level (Prestige)")
                    local rank = leaderstats:FindFirstChild("Rank")
                    local energy = leaderstats:FindFirstChild("Energy")
                    if level then LevelLabel:SetText("🎯 Level: " .. level.Value) end
                    if rank then RankLabel:SetText("🏆 Rank: " .. rank.Value) end
                    if energy then EnergyLabel:SetText("⚡ Energy: " .. energy.Value) end
                end
            end
        end)
    end
end)

local GachaSection = GachaStatsTab:CreateSection("🎰 Gacha & Upgrade System")

local GachaList = {"Common", "Rare", "Epic", "Legendary"}
local GachaDropdown = GachaStatsTab:CreateDropdown({
    Name = "📦 Select Gacha Type",
    Options = GachaList,
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "GachaDropdown",
    Callback = function(Option) end,
})

local StarList = {"1 Star", "2 Star", "3 Star", "4 Star", "5 Star"}
local StarDropdown = GachaStatsTab:CreateDropdown({
    Name = "⭐ Select Star Level",
    Options = StarList,
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "StarDropdown",
    Callback = function(Option) end,
})

local UpgradeList = {"Weapon", "Armor", "Accessory"}
local UpgradeDropdown = GachaStatsTab:CreateDropdown({
    Name = "🔧 Select Upgrade Type",
    Options = UpgradeList,
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "UpgradeDropdown",
    Callback = function(Option) end,
})

local OpenGachaToggle = GachaStatsTab:CreateToggle({
    Name = "🎁 Open Gacha",
    CurrentValue = false,
    Flag = "OpenGachaToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "🚧 Feature Coming Soon",
                Content = "Open Gacha functionality is under development!",
                Duration = 6.5,
                Image = "box",
            })
            OpenGachaToggle:Set(false)
        end
    end,
})

local OpenStarToggle = GachaStatsTab:CreateToggle({
    Name = "🌟 Open Star",
    CurrentValue = false,
    Flag = "OpenStarToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "🚧 Feature Coming Soon",
                Content = "Open Star functionality is under development!",
                Duration = 6.5,
                Image = "box",
            })
            OpenStarToggle:Set(false)
        end
    end,
})

local AutoUpgradeToggle = GachaStatsTab:CreateToggle({
    Name = "🔄 Auto Upgrade",
    CurrentValue = false,
    Flag = "AutoUpgradeToggle",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "🚧 Feature Coming Soon",
                Content = "Auto Upgrade functionality is under development!",
                Duration = 6.5,
                Image = "box",
            })
            AutoUpgradeToggle:Set(false)
        end
    end,
})
