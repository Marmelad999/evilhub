-- Загружаем библиотеку
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Marmelad999/evilhub/refs/heads/main/library"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("EvilHub") then
	warn("GUI уже открыт!")
	return
end

-- Флаги
local walkspeedActive, attackSpeedActive, comboActive = false, false, false
local walkspeedLoopConnection, attackSpeedLoopConnection, comboLoopConnection = nil, nil, nil
local espActive = false
local AutoPotionEnabled = false

-- GUI
local screenGui = Library:CreateScreenGui("EvilHub", playerGui)
local frame = Library:CreateFrame(screenGui, UDim2.new(0, 400, 0, 405), UDim2.new(0.5, -200, 0.5, -175), Color3.fromRGB(25, 25, 25))
Library:MakeDraggable(frame, 40)

-- ====== СТИЛЬ ТЕКСТА ======
local function styleText(obj, size)
	obj.Font = Enum.Font.Gotham
	obj.TextSize = size or 16
	obj.TextStrokeTransparency = 0
	obj.TextStrokeColor3 = Color3.new(0,0,0)
	obj.TextColor3 = Color3.fromRGB(235,235,235)
end

-- Заголовок
local title = Library:CreateLabel(frame, "EvilHub", UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), 18)
title.TextColor3 = Color3.fromRGB(255, 90, 90)
title.TextXAlignment = Enum.TextXAlignment.Center
styleText(title,18)

-- Кнопки управления
local closeButton = Library:CreateButton(frame, "X", UDim2.new(0,30,0,28), UDim2.new(1,-40,0,6), Color3.fromRGB(150,0,0))
local minimizeButton = Library:CreateButton(frame, "-", UDim2.new(0,30,0,28), UDim2.new(1,-80,0,6), Color3.fromRGB(60,60,60))
styleText(closeButton,14)
styleText(minimizeButton,14)

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Позиции
local startY = 55
local spacingY = 45
local labelX = 20
local textboxX = 190
local toggleX = 300
local elementWidth = 80
local elementHeight = 28

-- Walk Speed
local walkSpeedLabel = Library:CreateLabel(frame,"Walk Speed:",UDim2.new(0,120,0,elementHeight),UDim2.new(0,labelX,0,startY),16)
local walkSpeedTextBox = Library:CreateTextBox(frame,"20",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,textboxX,0,startY))
local walkspeedToggleButton = Library:CreateButton(frame,"OFF",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,toggleX,0,startY),Color3.fromRGB(120,0,0))

-- Attack Speed
local attackSpeedLabel = Library:CreateLabel(frame,"Attack Speed:",UDim2.new(0,140,0,elementHeight),UDim2.new(0,labelX,0,startY+spacingY),16)
local attackSpeedTextBox = Library:CreateTextBox(frame,"15",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,textboxX,0,startY+spacingY))
local attackSpeedToggleButton = Library:CreateButton(frame,"OFF",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,toggleX,0,startY+spacingY),Color3.fromRGB(120,0,0))

-- Combo
local comboLabel = Library:CreateLabel(frame,"Auto Combo:",UDim2.new(0,140,0,elementHeight),UDim2.new(0,labelX,0,startY+spacingY*2),16)
local comboValueTextBox = Library:CreateTextBox(frame,"1",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,textboxX,0,startY+spacingY*2))
local comboToggleButton = Library:CreateButton(frame,"OFF",UDim2.new(0,elementWidth,0,elementHeight),UDim2.new(0,toggleX,0,startY+spacingY*2),Color3.fromRGB(120,0,0))

-- ESP
local espButton = Library:CreateButton(frame,"ESP: OFF",UDim2.new(0,200,0,32),UDim2.new(0.5,-100,0,startY+spacingY*3+10),Color3.fromRGB(120,0,0))

-- AutoPotion
local autoPotionBtn = Library:CreateButton(frame,"AutoPotion: OFF",UDim2.new(0,200,0,32),UDim2.new(0.5,-100,0,startY+spacingY*4+10),Color3.fromRGB(50,50,50))

-- Применяем стиль
for _,v in pairs(frame:GetDescendants()) do
	if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
		styleText(v,16)
	end
end

-- ===== ESP (ТОЛЬКО НАЗВАНИЕ) =====
local function createEsp(target,text,color)
	if not target then return end

	local adornee
	if target:IsA("Model") then
		adornee = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	elseif target:IsA("BasePart") then
		adornee = target
	end
	if not adornee then return end
	if adornee:FindFirstChild("EspName") then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "EspName"
	billboard.Adornee = adornee
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0,120,0,22)
	billboard.StudsOffset = Vector3.new(0,3,0)
	billboard.Parent = adornee

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text or "Unknown"
	label.Font = Enum.Font.Gotham
	label.TextScaled = true
	label.TextStrokeTransparency = 0
	label.TextStrokeColor3 = Color3.new(0,0,0)
	label.TextColor3 = color or Color3.new(1,1,1)
	label.Parent = billboard
end

local function clearEsp()
	for _,inst in ipairs(workspace:GetDescendants()) do
		if inst:IsA("BillboardGui") and inst.Name == "EspName" then
			inst:Destroy()
		end
	end
end

-- Кнопка ESP
espButton.MouseButton1Click:Connect(function()
	espActive = not espActive
	espButton.Text = espActive and "ESP: ON" or "ESP: OFF"
	espButton.BackgroundColor3 = espActive and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
	if not espActive then
		clearEsp()
	end
end)
