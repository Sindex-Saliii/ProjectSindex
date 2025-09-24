local Env = getgenv()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Create the main UI elements
local Loader = Instance.new("ScreenGui")
Loader.Name = "Loader"
Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Loader.Parent = game:GetService("CoreGui")

local LoaderMain = Instance.new("Frame")
LoaderMain.Name = "LoaderMain"
LoaderMain.Size = UDim2.new(0, 400, 0, 200)
LoaderMain.Position = UDim2.new(0.5, 0, 0.5, 0)
LoaderMain.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
LoaderMain.BackgroundTransparency = 0.5 -- Semi-transparent
LoaderMain.BorderSizePixel = 0
LoaderMain.ClipsDescendants = true
LoaderMain.Parent = Loader

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = LoaderMain

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)), -- Pink
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 112, 219)) -- Purple
})
UIGradient.Rotation = 45 -- Diagonal gradient
UIGradient.Parent = LoaderMain

local Info = Instance.new("TextLabel")
Info.Name = "Info"
Info.Size = UDim2.new(0, 350, 0, 50)
Info.Position = UDim2.new(0.5, 0, 0.2, 0)
Info.AnchorPoint = Vector2.new(0.5, 0)
Info.BackgroundTransparency = 1
Info.Text = "Loading Flower Hub 3.0 Beta"
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Info.TextSize = 18
Info.TextTransparency = 0.5 -- Slightly transparent text
Info.Parent = LoaderMain

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(0, 350, 0, 30)
Status.Position = UDim2.new(0.5, 0, 0.5, 0)
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.BackgroundTransparency = 1
Status.Text = "0%"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Status.TextSize = 14
Status.TextTransparency = 0.5
Status.Parent = LoaderMain

local UF = Instance.new("Frame")
UF.Name = "UF"
UF.Size = UDim2.new(0, 350, 0, 10) -- Thinner progress bar
UF.Position = UDim2.new(0.5, 0, 0.7, 0)
UF.AnchorPoint = Vector2.new(0.5, 0)
UF.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker background for progress bar
UF.BackgroundTransparency = 0.5
UF.BorderSizePixel = 0
UF.ClipsDescendants = true
UF.Parent = LoaderMain

local B_UICorner = Instance.new("UICorner")
B_UICorner.CornerRadius = UDim.new(0, 5) -- Rounded corners for progress bar
B_UICorner.Parent = UF

local GS = Instance.new("Frame")
GS.Name = "GS"
GS.Size = UDim2.new(0, 0, 0, 10) -- Thinner progress bar
GS.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Pink
GS.BorderSizePixel = 0
GS.Parent = UF

local A_UICorner = Instance.new("UICorner")
A_UICorner.CornerRadius = UDim.new(0, 5) -- Rounded corners for progress bar
A_UICorner.Parent = GS

local UIGradient_1 = Instance.new("UIGradient")
UIGradient_1.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)), -- Pink
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 112, 219)) -- Purple
})
UIGradient_1.Rotation = 45 -- Diagonal gradient
UIGradient_1.Parent = GS

-- Function to update loading status
local function UpdateStatus(percentage)
    Status.Text = percentage .. "%"
    GS.Size = UDim2.new(0, 350 * (percentage / 100), 0, 10)
end

