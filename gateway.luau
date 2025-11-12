local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")

local function fastwait(t)
	if t and t > 0 then task.wait(t) else task.wait() end
end

local function safeCreate(class, props, parent)
	local inst = Instance.new(class)
	for k,v in pairs(props or {}) do inst[k] = v end
	if parent then inst.Parent = parent end
	return inst
end

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local isTablet = false
if isMobile then
	local viewportSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
	isTablet = math.min(viewportSize.X, viewportSize.Y) > 700
end

local function getResponsiveSize()
	if isMobile then
		if isTablet then
			return UDim2.new(0.85, 0, 0.8, 0)
		else
			return UDim2.new(0.95, 0, 0.85, 0)
		end
	else
		return UDim2.new(0, 700, 0, 500)
	end
end

local SupportedGames = {
	[90462358603255] = "Anime Eternal"
}

local player = Players.LocalPlayer
local LoaderGui = safeCreate("ScreenGui", {Name = "SindexLoader", ResetOnSpawn = false, DisplayOrder = 10, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, CoreGui)

local Main = safeCreate("Frame", {Size = getResponsiveSize(), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(10,10,15), BackgroundTransparency = 1, ClipsDescendants = true}, LoaderGui)

local MainContainer = safeCreate("Frame", {Size = UDim2.new(1, -40, 1, -40), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18,18,28), BackgroundTransparency = 1}, Main)
safeCreate("UICorner", {CornerRadius = UDim.new(0, 24)}, MainContainer)

local ContainerStroke = safeCreate("UIStroke", {
	Color = Color3.fromRGB(120,70,200),
	Thickness = 3,
	Transparency = 1,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border
}, MainContainer)

local GlowEffect = safeCreate("ImageLabel", {
	Size = UDim2.new(1, 80, 1, 80),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	Image = "rbxassetid://8992231224",
	ImageColor3 = Color3.fromRGB(100,50,180),
	ScaleType = Enum.ScaleType.Slice,
	SliceScale = 0.02,
	SliceCenter = Rect.new(256,256,256,256),
	ImageTransparency = 1,
	ZIndex = 0
}, MainContainer)

local LogoContainer = safeCreate("Frame", {Size = UDim2.new(1, 0, 0, 120), Position = UDim2.new(0, 0, 0.1, 0), BackgroundTransparency = 1}, MainContainer)

local LogoText = safeCreate("TextLabel", {
	Size = UDim2.new(1, 0, 0, 60),
	Position = UDim2.new(0.5, 0, 0, 0),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundTransparency = 1,
	Text = "PROJECT SINDEX",
	TextColor3 = Color3.new(1,1,1),
	FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
	TextSize = 42,
	TextTransparency = 1,
	TextStrokeTransparency = 0.8,
	TextStrokeColor3 = Color3.fromRGB(140,80,220)
}, LogoContainer)

local LogoGradient = safeCreate("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255,180,255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,120,240)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160,80,220))
	})
}, LogoText)

local Subtitle = safeCreate("TextLabel", {
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.new(0.5, 0, 0, 70),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundTransparency = 1,
	Text = "PREMIUM EXPERIENCE • ELITE PERFORMANCE",
	TextColor3 = Color3.fromRGB(180,180,220),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 14,
	TextTransparency = 1
}, LogoContainer)

local LoadingBarContainer = safeCreate("Frame", {
	Size = UDim2.new(0.8, 0, 0, 20),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(30,30,45),
	BackgroundTransparency = 1,
	ZIndex = 3
}, MainContainer)
safeCreate("UICorner", {CornerRadius = UDim.new(1, 0)}, LoadingBarContainer)

local BarStroke = safeCreate("UIStroke", {
	Color = Color3.fromRGB(80,80,120),
	Thickness = 2,
	Transparency = 1
}, LoadingBarContainer)

local LoadingBar = safeCreate("Frame", {
	Size = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(140,80,220),
	BackgroundTransparency = 1,
	ZIndex = 3
}, LoadingBarContainer)
safeCreate("UICorner", {CornerRadius = UDim.new(1, 0)}, LoadingBar)