-- Tween animations
local function AnimateLoader()
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Fade in the text
    TweenService:Create(Info, tweenInfo, { TextTransparency = 0 }):Play()
    TweenService:Create(Status, tweenInfo, { TextTransparency = 0 }):Play()
    wait(0.5)
    
    -- Simulate loading progress
    for i = 0, 100, 5 do
        UpdateStatus(i)
        wait(0.1)
    end
    
    -- Fade out the loader
    TweenService:Create(LoaderMain, tweenInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Info, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(Status, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(UF, tweenInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(GS, tweenInfo, { BackgroundTransparency = 1 }):Play()
    wait(1)
    
    -- Destroy the loader
    Loader:Destroy()
end

-- Start the animation
AnimateLoader()


--------------------------------------------------------------------

First_Sea = false
Second_Sea = false
Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    First_Sea = true
elseif placeId == 4442272183 then
    Second_Sea = true
elseif placeId == 7449423635 then
    Third_Sea = true
end

function CheckLevel()
    local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
    if First_Sea then
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        if Lv == 1 or Lv <= 9 or Env.SelectMonster == "Bandit [Lv. 5]" then -- Bandit
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif Lv == 10 or Lv <= 14 or Env.SelectMonster == "Monkey [Lv. 14]" then -- Monkey
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
        elseif Lv == 15 or Lv <= 29 or Env.SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
            Ms = "Gorilla"
            NameQuest = "JungleQuest"
            QuestLv = 2
            NameMon = "Gorilla"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
        elseif Lv == 30 or Lv <= 39 or Env.SelectMonster == "Pirate [Lv. 35]" then -- Pirate
            Ms = "Pirate"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            NameMon = "Pirate"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
        elseif Lv == 40 or Lv <= 59 or Env.SelectMonster == "Brute [Lv. 45]" then -- Brute
            Ms = "Brute"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            NameMon = "Brute"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
        elseif Lv == 60 or Lv <= 74 or Env.SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
            Ms = "Desert Bandit"
            NameQuest = "DesertQuest"
            QuestLv = 1
            NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        elseif Lv == 75 or Lv <= 89 or Env.SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
            Ms = "Desert Officer"
            NameQuest = "DesertQuest"
            QuestLv = 2
            NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        elseif Lv == 90 or Lv <= 99 or Env.SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
            Ms = "Snow Bandit"
            NameQuest = "SnowQuest"
            QuestLv = 1
            NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
        elseif Lv == 100 or Lv <= 119 or Env.SelectMonster == "Snowman [Lv. 100]" then -- Snowman
            Ms = "Snowman"
            NameQuest = "SnowQuest"
            QuestLv = 2
            NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        elseif Lv == 120 or Lv <= 149 or Env.SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
            Ms = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            QuestLv = 1
            NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
        elseif Lv == 150 or Lv <= 174 or Env.SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
            Ms = "Sky Bandit"
            NameQuest = "SkyQuest"
            QuestLv = 1
            NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
        elseif Lv == 175 or Lv <= 189 or Env.SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
            Ms = "Dark Master"
            NameQuest = "SkyQuest"
            QuestLv = 2
            NameMon = "Dark Master"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
        elseif Lv == 190 or Lv <= 209 or Env.SelectMonster == "Prisoner [Lv. 190]" then -- Prisoner
            Ms = "Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 1
            NameMon = "Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, -0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)
        elseif Lv == 210 or Lv <= 249 or Env.SelectMonster == "Dangerous Prisoner [Lv. 210]" then -- Dangerous Prisoner
            Ms = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 2
            NameMon = "Dangerous Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, -0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)
        elseif Lv == 250 or Lv <= 274 or Env.SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
            Ms = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
        elseif Lv == 275 or Lv <= 299 or Env.SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
            Ms = "Gladiator"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            NameMon = "Gladiator"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
        elseif Lv == 300 or Lv <= 324 or Env.SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
            Ms = "Military Soldier"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            NameMon = "Military Soldier"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
        elseif Lv == 325 or Lv <= 374 or Env.SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
            Ms = "Military Spy"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            NameMon = "Military Spy"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
        elseif Lv == 375 or Lv <= 399 or Env.SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
            Ms = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif Lv == 400 or Lv <= 449 or Env.SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
            Ms = "Fishman Commando"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif Lv == 450 or Lv <= 474 or Env.SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
            Ms = "God's Guard"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            NameMon = "God's Guard"
            CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
            CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif Lv == 475 or Lv <= 524 or Env.SelectMonster == "Shanda [Lv. 475]" then -- Shanda
            Ms = "Shanda"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            NameMon = "Shanda"
            CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
            CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif Lv == 525 or Lv <= 549 or Env.SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
            Ms = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            NameMon = "Royal Squad"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
        elseif Lv == 550 or Lv <= 624 or Env.SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
            Ms = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
        elseif Lv == 625 or Lv <= 649 or Env.SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
            Ms = "Galley Pirate"
            NameQuest = "FountainQuest"
            QuestLv = 1
            NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
        elseif Lv >= 650 or Env.SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
            Ms = "Galley Captain"
            NameQuest = "FountainQuest"
            QuestLv = 2
            NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
        end
    end
    if Second_Sea then
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        if Lv == 700 or Lv <= 724 or Env.SelectMonster == "Raider [Lv. 700]" then -- Raider
            Ms = "Raider"
            NameQuest = "Area1Quest"
            QuestLv = 1
            NameMon = "Raider"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif Lv == 725 or Lv <= 774 or Env.SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
            Ms = "Mercenary"
            NameQuest = "Area1Quest"
            QuestLv = 2
            NameMon = "Mercenary"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
        elseif Lv == 775 or Lv <= 799 or Env.SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
            Ms = "Swan Pirate"
            NameQuest = "Area2Quest"
            QuestLv = 1
            NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif Lv == 800 or Lv <= 874 or Env.SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
            Ms = "Factory Staff"
            NameQuest = "Area2Quest"
            QuestLv = 2
            NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif Lv == 875 or Lv <= 899 or Env.SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
            Ms = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
        elseif Lv == 900 or Lv <= 949 or Env.SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
            Ms = "Marine Captain"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            NameMon = "Marine Captain"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
        elseif Lv == 950 or Lv <= 974 or Env.SelectMonster == "Zombie [Lv. 950]" then -- Zombie
            Ms = "Zombie"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            NameMon = "Zombie"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
        elseif Lv == 975 or Lv <= 999 or Env.SelectMonster == "Vampire [Lv. 975]" then -- Vampire
            Ms = "Vampire"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            NameMon = "Vampire"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
        elseif Lv == 1000 or Lv <= 1049 or Env.SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
            Ms = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
        elseif Lv == 1050 or Lv <= 1099 or Env.SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
            Ms = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
        elseif Lv == 1100 or Lv <= 1124 or Env.SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
            Ms = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
        elseif Lv == 1125 or Lv <= 1174 or Env.SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
            Ms = "Horned Warrior"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
        elseif Lv == 1175 or Lv <= 1199 or Env.SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
            Ms = "Magma Ninja"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
        elseif Lv == 1200 or Lv <= 1249 or Env.SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
            Ms = "Lava Pirate"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
        elseif Lv == 1250 or Lv <= 1274 or Env.SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
            Ms = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1275 or Lv <= 1299 or Env.SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
            Ms = "Ship Engineer"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1300 or Lv <= 1324 or Env.SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
            Ms = "Ship Steward"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1325 or Lv <= 1349 or Env.SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
            Ms = "Ship Officer"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1350 or Lv <= 1374 or Env.SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
            Ms = "Arctic Warrior"
            NameQuest = "FrostQuest"
            QuestLv = 1
            NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            end
        elseif Lv == 1375 or Lv <= 1424 or Env.SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
            Ms = "Snow Lurker"
            NameQuest = "FrostQuest"
            QuestLv = 2
            NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
        elseif Lv == 1425 or Lv <= 1449 or Env.SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
            Ms = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
        elseif Lv >= 1450 or Env.SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
            Ms = "Water Fighter"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            NameMon = "Water Fighter"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
        end
    end
    if Third_Sea then
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        if Lv == 1500 or Lv <= 1524 or Env.SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
            Ms = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
        elseif Lv == 1525 or Lv <= 1574 or Env.SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
            Ms = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
        elseif Lv == 1575 or Lv <= 1599 or Env.SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
            Ms = "Dragon Crew Warrior"
            NameQuest = "DragonCrewQuest"
            QuestLv = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(6735.11084, 126.990463, -711.097961, 0.629286051, -0, -0.777173758, 0, 1, -0, 0.777173758, 0, 0.629286051)
            CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
        elseif Lv == 1600 or Lv <= 1624 or Env.SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
            Ms = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            QuestLv = 2
            NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(6735.11084, 126.990463, -711.097961, 0.629286051, -0, -0.777173758, 0, 1, -0, 0.777173758, 0, 0.629286051)
            CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
        elseif Lv == 1625 or Lv <= 1649 or Env.SelectMonster == "Hydra Enforcer [Lv. 1625]" then -- Female Islander 
            Ms = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            QuestLv = 1
            NameMon = "Hydra Enforcer"
            CFrameQ = CFrame.new(5214.33936, 1003.46765, 759.507324, 0.998771548, 0, 0.0495514274, 0, 1, 0, -0.0495514274, 0, 0.9987715)
            CFrameMon = CFrame.new(5195.61182, 1089.23682, 617.974304, -0.546986341, -1.6157415e-08, 0.837141514, -3.3323051e-08, 1, -2.47250798e-09, -0.837141514, -2.92485378e-08, -0.546986341)
        elseif Lv == 1650 or Lv <= 1699 or Env.SelectMonster == "Venomous Assailant [Lv. 1650]" then -- Giant Islander
            Ms = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            QuestLv = 2
            NameMon = "Venomous Assailant"
            CFrameQ = CFrame.new(5214.33936, 1003.46765, 759.507324, 0.998771548, 0, 0.0495514274, 0, 1, 0, -0.0495514274, 0, 0.9987715)
            CFrameMon = CFrame.new(5195.61182, 1089.23682, 617.974304, -0.546986341, -1.6157415e-08, 0.837141514, -3.3323051e-08, 1, -2.47250798e-09, -0.837141514, -2.92485378e-08, -0.546986341)
        elseif Lv == 1700 or Lv <= 1724 or Env.SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
            Ms = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
        elseif Lv == 1725 or Lv <= 1774 or Env.SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
            Ms = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
        elseif Lv == 1775 or Lv <= 1799 or Env.SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
            Ms = "Fishman Raider"
            NameQuest = "DeepForestIsland3"
            QuestLv = 1
            NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
            CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
        elseif Lv == 1800 or Lv <= 1824 or Env.SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
            Ms = "Fishman Captain"
            NameQuest = "DeepForestIsland3"
            QuestLv = 2
            NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
            CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
        elseif Lv == 1825 or Lv <= 1849 or Env.SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
            Ms = "Forest Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 1
            NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
        elseif Lv == 1850 or Lv <= 1899 or Env.SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
            Ms = "Mythological Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 2
            NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
        elseif Lv == 1900 or Lv <= 1924 or Env.SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
            Ms = "Jungle Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 1
            NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
        elseif Lv == 1925 or Lv <= 1974 or Env.SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
            Ms = "Musketeer Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 2
            NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
        elseif Lv == 1975 or Lv <= 1999 or Env.SelectMonster == "Reborn Skeleton [Lv. 1975]" then
            Ms = "Reborn Skeleton"
            NameQuest = "HauntedQuest1"
            QuestLv = 1
            NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
        elseif Lv == 2000 or Lv <= 2024 or Env.SelectMonster == "Living Zombie [Lv. 2000]" then
            Ms = "Living Zombie"
            NameQuest = "HauntedQuest1"
            QuestLv = 2
            NameMon = "Living Zombie"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
        elseif Lv == 2025 or Lv <= 2049 or Env.SelectMonster == "Demonic Soul [Lv. 2025]" then
            Ms = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
        elseif Lv == 2050 or Lv <= 2074 or Env.SelectMonster == "Posessed Mummy [Lv. 2050]" then
            Ms = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
        elseif Lv == 2075 or Lv <= 2099 or Env.SelectMonster == "Peanut Scout [Lv. 2075]" then
            Ms = "Peanut Scout"
            NameQuest = "NutsIslandQuest"
            QuestLv = 1
            NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
        elseif Lv == 2100 or Lv <= 2124 or Env.SelectMonster == "Peanut President [Lv. 2100]" then
            Ms = "Peanut President"
            NameQuest = "NutsIslandQuest"
            QuestLv = 2
            NameMon = "Peanut President"
            CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
        elseif Lv == 2125 or Lv <= 2149 or Env.SelectMonster == "Ice Cream Chef [Lv. 2125]" then
            Ms = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
        elseif Lv == 2150 or Lv <= 2199 or Env.SelectMonster == "Ice Cream Commander [Lv. 2150]" then
            Ms = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
        elseif Lv == 2200 or Lv <= 2224 or Env.SelectMonster == "Cookie Crafter [Lv. 2200]" then
            Ms = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            QuestLv = 1
            NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
        elseif Lv == 2225 or Lv <= 2249 or Env.SelectMonster == "Cake Guard [Lv. 2225]" then
            Ms = "Cake Guard"
            NameQuest = "CakeQuest1"
            QuestLv = 2
            NameMon = "Cake Guard"
            CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
        elseif Lv == 2250 or Lv <= 2274 or Env.SelectMonster == "Baking Staff [Lv. 2250]" then
            Ms = "Baking Staff"
            NameQuest = "CakeQuest2"
            QuestLv = 1
            NameMon = "Baking Staff"
            CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
        elseif Lv == 2275 or Lv <= 2299 or Env.SelectMonster == "Head Baker [Lv. 2275]" then
            Ms = "Head Baker"
            NameQuest = "CakeQuest2"
            QuestLv = 2
            NameMon = "Head Baker"
            CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-2251.5791, 52.2714615, -13033.3965, -0.991971016, 0, -0.126466095, 0, 1, 0, 0.126466095, 0, -0.991971016)
        elseif Lv == 2300 or Lv <= 2324 or Env.SelectMonster == "Cocoa Warrior [Lv. 2300]" then
            Ms = "Cocoa Warrior"
            NameQuest ="ChocQuest1"
            QuestLv = 1
            NameMon = "Cocoa Warrior"
            CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            CFrameMon = CFrame.new(167.978516, 26.2254658, -12238.874, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961)
        elseif Lv == 2325 or Lv <= 2349 or Env.SelectMonster == "Chocolate Bar Battler [Lv. 2325]" then
            Ms = "Chocolate Bar Battler"
            NameQuest = "ChocQuest1"
            QuestLv = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            CFrameMon = CFrame.new(701.312073, 25.5824986, -12708.2148, -0.342042685, 0, -0.939684391, 0, 1, 0, 0.939684391, 0, -0.342042685)
        elseif Lv == 2350 or Lv <= 2374 or Env.SelectMonster == "Sweet Thief [Lv. 2350]" then
            Ms = "Sweet Thief"
            NameQuest = "ChocQuest2"
            QuestLv = 1
            NameMon = "Sweet Thief"
            CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(-140.258301, 25.5824986, -12652.3115, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
        elseif Lv == 2375 or Lv <= 2400 or Env.SelectMonster == "Candy Rebel [Lv. 2375]" then
            Ms = "Candy Rebel"
            NameQuest = "ChocQuest2"
            QuestLv = 2
            NameMon = "Candy Rebel"
            CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(47.9231453, 25.5824986, -13029.2402, -0.819156051, 0, -0.573571265, 0, 1, 0, 0.573571265, 0, -0.819156051)
        elseif Lv == 2400 or Lv <= 2424 or Env.SelectMonster == "Candy Pirate [Lv. 2400]" then
            Ms = "Candy Pirate"
            NameQuest = "CandyQuest1"
            QuestLv = 1
            NameMon = "Candy Pirate"
            CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
            CFrameMon = CFrame.new(-1437.56348, 17.1481285, -14385.6934, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
        elseif Lv == 2425 or Lv <= 2449 or Env.SelectMonster == "Snow Demon [Lv. 2425]" then
            Ms = "Snow Demon"
            NameQuest = "CandyQuest1"
            QuestLv = 2
            NameMon = "Snow Demon"
            CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
            CFrameMon = CFrame.new(-916.222656, 17.1481285, -14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)

        elseif Lv == 2450 or Lv <= 2474 or Env.SelectMonster == "Isle Outlaw [Lv. 2450]" then
            Ms = "Isle Outlaw"
            NameQuest = "TikiQuest1"
            QuestLv = 1
            NameMon = "Isle Outlaw"
            CFrameQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
            CFrameMon = CFrame.new(-16122.4062, 10.6328173, -257.351685, -0.630029082, 0, 0.776571631, 0, 1, 0, -0.776571631, 0, -0.630029082)
        elseif Lv == 2475 or Lv <= 2499 or Env.SelectMonster == "Island Boy [Lv. 2475]" then
            Ms = "Island Boy"
            NameQuest = "TikiQuest1"
            QuestLv = 2
            NameMon = "Island Boy"
            CFrameQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
            CFrameMon = CFrame.new(-16736.2266, 20.533947, -131.718811, 0.546393692, 0, 0.837528467, 0, 1, 0, -0.837528467, 0, 0.546393692)
        elseif Lv == 2500 or Lv <= 2524 or Env.SelectMonster == "Sun-kissed Warrior [Lv. 2500]" then
            Ms = "Sun-kissed Warrior"
            NameQuest = "TikiQuest2"
            QuestLv = 1
            NameMon = "Sun-"
            CFrameQ = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
            CFrameMon = CFrame.new(-16413.5078, 54.6350479, 1054.43555, -0.999391913, 0, -0.034868788, 0, 1, 0, 0.034868788, 0, -0.999391913)
        elseif Lv == 2525 or Lv <= 2549 or Env.SelectMonster == "Isle Champion [Lv. 2525]" then
            Ms = "Isle Champion"
            NameQuest = "TikiQuest2"
            QuestLv = 2
            NameMon = "Isle Champion"
            CFrameQ = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
            CFrameMon = CFrame.new(-16787.3203, 20.6350517, 992.131836, -0.775471091, 0, 0.631383121, 0, 1, 0, -0.631383121, 0, -0.775471091)
        elseif Lv == 2550 or Lv <= 2574 or Env.SelectMonster == "Serpent Hunter [Lv. 2550]" then
            Ms = "Serpent Hunter"
            NameQuest = "TikiQuest3"
            QuestLv = 1
            NameMon = "Serpent Hunter"
            CFrameQ = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-16654.7754, 105.286232, 1579.67444, 0.999096751, 4.45934489e-08, 0.0424928814, -4.38822667e-08, 1, -1.76692847e-08, -0.0424928814, 1.57886415e-08, 0.999096751)
        elseif Lv == 2575 or Lv <= 2599 or Env.SelectMonster == "Skull Slayer [Lv. 2575]" then
            Ms = "Skull Slayer"
            NameQuest = "TikiQuest3"
            QuestLv = 2
            NameMon = "Skull Slayer"
            CFrameQ = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-16654.7754, 105.286232, 1579.67444, 0.999096751, 4.45934489e-08, 0.0424928814, -4.38822667e-08, 1, -1.76692847e-08, -0.0424928814, 1.57886415e-08, 0.999096751)
            elseif Lv == 2600 or Lv <= 2624 or Env.SelectMonster == "Reef Bandit [Lv. 2600]" then
            Ms = "Reef Bandit"
            NameQuest = "SubmergedQuest1"
            QuestLv = 1
            NameMon = "Reef Bandit"
            CFrameQ = CFrame.new(10778.8496, -2087.71338, 9260.76758, 0.254936904, -4.35733618e-08, -0.966957688, -2.55894843e-08, 1, -5.18089536e-08, 0.966957688, 3.79519633e-08, 0.254936904)
            CFrameMon = CFrame.new(11052.75, -2084.71289, 9152.53711, -0.773495615, -7.13662907e-10, 0.633801639, -8.58463578e-10, 1, 7.83291002e-11, -0.633801639, -4.835084e-10, -0.773495615)
        elseif Lv == 2625 or Lv <= 2649 or Env.SelectMonster == "Coral Pirates [Lv. 2625]" then
            Ms = "Coral Pirate"
            NameQuest = "SubmergedQuest1"
            QuestLv = 2
            NameMon = "Coral Pirates"
            CFrameQ = CFrame.new(10778.8496, -2087.71338, 9260.76758, 0.254936904, -4.35733618e-08, -0.966957688, -2.55894843e-08, 1, -5.18089536e-08, 0.966957688, 3.79519633e-08, 0.254936904)
            CFrameMon = CFrame.new(10670.4717, -2053.29297, 9281.41895, 0.708642364, -4.16000745e-08, 0.705567837, 9.98025218e-09, 1, 4.89359664e-08, -0.705567837, -2.76363554e-08, 0.708642364)
        elseif Lv == 2650 or Lv <= 2674 or Env.SelectMonster == "Sea Chanter [Lv. 2650]" then
            Ms = "Sea Chanter"
            NameQuest = "SubmergedQuest2"
            QuestLv = 1
            NameMon = "Sea Chanter"
            CFrameQ = CFrame.new(10883.1201, -2086.1897, 10035.7256, 0.582791984, 2.62260293e-08, -0.812621355, 9.86950188e-10, 1, 3.2981184e-08, 0.812621355, -2.00231867e-08, 0.582791984)
            CFrameMon = CFrame.new(10638.0596, -2046.32092, 10057.8281, -0.148388281, -4.43093171e-08, -0.988929152, -2.01947294e-08, 1, -4.17751416e-08, 0.988929152, 1.37722154e-08, -0.148388281)
        elseif Lv >= 2675 or Env.SelectMonster == "Ocean Prophet [Lv. 2675]" then
            Ms = "Ocean Prophet"
            NameQuest = "SubmergedQuest2"
            QuestLv = 2
            NameMon = "Ocean Prophet"
            CFrameQ = CFrame.new(10883.1201, -2086.1897, 10035.7256, 0.582791984, 2.62260293e-08, -0.812621355, 9.86950188e-10, 1, 3.2981184e-08, 0.812621355, -2.00231867e-08, 0.582791984)
            CFrameMon = CFrame.new(11046.1992, -1979.58191, 10196.0244, 0.815879762, 1.47977355e-08, 0.57822156, -3.88164985e-08, 1, 2.91788833e-08, -0.57822156, -4.62509959e-08, 0.815879762)
        end
    end
end

if First_Sea then
    tableMon = {"Empty","Bandit [Lv. 5]","Monkey [Lv. 14]","Gorilla [Lv. 20]","Pirate [Lv. 35]","Brute [Lv. 45]","Desert Bandit [Lv. 60]","Desert Officer [Lv. 70]","Snow Bandit [Lv. 90]","Snowman [Lv. 100]","Chief Petty Officer [Lv. 120]","Sky Bandit [Lv. 150]","Dark Master [Lv. 175]","Prisoner [Lv. 190]", "Dangerous Prisoner [Lv. 210]","Toga Warrior [Lv. 250]","Gladiator [Lv. 275]","Military Soldier [Lv. 300]","Military Spy [Lv. 325]","Fishman Warrior [Lv. 375]","Fishman Commando [Lv. 400]","God's Guard [Lv. 450]","Shanda [Lv. 475]","Royal Squad [Lv. 525]","Royal Soldier [Lv. 550]","Galley Pirate [Lv. 625]","Galley Captain [Lv. 650]"}
elseif Second_Sea then
    tableMon = {"Empty","Raider [Lv. 700]","Mercenary [Lv. 725]","Swan Pirate [Lv. 775]","Factory Staff [Lv. 800]","Marine Lieutenant [Lv. 875]","Marine Captain [Lv. 900]","Zombie [Lv. 950]","Vampire [Lv. 975]","Snow Trooper [Lv. 1000]","Winter Warrior [Lv. 1050]","Lab Subordinate [Lv. 1100]","Horned Warrior [Lv. 1125]","Magma Ninja [Lv. 1175]","Lava Pirate [Lv. 1200]","Ship Deckhand [Lv. 1250]","Ship Engineer [Lv. 1275]","Ship Steward [Lv. 1300]","Ship Officer [Lv. 1325]","Arctic Warrior [Lv. 1350]","Snow Lurker [Lv. 1375]","Sea Soldier [Lv. 1425]","Water Fighter [Lv. 1450]"}
elseif Third_Sea then
    tableMon = {"Empty","Pirate Millionaire [Lv. 1500]","Dragon Crew Warrior [Lv. 1575]","Dragon Crew Archer [Lv. 1600]","Hydra Enforcer [Lv. 1625]","Venomous Assailant [Lv. 1650]","Marine Commodore [Lv. 1700]","Marine Rear Admiral [Lv. 1725]","Fishman Raider [Lv. 1775]","Fishman Captain [Lv. 1800]","Forest Pirate [Lv. 1825]","Mythological Pirate [Lv. 1850]","Jungle Pirate [Lv. 1900]","Musketeer Pirate [Lv. 1925]","Reborn Skeleton [Lv. 1975]","Living Zombie [Lv. 2000]","Demonic Soul [Lv. 2025]","Posessed Mummy [Lv. 2050]", "Peanut Scout [Lv. 2075]", "Peanut President [Lv. 2100]", "Ice Cream Chef [Lv. 2125]", "Ice Cream Commander [Lv. 2150]", "Cookie Crafter [Lv. 2200]", "Cake Guard [Lv. 2225]", "Baking Staff [Lv. 2250]", "Head Baker [Lv. 2275]", "Cocoa Warrior [Lv. 2300]", "Chocolate Bar Battler [Lv. 2325]", "Sweet Thief [Lv. 2350]", "Candy Rebel [Lv. 2375]", "Candy Pirate [Lv. 2400]", "Snow Demon [Lv. 2425]",
        "Isle Outlaw [Lv. 2450]", "Island Boy [2475]", "Sun-kissed Warrior [Lv. 2500]", "Isle Champion [Lv. 2525]", "Serpent Hunter [Lv. 2550]", "Skull Slayer [Lv. 2575]"
    }
end

function CheckBossQuest()
    if First_Sea then
        if SelectBoss == "The Gorilla King" then
            BossMon = "The Gorilla King [Lv. 25] [Boss]"
            NameBoss = 'The Gorrila King'
            NameQuestBoss = "JungleQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$2,000\n7,000 Exp."
            CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
        elseif SelectBoss == "Bobby" then
            BossMon = "Bobby [Lv. 55] [Boss]"
            NameBoss = 'Bobby'
            NameQuestBoss = "BuggyQuest1"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$8,000\n35,000 Exp."
            CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
        elseif SelectBoss == "The Saw" then
            BossMon = "The Saw [Lv. 100] [Boss]"
            NameBoss = 'The Saw'
            CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
        elseif SelectBoss == "Yeti" then
            BossMon = "Yeti [Lv. 110] [Boss]"
            NameBoss = 'Yeti'
            NameQuestBoss = "SnowQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$10,000\n180,000 Exp."
            CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        elseif SelectBoss == "Mob Leader" then
            BossMon = "Mob Leader [Lv. 120] [Boss]"
            NameBoss = 'Mob Leader'
            CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
        elseif SelectBoss == "Vice Admiral" then
            BossMon = "Vice Admiral [Lv. 130] [Boss]"
            NameBoss = 'Vice Admiral'
            NameQuestBoss = "MarineQuest2"
            QuestLvBoss = 2
            RewardBoss = "Reward:\n$10,000\n180,000 Exp."
            CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
            CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
        elseif SelectBoss == "Saber Expert" then
            NameBoss = 'Saber Expert'
            BossMon = "Saber Expert [Lv. 200] [Boss]"
            CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
        elseif SelectBoss == "Warden" then
            BossMon = "Warden [Lv. 220] [Boss]"
            NameBoss = 'Warden'
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 1
            RewardBoss = "Reward:\n$6,000\n850,000 Exp."
            CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
            CFrameQBoss= CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif SelectBoss == "Chief Warden" then
            BossMon = "Chief Warden [Lv. 230] [Boss]"
            NameBoss = 'Chief Warden'
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 2
            RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
            CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif SelectBoss == "Swan" then
            BossMon = "Swan [Lv. 240] [Boss]"
            NameBoss = 'Swan'
            NameQuestBoss = "ImpelQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
            CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
        elseif SelectBoss == "Magma Admiral" then
            BossMon = "Magma Admiral [Lv. 350] [Boss]"
            NameBoss = 'Magma Admiral'
            NameQuestBoss = "MagmaQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
            CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
            CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
        elseif SelectBoss == "Fishman Lord" then
            BossMon = "Fishman Lord [Lv. 425] [Boss]"
            NameBoss = 'Fishman Lord'
            NameQuestBoss = "FishmanQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
            CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
        elseif SelectBoss == "Wysper" then
            BossMon = "Wysper [Lv. 500] [Boss]"
            NameBoss = 'Wysper'
            NameQuestBoss = "SkyExp1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
            CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
            CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
        elseif SelectBoss == "Thunder God" then
            BossMon = "Thunder God [Lv. 575] [Boss]"
            NameBoss = 'Thunder God'
            NameQuestBoss = "SkyExp2Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
            CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
        elseif SelectBoss == "Cyborg" then
            BossMon = "Cyborg [Lv. 675] [Boss]"
            NameBoss = 'Cyborg'
            NameQuestBoss = "FountainQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
            CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
        elseif SelectBoss == "Ice Admiral" then
            BossMon = "Ice Admiral [Lv. 700] [Boss]"
            NameBoss = 'Ice Admiral'
            CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
        elseif SelectBoss == "Greybeard" then
            BossMon = "Greybeard [Lv. 750] [Raid Boss]"
            NameBoss = 'Greybeard'
            CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
        end
    end
    if Second_Sea then
        if SelectBoss == "Diamond" then
            BossMon = "Diamond [Lv. 750] [Boss]"
            NameBoss = 'Diamond'
            NameQuestBoss = "Area1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
            CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
            CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
        elseif SelectBoss == "Jeremy" then
            BossMon = "Jeremy [Lv. 850] [Boss]"
            NameBoss = 'Jeremy'
            NameQuestBoss = "Area2Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
            CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
            CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
        elseif SelectBoss == "Fajita" then
            BossMon = "Fajita [Lv. 925] [Boss]"
            NameBoss = 'Fajita'
            NameQuestBoss = "MarineQuest3"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
            CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
            CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
        elseif SelectBoss == "Don Swan" then
            BossMon = "Don Swan [Lv. 1000] [Boss]"
            NameBoss = 'Don Swan'
            CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
        elseif SelectBoss == "Smoke Admiral" then
            BossMon = "Smoke Admiral [Lv. 1150] [Boss]"
            NameBoss = 'Smoke Admiral'
            NameQuestBoss = "IceSideQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
            CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
        elseif SelectBoss == "Awakened Ice Admiral" then
            BossMon = "Awakened Ice Admiral [Lv. 1400] [Boss]"
            NameBoss = 'Awakened Ice Admiral'
            NameQuestBoss = "FrostQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
            CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
            CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
        elseif SelectBoss == "Tide Keeper" then
            BossMon = "Tide Keeper [Lv. 1475] [Boss]"
            NameBoss = 'Tide Keeper'
            NameQuestBoss = "ForgottenQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
            CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
            CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
        elseif SelectBoss == "Darkbeard" then
            BossMon = "Darkbeard [Lv. 1000] [Raid Boss]"
            NameBoss = 'Darkbeard'
            CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
        elseif SelectBoss == "Cursed Captain" then
            BossMon = "Cursed Captain [Lv. 1325] [Raid Boss]"
            NameBoss = 'Cursed Captain'
            CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
        elseif SelectBoss == "Order" then
            BossMon = "Order [Lv. 1250] [Raid Boss]"
            NameBoss = 'Order'
            CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
        end
    end
    if Third_Sea then
        if SelectBoss == "Stone" then
            BossMon = "Stone [Lv. 1550] [Boss]"
            NameBoss = 'Stone'
            NameQuestBoss = "PiratePortQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
            CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
            CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
        elseif SelectBoss == "Hydra Leader" then
            BossMon = "Hydra Leader [Lv. 1675] [Boss]"
            NameBoss = 'Hydra Leader'
            NameQuestBoss = "VenomCrewQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$30,000\n70,000,000 Exp."
            CFrameQBoss = CFrame.new(5214.33936, 1003.46765, 759.507324, 0.998874724, 0, 0.0474264994, 0, 1, 0, -0.0474264994, 0, 0.9988747)
            CFrameBoss = CFrame.new(5887.97168, 1018.40173, -117.293022, -0.544665515, 0, 0.838653386, 0, 1, 0, -0.838653386, 0, -0.544665515)
        elseif SelectBoss == "Kilo Admiral" then
            BossMon = "Kilo Admiral [Lv. 1750] [Boss]"
            NameBoss = 'Kilo Admiral'
            NameQuestBoss = "MarineTreeIsland"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
            CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
            CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
        elseif SelectBoss == "Captain Elephant" then
            BossMon = "Captain Elephant [Lv. 1875] [Boss]"
            NameBoss = 'Captain Elephant'
            NameQuestBoss = "DeepForestIsland"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
            CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
            CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
        elseif SelectBoss == "Beautiful Pirate" then
            BossMon = "Beautiful Pirate [Lv. 1950] [Boss]"
            NameBoss = 'Beautiful Pirate'
            NameQuestBoss = "DeepForestIsland2"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
            CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
        elseif SelectBoss == "Cake Queen" then
            BossMon = "Cake Queen [Lv. 2175] [Boss]"
            NameBoss = 'Cake Queen'
            NameQuestBoss = "IceCreamIslandQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
            CFrameQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
        elseif SelectBoss == "Longma" then
            BossMon = "Longma [Lv. 2000] [Boss]"
            NameBoss = 'Longma'
            CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
        elseif SelectBoss == "Soul Reaper" then
            BossMon = "Soul Reaper [Lv. 2100] [Raid Boss]"
            NameBoss = 'Soul Reaper'
            CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
        elseif SelectBoss == "rip_indra True Form" then
            BossMon = "rip_indra True Form [Lv. 5000] [Raid Boss]"
            NameBoss = 'rip_indra True Form'
            CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
        end
    end
end

--// Check Material
function MaterialMon()
    if SelectMaterial == "Radioactive Material" then
        MMon = "Factory Staff"
        MPos = CFrame.new(295,73,-56)
        SP = "Default"
    elseif SelectMaterial == "Mystic Droplet" then
        MMon = "Water Fighter"
        MPos = CFrame.new(-3385,239,-10542)
        SP = "Default"
    elseif SelectMaterial == "Magma Ore" then
        if First_Sea then
            MMon = "Military Spy"
            MPos = CFrame.new(-5815,84,8820)
            SP = "Default"
        elseif Second_Sea then
            MMon = "Magma Ninja"
            MPos = CFrame.new(-5428,78,-5959)
            SP = "Default"
        end
    elseif SelectMaterial == "Angel Wings" then
        MMon = "God's Guard"
        MPos = CFrame.new(-4698,845,-1912)
        SP = "Default"
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7859.09814, 5544.19043, -381.476196))
        end
    elseif SelectMaterial == "Leather" then
        if First_Sea then
            MMon = "Brute"
            MPos = CFrame.new(-1145,15,4350)
            SP = "Default"
        elseif Second_Sea then
            MMon = "Marine Captain"
            MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
            SP = "Default"
        elseif Third_Sea then
            MMon = "Jungle Pirate"
            MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
            SP = "Default"
        end
    elseif SelectMaterial == "Scrap Metal" then
        if First_Sea then
            MMon = "Brute"
            MPos = CFrame.new(-1145,15,4350)
            SP = "Default"
        elseif Second_Sea then
            MMon = "Swan Pirate"
            MPos = CFrame.new(878,122,1235)
            SP = "Default"
        elseif Third_Sea then
            MMon = "Jungle Pirate"
            MPos = CFrame.new(-12107,332,-10549)
            SP = "Default"
        end
    elseif SelectMaterial == "Fish Tail" then
        if Third_Sea then
            MMon = "Fishman Raider"
            MPos = CFrame.new(-10993,332,-8940)
            SP = "Default"
        elseif First_Sea then
            MMon = "Fishman Warrior"
            MPos = CFrame.new(61123,19,1569)
            SP = "Default"
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
            end
        end
    elseif SelectMaterial == "Demonic Wisp" then
        MMon = "Demonic Soul"
        MPos = CFrame.new(-9507,172,6158)
        SP = "Default"
    elseif SelectMaterial == "Vampire Fang" then
        MMon = "Vampire"
        MPos = CFrame.new(-6033,7,-1317)
        SP = "Default"
    elseif SelectMaterial == "Conjured Cocoa" then
        MMon = "Chocolate Bar Battler"
        MPos = CFrame.new(620.6344604492188,78.93644714355469, -12581.369140625)
        SP = "Default"
    elseif SelectMaterial == "Dragon Scale" then
        MMon = "Dragon Crew Archer"
        MPos = CFrame.new(6594,383,139)
        SP = "Default"
    elseif SelectMaterial == "Gunpowder" then
        MMon = "Pistol Billionaire"
        MPos = CFrame.new(-469,74,5904)
        SP = "Default"
    elseif SelectMaterial == "Mini Tusk" then
        MMon = "Mythological Pirate"
        MPos = CFrame.new(-13545,470,-6917)
        SP = "Default"
    end