local BarGradient = safeCreate("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(200,120,255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(140,80,220))
	})
}, LoadingBar)

local BarGlow = safeCreate("ImageLabel", {
	Size = UDim2.new(1, 20, 1, 20),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	Image = "rbxassetid://8992231224",
	ImageColor3 = Color3.fromRGB(180,100,240),
	ScaleType = Enum.ScaleType.Slice,
	SliceScale = 0.02,
	SliceCenter = Rect.new(256,256,256,256),
	ImageTransparency = 1,
	ZIndex = 2
}, LoadingBar)

local StatusText = safeCreate("TextLabel", {
	Size = UDim2.new(0.8, 0, 0, 20),
	Position = UDim2.new(0.5, 0, 0.5, 40),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundTransparency = 1,
	Text = "Initializing...",
	TextColor3 = Color3.fromRGB(200,200,230),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 16,
	TextTransparency = 1,
	ZIndex = 3
}, MainContainer)

local InfoContainer = safeCreate("Frame", {
	Size = UDim2.new(0.8, 0, 0, 120),
	Position = UDim2.new(0.5, 0, 0.75, 0),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundColor3 = Color3.fromRGB(25,25,38),
	BackgroundTransparency = 1,
	ZIndex = 3
}, MainContainer)
safeCreate("UICorner", {CornerRadius = UDim.new(0, 16)}, InfoContainer)

local InfoStroke = safeCreate("UIStroke", {
	Color = Color3.fromRGB(80,80,120),
	Thickness = 2,
	Transparency = 1
}, InfoContainer)

local UsernameLabel = safeCreate("TextLabel", {
	Size = UDim2.new(1, -20, 0, 25),
	Position = UDim2.new(0, 10, 0, 10),
	BackgroundTransparency = 1,
	Text = "Username: ...",
	TextColor3 = Color3.fromRGB(180,180,220),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 14,
	TextTransparency = 1,
	TextXAlignment = Enum.TextXAlignment.Left
}, InfoContainer)

local ExecutorLabel = safeCreate("TextLabel", {
	Size = UDim2.new(1, -20, 0, 25),
	Position = UDim2.new(0, 10, 0, 35),
	BackgroundTransparency = 1,
	Text = "Executor: ...",
	TextColor3 = Color3.fromRGB(180,180,220),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 14,
	TextTransparency = 1,
	TextXAlignment = Enum.TextXAlignment.Left
}, InfoContainer)

local PlaceIdLabel = safeCreate("TextLabel", {
	Size = UDim2.new(1, -20, 0, 25),
	Position = UDim2.new(0, 10, 0, 60),
	BackgroundTransparency = 1,
	Text = "Place ID: ...",
	TextColor3 = Color3.fromRGB(180,180,220),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 14,
	TextTransparency = 1,
	TextXAlignment = Enum.TextXAlignment.Left
}, InfoContainer)

local GameNameLabel = safeCreate("TextLabel", {
	Size = UDim2.new(1, -20, 0, 25),
	Position = UDim2.new(0, 10, 0, 85),
	BackgroundTransparency = 1,
	Text = "Game: ...",
	TextColor3 = Color3.fromRGB(180,180,220),
	FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
	TextSize = 14,
	TextTransparency = 1,
	TextXAlignment = Enum.TextXAlignment.Left
}, InfoContainer)

local FloatingOrbs = safeCreate("Frame", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 1
}, MainContainer)