end

function EquipTool(Tool)
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack[Tool])
    end)
end

--// TWEEN PLAYER
function Tween(K1)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")    
    if humanoid.Sit then 
        humanoid.Sit = false
    end
    local root = char:WaitForChild("HumanoidRootPart")
    root.CanCollide = false
    local dist = (K1.Position - root.Position).Magnitude
    local spd = 330
    local TweenSvc = game:GetService("TweenService")
    local TweenInf = TweenInfo.new(dist / spd, Enum.EasingStyle.Linear)
    local tween = TweenSvc:Create(root, TweenInf, {CFrame = K1})
    tween:Play()
    tween.Completed:Connect(function()
        root.CanCollide = true 
    end)
    while tween.PlaybackState == Enum.PlaybackState.Playing do
        wait(0.03) 
        if _G.StopTween then
            tween:Cancel()
            root.CanCollide = true 
            break
        end
    end
end

--// TP ISLAND
function TP2(P1)
    local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance > 1 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Play()
    if _G.StopTween2 then
        game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Cancel()
    end
    _G.Clip2 = true
    wait(Distance/Speed)
    _G.Clip2 = false
end

--// CANCEL TWEEN
function CancelTween(target)
    if not target then
        _G.StopTween = true
        wait(.1)
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait(.1)
        _G.StopTween = false
    end
end

--// Bypass Teleport
function BTP(Tarpos)
    if (Tarpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
        game.Players.LocalPlayer.Character.Head:Destroy()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Tarpos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
        wait(1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Tarpos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
        wait(7)
    elseif (Tarpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
        Tween(Tarpos)
    end
end

--// AUTO CLICK
function AutoClick2()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
end
task.spawn(function()
    while wait() do
        local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
        CameraShakerR:Stop()
    end
end)

local function ApplyBodyVelocity()
    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
        local Noclip = Instance.new("BodyVelocity")
        Noclip.Name = "BodyClip"
        Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
        Noclip.Velocity = Vector3.new(0, 0, 0)
    end
end

local function RemoveBodyVelocity()
    if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
        game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
    end
end

spawn(function()
    while task.wait() do
        pcall(function()
            if _G.BlazeEE or EventLocation or DragonTalonUpgrade or TreeDestroyFarm or TeleportPrehistoric or PurpleBeltF or WhiteBeltF or BlazeEmberFarm or AttackFish or AttackTerrorshark or AttackGhostship or AutoSeabeastFarm or AutoSeaFarm or DojoClaimQuest or DojoRequestQuest or DojoQuestEnable or AutoSTartRaids or TeleporttoFruitDealer or _G.TeleportFruit or TeleporttoKitsune or CollectAzureAmber or AutoTrain or AutoKillHuman or AutoPirateCastle or TweenToPlayer or AutoSail or AutoFarmTerrorShark or AutoFarmFish or AutoFarmSeaBeast or AutoFarmGhostBoats or LevelFarmNoQuest or LevelFarmQuest or Farm_Bone or Farm_Ectoplasm or Nearest_Farm or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or Auto_Farm_Material or AutoFarmBossNoQuest or AutoFarmBossQuest or GunMastery_Farm or DevilMastery_Farm or AutoKenV2 or AutoFarmKen or AutoNextIsland or BossRaid or _G.Teleport_to_Player or _G.Clip or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or TeleporttoMirage or TeleporttoGear or _G.Auto_Teleport_Fruit or AutoSecondWorld or AutoThirdWorld or AutoDeathStep or AutoSuperhuman or AutoSharkman or AutoElectricClaw or AutoDragonTalon or AutoGodhuman or AutoSaber or AutoRengoku or AutoBuddySword or AutoPole or AutoYama or AutoCavander or AutoTushita or Auto_Cursed_Dual_Katana or Auto_Quest_Yama_1 or Auto_Quest_Yama_2 or Auto_Quest_Yama_3 or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoEliteHunter or AutoCakePrince or _G.AutoDoughKing or AutoDarkDagger or AutoHallowSycthe or AutoCitizen or AutoEvoRace or AutoBartilo or AutoFactory or _G.SwanGlasses or RipIndra or AutoRainbowHaki or AutoTorch or AutoSoulGuitar or AutoTryLuck or AutoPray or AutoAdvanceDungeon or AutoMusketeer or Auto_Serpent_Bow then
                ApplyBodyVelocity()
            else
                RemoveBodyVelocity()
            end
        end)
    end
end)

--// Farming Clip Tween
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.BlazeEE or EventLocation or DragonTalonUpgrade or TreeDestroyFarm or TeleportPrehistoric or PurpleBeltF or WhiteBeltF or BlazeEmberFarm or AttackFish or AttackTerrorshark or AttackGhostship or AutoSeabeastFarm or AutoSeaFarm or DojoClaimQuest or DojoRequestQuest or DojoQuestEnable or AutoSTartRaids or TeleporttoFruitDealer or _G.TeleportFruit or TeleporttoKitsune or CollectAzureAmber or AutoTrain or AutoKillHuman or AutoPirateCastle or TweenToPlayer or AutoSail or AutoFarmTerrorShark or AutoFarmFish or AutoFarmSeaBeast or AutoFarmGhostBoats or LevelFarmNoQuest or LevelFarmQuest or Farm_Bone or Farm_Ectoplasm or Nearest_Farm or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or Auto_Farm_Material or AutoFarmBossNoQuest or AutoFarmBossQuest or GunMastery_Farm or DevilMastery_Farm or AutoKenV2 or AutoFarmKen or AutoNextIsland or BossRaid or _G.Teleport_to_Player or _G.Clip or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or TeleporttoMirage or TeleporttoGear or _G.Auto_Teleport_Fruit or AutoSecondWorld or AutoThirdWorld or AutoDeathStep or AutoSuperhuman or AutoSharkman or AutoElectricClaw or AutoDragonTalon or AutoGodhuman or AutoSaber or AutoRengoku or AutoBuddySword or AutoPole or AutoYama or AutoCavander or AutoTushita or Auto_Cursed_Dual_Katana or Auto_Quest_Yama_1 or Auto_Quest_Yama_2 or Auto_Quest_Yama_3 or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoEliteHunter or AutoCakePrince or _G.AutoDoughKing or AutoDarkDagger or AutoHallowSycthe or AutoCitizen or AutoEvoRace or AutoBartilo or AutoFactory or _G.SwanGlasses or RipIndra or AutoRainbowHaki or AutoTorch or AutoSoulGuitar or AutoTryLuck or AutoPray or AutoAdvanceDungeon or AutoMusketeer or Auto_Serpent_Bow then
                for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)



local Notification = require(game:GetService("ReplicatedStorage").Notification)
Notification.new("<Color=Green>Thank For Using Flower Hub<Color=/>"):Display()

-----------------------------Fluent UI -------------------------------------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

do  local ui =  game:GetService("CoreGui"):FindFirstChild("UILibrary")  if ui then ui:Destroy() end end
do  local ui =  game:GetService("Lighting"):FindFirstChild("Blur")  if ui then ui:Destroy() end end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local tween = game:service"TweenService"
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function tablefound(ta, object)
  for i,v in pairs(ta) do
    if v == object then
      return true
    end
  end
  return false
end

local ActualTypes = {RoundFrame = "ImageLabel", Shadow = "ImageLabel", Circle = "ImageLabel", CircleButton = "ImageButton", Frame = "Frame", Label = "TextLabel", Button = "TextButton", SmoothButton = "ImageButton", Box = "TextBox", ScrollingFrame = "ScrollingFrame", Menu = "ImageButton", NavBar = "ImageButton"}

local Properties = {
  RoundFrame = {
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=5554237731",
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(3,3,297,297)
  },
  SmoothButton = {
    AutoButtonColor = false,
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=5554237731",
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(3,3,297,297)
  },
  Shadow = {
    Name = "Shadow",
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=5554236805",
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(23,23,277,277),
    Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
    Position = UDim2.fromOffset(-15,-15)
  },
  Circle = {
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=5554831670"
  },
  CircleButton = {
    BackgroundTransparency = 1,
    AutoButtonColor = false,
    Image = "http://www.roblox.com/asset/?id=5554831670"
  },
  Frame = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1,1)
  },
  Label = {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(5,0),
    Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
  },
  Button = {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(5,0),
    Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
  },
  Box = {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(5,0),
    Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
  },
  ScrollingFrame = {
    BackgroundTransparency = 1,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.fromScale(0,0),
    Size = UDim2.fromScale(1,1)
  },
  Menu = {
    Name = "More",
    AutoButtonColor = false,
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=5555108481",
    Size = UDim2.fromOffset(20,20),
    Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
  },
  NavBar = {
    Name = "SheetToggle",
    Image = "http://www.roblox.com/asset/?id=5576439039",
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(20,20),
    Position = UDim2.fromOffset(5,5),
    AutoButtonColor = false
  }
}
local Types = {"RoundFrame", "Shadow", "Circle", "CircleButton", "Frame", "Label", "Button", "SmoothButton", "Box", "ScrollingFrame", "Menu", "NavBar"}
function FindType(String)
  for _, Type in next, Types do
    if Type:sub(1, #String):lower() == String:lower() then
      return Type
    end
  end
  return false
end

local Objects = {}

function Objects.new(Type)
  local TargetType = FindType(Type)
  if TargetType then
    local NewImage = Instance.new(ActualTypes[TargetType])
    if Properties[TargetType] then
      for Property, Value in next, Properties[TargetType] do
        NewImage[Property] = Value
      end
    end
    return NewImage
  else
    return Instance.new(Type)
  end
end

local function GetXY(GuiObject)
  local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
  local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
  return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
  local PX, PY = GetXY(GuiObject)
  local Circle = Objects.new("Shadow")
  Circle.Size = UDim2.fromScale(0,0)
  Circle.Position = UDim2.fromScale(PX,PY)
  Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
  Circle.ZIndex = 200
  Circle.Parent = GuiObject
  local Size = GuiObject.AbsoluteSize.X
  TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
  spawn(function()
    wait(0.5)
    Circle:Destroy()
  end)
end

local UILibrary = Instance.new("ScreenGui")
local Load = Instance.new("Frame")
local UICornerLoad = Instance.new("UICorner")
local LoadButton = Instance.new("ImageButton")

UILibrary.Name = "Flower Hub"
UILibrary.Parent = game:GetService("CoreGui")
UILibrary.IgnoreGuiInset = true
UILibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Load.Name = "Load"
Load.Parent = UILibrary
Load.Active = true
Load.AnchorPoint = Vector2.new(0.5, 0.5)
Load.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Load.BackgroundTransparency = 1
Load.BorderSizePixel = 0
Load.Position = UDim2.new(0.5, 0, 1, 0)
Load.Size = UDim2.new(0, 100, 0, 100)
Load.BackgroundTransparency = 1

local uitoggled = false
UserInputService.InputBegan:Connect(
function(io, p)
  if io.KeyCode == Enum.KeyCode.RightShift then
    if uitoggled == false then
      uitoggled = true
      UILibrary.Enabled = false
    else
      UILibrary.Enabled = true
      uitoggled = false
    end
  end
end)

UICornerLoad.CornerRadius = UDim.new(0, 30)
UICornerLoad.Name = "UICornerLoad"
UICornerLoad.Parent = Load

LoadButton.Name = "LoadButton"
LoadButton.Parent = Load
LoadButton.AnchorPoint = Vector2.new(0.5, 0.5)
LoadButton.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.BackgroundTransparency = 1.000
LoadButton.Size = UDim2.new(0, 70, 0, 70)
LoadButton.Image = "http://www.roblox.com/asset/?id=91722326134472"
LoadButton.ImageTransparency = 1

local ClickFrame = Instance.new("Frame")
ClickFrame.Name = "ClickFrame"
ClickFrame.Parent = Load
ClickFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickFrame.BackgroundTransparency = 1.000
ClickFrame.Position = UDim2.new(0, 0, 7.62939436e-08, 0)
ClickFrame.Size = UDim2.new(0, 0, 0, 0)

local SoundClick = Instance.new("Sound")
SoundClick.Name = "Sound Effect"
SoundClick.Parent = Load
SoundClick.SoundId = "rbxassetid://130785805"
SoundClick.Volume = 1

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = game.Lighting

if game.Workspace.Camera.FieldOfView == 50 then
  return game.Workspace.Camera.FieldOfView == 70
end

local LoadText = Instance.new("Frame")
local UIListLayoutLoadText = Instance.new("UIListLayout")
local TitleLoad = Instance.new("TextLabel")

LoadText.Name = "LoadText"
LoadText.Parent = Load
LoadText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadText.BackgroundTransparency = 1.000
LoadText.Size = UDim2.new(0, 500, 0, 50)
LoadText.ClipsDescendants = true

UIListLayoutLoadText.Name = "UIListLayoutLoadText"
UIListLayoutLoadText.Parent = LoadText
UIListLayoutLoadText.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutLoadText.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayoutLoadText.SortOrder = Enum.SortOrder.LayoutOrder

TitleLoad.Name = "TitleLoad"
TitleLoad.Parent = LoadText
TitleLoad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLoad.BackgroundTransparency = 1.000
TitleLoad.Size = UDim2.new(0, 200, 0, 50)
TitleLoad.Font = Enum.Font.Gotham
TitleLoad.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLoad.TextSize = 14.000
TitleLoad.TextTransparency = 1

local Scrollbar = Instance.new("Frame")
local LoadScrollbar = Instance.new("ImageButton")
local Icon = Instance.new("Frame")
local LoadIcon = Instance.new("ImageButton")

Scrollbar.Name = "Scrollbar"
Scrollbar.Parent = Load
Scrollbar.Active = true
Scrollbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scrollbar.BackgroundTransparency = 1.000
Scrollbar.ClipsDescendants = true
Scrollbar.Position = UDim2.new(0.899999976, 0, -0.0199999232, 0)
Scrollbar.Size = UDim2.new(0, 50, 0, 50)

LoadScrollbar.Name = "LoadScrollbar"
LoadScrollbar.Parent = Scrollbar
LoadScrollbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadScrollbar.AnchorPoint = Vector2.new(0.5,0.5)
LoadScrollbar.BackgroundTransparency = 1.000
LoadScrollbar.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadScrollbar.Size = UDim2.new(0, 30, 0, 30)
LoadScrollbar.Image = "http://www.roblox.com/asset/?id=6031097225"
LoadScrollbar.ImageTransparency = 1
LoadScrollbar.Visible = false

Icon.Name = "Icon"
Icon.Parent = Load
Icon.Active = true
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1
Icon.ClipsDescendants = true
Icon.Position = UDim2.new(0, 0, -0.02, 0)
Icon.Size = UDim2.new(0, 50, 0, 50)

LoadIcon.Name = "LoadIcon"
LoadIcon.Parent = Icon
LoadIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadIcon.AnchorPoint = Vector2.new(0.5, 0.5)
LoadIcon.BackgroundTransparency = 1
LoadIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadIcon.Size = UDim2.new(0, 40, 0, 40)
LoadIcon.Image = "http://www.roblox.com/asset/?id=91722326134472"
LoadIcon.ImageTransparency = 1
LoadIcon.Visible = false

local osday = Instance.new("TextLabel")
osday.Name = "osday"
osday.Parent = ClickFrame
osday.Active = true
osday.AnchorPoint = Vector2.new(0.5, 0.5)
osday.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
osday.BackgroundTransparency = 1.000
osday.Position = UDim2.new(0.5, 0, 0.699999988, 0)
osday.Size = UDim2.new(0, 384, 0, 30)
osday.Font = Enum.Font.GothamBold
osday.TextTransparency = 1
osday.TextColor3 = Color3.fromRGB(255, 255, 255)
osday.TextSize = 14.000

task.spawn(function()
  while task.wait() do
    pcall(function()
      osday.Text = os.date("%I:%M:%S".." | ".."%B %d, %Y")
    end)
  end
end)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = ClickFrame
Title.Active = true
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.5, 0, 0.280000001, 0)
Title.Size = UDim2.new(0, 384, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Flower Hub V3"
Title.TextTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 0, 255)
Title.TextSize = 14.000

function LoadFunction()
  TweenService:Create(game.Workspace.Camera, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {FieldOfView = 50}):Play()
  TweenService:Create(Blur, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = 20}):Play()
  TweenService:Create(Load, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
  TweenService:Create(Load, TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 0}):Play()
  wait(.5)
  TweenService:Create(LoadButton, TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 0}):Play()
  LoadButton.MouseEnter:Connect(function() 
    TweenService:Create(LoadButton, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 80, 0, 80)}):Play()
  end)
  LoadButton.MouseLeave:Connect(function()
    TweenService:Create(LoadButton, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 70, 0, 70)}):Play()
  end)
  local LoadFocus = false
  LoadButton.MouseButton1Down:Connect(function()
    if LoadFocus == false then
      LoadFocus = true
      TweenService:Create(LoadButton, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Rotation = 180}):Play()
      SoundClick:Play()
      wait(.05)
      TweenService:Create(LoadButton, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Rotation = 180}):Play()
      TweenService:Create(LoadButton, TweenInfo.new(.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
      wait(.5)
      LoadButton:Destroy()
      wait(.5)
      TweenService:Create(Load, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.075, 0)}):Play()
      TweenService:Create(Blur, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = 0}):Play()
      TweenService:Create(game.Workspace.Camera, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {FieldOfView = 70}):Play()
      wait(.5)
      TweenService:Create(Load, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 500, 0, 50)}):Play()
      repeat wait()
        TweenService:Create(TitleLoad, TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 0.2}):Play()
        TitleLoad.Text = "Loading Script.."
        wait(0.5)
        TweenService:Create(TitleLoad, TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
        wait(0.5)
        TweenService:Create(TitleLoad, TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 0.2}):Play()
        TitleLoad.Text = "Version 3.0.1"
        wait(0.5)
        TweenService:Create(TitleLoad, TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
        wait(0.5)
        TweenService:Create(TitleLoad, TweenInfo.new(.45, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 0.2}):Play()
        TitleLoad.Text = "Flower Hub Paid"
        TitleLoad.Font = Enum.Font.GothamBold
        TitleLoad.TextTransparency = 0
        wait(1.5)
        TweenService:Create(TitleLoad, TweenInfo.new(.45, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
      until Load.Size == UDim2.new(0, 500, 0, 50)
      TweenService:Create(ClickFrame, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 500, 0, 50)}):Play()
      TweenService:Create(Load, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.05}):Play()
      LoadScrollbar.Visible = true
      LoadIcon.Visible = true
      wait(.5)
      TweenService:Create(LoadScrollbar,TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{ImageTransparency = 0}):Play()
      TweenService:Create(LoadIcon,TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{ImageTransparency = 0}):Play()
      repeat wait() until LoadScrollbar.ImageTransparency == 0 and LoadIcon.ImageTransparency == 0
      wait(.5)
      TweenService:Create(osday,TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{TextTransparency = 0}):Play()
      wait(.5)
      TweenService:Create(Title,TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{TextTransparency = 0}):Play()
    end
  end)
end

LoadFunction()
LoadScrollbarFocus = false

LoadScrollbar.MouseLeave:Connect(function()
  if LoadScrollbarFocus == false then
    TweenService:Create(LoadScrollbar,TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
  end
end)

LoadScrollbar.MouseEnter:Connect(function()
  if LoadScrollbarFocus == false then
    TweenService:Create(LoadScrollbar,TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),{ImageColor3 = Color3.fromRGB(255, 0, 127)}):Play()
  end
end)

LoadScrollbar.MouseButton1Click:Connect(function()
  game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
  game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)

local Window = Fluent:CreateWindow({
    Title = "Mornal Hub V1",
    SubTitle = "by x.saliii",
    TabWidth = 100,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    setfarm = Window:AddTab({ Title = "Farm Settings", Icon = "user-cog" }),
    Main = Window:AddTab({ Title = "Main", Icon = "table-of-contents" }),
    Items = Window:AddTab({ Title = "Items", Icon = "users" }),
    Event = Window:AddTab({ Title = "Event", Icon = "party-popper" }),
    Raid = Window:AddTab({ Title = "Teleport & Raid", Icon = "gift" }),
    Shop = Window:AddTab({ Title = "Shopping", Icon = "shopping-cart" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
end

function BringMonster(TargetName, TargetCFrame)
    local sethiddenproperty = sethiddenproperty or (function(...) return ... end)
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == TargetName then
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < tonumber(bringfrec) then
                    v.HumanoidRootPart.CFrame = TargetCFrame
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    v.HumanoidRootPart.Transparency = 1
                    v.Humanoid:ChangeState(11)
                    v.Humanoid:ChangeState(14)
                    if v.Humanoid:FindFirstChild("Animator") then
                        v.Humanoid.Animator:Destroy()
                    end
                    --sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end
            end
        end
    end
    pcall(sethiddenproperty, game.Players.LocalPlayer, "SimulationRadius", math.huge)
end

bringfrec = 200
local WeaponList = {"Melee","Blox Fruit","Sword","Gun"}
SelectWeaponFarm = "Melee"

local Dropdown1 = Tabs.setfarm:AddDropdown("Select Weapon", {
    Title = "Select Weapon",
    Values = {"Melee","Sword","Fruit","Gun"},
    Multi = false,
    Default = 1,
})
Env.SelectMonster = nil

Tabs.setfarm:AddButton({
    Title = "Boost Fps",
    Description = "Very important button",
    Callback = function()
        game:GetService("ReplicatedStorage").Assets.Models:Destroy()
    game:GetService("ReplicatedStorage").Assets.GUI:Destroy()
    game:GetService("ReplicatedStorage").Assets.SlashHit:Destroy()
    for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Death:GetChildren()) do
        v:Destroy()
    end
    for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Respawn:GetChildren()) do
        v:Destroy()
    end
    local decalsyeeted = false
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
    end
})

spawn(function()
    while task.wait() do
        pcall(function()
            Farm_Mode = CFrame.new(0,30,0)
        end)
    end
end)

Dropdown1:SetValue("Melee")

Dropdown1:OnChanged(function(Value)
    SelectWeaponFarm = Value
end)

spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoSetSpawn then
                if game:GetService("Players").LocalPlayer.Character.Humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                end
            end
        end
    end)
end)

task.spawn(function()
    while wait() do
        pcall(function()
            if SelectWeaponFarm == "Melee" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            SelectWeapon = v.Name
                        end
                    end
                end
            elseif SelectWeaponFarm == "Sword" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Sword" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            SelectWeapon = v.Name
                        end
                    end
                end
            elseif SelectWeaponFarm == "Blox Fruit" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            SelectWeapon = v.Name
                        end
                    end
                end
            elseif SelectWeaponFarm == "Gun" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Gun" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            SelectWeapon = v.Name
                        end
                    end
                end
            end
        end)
    end
end)
wait()

local env = getgenv()

local b1mob = Tabs.setfarm:AddToggle("Bring Mob", {Title = "Bring Mob", Default = true })

b1mob:OnChanged(function(Value)
    BringMobs = Value
end)

local bttp = Tabs.setfarm:AddToggle("btp", {Title = "Bypass Teleport", Default = false })

bttp:OnChanged(function(Value)
    ByPassTP = Value
end)
local fastt = Tabs.setfarm:AddToggle("btp", {Title = "Fast Attack", Default = true })

fastt:OnChanged(function(Value)
    env.fastattack = Value
    env.freezeenemies = Value
end)

local setss = Tabs.setfarm:AddToggle("all in one", {Title = "Set Spawn & Haki & Rejoin", Default = true })

-- Define the optimized AttackNearest function

setss:OnChanged(function(Value)
    AutoSetSpawn = Value
    Haki = Value
    _G.Rejoin = Value
    spawn(function()
    while _G.Rejoin do wait()
        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end
        end)
    end
end)
end)