local function createFloatingOrbs()
	local orbs = {}
	local colors = {
		Color3.fromRGB(120,70,200),
		Color3.fromRGB(200,100,220),
		Color3.fromRGB(160,90,230),
		Color3.fromRGB(140,80,210)
	}
	
	for i = 1, 8 do
		local orb = safeCreate("Frame", {
			Size = UDim2.new(0, math.random(6,12), 0, math.random(6,12)),
			Position = UDim2.new(math.random(), 0, math.random(), 0),
			BackgroundTransparency = 1,
			BackgroundColor3 = colors[math.random(1, #colors)],
			ZIndex = 1
		}, FloatingOrbs)
		safeCreate("UICorner", {CornerRadius = UDim.new(1, 0)}, orb)
		
		table.insert(orbs, orb)
	end
	return orbs
end

local Orbs = createFloatingOrbs()

local function makeDraggable(frame)
	local dragging = false
	local dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

makeDraggable(Main)

local function animateOrbs(orbs)
	for _, orb in ipairs(orbs) do
		coroutine.wrap(function()
			while orb.Parent do
				local targetPos = UDim2.new(math.random(), 0, math.random(), 0)
				local duration = math.random(20, 30) / 10
				
				TweenService:Create(orb, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Position = targetPos,
					BackgroundTransparency = 0.3
				}):Play()
				
				fastwait(duration / 2)
				TweenService:Create(orb, TweenInfo.new(duration / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()
				
				fastwait(duration / 2)
			end
		end)()
	end
end

local function updateProgress(progress, message)
	StatusText.Text = message
	TweenService:Create(LoadingBar, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.new(progress / 100, 0, 1, 0)
	}):Play()
	
	if progress % 25 == 0 then
		TweenService:Create(BarGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageTransparency = 0.6
		}):Play()
	end
end

local function animateIn()
	local t = 0.8
	
	TweenService:Create(Main, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(MainContainer, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(ContainerStroke, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Transparency = 0
	}):Play()
	
	TweenService:Create(GlowEffect, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		ImageTransparency = 0.7
	}):Play()
	
	TweenService:Create(LogoText, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	TweenService:Create(Subtitle, TweenInfo.new(t + 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0.3
	}):Play()
	
	TweenService:Create(LoadingBarContainer, TweenInfo.new(t + 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(BarStroke, TweenInfo.new(t + 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Transparency = 0
	}):Play()
	
	TweenService:Create(LoadingBar, TweenInfo.new(t + 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(StatusText, TweenInfo.new(t + 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	animateOrbs(Orbs)
	
	fastwait(0.5)
	
	updateProgress(25, "Checking Game Support")
	fastwait(1.2)
	
	if not SupportedGames[game.PlaceId] then
		updateProgress(100, "Game Not Supported - Closing")
		fastwait(1.5)
		
		local t2 = 0.6
		TweenService:Create(Main, TweenInfo.new(t2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1
		}):Play()
		
		TweenService:Create(MainContainer, TweenInfo.new(t2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1
		}):Play()
		
		fastwait(t2)
		LoaderGui:Destroy()
		return
	end
	
	updateProgress(50, "Game Supported - Loading Info")
	
	UsernameLabel.Text = "Username: " .. player.Name
	ExecutorLabel.Text = "Executor: " .. identifyexecutor()
	PlaceIdLabel.Text = "Place ID: " .. game.PlaceId
	GameNameLabel.Text = "Game: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name
	
	TweenService:Create(InfoContainer, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(InfoStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Transparency = 0
	}):Play()
	
	TweenService:Create(UsernameLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	TweenService:Create(ExecutorLabel, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	TweenService:Create(PlaceIdLabel, TweenInfo.new(1.0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	TweenService:Create(GameNameLabel, TweenInfo.new(1.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	fastwait(1.5)
	
	updateProgress(75, "Loading Game Script")
	fastwait(1.2)
	
	updateProgress(100, "Ready - Executing")
	fastwait(1.0)
	
	if game.PlaceId == 90462358603255 then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/ProjectSindex/refs/heads/main/AnimeEternal.lua"))()
	else 
       game:GetService("Players").LocalPlayer:Kick("Game Not Supported")
	end
	
	local t3 = 0.8
	TweenService:Create(Main, TweenInfo.new(t3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	}):Play()
	
	TweenService:Create(MainContainer, TweenInfo.new(t3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	}):Play()
	
	TweenService:Create(ContainerStroke, TweenInfo.new(t3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Transparency = 1
	}):Play()
	
	TweenService:Create(GlowEffect, TweenInfo.new(t3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		ImageTransparency = 1
	}):Play()
	
	fastwait(t3)
	LoaderGui:Destroy()
end

animateIn()