spawn(function()
    while task.wait() do
        if Haki then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

spawn(function()
    while task.wait() do
        if Haki then
            if not game.Players.LocalPlayer.Character:FindFirstChild("Highlight") then
                game:service('VirtualInputManager'):SendKeyEvent(true, "K", false, game)
                wait(.1)
                game:service('VirtualInputManager'):SendKeyEvent(false, "K", false, game)
            end
        end
    end
end)

spawn(function()
    while task.wait() do
        if AutoSetSpawn then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
        end
    end
end)

spawn(function()
    while task.wait() do
        if BringMobs and (LevelFarmQuest or LevelFarmNoQuest) then
            pcall(function()
                BringMonster(Level_Farm_Name, Level_Farm_CFrame)
            end)

        elseif BringMobs and Farm_Bone then
            pcall(function()
                BringMonster(Bone_Farm_Name, Bone_Farm_CFrame)
            end)

        elseif BringMobs and Farm_Ectoplasm then
            pcall(function()
                BringMonster(Ecto_Farm_Name, Ecto_Farm_CFrame)
            end)

        elseif BringMobs and Nearest_Farm then
            pcall(function()
                BringMonster(Nearest_Farm_Name, Nearest_Farm_CFrame)
            end)

        elseif BringMobs and (SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm) then
            pcall(function()
                BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
            end)

        elseif BringMobs and Auto_Farm_Material then
            pcall(function()
                BringMonster(Material_Farm_Name, Material_Farm_CFrame)
            end)

        elseif BringMobs and (GunMastery_Farm or DevilMastery_Farm) then
            pcall(function()
                BringMonster(Mastery_Farm_Name, Mastery_Farm_CFrame)
            end)

        elseif BringMobs and AutoRengoku then
            pcall(function()
                BringMonster(Rengoku_Farm_Name, Rengoku_Farm_CFrame)
            end)

        elseif BringMobs and AutoCakePrince then
            pcall(function()
                BringMonster(CakePrince_Farm_Name, CakePrince_Farm_CFrame)
            end)

        elseif BringMobs and _G.AutoDoughKing then
            pcall(function()
                BringMonster(DoughKing_Farm_Name, DoughKing_Farm_CFrame)
            end)

        elseif BringMobs and AutoCitizen then
            pcall(function()
                BringMonster(Citizen_Farm_Name, Citizen_Farm_CFrame)
            end)

        elseif BringMobs and AutoEvoRace then
            pcall(function()
                BringMonster(EvoV2_Farm_Name, EvoV2_Farm_CFrame)
            end)

        elseif BringMobs and AutoBartilo then
            pcall(function()
                BringMonster(Bartilo_Farm_Name, Bartilo_Farm_CFrame)
            end)

        elseif BringMobs and AutoSoulGuitar then
            pcall(function()
                BringMonster(SoulGuitar_Farm_Name, SoulGuitar_Farm_CFrame)
            end)

        elseif BringMobs and AutoMusketeer then
            pcall(function()
                BringMonster(Musketere_Farm_Name, Musketere_Farm_CFrame)
            end)
            
        elseif BringMobs and AutoTrain then
            pcall(function()
                BringMonster(Ancient_Farm_Name, Ancient_Farm_CFrame)
            end)

        elseif BringMobs and AutoPirateCastle then
            pcall(function()
                BringMonster(PirateCastle_Name, PirateCastle_CFrame)
            end)
        elseif BringMobs and BlazeEmberFarm then
            pcall(function()
                BringMonster(BlazeEmber_Farm_Name, BlazeEmber_Farm_CFrame)
            end)
        end
    end
end)

local whss = Tabs.setfarm:AddToggle("White Screen", {Title = "White Screen", Default = false })

whss:OnChanged(function(Value)
    _G.White_Screen = Value
    if _G.White_Screen then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
        game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
end)

Tabs.Main:AddParagraph({
    Title = "Farming Functions",
    Content = "Choose What You Gonna Use!"
})

wait()

local atfarm = Tabs.Main:AddToggle("Level Farming", {Title = "Auto Farm Level", Default = false })

    atfarm:OnChanged(function(Value)
        LevelFarmQuest = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if LevelFarmQuest then
                pcall(function()
                    CheckLevel() -- Ensure this function updates the required variables (NameQuest, QuestLv, NameMon, etc.)
    
                    local questTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    local questVisible = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
    
                    -- Check if the current quest is not targeting the correct monster
                    if not string.find(questTitle, NameMon) or not questVisible then
                        -- Abandon the current quest
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    
                        -- Teleport or tween to the quest start location
                        if ByPassTP then
                            BTP(CFrameQ)
                        else
                            Tween(CFrameQ)
                        end
    
                        -- Wait until the player is near the quest start location
                        if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            task.wait(1)
                            -- Start the correct quest
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        end
                    else
                        -- If the quest is targeting the correct monster, proceed to farm
                        local targetMonster = game:GetService("Workspace").Enemies:FindFirstChild(NameMon)
    
                        if targetMonster then
                            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if enemy.Name == NameMon and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        EquipTool(SelectWeapon)
                                        Tween(enemy.HumanoidRootPart.CFrame * Farm_Mode)
                                        enemy.HumanoidRootPart.CanCollide = false
                                        enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        enemy.HumanoidRootPart.Transparency = 1
                                        Level_Farm_Name = enemy.Name
                                        Level_Farm_CFrame = enemy.HumanoidRootPart.CFrame
                                        AutoClick()
                                    until not LevelFarmQuest or not enemy.Parent or enemy.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(enemy.Name) or not questVisible
                                end
                            end
                        else
                            -- If the target monster is not found, move to the monster's spawn location
                            Tween(CFrameMon)
                        end
                    end
                end)
            end
        end
    end)
    
wait()

local sec1 = Tabs.Main:AddToggle("Auto Second Sea", {Title = "Auto Second Sea", Default = false })

    sec1:OnChanged(function(Value)
        AutoSecondWorld = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoSecondWorld then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 700 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress").UsedKey == false then
                            if not game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or not game.Players.LocalPlayer.Character:FindFirstChild("Key") then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                            elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Key"])
                                if ByPassTP then
                                    BTP(CFrame.new(1349.697265625, 37.34928512573242, -1328.8309326171875))
                                    game:GetService("Workspace").Map.Ice.Door.Size = Vector3.new(30,30,30)
                                elseif not ByPassTP then
                                    Tween(CFrame.new(1349.697265625, 37.34928512573242, -1328.8309326171875))
                                    game:GetService("Workspace").Map.Ice.Door.Size = Vector3.new(30,30,30)
                                end
                                Tween(CFrame.new(1347.65271, 37.3906517, -1325.07715, 0.484830558, 2.71348792e-08, 0.874608099, -2.34559963e-08, 1, -1.80225808e-08, -0.874608099, -1.17769057e-08, 0.484830558))
                            end
                        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress").UsedKey == true then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress").KilledIceBoss == false then
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral" then
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        AutoClick()
                                    end
                                end
                                for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
                                    if v.Name == "Ice Admiral" then
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress").KilledIceBoss == true then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                            end
                        end
                    end
                end)
            end
        end
    end)

    wait()

    local th3 = Tabs.Main:AddToggle("Auto Third Sea", {Title = "Auto Third Sea [Level 1500]", Default = false })

    th3:OnChanged(function(Value)
        AutoThirdWorld = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoThirdWorld then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 1500 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                                if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == nil then
                                    if game.Workspace.Enemies:FindFirstChild("Don Swan") then
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if v.Name == "Don Swan" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat game:GetService("RunService").Heartbeat:wait()
                                                    EquipTool(SelectWeapon)
                                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    AutoClick()
                                                until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(2288.802, 15.1870775, 863.034607))
                                    end
                                elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                                    if game.Workspace.Enemies:FindFirstChild("rip_indra") then
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if v.Name == "rip_indra" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat game:GetService("RunService").Heartbeat:wait()
                                                    EquipTool(SelectWeapon)
                                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                    AutoClick()
                                                until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(-26952.2891, 21.5294781, 329.351562, -0.453972578, 0, -0.891015649, 0, 1, 0, 0.891015649, 0, -0.453972578))
                                    end
                                end
                            
                                TabelDevilFruitStore = {}
                                TabelDevilFruitOpen = {}
                                for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                                    for i1,v1 in pairs(v) do
                                        if i1 == "Name" then
                                            table.insert(TabelDevilFruitStore,v1)
                                        end
                                    end
                                end
                                for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
                                    if v.Price >= 1000000 then
                                        table.insert(TabelDevilFruitOpen,v.Name)
                                    end
                                end
                                for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
                                    for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
                                        if DevilFruitOpenDoor == DevilFruitStore and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                                            if not game.Players.LocalPlayer.Backpack:FindFirstChild(DevilFruitStore) then
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit",DevilFruitStore)
                                            else
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
                                            end
                                        end
                                    end
                                end
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == true then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                            end
                        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                            if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
                                if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == "Swan Pirate" then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                                                AutoClick()
                                            until not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not AutoThirdWorld
                                        end
                                    end
                                else
                                    if ByPassTP then
                                        BTP(CFrame.new(1057.92761, 137.614319, 1242.08069))
                                    else
                                        Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
                                    end
                                end
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                            end
                        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")
                            if game.Workspace.Enemies:FindFirstChild("Jeremy") then
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        if v.Name == "Jeremy" then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                AutoClick()
                                            until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
                                        end
                                    end
                                end
                            else
                                if ByPassTP then
                                    BTP(CFrame.new(2099.88159, 448.931, 648.997375))
                                else
                                    Tween(CFrame.new(2099.88159, 448.931, 648.997375))
                                end
                            end
                        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameThird.Position).Magnitude > 1500 then
                                if ByPassTP then
                                    BTP(CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375))
                                else
                                    Tween(CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375))
                                end
                            else
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
                            end
                        end
                    end
                end)
            end
        end
    end)

    Tabs.Main:AddParagraph({
        Title = "---[ Bone & Monster ]---",
        Content = "Monster Bone And Mastery"
    })

    local bome = Tabs.Main:AddToggle("Auto Farm Bone", {Title = "Auto Farm Bone", Default = false })

    bome:OnChanged(function(Value)
        Farm_Bone = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    local gacha = Tabs.Main:AddToggle("Auto Random Bone", {Title = "Auto Random Bone", Default = false })

    gacha:OnChanged(function(Value)
        Auto_Trade_Bone = Value

    while Auto_Trade_Bone do wait()
        local args = {   
            [1] = "Bones",   
            [2] = "Buy",
            [3] = 1,
            [4] = 1
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
    end)

    local BonePos = CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375)

    spawn(function()
        while task.wait() do
            if Farm_Bone and Third_Sea then
                pcall(function()
                    -- Check if any of the bone monsters are present in the workspace
                    if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
                        -- Loop through all enemies
                        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        -- Equip the selected weapon and prepare for combat
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        Bone_Farm_Name = v.Name
                                        Bone_Farm_CFrame = v.HumanoidRootPart.CFrame
    
                                        -- Move to the monster's position with an offset
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
    
                                        -- Auto-attack
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    until not Farm_Bone or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        -- If no monsters are found, move to the default bone farming position
                        Tween(CFrame.new(-9466.72949, 171.162918, 6132.01514))
    
                        -- Check for monsters in ReplicatedStorage and move to their positions
                        for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                            end
                        end
                    end
                end)
            end
        end
    end)

spawn(function ()
    while true and task.wait() do
        if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        end
    end
end)

    local Monn = Tabs.Main:AddDropdown("mon", {
        Title = "Select Monster",
        Values = tableMon,
        Multi = false,
        Default = 1,
    })

    Monn:OnChanged(function(Value)
        Env.SelectMonster = Value
    end)

    local fmonq = Tabs.Main:AddToggle("fmonq", {Title = "Farm Monster (Quest)", Default = false })

    fmonq:OnChanged(function(Value)
        SelectMonster_Quest_Farm = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if SelectMonster_Quest_Farm then
                pcall(function()
                    CheckLevel(Env.SelectMonster)
                    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        if ByPassTP then
                            BTP(CFrameQ)
                        elseif not ByPassTP then
                            Tween(CFrameQ)
                        end
                        if (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,QuestLv)
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == Ms then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            SelectMonster_Farm_Name = v.Name
                                            SelectMonster_Farm_CFrame = v.HumanoidRootPart.CFrame
                                            AutoClick()
                                        until not SelectMonster_Quest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            end
                        else
                            Tween(CFrameMon)
                        end
                    end
                end)
            end
        end
    end)

    local fmonnoq = Tabs.Main:AddToggle("fmonnoq", {Title = "Farm Monster (No Quest)", Default = false })

    fmonnoq:OnChanged(function(Value)
        SelectMonster_NoQuest_Farm = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if SelectMonster_NoQuest_Farm then
                pcall(function()
                    CheckLevel(Env.SelectMonster)
                    if ByPassTP then
                        BTP(CFrameQ)
                    elseif not ByPassTP then
                        Tween(CFrameQ)
                    end
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        SelectMonster_Farm_Name = v.Name
                                        SelectMonster_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    until not SelectMonster_NoQuest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    else
                        Tween(CFrameMon)
                    end
                end)
            end
        end
    end)

    KillPercent = 30
    local hpsli = Tabs.Main:AddSlider("hp", {
        Title = "Health %",
        Description = "Select HP",
        Default = 40,
        Min = 25,
        Max = 80,
        Rounding = 1,
        Callback = function(Value)
            KillPercent = Value
        end
    })

    hpsli:OnChanged(function(Value)
        KillPercent = Value
    end)

    local MasteryType = {'Quest', 'No Quest', 'Nearest', 'Bone', 'Cake Prince'}
    local modemas = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Farm Mode",
        Values = MasteryType,
        Multi = false,
        Default = 1,
    })

    modemas:OnChanged(function(Value)
        SelectedMethodMastery = Value
    end)

    SelectedMethodMastery = "Quest"

    local hi35 = Tabs.Main:AddToggle("MyToggle", {Title = "Farm Fruit Mastery", Default = false })

    hi35:OnChanged(function(Value)
        DevilMastery_Farm = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    local hi36 = Tabs.Main:AddToggle("MyToggle", {Title = "Farm Gun Mastery", Default = false })

    hi36:OnChanged(function(Value)
        GunMastery_Farm = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        pcall(function()
            while task.wait() do
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            CurrentEquipDevilFruit = v.Name
                        end
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        local gg = getrawmetatable(game)
        local old = gg.__namecall
        setreadonly(gg,false)
        gg.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            if tostring(method) == "FireServer" then
                if tostring(args[1]) == "RemoteEvent" then
                    if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                        if UseSkill then
                            if type(args[2]) == "vector" then
                                args[2] = PositionSkillMasteryDevilFruit
                            else
                                args[2] = CFrame.new(PositionSkillMasteryDevilFruit)
                            end
                            return old(unpack(args))
                        end
                        if UseGunMastery then
                            if type(args[2]) == "vector" then
                                args[2] = PositionSkillMasteryGun
                            else
                                args[2] = CFrame.new(PositionSkillMasteryGun)
                            end
                            return old(unpack(args))
                        end
                    end
                end
            end
            return old(...)
        end)
    end)
    
    spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            pcall(function()
                if UseGunMastery or UseSkill then
                    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
                        if v.Name == "NotificationTemplate" then
                            if string.find(v.Text,"Skill locked!") then
                                v:Destroy()
                            end
                        end
                    end
                end
            end)
        end)
    end)
    
    spawn(function()
        while task.wait() do
            if UseSkill == true then
                local plr = game:GetService("Players").LocalPlayer
                pcall(function()
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == Mastery_Farm_Name then 
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 50 then
                                        EquipTool(CurrentEquipDevilFruit)
                                        PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
                                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild(CurrentEquipDevilFruit) then
                                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(CurrentEquipDevilFruit).MousePos.Value = PositionSkillMasteryDevilFruit
                                            local DevilFruitMastery = game:GetService("Players").LocalPlayer.Character:FindFirstChild(CurrentEquipDevilFruit).Level.Value
                                            local plr = game:GetService("Players").LocalPlayer
                                            if _G.SkillZ then
                                                game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
                                                wait(.1)
                                                game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
                                            end
                                            if _G.SkillX then
                                                game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
                                                wait(.1)
                                                game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
                                            end
                                            if _G.SkillC then
                                                game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
                                                wait(.1)
                                                game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
                                            end
                                            if _G.SkillV then
                                                game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                                                wait(.1)
                                                game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                                            end
                                            if _G.SkillF then
                                                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                                                wait(.1)
                                                game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                                            end
                                        end
                                    end
                                until not UseSkill or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        while task.wait() do
            if DevilMastery_Farm and SelectedMethodMastery == "Quest" then
                pcall(function()
                    CheckLevel()
                    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        if ByPassTP then
                            BTP(CFrameQ)
                        elseif not ByPassTP then
                            Tween(CFrameQ)
                        end
    
                        if (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,QuestLv)
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                    if v.Name == Ms then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                                UseSkill = true
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            else
                                                UseSkill = false
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                                                Mastery_Farm_Name = v.Name
                                                Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                                AutoClick()
                                            end
                                        until not DevilMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end
                        else
                            Tween(CFrameMon)
                        end
                    end
                end)
    
            elseif DevilMastery_Farm and SelectedMethodMastery == "No Quest" then
                pcall(function()
                    CheckLevel()
                    if ByPassTP then
                        BTP(CFrameQ)
                    elseif not ByPassTP then
                        Tween(CFrameQ)
                    end
                    for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            if v.Name == Ms then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        UseSkill = true
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    else
                                        UseSkill = false
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Mastery_Farm_Name = v.Name
                                        Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    end
                                    
                                until not DevilMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            elseif DevilMastery_Farm and SelectedMethodMastery == "Nearest" then
                pcall(function()
                    for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
                        if v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 2000 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        UseSkill = true
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    else
                                        UseSkill = false
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Mastery_Farm_Name = v.Name
                                        Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    end
                                until not DevilMastery_Farm or not SelectedMethodMastery == 'Nearest' or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            elseif DevilMastery_Farm and SelectedMethodMastery == "Bone" then
                pcall(function()
                    local boneframe = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)
                    if ByPassTP then
                        BTP(boneframe)
                    elseif not ByPassTP then
                        Tween(boneframe)
                    end
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name =="Demonic Soul" or v.Name == "Posessed Mummy" then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        UseSkill = true
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    else
                                        UseSkill = false
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        Mastery_Farm_Name = v.Name
                                        Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    end
                                until not DevilMastery_Farm or not SelectedMethodMastery == 'Bone' or not v.Parent or v.Humanoid.Health == 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                    for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                        if v.Name == "Reborn Skeleton" then
                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                        elseif v.Name == "Living Zombie" then
                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                        elseif v.Name == "Demonic Soul" then
                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                        elseif v.Name == "Posessed Mummy" then
                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                        end
                    end
                end)
    
            elseif DevilMastery_Farm and SelectedMethodMastery == "Cake Prince" then
                pcall(function()
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    if game.ReplicatedStorage:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Cake Prince" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                            UseSkill = true
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        else
                                            UseSkill = false
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            Mastery_Farm_Name = v.Name
                                            Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                            AutoClick()
                                        end
                                    until not DevilMastery_Farm or not SelectedMethodMastery == 'Cake Prince' or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                end
                            end
                        else
                            if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
                                Tween(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                            end
                        end
                    else
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                    if (v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                                UseSkill = true
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            else
                                                UseSkill = false
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                                                Mastery_Farm_Name = v.Name
                                                Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame
                                                AutoClick()
                                            end
                                        until not DevilMastery_Farm or not SelectedMethodMastery == 'Cake Prince' or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end
                        else
                            local cakepos = CFrame.new(-2077, 252, -12373)
                            if ByPassTP then
                                BTP(cakepos)
                            else
                                Tween(cakepos)
                            end
                        end
                    end
                end)
    
            else
                UseSkill = false
            end
        end
    end)    
    
    Tabs.Main:AddParagraph({
        Title = "Boss Menu",
        Content = "Farming Boss"
    })

    if First_Sea then
         BossNameStorage = {"The Gorrila King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral", "Saber Expert", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard"}
    elseif Second_Sea then
         BossNameStorage = {"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Awakened Ice Admiral", "Tide Keeper", "Darkbeard", "Cursed Captain", "Order"}
    elseif Third_Sea then
         BossNameStorage = {"Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen", "Longma", "Soul Reaper", "rip_indra True Form"}
    end

    local Refresh_Boss = Tabs.Main:AddDropdown("BOss", {
        Title = "Select Boss",
        Values = BossNameStorage,
        Multi = false,
        Default = 1,
    })

    Refresh_Boss:OnChanged(function(Value)
        SelectBoss = Value
    end)

    local wdvv = Tabs.Main:AddToggle("Farm Boss [Quest]", {Title = "Auto Farm Boss", Default = false })

    wdvv:OnChanged(function(Value)
        AutoFarmBossQuest = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoFarmBossQuest then
                pcall(function()
                    CheckBossQuest(SelectBoss)
                    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        if ByPassTP then
                            BTP(CFrameQBoss)
                        elseif not ByPassTP then
                            Tween(CFrameQBoss)
                        end
                        if (CFrameQBoss.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuestBoss,QuestLvBoss)
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == SelectBoss then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            AutoClick()
                                        until not AutoFarmBossQuest or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            end
                        else
                            Tween(CFrameBoss)
                        end
                    end
                end)
            end
        end
    end)

    local uyy = Tabs.Main:AddToggle("wdvv", {Title = "Farm Boss [No Quest]", Default = false })

    uyy:OnChanged(function(Value)
        AutoFarmBossNoQuest = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AutoFarmBossNoQuest then
                pcall(function()
                    CheckBossQuest(SelectBoss)
                    if ByPassTP then
                        BTP(CFrameBoss)
                    elseif not ByPassTP then
                        Tween(CFrameBoss)
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == SelectBoss then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    AutoClick()
                                until not AutoFarmBossNoQuest or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            end
        end
    end)
    if First_Sea then
        MaterialList = {"Scrap Metal","Leather","Angel Wings","Magma Ore","Fish Tail"}
    elseif Second_Sea then
        MaterialList = {"Scrap Metal","Leather","Radioactive Material","Mystic Droplet","Magma Ore","Vampire Fang"}
    elseif Third_Sea then
        MaterialList = {"Scrap Metal","Leather","Demonic Wisp","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"}
    end
    local matdrop = Tabs.Items:AddDropdown("Material Lists", {
        Title = "Materials Lists",
        Values = MaterialList,
        Multi = false,
        Default = 1,
    })

    matdrop:OnChanged(function(Value)
        SelectMaterial = Value
    end)

    local matff = Tabs.Items:AddToggle("Farm Material [ฟามวัตถุดิบ]", {Title = "Farm Material Selected", Default = false })

    matff:OnChanged(function(Value)
        Auto_Farm_Material = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if Auto_Farm_Material then
                pcall(function()
                    MaterialMon(SelectMaterial)
                    if ByPassTP then
                        BTP(MPos)
                    elseif not ByPassTP then
                        Tween(MPos)
                    end
                    for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == MMon then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    Material_Farm_Name = v.Name
                                    Material_Farm_CFrame = v.HumanoidRootPart.CFrame
                                    AutoClick()
                                until not Auto_Farm_Material or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            end
        end
    end)

    wait()

    Tabs.Items:AddParagraph({
        Title = "Items First Sea",
        Content = "Auto Items First Sea"
    })

    local sabere = Tabs.Items:AddToggle("Auto Saber", {Title = "Auto Saber Sword", Default = false })

    sabere:OnChanged(function(Value)
        AutoSaber = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoSaber and game.Players.LocalPlayer.Data.Level.Value >= 200 and not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Saber") and not game.Players.LocalPlayer.Character:FindFirstChild("Saber") then
                pcall(function()
                    if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then
                        if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0 then
                            if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                                Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
                                wait(1)
                            else
                                Tween(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
                            end
                        else
                            if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0 then
                                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                                    EquipTool("Torch")
                                    Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
                                else
                                    Tween(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
                                end
                            else
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                                    wait(0.5)
                                    EquipTool("Cup")
                                    wait(0.5)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
                                    wait(0)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
                                else
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") then
                                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                    if v.Name == "Mob Leader" then
                                                        repeat game:GetService("RunService").Heartbeat:wait()
                                                            EquipTool(SelectWeapon)
                                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                            v.HumanoidRootPart.Transparency = 1
                                                            v.Humanoid:ChangeState(11)
                                                            v.Humanoid:ChangeState(14)
                                                            AutoClick()
                                                        until v.Humanoid.Health <= 0 or AutoSaber == false or not v.Parent
                                                    end
                                                end
                                            end
                                        else
                                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader").HumanoidRootPart.CFrame)
                                        end
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                        wait(0.5)
                                        EquipTool("Relic")
                                        wait(0.5)
                                        Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
                                    end
                                end
                            end
                        end
                    else
                        if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == "Saber Expert" then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            AutoClick()
                                        until v.Humanoid.Health <= 0 or AutoSaber == false
                                        if v.Humanoid.Health <= 0 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic")
                                        end
                                    end
                                end
                            end
                        else
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert").HumanoidRootPart.CFrame)
                        end
                    end
                end)
            end
        end
    end)
    
    local pp = Tabs.Items:AddToggle("Auto Pole", {Title = "Auto Pole", Default = false })

    pp:OnChanged(function(Value)
        AutoPole = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AutoPole then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == "Thunder God" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        AutoClick()
                                    until not AutoPole or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        if ByPassTP then
                            BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame)
                        else
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame)
                        end
                    end
                end)
            end
       end
    end)

Tabs.Items:AddParagraph({

        Title = "Item Second Sea",

        Content = "Auto Item in Second Sea"
    })

local bbqe = Tabs.Items:AddToggle("Auto Bartilo Quest", {Title = "Auto Bartilo Quest", Default = false })

    bbqe:OnChanged(function(Value)
        AutoBartilo = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    if game.Players.LocalPlayer.Backpack:FindFirstChild("Warrior Helmet") then
        Success = true
    elseif game.Players.LocalPlayer.Character:FindFirstChild("Warrior Helmet") then
        Success = true
    end
    end)
    
    if game.Players.LocalPlayer.Backpack:FindFirstChild("Warrior Helmet") then

        Fluent:Notify({
        Title = "Auto Bartilo Quest",
        Content = "Quest Completed!",
        SubContent = "by flower hub", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
    elseif game.Players.LocalPlayer.Character:FindFirstChild("Warrior Helmet") then
        Fluent:Notify({
        Title = "Auto Bartilo Quest",
        Content = "Quest Completed!",
        SubContent = "by flower hub", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
    end

    spawn(function()
        while task.wait() do
            if AutoBartilo then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                        if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
                            if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Swan Pirate" then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            Bartilo_Farm_Name = v.Name
                                            Bartilo_Farm_CFrame = v.HumanoidRootPart.CFrame
                                            AutoClick()
                                        until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            else
                                if ByPassTP then
                                    BTP(CFrame.new(1057.92761, 137.614319, 1242.08069))
                                else
                                    Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
                                end
                            end
                        else
                            Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
                            if (Vector3.new(-456.28952, 73.0200958, 299.895966) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                wait(1.1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                            end
                        end
                    elseif game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                        if QuestBartilo == nil then
                            Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
                        end
                        if (Vector3.new(-456.28952, 73.0200958, 299.895966) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")
                            QuestBartilo = 1
                        end
                        if game.Workspace.Enemies:FindFirstChild("Jeremy") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Jeremy" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        AutoClick()
                                    until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                end
                            end
                        else
                            Tween(CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172))
                            if QuestBartilo == 1 then
                                Tween(CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172))
                            end
                        end
                    elseif game.Players.LocalPlayer.Data.Level.Value >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                        Tween(game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.CFrame)
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.CFrame
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.CFrame
                        wait(1)
                    end
                end)
            end 
        end
    end)

    
    local fact = Tabs.Items:AddToggle("Auto Factory", {Title = "Auto Factory", Default = false })

    fact:OnChanged(function(Value)
        AutoFactory = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AutoFactory then
                if game.Workspace.Enemies:FindFirstChild("Core") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Core" and v.Humanoid.Health > 0 then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                                EquipTool(SelectWeapon)
                                AutoClick()
                            until not v.Parent or v.Humanoid.Health <= 0  or AutoFactory == false
                        end
                    end
                elseif game.ReplicatedStorage:FindFirstChild("Core") then
                    repeat Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                        wait()
                    until not AutoFactory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
                end
            end
        end
    end)

local swan = Tabs.Items:AddToggle("glassmswan", {Title = "Auto Swan Glasses", Default = false })

    swan:OnChanged(function(Value)
        _G.SwanGlasses = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if _G.SwanGlasses then
                if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if v.Name == "Don Swan" then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    AutoClick()
                                until _G.SwanGlasses == false or v.Humanoid.Health <= 0 or not v.Parent
                            end
                        end
                    end
                else
                    if ByPassTP then
                        BTP(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
                    else
                        Tween(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
                    end
                end
            end
        end
    end)
    

Tabs.Items:AddParagraph({

        Title = "Item Third Sea",

        Content = "Auto Item in Third Sea"
    })

Tabs.Items:AddButton({
        Title = "Check Elite Hunter",
        Description = "Check if Elite Spawn",
        Callback = function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
            Fluent:Notify({
        Title = "Elite Hunter Checker",
        Content = "Boss Has Been Spawned!",
        SubContent = "Bloxfruit third sea", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
            else
                Fluent:Notify({
        Title = "Elite Hunter Checker",
        Content = "Boss Not Spawned!",
        SubContent = "Bloxfruit third sea", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
                end
        end
    })

local butttt = Tabs.Items:AddToggle("Auto Elite", {Title = "Auto Elite Hunter", Default = false })

    butttt:OnChanged(function(Value)
        AutoEliteHunter = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AutoEliteHunter then
                pcall(function()
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                                                AutoClick()
                                            until AutoEliteHunter == false or v.Humanoid.Health <= 0 or not v.Parent
                                        end
                                    end
                                end
                            else
                                if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                    if ByPassTP then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                                    else
                                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                                    end
                                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                    if ByPassTP then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                                    else
                                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                                    end
                                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                    if ByPassTP then
                                        BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                                    else
                                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                                    end
                                end
                            end
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    end
                end)
            end
        end
    end)


local pro = Tabs.Items:AddToggle("Auto Dought Boss", {Title = "Auto Dought Boss", Default = false })

    pro:OnChanged(function(Value)
        AutoCakePrince = Value
        _G.spawn = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoCakePrince then
                pcall(function()
                    if game.ReplicatedStorage:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if AutoCakePrince and v.Name == "Cake Prince" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        AutoClick()
                                    until not AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
                                Tween(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                            end
                        end
                    else
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if (v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            CakePrince_Farm_Name = v.Name
                                            CakePrince_Farm_CFrame = v.HumanoidRootPart.CFrame
                                            AutoClick()
                                        until not AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            local cakepos = CFrame.new(-2077, 252, -12373)
                            if ByPassTP then
                                BTP(cakepos)
                            else
                                Tween(cakepos)
                            end
                        end
                    end
                end)
            end
        end
    end)
    
    
    local butt = Tabs.Items:AddToggle("Auto Buddy Sword", {Title = "Auto Buddy Sword", Default = false })

    butt:OnChanged(function(Value)
        AutoBuddySword = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AutoBuddySword then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == "Cake Queen [Lv. 2175] [Boss]" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        AutoClick()
                                    until not AutoBuddySword or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]").HumanoidRootPart.CFrame)
                    end
                end)
            end
        end
    end)

    local soii = Tabs.Items:AddToggle("Auto Castle Raid", {Title = "Auto Castle Raid", Default = false })

    soii:OnChanged(function(Value)
        AutoPirateCastle = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoPirateCastle then
                pcall(function()
                    local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
                    if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name then
                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid:ChangeState(14)
                                            PirateCastle_Name = v.Name
                                            PirateCastle_CFrame = v.HumanoidRootPart.CFrame
                                            AutoClick()
                                        until not AutoPirateCastle or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                    end
                                end
                            end
                        end
                    else
                        Tween(CFrameCastleRaid)
                    end
                end)
            end
        end
    end)

    spawn(function()
        while task.wait() do
            if _G.spawn then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            end
        end
    end)

    local guitt = Tabs.Items:AddToggle("Auto Soul Guitar", {Title = "Auto Soul Guitar", Default = false })

    guitt:OnChanged(function(Value)
        AutoSoulGuitar = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    function GetWeaponInventory(Sword)
        for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
            if type(v) == "table" then
                if v.Type == "Sword" then
                    if v.Name == Sword then
                        return true
                    end
                end
            end
        end
        return false
    end

    spawn(function()
        while task.wait() do
            if AutoSoulGuitar then
                pcall(function()
                    if GetWeaponInventory("Soul Guitar") == false then
                        if (CFrame.new(-9681.458984375, 6.139880657196045, 6341.3720703125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000 then
                            if game:GetService("Workspace").NPCs:FindFirstChild("Skeleton Machine") then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy",true)
                            else
                                if game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency == 0 then
                                    if game:GetService("Workspace").Map["Haunted Castle"].Placard1.Left.Part.Transparency == 0 then
                                        Quest2 = true
                                        repeat task.wait() 
                                            Tween(CFrame.new(-8762.69140625, 176.84783935546875, 6171.3076171875)) 
                                        until (CFrame.new(-8762.69140625, 176.84783935546875, 6171.3076171875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not AutoSoulGuitar
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard7.Left.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard6.Left.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard5.Left.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard4.Right.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard3.Left.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard2.Right.ClickDetector)
                                        wait(1)
                                        fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard1.Right.ClickDetector)
                                        wait(1)
                                    elseif game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector") then
                                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1:FindFirstChild("ClickDetector") then
                                            Quest4 = true
                                            repeat task.wait() 
                                                Tween(CFrame.new(-9553.5986328125, 65.62338256835938, 6041.58837890625)) 
                                            until (CFrame.new(-9553.5986328125, 65.62338256835938, 6041.58837890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not AutoSoulGuitar
                                            wait(1)
                                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
                                            wait(1)
                                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                                            wait(1)
                                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                                            wait(1)
                                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
                                            wait(1)
                                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                            wait(1)
                                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                                        else
                                            Quest3 = true
                                            --Not Work Yet
                                        end
                                    else
                                        if game:GetService("Workspace").NPCs:FindFirstChild("Ghost") then
                                            local args = {
                                                [1] = "GuitarPuzzleProgress",
                                                [2] = "Ghost"
                                            }
    
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        if game.Workspace.Enemies:FindFirstChild("Living Zombie") then
                                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                                    if v.Name == "Living Zombie" then
                                                        repeat game:GetService("RunService").Heartbeat:wait()
                                                            EquipTool(SelectWeapon)
                                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                            v.HumanoidRootPart.Transparency = 1
                                                            v.Humanoid:ChangeState(11)
                                                            v.Humanoid:ChangeState(14)
                                                            SoulGuitar_Farm_Name = v.Name
                                                            SoulGuitar_Farm_CFrame = v.HumanoidRootPart.CFrame
                                                            AutoClick()
                                                        until v.Humanoid.Health <= 0 or not v.Parent or not AutoSoulGuitar
                                                    end
                                                end
                                            end
                                        else
                                            Tween(CFrame.new(-10160.787109375, 138.6616973876953, 5955.03076171875))
                                        end
                                    end
                                else    
                                    if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Error") then
                                        print("Go to Grave")
                                        Tween(CFrame.new(-8653.2060546875, 140.98487854003906, 6160.033203125))
                                    elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Nothing") then
                                        print("Wait Next Night")
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent",2,true)
                                    end
                                end
                            end
                        else
                            Tween(CFrame.new(-9681.458984375, 6.139880657196045, 6341.3720703125))
                        end
                    end
                end)
            end
        end
    end)
    local hallowww = Tabs.Items:AddToggle("Auto Hallow Scythe", {Title = "Auto Hallow Scythe", Default = false })

    hallowww:OnChanged(function(Value)
        AutoHallowSycthe = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoHallowSycthe then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == "Soul Reaper" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid:ChangeState(11)
                                        v.Humanoid:ChangeState(14)
                                        AutoClick()
                                    until v.Humanoid.Health <= 0 or not AutoHallowSycthe or not v.Parent
                                end
                            end
                        end
                    else
                        loc3 = CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                            repeat task.wait()
                                Tween(loc3)
                                wait()
                            until (loc3.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
                            EquipTool("Hallow Essence")
                        else
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
                        end
                    end
                end)
            end
        end
    end)

    Tabs.Event:AddParagraph({
        Title = "Dojo Event Quest",
        Content = "Dojo Quest Function"
    })

    function getAcc(BeltName)
        for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
            if type(v) == "table" then
                if v.Type == "Wear" then
                    if v.Name == BeltName then
                        return true
                    end
                end
            end
        end
        return false
    end
    local DojoQuestNpc = CFrame.new(5855.19629, 1208.32178, 872.713501, 0.606994748, -1.81058823e-09, -0.794705868, 5.72712722e-09, 1, 2.09605577e-09, 0.794705868, -5.82367621e-09, 0.606994748)    
    local DojoProgessCheck
    local DojoInfoCheck

    local lopp = Tabs.Event:AddToggle("Auto Dojo", {Title = "Auto Dojo Quest 1-2", Default = false })

    lopp:OnChanged(function(Value)
        DojoQuestEnable = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if DojoQuestEnable then  
                pcall(function()
                    if getAcc("Dojo Belt (White)") == false and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        CheckLevel()
                        if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                            if ByPassTP then
                                BTP(CFrameQuest)
                            elseif not ByPassTP then
                                Tween(CFrameQuest)
                            end
                            if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                                task.wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                            end
    
                        elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        if v.Name == Ms then
                                            repeat game:GetService("RunService").Heartbeat:wait()
                                                EquipTool(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                v.HumanoidRootPart.Transparency = 1
                                                Dojo_Farm_Name = v.Name
                                                Dojo_Farm_CFrame = v.HumanoidRootPart.CFrame
                                            until not DojoQuestEnable or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        end
                                    end
                                end
                            else
                                Tween(CFrameMon)
                            end
                        end
    
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
    
                        Tween(CFrame.new(-12575.7666, 336.955719, -7556.80029, 0.0528766066, -7.96442023e-08, -0.998601079, 2.11768718e-08, 1, -7.86344501e-08, 0.998601079, -1.69893237e-08, 0.0528766066))
    
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
    
                        if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                        until DojoQuestEnable == false or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            end
                        else
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                if ByPassTP then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                                else
                                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                                end
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                if ByPassTP then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                                else
                                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                                end
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                if ByPassTP then
                                    BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                                else
                                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                                end
                            end
                        end
                        
                    end
                end)
            end
        end
    end)

    local lopgp = Tabs.Event:AddToggle("Auto Claim", {Title = "Auto Claim Quest Dojo", Default = false })

    lopgp:OnChanged(function(Value)
        DojoClaimQuest = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if DojoClaimQuest then
                pcall(function()
                    if ByPassTP then
                        BTP(DojoQuestNpc)
                    elseif not ByPassTP then
                        Tween(DojoQuestNpc)
                    end
                
                    if (DojoQuestNpc.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        local ohTable1 = {
                            ["NPC"] = "Dojo Trainer",
                            ["Command"] = "ClaimQuest"
                        }
                        
                        game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
                    end
    
                end)
            end
        end
    end)

    local bblaze = Tabs.Event:AddToggle("Auto Blaze Ember", {Title = "Auto Farm Blaze Ember Full", Default = false })

    bblaze:OnChanged(function(Value)
        _G.BlazeEE = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    function BlazeEmber()
        for i, v in pairs(workspace:GetChildren()) do
            if v:IsA("Model") and v.Name == "EmberTemplate" then
                return v
            end
        end
        return nil
    end
    local questCompleted = true
    local re
    function CheckNotify(msg)
        msg = string.lower(msg)
        for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetDescendants()) do
            if v:IsA("TextLabel") then
                if string.find(string.lower(v.Text), msg) then
                    return v
                end
            end
        end
        return nil
    end
    function CheckQ()
        if CheckNotify('Task completed!') and not CheckNotify('Task completed!'):FindFirstChild("Ignored") then
            if not questCompleted then
                questCompleted = true
                Instance.new("IntValue", CheckNotify('Task completed!')).Name = "Ignored"
                print("Quest Completed!")
            end
        end
        local cq = game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({["Context"] = "Check"})
        if questCompleted and cq and cq.Text == "Destroy 10 trees on Hydra Island." then
            questCompleted = false
            re = "Tree"
        elseif questCompleted and cq and cq.Text == "Defeat 3 Venomous Assailants on Hydra Island." then
            questCompleted = false
            re = "Venomous"
        elseif questCompleted and cq and cq.Text == "Defeat 3 Hydra Enforcers on Hydra Island." then
            questCompleted = false
            re = "Hydra"
        elseif questCompleted and (not cq or (cq and cq.Text == nil)) then
            re = "Get Quest"
        end
        return re
    end
    function TP(p)
        local Distance = (p.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 200 then
            game.Players.LocalPlayer.Character.PartTele.CFrame = p
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PartTele.CFrame
        end
        if not game.Players.LocalPlayer.Character:FindFirstChild("PartTele") then
            local ga = Instance.new("Part", game.Players.LocalPlayer.Character)
            ga.Size = Vector3.new(10,1,10)
            ga.Name = "PartTele"
            ga.Anchored = true
            ga.Transparency = 1
            ga.CanCollide = false
            ga.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            ga:GetPropertyChangedSignal("CFrame"):Connect(function()
                task.wait(0.01)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PartTele.CFrame
            end)
        end
        game.Players.LocalPlayer.Character.PartTele.CFrame = CFrame.new(game.Players.LocalPlayer.Character.PartTele.CFrame.X, p.Y, game.Players.LocalPlayer.Character.PartTele.CFrame.Z)
        local tw = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.PartTele, TweenInfo.new(Distance / 300, Enum.EasingStyle.Linear),{CFrame = p})
        tw:Play()
        function StopTween()
            if tw then
                tw:Cancel()
            end
            if game.Players.LocalPlayer.Character:FindFirstChild("PartTele") then
                game.Players.LocalPlayer.Character:FindFirstChild("PartTele"):Destroy()
            end
        end
    end
    function Attack()
        for i, v in next, workspace.Enemies:GetChildren() do
            if v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= tonumber(60) then
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack"):FireServer(0)
                local args = {
                    [1] = v:FindFirstChild("RightHand"),
                    [2] = {}
                }
                for _, e in next, workspace:WaitForChild("Enemies"):GetChildren() do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        table.insert(args[2], {
                            [1] = e,
                            [2] = e:FindFirstChild("HumanoidRootPart") or e:FindFirstChildOfClass("BasePart")
                        })
                    end
                end
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
            end
        end
    end
    function Monster(a)
        for i, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == a and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                return v
            end
        end
        return nil
    end
    function Equip(f)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(f))
    end
    function Kill(Mon)
        if Mon then
            repeat task.wait()
                TP(Mon.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                Equip(Melee)
                Attack()
            until not Mon or Mon.Humanoid.Health <= 0 or not Mon:FindFirstChild("HumanoidRootPart")
        else
            TP(CFrame.new(4661.08154296875, 1132.206298828125, 678.4617309570312))
        end
    end
    function UK(k)
        game:GetService("VirtualInputManager"):SendKeyEvent(true ,k, false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false ,k, false, game)
    end
    function ChangeMelee()
        local MeleeChange = {
            Melee,
            Sword,
            Gun,
            Fruit
        }
        local index = 1
        while true do
            coroutine.yield(MeleeChange[index])
            index = index + 1
            if index > #MeleeChange then
                index = 1
            end
            wait(2)
        end
    end
    local meleeCoroutine = coroutine.create(ChangeMelee)
    task.spawn(function()
        while task.wait(.5) do
            pcall(function()
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        if v.ToolTip == "Melee" then
                            Melee = v.Name
                        end
                        if v.ToolTip == "Sword" then
                            Sword = v.Name
                        end
                        if v.ToolTip == "Gun" then
                            Gun = v.Name
                        end
                        if v.ToolTip == "Blox Fruit" then
                            Fruit = v.Name
                        end
                    end
                end
            end)
    
            pcall(function()
                if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit then
                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                end
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                    local BodyVelocity = Instance.new("BodyVelocity")
                    BodyVelocity.Name = "BodyVelocity1"
                    BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    BodyVelocity.MaxForce = Vector3.new(10000,10000,10000)
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if _G.BlazeEE then
            xpcall(function()
            __External = CheckQuest()
            if BlazeEmber() then
                TP(BlazeEmber().Part.CFrame)
            elseif __External == "Tree" then
                for i, v in pairs(workspace.Map.Waterfall.IslandModel.DojoAddition:GetChildren()) do
                    if v:IsA("Model") and v.Name == "Tree" and (#v:GetChildren() < 2 and #v:GetChildren("Group") < 2) and __External == "Tree" and not BlazeEmber() then
                        repeat task.wait()
                            TP(CFrame.new(v.PrimaryPart.Position))
                            task.spawn(function()
                                local success, result = coroutine.resume(meleeCoroutine)
                                if success then
                                    Equip(result)
                            end
                        end)
                            if (v.PrimaryPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10 then
                                UK(Enum.KeyCode.Z); UK(Enum.KeyCode.X); UK(Enum.KeyCode.C); UK(Enum.KeyCode.F)
                            end
                        until not v.Parent or (#v:GetChildren() > 2 and #v:GetChildren("Group") > 2) or __External ~= "Tree" or (CheckNotify('Task completed!') and not CheckNotify('Task completed!'):FindFirstChild("Ignored")) or BlazeEmber()
                    end
                end
            elseif __External == "Venomous" then
                local Mon = Monster("Venomous Assailant")
                Kill(Mon)
            elseif __External == "Hydra" then
                local Mon = Monster("Hydra Enforcer")
                Kill(Mon)
            elseif __External == "Get Quest" then
                if questCompleted then
                    __External = CheckQ()
                    local NPC = CFrame.new(5862, 1208, 807)
                    repeat task.wait()
                        TP(NPC)
                    until (NPC.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10
                    if (NPC.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10 then
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").Modules.Net["RF/DragonHunter"]:InvokeServer({["Context"] = "RequestQuest"})
                    end
                end
            end
            end,print)
        end
    end
    end)

    Tabs.Event:AddButton({
        Title = "Upgrade Dragon Talon",
        Description = "Talon Upgrade",
        Callback = function(Value)
            DragonTalonUpgrade = Value
            if Value == false then
                Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        end
    })

    spawn(function()
        while task.wait() do
            if DragonTalonUpgrade then
                local UzothNPC = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)
    
                Tween(UzothNPC)
                if (UzothNPC.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    local ohTable1 = {
                        ["NPC"] = "Uzoth",
                        ["Command"] = "Upgrade"
                    }
                    
                    game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
                end
            end
        end
    end)
    Tabs.Event:AddButton({
        Title = "Go To Dragon Hunter",
        Description = "Dragon Hunter",
        Callback = function()
            Tween(CFrame.new(5865.80811, 1209.50269, 811.746582, -0.675207436, -6.76664627e-08, 0.737627923, 8.33632186e-09, 1, 9.93661047e-08, -0.737627923, 7.32418357e-08, -0.675207436))
        end
    })

    Tabs.Event:AddParagraph({
        Title = "Sea Event",
        Content = "Alway Bugs"
    })

    function TPB(BoatsPos)
        local Distance = (BoatsPos.Position - game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.Position).Magnitude
        if Distance > 1 then
            Speed = SpeedBoatTween
        end
        game:GetService("TweenService"):Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = BoatsPos}):Play()
        if _G.StopTweenBoat then
            game:GetService("TweenService"):Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = BoatsPos}):Cancel()
        end
    end
    
    --// CANCEL TWEEN BOATS
    function StopBoats(target)
        if not target then
            _G.StopTweenBoat = true
            wait(.1)
            TPB(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame)
            wait(.1)
            _G.StopTweenBoat = false
        end
    end
    
    spawn(function()
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if DojoQuestEnable then
                    if game:GetService("Workspace").Boats:FindFirstChild('PirateBrigade') then
                        for _,v in pairs(game:GetService("Workspace").Boats.PirateBrigade:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end)
    end)
    spawn(function()
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if AutoSeaFarm or AutoSail then
                    if game:GetService("Workspace").Boats:FindFirstChild(BoatSelected) then
                        local BoatsTarget = game:GetService("Workspace").Boats:FindFirstChild(BoatSelected)
                        for _,v in pairs(BoatsTarget:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end)
    end)
    
    --// Boats Body Velocity
    spawn(function()
        while task.wait() do
            pcall(function()
                if DojoQuestEnable then
                    game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(100000,100000,100000)
                    game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.Velocity = Vector3.new(0,0,0)
                else
                    game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                    game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.Velocity = Vector3.new(0,0,0)
                end
            end)
        end
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if AutoSeaFarm or AutoSail then
                    game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.BodyVelocity.MaxForce = Vector3.new(100000000000,100000000000,100000000000)
                    --game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.BodyPosition.MaxForce = Vector3.new(100000000,100000000,100000000)
                else
                    game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.BodyVelocity.MaxForce = Vector3.new(2453406976, 0, 2453406976)
                    --game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.BodyPosition.MaxForce = Vector3.new(0, 2453406976, 0)
                    --game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.BodyVelocity.Velocity = Vector3.new(0,0,0)
    
                end
            end)
        end
    end)
    
    function PlayBoatsTween(Target)
        local Distance = (Target.Position - game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.Position).Magnitude
        if Distance > 1 then
            Speed = SpeedBoatTween
        end
    
        game:GetService("TweenService"):Create(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = Target}):Play()
        if _G.StopTweenBoat then
            game:GetService("TweenService"):Create(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = Target}):Cancel()
        end
    end
    
    --// CANCEL TWEEN BOATS
    function StopBoatsTween(target)
        if not target then
            _G.StopTweenBoat = true
            wait(.1)
            PlayBoatsTween(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.CFrame)
            wait(.1)
            _G.StopTweenBoat = false
        end
    end
    
    function CheckSea()
        if SeaLevelSelected == 'Level 1' then
            SeaCFrame = CFrame.new(-11887.5742, -0.306667894, 16193.2705, -0.96911639, 1.13939585e-07, -0.246603817, 1.18964671e-07, 1, -5.47853096e-09, 0.246603817, -3.46464759e-08, -0.96911639)
            
        elseif SeaLevelSelected == 'Level 2' then
            SeaCFrame = CFrame.new(-11000.5625, -0.306667894, 21056.0312, -0.796931446, -6.01718924e-08, -0.604069769, -7.4490849e-08, 1, -1.33725619e-09, 0.604069769, 4.39319656e-08, -0.796931446)
            
        elseif SeaLevelSelected == 'Level 3' then
            SeaCFrame = CFrame.new(-9995.36719, -0.306667894, 24740.7656, -0.970631301, 1.55747459e-09, -0.240571901, 3.96488886e-09, 1, -9.52301882e-09, 0.240571901, -1.01971809e-08, -0.970631301)
        
        elseif SeaLevelSelected == 'Level 4' then
            SeaCFrame = CFrame.new(-8656.56934, -0.306667894, 29984.1152, -0.737478554, -7.80717357e-08, -0.675370574, -4.13984687e-08, 1, -7.03928436e-08, 0.675370574, -2.3953902e-08, -0.737478554)
            
        elseif SeaLevelSelected == 'Level 5' then
            SeaCFrame = CFrame.new(-8627.31934, -0.306667835, 34267.3516, -0.937176228, -4.47612693e-12, -0.34885627, -2.15563958e-08, 1, 5.78968127e-08, 0.34885627, 6.17796019e-08, -0.937176228)
    
        elseif SeaLevelSelected == 'Level 6' then
            SeaCFrame = CFrame.new(-2551.66382, -0.306667715, 75050.8047, -0.909505963, -3.70954254e-08, -0.415690839, 4.82135842e-09, 1, -9.97868526e-08, 0.415690839, -9.27609278e-08, -0.909505963)
    
        end
    end

    BoatList = { 'Dinghy'; 'PirateSloop'; 'PirateBrigade'; 'PirateGrandBrigade'; 'MarineSloop'; 'MarineBrigade'; 'MarineGrandBrigade'}

    local boatse = Tabs.Event:AddDropdown("wwboat", {
        Title = "Select Boat",
        Values = BoatList,
        Multi = false,
        Default = 1,
    })

    boatse:OnChanged(function(Value)
        BoatSelected = Value
    end)

    local SeaLevelList = {
        'Level 1'; 'Level 2'; 'Level 3'; 'Level 4'; 'Level 5'; 'Level 6';
    } 
    local ee1 = Tabs.Event:AddDropdown("wwboat", {
        Title = "Select Sea Level",
        Values = SeaLevelList,
        Multi = false,
        Default = 1,
    })

    ee1:OnChanged(function(Value)
        SeaLevelSelected = Value
    end)

    local sail2 = Tabs.Event:AddToggle("MyToggle", {Title = "Auto Sail Boat (เเจวเรือ)", Default = false })

    sail2:OnChanged(function(Value)
        AutoSail = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    local TikiPost = CFrame.new(-16192.5742, 11.0552588, 1741.49121, 0.927989781, 0, -0.372605681, -0, 1, 0, 0.372605681, 0, 0.927989781)

spawn(function()
    while task.wait() do
        if AutoSail then
            
            --local RoughSeaPos = CFrame.new(-47041.6641, 10.8365746, -6858.74072, 0.703071356, -0.0286799595, 0.710540712, 0.0407584943, 0.999169052, -2.41380471e-09, -0.709950268, 0.0289605707, 0.703656077)
            pcall(function()
                CheckSea()

                if game:GetService("Workspace").Boats:FindFirstChild(BoatSelected) then
                
                    if game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).Owner.Value.Name == tostring(game.Players.LocalPlayer.Name) then

                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then

                            Tween(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.CFrame * CFrame.new(0,1,0))

                        elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then

                            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then

                                PlayBoatsTween(game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island").CFrame * CFrame.new(0,50,0))

                            else

                                PlayBoatsTween(SeaCFrame * CFrame.new(0,50,0))

                                if AutoFarmSeaBeast then
                                    if game:GetService("Workspace").SeaBeasts:FindFirstChild('SeaBeast1') then
                                        PlayBoatsTween(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.CFrame)
                                    end
                                end
                                if AttackFish then
                                    if (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') or game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') or game:GetService('Workspace').Enemies:FindFirstChild('Terrorshark') or game:GetService('Workspace').Enemies:FindFirstChild('Shark') or game:GetService('Workspace').Enemies:FindFirstChild('Piranha') or game:GetService('Workspace').Enemies:FindFirstChild('Fish Crew Member')) then
                                        PlayBoatsTween(game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).VehicleSeat.CFrame)
                                    end
                                end
                            
                            end
                            
                        end

                    elseif game:GetService("Workspace").Boats:FindFirstChild(BoatSelected).Owner.Value.Name ~= tostring(game.Players.LocalPlayer.Name) then

                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false

                        if ByPassTP then
                            BTP(TikiPost)
                        elseif not ByPassTP then
                            Tween(TikiPost)
                        end

                        if (TikiPost.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                            local args = {
                                [1] = "BuyBoat",
                                [2] = BoatSelected
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            wait(1)
                        end
                        
                    end

                elseif not game:GetService("Workspace").Boats:FindFirstChild(BoatSelected) then

                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false

                    if ByPassTP then
                        BTP(TikiPost)
                    elseif not ByPassTP then
                        Tween(TikiPost)
                    end
                    if (TikiPost.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                        local args = {
                            [1] = "BuyBoat",
                            [2] = BoatSelected
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        wait(1)
                    end

                end

            end)
        end
    end
end)
local Attackmm = Tabs.Event:AddToggle("MyToggle", {Title = "Attack Sea Monster", Default = false })

    Attackmm:OnChanged(function(Value)
        AttackFish = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait() do
            if AttackFish then
                pcall(function()
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Shark" or v.Name == "Piranha" or v.Name == "Fish Crew Member" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
    
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                    EquipTool(SelectWeapon)
                                    
                                    local HumOwn = game.Players.LocalPlayer.Character.Humanoid
                                    if HumOwn.Health < HumOwn.MaxHealth * 35 / 100 then
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,120,0))
                                    end
    
                                    if HumOwn.Health > HumOwn.MaxHealth * 50 / 100 then
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,DisSeaFarm,0))
                                    end
    
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(40,40,40)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    
                                until not AttackFish or v.Humanoid.Health < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        elseif v.Name == "Terrorshark" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    SeaUseSkill = true
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                    EquipTool(SelectWeapon)
    
                                    local HumOwn = game.Players.LocalPlayer.Character.Humanoid
                                    if HumOwn.Health < HumOwn.MaxHealth * 35 / 100 then
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,120,0))
                                    end
                                    if HumOwn.Health > HumOwn.MaxHealth * 50 / 100 then
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,DisSeaFarm,0))
                                    end
    
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(40,40,40)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                    
                                until not AttackFish or v.Humanoid.Health < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            else
                                SeaUseSkill = false
                            end
    
                        elseif v.Name == "PirateBrigade" then
                            if v:FindFirstChild("Humanoid") and v.Humanoid.Value > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                    EquipTool(SelectWeapon)
    
                                    SeaUseSkill = true
                                    
                                    Tween(v.Engine.CFrame * CFrame.new(0,DisSeaFarm,0))
                                    v.Engine.Size = Vector3.new(60,60,60)
                                    v.Engine.Transparency = 1
                                    v.Engine.CanCollide = false
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                
                                until not AttackFish or v.Humanoid.Value < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
    
                            else
                                SeaUseSkill = false
                            end
                            
                        elseif v.Name == "PirateGrandBrigade" then
                            if v:FindFirstChild("Humanoid") and v.Humanoid.Value > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                    EquipTool(SelectWeapon)
    
                                    SeaUseSkill = true
                                    
                                    Tween(v.Engine.CFrame * CFrame.new(0,DisSeaFarm,0))
                                    v.Engine.Size = Vector3.new(60,120,60)
                                    v.Engine.Transparency = 1
                                    v.Engine.CanCollide = false
                                    v.Humanoid:ChangeState(11)
                                    v.Humanoid:ChangeState(14)
                                
                                until not AttackFish or v.Humanoid.Value < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
    
                            else
                                SeaUseSkill = false
                            end
                        end
                    end
                end)
            end
        end
    end)

    local dest = Tabs.Event:AddToggle("MyToggle", {Title = "Destroy Rock", Default = false })

    dest:OnChanged(function(Value)
        HiddenRock = Value
    end)

    spawn(function()
        while task.wait() do
            if HiddenRock then
                pcall(function()
                    for i,v in pairs(game:GetService('Workspace').Rocks:GetChildren()) do
                        if v:IsA('MeshPart') then
                            if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 250 then
                                v:Destroy()
                            end
                        end
                    end
                end)
            end
        end
    end)

    Tabs.Event:AddButton({
        Title = "Kill Your Self (If Bugs)",
        Description = "Reset Character",
        Callback = function()
            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild('HumanoidRootPart') or v:FindFirstChild('Engine') then
                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 80 or (v.Engine.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 80 then
                        v:Destroy()
                    end
                end
            end
        end
    })

    _G.SeaSkillZ = true
_G.SeaSkillX = true
_G.SeaSkillC = true
_G.SeaSkillV = true
_G.SeaSkillF = true

spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if SeaUseSkill then
                        if type(args[2]) == "vector" then
                            args[2] = SeaMonPosition
                        else
                            args[2] = CFrame.new(SeaMonPosition)
                        end
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)
spawn(function()
    while task.wait() do
        if SeaUseSkill then
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("Engine") and v.Humanoid.Value > 0 then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                if (v.VehicleSeat.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 500 then
                                    --SeaMonPosition = v.Body.Part.Position
                                    SeaMonPosition = v.Sails.Position
                                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon).MousePos.Value = SeaMonPosition
                                        if _G.SeaSkillZ then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
                                        end
                                        if _G.SeaSkillX then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
                                        end
                                        if _G.SeaSkillC then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
                                        end
                                        if _G.SeaSkillV then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                                        end
                                        if _G.SeaSkillF then
                                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                                            wait(.1)
                                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                                        end
                                    end
                                end
                            until not SeaUseSkill or not v.Parent or v.Humanoid.Value < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                        end
                    elseif v.Name == "Shark" or v.Name == "Piranha" or v.Name == "Fish Crew Member" or v.Name == "Terrorshark" then
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 500 then
                                    SeaMonPosition = v.HumanoidRootPart.Position
                                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon).MousePos.Value = SeaMonPosition
                                        if _G.SeaSkillZ then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
                                        end
                                        if _G.SeaSkillX then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
                                        end
                                        if _G.SeaSkillC then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
                                        end
                                        if _G.SeaSkillV then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                                        end
                                        if _G.SeaSkillF then
                                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                                            wait(.1)
                                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                                        end
                                    end
                                end
                            until not SeaUseSkill or not v.Parent or v.Humanoid.Health < 1 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                        end
                    end
                end

                for i,v in pairs (game.Workspace.SeaBeasts:GetChildren()) do
                    if v.Name == "SeaBeast1" then
                        if v:FindFirstChild("HumanoidRootPart") and v.Health.Value > 0 then
                            repeat game:GetService("RunService").Heartbeat:wait()
                                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 500 then
                                    SeaMonPosition = v.HumanoidRootPart.Position
                                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectWeapon).MousePos.Value = SeaMonPosition
                                        if _G.SeaSkillZ then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
                                        end
                                        if _G.SeaSkillX then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
                                        end
                                        if _G.SeaSkillC then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
                                        end
                                        if _G.SeaSkillV then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                                            wait(.1)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                                        end
                                        if _G.SeaSkillF then
                                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                                            wait(.1)
                                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                                        end
                                    end
                                end
                            until not SeaUseSkill or not v.Parent or v.Health.Value < 1 or not game:GetService("Workspace").SeaBeasts:FindFirstChild(v.Name)
                        end 
                    end
                end
            end)
        end
    end
end)
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            if SeaUseSkill then
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
                    if v.Name == "NotificationTemplate" then
                        if string.find(v.Text,"Skill locked!") then
                            v:Destroy()
                        end
                    end
                end
            end
        end)
    end)
end)



    Tabs.Event:AddParagraph({
        Title = "Race V4",
        Content = "Upgrade Race V4"
    })

    local trialaa = Tabs.Event:AddToggle("traa", {Title = "Auto Trials", Default = false })

    trialaa:OnChanged(function(Value)
        AutoCompleteRace = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while task.wait() do
            if AutoCompleteRace then
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                    pcall(function()
                        for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        v.Humanoid.Health = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game:GetService('Players').LocalPlayer,"SimulationRadius",math.huge)
                                    until not AutoCompleteRace or not v.Parent or not game.Workspace.Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    end)
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
                    for i,v in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetDescendants()) do
                        if v.Name ==  "snowisland_Cylinder.081" then
                            TP2(v.CFrame * CFrame.new(0,0,0))
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
                    for i,v in pairs(game:GetService("Workspace").SeaBeasts.SeaBeast1:GetDescendants()) do
                        if v.Name ==  "HumanoidRootPart" then
                            TP2(v.CFrame * CFrame.new(20,450,0))
                            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") then
                                    if v.ToolTip == "Melee" then -- "Blox Fruit" , "Sword" , "Wear" , "Agility"
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") then
                                    if v.ToolTip == "Blox Fruit" then -- "Blox Fruit" , "Sword" , "Wear" , "Agility"
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                    
                            wait(0.5)
                            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") then
                                    if v.ToolTip == "Sword" then -- "Blox Fruit" , "Sword" , "Wear" , "Agility"
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(0.5)
                            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") then
                                    if v.ToolTip == "Gun" then -- "Blox Fruit" , "Sword" , "Wear" , "Agility"
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                    end
                                end
                            end
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            wait(.2)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
                        end
                    end
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                    TP2(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
                    pcall(function()
                        for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        v.Humanoid.Health = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game:GetService('Players').LocalPlayer,"SimulationRadius",math.huge)
                                    until not AutoCompleteRace or not v.Parent or not game.Workspace.Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    end)
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if v.Name == "StartPoint" then
                            TP2(v.CFrame* CFrame.new(0,10,0))
                        end
                    end
                end
            end
        end
    end)

    local godoor = Tabs.Event:AddToggle("door", {Title = "Go To Race Doors", Default = false })

    godoor:OnChanged(function(Value)
        RaceDoors = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
    
    spawn(function()
        while task.wait(.1) do
            if RaceDoors then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
                wait(.5)
                if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
                    Tween(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
                    Tween(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
                    Tween(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
                    Tween(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
                    Tween(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156))
                elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                    Tween(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094))
                end
            end
        end
    end)

    Tabs.Event:AddButton({
        Title = "Temple of Times",
        Description = "",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
    wait(1)
    Tween(CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        end
    })

    Tabs.Event:AddButton({
        Title = "Go To Lever",
        Description = "",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28575.181640625, 14936.6279296875, 72.31636810302734))
            wait(1)
            Tween(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734)) 
        end
    })

    Tabs.Event:AddButton({
        Title = "Ancient One",
        Description = "",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28981.552734375, 14888.4267578125, -120.245849609375))
    wait(1)
    Tween(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375))
        end
    })

    Tabs.Raid:AddParagraph({
        Title = "Island Teleport",
        Content = "Island Teleporting!"
    })

    if First_Sea then
        IslandCheck = {
            "Start Island";
            "Marine Start";
            "Middle Town";
            "Jungle";
            "Pirate Village";
            "Desert";
            "Frozen Village";
            "Marine Ford";
            "Colosseum 1";
            "Sky island 1";
            "Sky island 2";
            "Sky island 3";
            "Sky island 4";
            "Prison";
            "Magma Village";
            "UndeyWater City";
            "Fountain City";
            "House Cyborgs";
            "Shanks Room";
            "Mob Island";
            "Sea Beast";
        }
    elseif Second_Sea then
        IslandCheck = {
            "Dock";
            "Kingdom of Rose";
            "Mansion 1";
            "Flamingo Room";
            "Green Zone";
            "Cafe";
            "Factory";
            "Colosseum 2";
            "Grave Island";
            "Snow Mountain";
            "Cold Island";
            "Hot Island";
            "Cursed Ship";
            "Ice Castle";
            "Forgotten Island";
            "Usoapp Island";
            "Minisky Island";
            "Sea Beast";
        }
    elseif Third_Sea then
        IslandCheck = {
            "Port Town";
            "Hydra Island";
            "Great Tree";
            "Castle on the Sea";
            "Floating Turtle";
            "Mansion 2";
            "Secret Temple";
            "Friendly Arena";
            "Beautiful Pirate Domain";
            "Teler Park";
            "Peanut Island";
            "Chocolate Island";
            "Ice Cream Island";
            "Haunted Castle";
            "Cake Loaf";
            "Candy Cane";
            "Tiki Outpost";
            "Raid Lab";
            "Mini Sky";
            "Sea Beast";
        }
    end

    local rrrddd = Tabs.Raid:AddDropdown("Isisanddd", {
        Title = "Select Island",
        Values = IslandCheck,
        Multi = false,
        Default = 1,
    })

    rrrddd:OnChanged(function(Value)
        SelectedIsland = Value
    end)

    local gotott = Tabs.Raid:AddToggle("MyToggle", {Title = "Teleport To Island", Default = false })

    gotott:OnChanged(function(Value)
        _G.TeleportS = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    local wds = Tabs.Raid:AddToggle("MyToggle", {Title = "Bypass tp", Default = false })

    wds:OnChanged(function(Value)
        BypassTeleport = Value
    end)

    spawn(function()
        while task.wait() do
            pcall(function (...)
                if  _G.TeleportS then
                    if SelectedIsland == "Start Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(1071.2832, 16.3085976, 1426.86792))
                        else
                            Tween(CFrame.new(1071.2832, 16.3085976, 1426.86792))
                        end
                    elseif SelectedIsland == "Marine Start" then
                        if BypassTeleport then
                            BTP(CFrame.new(-2573.3374, 6.88881969, 2046.99817))
                        else
                            Tween(CFrame.new(-2573.3374, 6.88881969, 2046.99817))
                        end
                    elseif SelectedIsland == "Middle Town" then
                        if BypassTeleport then
                            BTP(CFrame.new(-655.824158, 7.88708115, 1436.67908))
                        else
                            Tween(CFrame.new(-655.824158, 7.88708115, 1436.67908))
                        end
                    elseif SelectedIsland == "Jungle" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1249.77222, 11.8870859, 341.356476))
                        else
                            Tween(CFrame.new(-1249.77222, 11.8870859, 341.356476))
                        end
                    elseif SelectedIsland == "Pirate Village" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1122.34998, 4.78708982, 3855.91992))
                        else
                            Tween(CFrame.new(-1122.34998, 4.78708982, 3855.91992))
                        end
                    elseif SelectedIsland == "Desert" then
                        if BypassTeleport then
                            BTP(CFrame.new(1094.14587, 6.47350502, 4192.88721))
                        else
                            Tween(CFrame.new(1094.14587, 6.47350502, 4192.88721))
                        end
                    elseif SelectedIsland == "Frozen Village" then
                        if BypassTeleport then
                            BTP(CFrame.new(1198.00928, 27.0074959, -1211.73376))
                        else
                            Tween(CFrame.new(1198.00928, 27.0074959, -1211.73376))
                        end
                    elseif SelectedIsland == "Marine Ford" then
                        if BypassTeleport then
                            BTP(CFrame.new(-4505.375, 20.687294, 4260.55908))
                        else
                            Tween(CFrame.new(-4505.375, 20.687294, 4260.55908))
                        end
                    elseif SelectedIsland == "Colosseum 1" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1428.35474, 7.38933945, -3014.37305))
                        else
                            Tween(CFrame.new(-1428.35474, 7.38933945, -3014.37305))
                        end
                    elseif SelectedIsland == "Sky island 1" then
                        if BypassTeleport then
                            BTP(CFrame.new(-4970.21875, 717.707275, -2622.35449))
                        else
                            Tween(CFrame.new(-4970.21875, 717.707275, -2622.35449))
                        end
                    elseif SelectedIsland == "Sky island 2" then
                        if BypassTeleport then
                            BTP(CFrame.new(-4813.0249, 903.708557, -1912.69055))
                        else
                            Tween(CFrame.new(-4813.0249, 903.708557, -1912.69055))
                        end
                    elseif SelectedIsland == "Sky island 3" then
                        if BypassTeleport then
                            BTP(CFrame.new(-7952.31006, 5545.52832, -320.704956))
                        else
                            Tween(CFrame.new(-7952.31006, 5545.52832, -320.704956))
                        end
                    elseif SelectedIsland == "Sky island 4" then
                        if BypassTeleport then
                            BTP(CFrame.new(-7793.43896, 5607.22168, -2016.58362))
                        else
                            Tween(CFrame.new(-7793.43896, 5607.22168, -2016.58362))
                        end
                    elseif SelectedIsland == "Prison" then
                        if BypassTeleport then
                            BTP(CFrame.new(4854.16455, 5.68742752, 740.194641))
                        else
                            Tween(CFrame.new(4854.16455, 5.68742752, 740.194641))
                        end
                    elseif SelectedIsland == "Magma Village" then
                        if BypassTeleport then
                            BTP(CFrame.new(-5231.75879, 8.61593437, 8467.87695))
                        else
                            Tween(CFrame.new(-5231.75879, 8.61593437, 8467.87695))
                        end
                    elseif SelectedIsland == "UndeyWater City" then
                        if BypassTeleport then
                            BTP(CFrame.new(61163.8516, 11.7796879, 1819.78418))
                        else
                            Tween(CFrame.new(61163.8516, 11.7796879, 1819.78418))
                        end
                    elseif SelectedIsland == "Fountain City" then
                        if BypassTeleport then
                            TP2(CFrame.new(5132.7124, 4.53632832, 4037.8562))
                        else
                            Tween(CFrame.new(5132.7124, 4.53632832, 4037.8562))
                        end
                    elseif SelectedIsland == "House Cyborgs" then
                        if BypassTeleport then
                            BTP(CFrame.new(6262.72559, 71.3003616, 3998.23047))
                        else
                            Tween(CFrame.new(6262.72559, 71.3003616, 3998.23047))
                        end
                    elseif SelectedIsland == "Shanks Room" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
                        else
                            Tween(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
                        end
                    elseif SelectedIsland == "Mob Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
                        else
                            Tween(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
                        end
                    elseif SelectedIsland == "Dock" then
                        if BypassTeleport then
                            BTP(CFrame.new(82.9490662, 18.0710983, 2834.98779))
                        else
                            Tween(CFrame.new(82.9490662, 18.0710983, 2834.98779))
                        end
                    elseif SelectedIsland == "Kingdom of Rose" then
                        if BypassTeleport then
                            BTP(CFrame.new(-394.983521, 118.503128, 1245.8446))
                        else
                            Tween(CFrame.new(-394.983521, 118.503128, 1245.8446))
                        end
                    elseif SelectedIsland == "Mansion 1" then
                        if BypassTeleport then
                            BTP(CFrame.new(-390.096313, 331.886475, 673.464966))
                        else
                            Tween(CFrame.new(-390.096313, 331.886475, 673.464966))
                        end
                    elseif SelectedIsland == "Flamingo Room" then
                        if BypassTeleport then
                            BTP(CFrame.new(2302.19019, 15.1778421, 663.811035))
                        else
                            Tween(CFrame.new(2302.19019, 15.1778421, 663.811035))
                        end
                    elseif SelectedIsland == "Green Zone" then
                        if BypassTeleport then
                            BTP(CFrame.new(-2372.14697, 72.9919434, -3166.51416))
                        else
                            Tween(CFrame.new(-2372.14697, 72.9919434, -3166.51416))
                        end
                    elseif SelectedIsland == "Cafe" then
                        if BypassTeleport then
                            BTP(CFrame.new(-385.250916, 73.0458984, 297.388397))
                        else
                            Tween(CFrame.new(-385.250916, 73.0458984, 297.388397))
                        end
                    elseif SelectedIsland == "Factory" then
                        if BypassTeleport then
                            BTP(CFrame.new(430.42569, 210.019623, -432.504791))
                        else
                            Tween(CFrame.new(430.42569, 210.019623, -432.504791))
                        end
                    elseif SelectedIsland == "Colosseum 2" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1836.58191, 44.5890656, 1360.30652))
                        else
                            Tween(CFrame.new(-1836.58191, 44.5890656, 1360.30652))
                        end
                    elseif SelectedIsland == "Grave Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-5411.47607, 48.8234024, -721.272522))
                        else
                            Tween(CFrame.new(-5411.47607, 48.8234024, -721.272522))
                        end
                    elseif SelectedIsland == "Snow Mountain" then
                        if BypassTeleport then
                            BTP(CFrame.new(511.825226, 401.765198, -5380.396))
                        else
                            Tween(CFrame.new(511.825226, 401.765198, -5380.396))
                        end
                    elseif SelectedIsland == "Cold Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-6026.96484, 14.7461271, -5071.96338))
                        else
                            Tween(CFrame.new(-6026.96484, 14.7461271, -5071.96338))
                        end
                    elseif SelectedIsland == "Hot Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
                        else
                            Tween(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
                        end
                    elseif SelectedIsland == "Cursed Ship" then
                        if BypassTeleport then
                            BTP(CFrame.new(902.059143, 124.752518, 33071.8125))
                        else
                            Tween(CFrame.new(902.059143, 124.752518, 33071.8125))
                        end
                    elseif SelectedIsland == "Ice Castle" then
                        if BypassTeleport then
                            BTP(CFrame.new(5400.40381, 28.21698, -6236.99219))
                        else
                            Tween(CFrame.new(5400.40381, 28.21698, -6236.99219))
                        end
                    elseif SelectedIsland == "Forgotten Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-3043.31543, 238.881271, -10191.5791))
                        else
                            Tween(CFrame.new(-3043.31543, 238.881271, -10191.5791))
                        end
                    elseif SelectedIsland == "Usoapp Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(4748.78857, 8.35370827, 2849.57959))
                        else
                            Tween(CFrame.new(4748.78857, 8.35370827, 2849.57959))
                        end
                    elseif SelectedIsland == "Minisky Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-260.358917, 49325.7031, -35259.3008))
                        else
                            Tween(CFrame.new(-260.358917, 49325.7031, -35259.3008))
                        end
                    elseif SelectedIsland == "Port Town" then
                        if BypassTeleport then
                            BTP(CFrame.new(-610.309692, 57.8323097, 6436.33594))
                        else
                            Tween(CFrame.new(-610.309692, 57.8323097, 6436.33594))
                        end
                    elseif SelectedIsland == "Hydra Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(5229.99561, 603.916565, 345.154022))
                        else
                            Tween(CFrame.new(5229.99561, 603.916565, 345.154022))
                        end
                    elseif SelectedIsland == "Great Tree" then
                        if BypassTeleport then
                            BTP(CFrame.new(2174.94873, 28.7312393, -6728.83154))
                        else
                            Tween(CFrame.new(2174.94873, 28.7312393, -6728.83154))
                        end
                    elseif SelectedIsland == "Castle on the Sea" then
                        if BypassTeleport then
                            BTP(CFrame.new(-5477.62842, 313.794739, -2808.4585))
                        else
                            Tween(CFrame.new(-5477.62842, 313.794739, -2808.4585))
                        end
                    elseif SelectedIsland == "Floating Turtle" then
                        if BypassTeleport then
                            BTP(CFrame.new(-10919.2998, 331.788452, -8637.57227))
                        else
                            Tween(CFrame.new(-10919.2998, 331.788452, -8637.57227))
                        end
                    elseif SelectedIsland == "Mansion 2" then
                        if BypassTeleport then
                            BTP(CFrame.new(-12553.8125, 332.403961, -7621.91748))
                        else
                            Tween(CFrame.new(-12553.8125, 332.403961, -7621.91748))
                        end
                    elseif SelectedIsland == "Secret Temple" then
                        if BypassTeleport then
                            BTP(CFrame.new(5217.35693, 6.56511116, 1100.88159))
                        else
                            Tween(CFrame.new(5217.35693, 6.56511116, 1100.88159))
                        end
                    elseif SelectedIsland == "Friendly Arena" then
                        if BypassTeleport then
                            BTP(CFrame.new(5220.28955, 72.8193436, -1450.86304))
                        else
                            Tween(CFrame.new(5220.28955, 72.8193436, -1450.86304))
                        end
                    elseif SelectedIsland == "Beautiful Pirate Domain" then
                        if BypassTeleport then
                            BTP(CFrame.new(5310.8095703125, 21.594484329224, 129.39053344727))
                        else
                            Tween(CFrame.new(5310.8095703125, 21.594484329224, 129.39053344727))
                        end
                    elseif SelectedIsland == "Teler Park" then
                        if BypassTeleport then
                            BTP(CFrame.new(-9512.3623046875, 142.13258361816, 5548.845703125))
                        else
                            Tween(CFrame.new(-9512.3623046875, 142.13258361816, 5548.845703125))
                        end
                    elseif SelectedIsland == "Peanut Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-2142, 48, -10031))
                        else
                            Tween(CFrame.new(-2142, 48, -10031))
                        end
                    elseif SelectedIsland == "Chocolate Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(156.896484, 30.5935211, -12662.7031, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219))
                        else
                            Tween(CFrame.new(156.896484, 30.5935211, -12662.7031, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219))
                        end
                    elseif SelectedIsland == "Ice Cream Island" then
                        if BypassTeleport then
                            BTP(CFrame.new(-949, 59, -10907))
                        else
                            Tween(CFrame.new(-949, 59, -10907))
                        end
                    elseif SelectedIsland == "Haunted Castle" then
                        if BypassTeleport then
                            BTP(CFrame.new(-9530.61035, -132.860657, 5763.13477))
                        else
                            Tween(CFrame.new(-9530.61035, -132.860657, 5763.13477))
                        end
                    elseif SelectedIsland == "Cake Loaf" then
                        if BypassTeleport then
                            BTP(CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574))
                        else
                            Tween(CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574))
                        end
                    elseif SelectedIsland == "Candy Cane" then
                        if BypassTeleport then
                            BTP(CFrame.new(-1530.97144, 13.728817, -14770.0889, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359))
                        else
                            Tween(CFrame.new(-1530.97144, 13.728817, -14770.0889, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359))
                        end
                    elseif SelectedIsland == "Tiki Outpost" then
                        if BypassTeleport then
                            BTP(CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566))
                        else
                            Tween(CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566))
                        end
                    elseif SelectedIsland == "Raid Lab" then
                        if BypassTeleport then
                            BTP(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
                        else
                            Tween(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
                        end
                    elseif SelectedIsland == "Mini Sky" then
                        if BypassTeleport then
                            BTP(CFrame.new(-263.66668701172, 49325.49609375, -35260))
                        else
                            Tween(CFrame.new(-263.66668701172, 49325.49609375, -35260))
                        end
                    elseif SelectedIsland == "Sea Beast" then
                        Tween(game:GetService("Workspace")["_WorldOrigin"].Locations["Sea of Treats"].CFrame)
                    end
            end
        end)
        end
    end)


    Tabs.Raid:AddParagraph({
        Title = "Auto Raid",
        Content = "Auto Raid Dungeon",
    })

    local Chips = {"Flame","Ice","Quake","Light","Dark","Spider","Rumble","Magma","Buddha","Sand","Phoenix","Dough"}

    local wdcc = Tabs.Raid:AddDropdown("cccchip", {
        Title = "Select Chip",
        Values = Chips,
        Multi = false,
        Default = 1,
    })

    wdcc:OnChanged(function(Value)
        SelectChip = Value
    end)

    local buyc = Tabs.Raid:AddToggle("Buy chip", {Title = "Auto Buy Chips", Default = false })

    buyc:OnChanged(function(Value)
        AutoBuySpecialChip = Value
    end)

    spawn(function()
        while task.wait() do
            if AutoBuySpecialChip then
                if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc","Select",SelectChip)
                end
            end
        end
    end)

    local strr = Tabs.Raid:AddToggle("Start Raid", {Title = "Auto Start Raid", Default = false })

    strr:OnChanged(function(Value)
        AutoSTartRaids = Value
    end)

    spawn(function()
        while task.wait() do
            if AutoSTartRaids then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") then
                    if World2 then
                        fireclickdetector(game.Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                    elseif World3 then
                        local plr = game:GetService("Players").LocalPlayer
                        local RaidLab = CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469)
                        if (RaidLab.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 10 then
                            Tween(RaidLab)
                        elseif (RaidLab.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10 then
                            wait(1)
                            fireclickdetector(game.Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                        end
                    end
                end
            end
        end
    end)

    local kaa = Tabs.Raid:AddToggle("Kill Aura", {Title = "Kill Aura", Default = false })

    kaa:OnChanged(function(Value)
        RaidAura = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        game:GetService("RunService").Heartbeat:Connect(function()
            if RaidAura then
                local RegisterAttack = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]
                local RegisterHit = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterHit"]
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
                    pcall(function()
                        for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeaponRaid)
                                        v.Humanoid.Health = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game:GetService('Players').LocalPlayer,"SimulationRadius",math.huge)
                                    until not RaidAura or not v.Parent or not game.Workspace.Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end)
    local nextis = Tabs.Raid:AddToggle("Next Island", {Title = "Next Island", Default = false })

    nextis:OnChanged(function(Value)
        AutoNextIsland = Value
        if Value == false then
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)

    spawn(function()
        while wait() do
            if AutoNextIsland then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
                    if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
                        if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                            Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame*CFrame.new(0,DisRaid,0))
                        end
                    elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
                        if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                            Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame*CFrame.new(0,DisRaid,0))
                        end
                    elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
                        if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                            Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame*CFrame.new(0,DisRaid,0))
                        end
                    elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
                        if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                            Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame*CFrame.new(0,DisRaid,0))
                        end
                    elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                        if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                            Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame*CFrame.new(0,DisRaid,0))
                        end
                    end
                end
            end
        end
    end)

    local awaa = Tabs.Raid:AddToggle("awakenaa", {Title = "Auto Awaken", Default = false })

    awaa:OnChanged(function(Value)
        AutoAwakenAbilities = Value
    end)

    spawn(function()
        while wait() do
            if AutoAwakenAbilities then
                local args1 = {
                    [1] = "Awakener",
                    [2] = "Check"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
                local args2 = {
                    [1] = "Awakener",
                    [2] = "Awaken"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args2))
            end
        end
    end)

    
    Tabs.Raid:AddButton({
        Title = "Teleport To Lab",
        Description = "Very important button",
        Callback = function()
            if Second_Sea then
                Tween(CFrame.new(-6449.68896, 249.56958, -4497.59326, 0.69785428, 5.60444446e-09, -0.71623975, -2.18662333e-09, 1, 5.69432235e-09, 0.71623975, -2.40766074e-09, 0.69785428))
            elseif Third_Sea then
                Tween(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
            end
        end
    })

    Tabs.Raid:AddParagraph({
        Title = "Stats",
        Content = "Auto Add Stats"
    })


    Points = 1

    local Toggle2 = Tabs.Raid:AddToggle("mee", {Title = "Melee", Default = false })

    Toggle2:OnChanged(function(Value)
        Melee_A = Value
    end)

    local Toggle3 = Tabs.Raid:AddToggle("def", {Title = "Defense", Default = false })

    Toggle3:OnChanged(function(Value)
        Defense_A = Value
    end)

    local Toggle4 = Tabs.Raid:AddToggle("sw", {Title = "Sword", Default = false })

    Toggle4:OnChanged(function(Value)
        Sword_A = Value
    end)

    local Toggle5 = Tabs.Raid:AddToggle("gun", {Title = "Gun", Default = false })

    Toggle5:OnChanged(function(Value)
        Gun_A = Value
    end)

    local Toggle6 = Tabs.Raid:AddToggle("df", {Title = "Fruit", Default = false })

    Toggle6:OnChanged(function(Value)
        Fruit_A = Value
    end)

    spawn(function()
        while task.wait(0.5) do
            if Melee_A then
                if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", Points)
                end
            end
        end
    end)
    
    spawn(function()
        while task.wait(0.5) do
            if Defense_A then
                if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", Points)
                end
            end
        end
    end)
    
    spawn(function()
        while task.wait(0.5) do
            if Sword_A then
                if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", Points)
                end
            end
        end
    end)
    
    spawn(function()
        while task.wait(0.5) do
            if Gun_A then
                if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", Points)
                end
            end
        end
    end)
    
    spawn(function()
        while wait(0.5) do
            if Fruit_A then
                if game:GetService("Players").LocalPlayer.Data.Points.Value > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", Points)
                end
            end
        end
    end)

    local Main = Tabs.Shop:AddSection("Auto Buyer Abilities")
Tabs.Shop:AddButton({
    Title = "Buy Geppo [$10,000 Beli]",
    Description = "ซื้อเดินชมจันทร์",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Buso Haki [$25,000 Beli]",
    Description = "ซื้อฮาคิเกราะ",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Soru [$25,000 Beli]",
    Description = "ซื้อโซล",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Observation Haki [$750,000 Beli]",
    Description = "ซื้อฮาคิสังเกตุ",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
    end
})
local Main = Tabs.Shop:AddSection("Auto Buyer Melee")
Tabs.Shop:AddButton({
    Title = "Buy Black Leg [$150,000 Beli]",
    Description = "ซื้อขาดำ V1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Electro [$550,000 Beli]",
    Description = "ซื้อหมัดสายฟ้า V1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Fishman Karate [$750,000 Beli]",
    Description = "ซื้อหมัดมนุษย์เงือก V1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Dragon Claw [$1,500 Fragments]",
    Description = "ซื้อหมัดมังกร V1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Superhuman [$3,000,000 Beli]",
    Description = "ซื้อหมัดชุปเปอร์ฮิวเมน V1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Death Step [$5,000 Fragments + $5,000,000 Beli]",
    Description = "ซื้อขาดำ V2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Sharkman Karate [$5,000 Fragments + $2,500,000 Beli]",
    Description = "ซื้อหมัดมนุษย์เงือก V2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Electric Claw [$5,000 Fragments + $3,000,000 Beli]",
    Description = "ซื้อหมัดสายฟ้า V2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Dragon Talon [$5,000 Fragments + $3,000,000 Beli]",
    Description = "ซื้อหมัดมังกร V2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy God Human [$5,000 Fragments + $5,000,000 Beli]",
    Description = "ซื้อหมัดก็อตฮิวเมน V2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Sanguine Art [$5,000 Fragments + $5,000,000 Beli]",
    Description = "ซื้อหมัดแวมไพร์",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})

local Main = Tabs.Shop:AddSection("Auto Buyer Sword")
Tabs.Shop:AddButton({
    Title = "Buy Cutlass [$1,000 Beli]",
    Description = "ซื้อมีดสั้น",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
    end
})
Tabs.Shop:AddButton({
    Title = "Buy Katana [$1,000 Beli]",
    Description = "ซื้อดาบคาตานะ",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อกระบองเหล็ก",
    Description = "Buy Iron Mace [$25,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อดาบคาตานะคู่",
    Description = "Buy Dual Katana [$12,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อดาบทริปเปิลคาตานะ",
    Description = "Buy Triple Katana [$60,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อท่อ",
    Description = "Buy Pipe [$100,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อใบมีดสองหัว",
    Description = "Buy Dual-Headed Blade [$400,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อดาบหนวดขาว",
    Description = "Buy Bisento [$1,200,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อไม้เท้าวิญญาณ",
    Description = "Buy Soul Cane [$750,000 Beli]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
    end
})
Tabs.Shop:AddButton({
    Title = "ซื้อโพ V2",
    Description = "Buy Pole V2 [5,000 Fragments]",
    Callback = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end
})


setfpscap(9999)
        
                _G.DeleteAttackFx = true
                if _G.DeleteAttackFx == true then
                    for i, v in pairs(game.Workspace["_WorldOrigin"]:GetChildren()) do
                        if v.Name == "CurvedRing" or v.Name == "SlashHit" or v.Name == "SwordSlash" or v.Name == "Sounds" then
                            v:Destroy() 
                        end
                    end
                end
        
                _G.StopNPC = true
                    spawn(function()
                        while game:GetService("RunService").RenderStepped:wait() do
                        if _G.StopNPC then
                            pcall(function ()
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                                if v.Name == "Humanoid" then
                                v.PlatformStand = true
                                end
                            end
                        end)
                        end
                    end
                    end)
                    
                    SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

-- Call the function in a loop with a 0.01-second delay

local env = getgenv()
local rs = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local client = players.LocalPlayer
local net = rs:WaitForChild("Modules"):WaitForChild("Net")
local RegisterAttack = net:WaitForChild("RE/RegisterAttack")
local RegisterHit = net:WaitForChild("RE/RegisterHit")
local enemyFolder = workspace:WaitForChild("Enemies")
local run = game:GetService("RunService")

local AttackModule = {
    HitID = tostring(math.random(100000,999999)),
    _loop = nil,
    FrozenEnemies = {},
    LastAttack = 0,
    Delay = 0.05,
    NormalDelay = 0.05,
}

local function IsAlive(char)
    local h = char and char:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function FreezeEnemy(e)
    if not e or AttackModule.FrozenEnemies[e] then return end
    local h = e:FindFirstChildOfClass("Humanoid")
    local r = e:FindFirstChild("HumanoidRootPart")
    if h and r then
        AttackModule.FrozenEnemies[e] = true
        h.WalkSpeed, h.JumpPower, r.Anchored = 0, 0, true
        for _,v in ipairs(e:GetDescendants()) do
            if v:IsA("BodyMover") then v:Destroy() end
        end
    end
end

local function UnfreezeEnemy(e)
    if not e or not AttackModule.FrozenEnemies[e] then return end
    local h = e:FindFirstChildOfClass("Humanoid")
    local r = e:FindFirstChild("HumanoidRootPart")
    if h and r then
        AttackModule.FrozenEnemies[e] = nil
        h.WalkSpeed, h.JumpPower, r.Anchored = 16, 50, false
    end
end

local function AttackAll()
    if not client.Character or not IsAlive(client.Character) then return end
    if os.clock() - AttackModule.LastAttack < AttackModule.Delay then return end
    AttackModule.LastAttack = os.clock()
    
    for _, e in ipairs(enemyFolder:GetChildren()) do
        if env.freezeenemies then 
            FreezeEnemy(e) 
        end
        
        local p = e:FindFirstChild("HumanoidRootPart") or e:FindFirstChild("Head") or e:FindFirstChild("UpperTorso")
        if p and IsAlive(e) then
            RegisterAttack:FireServer(0)
            RegisterHit:FireServer(p, {[1] = e, [2] = p, [4] = AttackModule.HitID})
            
            if env.freezeenemies then
                UnfreezeEnemy(e) -- Unfreeze the enemy after attacking
            end
        end
    end
end

-- Initialize environment variables if they don't exist
env.fastattack = env.fastattack or false
env.freezeenemies = env.freezeenemies or false
env.fastest = env.fastest or false

-- Create the heartbeat connection
AttackModule._loop = run.Heartbeat:Connect(function()
    if not env.fastattack then
        if AttackModule._loop then 
            AttackModule._loop:Disconnect() 
            AttackModule._loop = nil 
        end
        return
    end
    AttackAll()
end)

return {
    Toggle = function(s)
        env.fastattack = s
        if s and not AttackModule._loop then
            AttackModule._loop = run.Heartbeat:Connect(function()
                if env.fastattack then
                    AttackAll()
                end
            end)
        elseif not s and AttackModule._loop then
            AttackModule._loop:Disconnect()
            AttackModule._loop = nil
        end
    end,
    SetFastest = function(s)
        env.fastest = s
        if s then
            AttackModule.Delay = 0.03
        else
            AttackModule.Delay = AttackModule.NormalDelay
        end
    end,
    SetFreeze = function(s) 
        env.freezeenemies = s 
    end,
    SetDelay = function(d)
        AttackModule.Delay = d
        AttackModule.NormalDelay = d
    end
}
