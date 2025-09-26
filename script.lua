-- Проверяем, существует ли уже GUI
if game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("EvilHub") then
	print("GUI уже открыт!")
	return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EvilHub"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui

-- Перетаскивание
local dragging = false
local dragStart, startPos
frame.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
frame.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "EvilHub"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Кнопка свернуть/развернуть
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -80, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = frame

-- Настройки элементов GUI
local startY = 50
local spacingY = 50
local labelX = 20
local textboxX = 190
local toggleX = 300
local elementWidth = 80
local elementHeight = 30

-- Walk Speed
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, 100, 0, elementHeight)
walkSpeedLabel.Position = UDim2.new(0, labelX, 0, startY)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "Walk Speed:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.TextSize = 20
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.Parent = frame

local walkSpeedTextBox = Instance.new("TextBox")
walkSpeedTextBox.Size = UDim2.new(0, elementWidth, 0, elementHeight)
walkSpeedTextBox.Position = UDim2.new(0, textboxX, 0, startY)
walkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedTextBox.Text = "18"
walkSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedTextBox.TextSize = 20
walkSpeedTextBox.Font = Enum.Font.Gotham
walkSpeedTextBox.Parent = frame

local walkspeedToggleButton = Instance.new("TextButton")
walkspeedToggleButton.Size = UDim2.new(0, elementWidth, 0, elementHeight)
walkspeedToggleButton.Position = UDim2.new(0, toggleX, 0, startY)
walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
walkspeedToggleButton.Text = "OFF"
walkspeedToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
walkspeedToggleButton.TextSize = 20
walkspeedToggleButton.Font = Enum.Font.GothamBold
walkspeedToggleButton.Parent = frame

-- Attack Speed
local attackSpeedLabel = Instance.new("TextLabel")
attackSpeedLabel.Size = UDim2.new(0, 140, 0, elementHeight)
attackSpeedLabel.Position = UDim2.new(0, labelX, 0, startY + spacingY)
attackSpeedLabel.BackgroundTransparency = 1
attackSpeedLabel.Text = "Attack Speed:"
attackSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedLabel.TextSize = 20
attackSpeedLabel.Font = Enum.Font.Gotham
attackSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
attackSpeedLabel.Parent = frame

local attackSpeedTextBox = Instance.new("TextBox")
attackSpeedTextBox.Size = UDim2.new(0, elementWidth, 0, elementHeight)
attackSpeedTextBox.Position = UDim2.new(0, textboxX, 0, startY + spacingY)
attackSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedTextBox.Text = "15"
attackSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
attackSpeedTextBox.TextSize = 20
attackSpeedTextBox.Font = Enum.Font.Gotham
attackSpeedTextBox.Parent = frame

local attackSpeedToggleButton = Instance.new("TextButton")
attackSpeedToggleButton.Size = UDim2.new(0, elementWidth, 0, elementHeight)
attackSpeedToggleButton.Position = UDim2.new(0, toggleX, 0, startY + spacingY)
attackSpeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
attackSpeedToggleButton.Text = "OFF"
attackSpeedToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedToggleButton.TextSize = 20
attackSpeedToggleButton.Font = Enum.Font.GothamBold
attackSpeedToggleButton.Parent = frame

-- Combo
local comboLabel = Instance.new("TextLabel")
comboLabel.Size = UDim2.new(0, 140, 0, elementHeight)
comboLabel.Position = UDim2.new(0, labelX, 0, startY + spacingY*2)
comboLabel.BackgroundTransparency = 1
comboLabel.Text = "Auto Combo:"
comboLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
comboLabel.TextSize = 20
comboLabel.Font = Enum.Font.Gotham
comboLabel.TextXAlignment = Enum.TextXAlignment.Left
comboLabel.Parent = frame

local comboValueTextBox = Instance.new("TextBox")
comboValueTextBox.Size = UDim2.new(0, elementWidth, 0, elementHeight)
comboValueTextBox.Position = UDim2.new(0, textboxX, 0, startY + spacingY*2)
comboValueTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
comboValueTextBox.Text = "1"
comboValueTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
comboValueTextBox.TextSize = 20
comboValueTextBox.Font = Enum.Font.Gotham
comboValueTextBox.Parent = frame

local comboToggleButton = Instance.new("TextButton")
comboToggleButton.Size = UDim2.new(0, elementWidth, 0, elementHeight)
comboToggleButton.Position = UDim2.new(0, toggleX, 0, startY + spacingY*2)
comboToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
comboToggleButton.Text = "OFF"
comboToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
comboToggleButton.TextSize = 20
comboToggleButton.Font = Enum.Font.GothamBold
comboToggleButton.Parent = frame

-- Кнопки ESP (мобы и сундуки)
local espMobButton = Instance.new("TextButton")
espMobButton.Size = UDim2.new(0, 150, 0, 35)
espMobButton.Position = UDim2.new(0, 20, 0, startY + spacingY*3)
espMobButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espMobButton.Text = "ESP Mobs: OFF"
espMobButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espMobButton.TextSize = 18
espMobButton.Font = Enum.Font.GothamBold
espMobButton.Parent = frame

local espChestButton = Instance.new("TextButton")
espChestButton.Size = UDim2.new(0, 150, 0, 35)
espChestButton.Position = UDim2.new(0, 200, 0, startY + spacingY*3)
espChestButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espChestButton.Text = "ESP Chest: OFF"
espChestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espChestButton.TextSize = 18
espChestButton.Font = Enum.Font.GothamBold
espChestButton.Parent = frame

-- Флаги
local walkspeedActive, attackSpeedActive, comboActive = false, false, false
local walkspeedLoopConnection, attackSpeedLoopConnection, comboLoopConnection = nil, nil, nil

local espMobsActive, espChestActive = false, false

-- Функции очистки ESP по типу
local function clearEspMobs()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:FindFirstChild("Humanoid") then
			local espBox = obj:FindFirstChild("EspBox")
			local espName = obj:FindFirstChild("EspName")
			if espBox and espBox:IsA("BoxHandleAdornment") then espBox:Destroy() end
			if espName and espName:IsA("BillboardGui") then espName:Destroy() end
		end
	end
end

local function clearEspChests()
	local tower = workspace:FindFirstChild("Tower")
	if tower then
		for _, room in ipairs(tower:GetChildren()) do
			if room:IsA("Model") and tonumber(room.Name) then
				for _, chestName in ipairs({"Chest", "SecretChest"}) do
					local chest = room:FindFirstChild(chestName)
					if chest and chest:IsA("Model") then
						local espBox = chest:FindFirstChild("EspBox")
						local espName = chest:FindFirstChild("EspName")
						if espBox and espBox:IsA("BoxHandleAdornment") then espBox:Destroy() end
						if espName and espName:IsA("BillboardGui") then espName:Destroy() end
					end
				end
			end
		end
	end
end

-- WalkSpeed Toggle
walkspeedToggleButton.MouseButton1Click:Connect(function()
	walkspeedActive = not walkspeedActive
	local player = LocalPlayer
	local character = player.Character
	if walkspeedActive then
		walkspeedToggleButton.Text = "ON"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		walkspeedLoopConnection = RunService.Heartbeat:Connect(function()
			if character and character:FindFirstChildOfClass("Humanoid") then
				local value = tonumber(walkSpeedTextBox.Text)
				if value then character.Humanoid.WalkSpeed = value end
			end
		end)
	else
		walkspeedToggleButton.Text = "OFF"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if walkspeedLoopConnection then walkspeedLoopConnection:Disconnect() walkspeedLoopConnection=nil end
	end
end)

-- AttackSpeed Toggle
attackSpeedToggleButton.MouseButton1Click:Connect(function()
	attackSpeedActive = not attackSpeedActive
	local player = LocalPlayer
	local character = player.Character
	if attackSpeedActive then
		attackSpeedToggleButton.Text = "ON"
		attackSpeedToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		attackSpeedLoopConnection = RunService.Heartbeat:Connect(function()
			if character and character:GetAttribute("AttackSpeed") ~= nil then
				local value = tonumber(attackSpeedTextBox.Text)
				if value then character:SetAttribute("AttackSpeed", value) end
			end
		end)
	else
		attackSpeedToggleButton.Text = "OFF"
		attackSpeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if attackSpeedLoopConnection then attackSpeedLoopConnection:Disconnect() attackSpeedLoopConnection=nil end
	end
end)

-- Combo Toggle
comboToggleButton.MouseButton1Click:Connect(function()
	comboActive = not comboActive
	local player = LocalPlayer
	local character = player.Character
	if comboActive then
		comboToggleButton.Text = "ON"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		comboLoopConnection = RunService.Heartbeat:Connect(function()
			if character and character:GetAttribute("Combo") ~= nil then
				local value = tonumber(comboValueTextBox.Text)
				if value and (value==1 or value==2 or value==3) then
					character:SetAttribute("Combo", value)
				end
			end
		end)
	else
		comboToggleButton.Text = "OFF"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if comboLoopConnection then comboLoopConnection:Disconnect() comboLoopConnection=nil end
	end
end)

-- === ТУТ вставлен ТВОЙ оригинальный ESP-код (минимально изменён: добавлены проверки флагов, остальной код — точно как ты прислал) ===
spawn(function()
	while wait(0.5) do 
		-- ESP для мобов
		if espMobsActive then
			for _, childrik in ipairs(workspace:GetDescendants()) do
				if childrik:FindFirstChild("Humanoid") and childrik ~= game.Players.LocalPlayer.Character then

					-- Бокс
					if not childrik:FindFirstChild("EspBox") then
						local esp = Instance.new("BoxHandleAdornment",childrik)
						esp.Adornee = childrik
						esp.ZIndex = 0
						esp.Size = Vector3.new(4, 5, 1)
						esp.Transparency = 0.65
						esp.Color3 = Color3.fromRGB(255,48,48)
						esp.AlwaysOnTop = true
						esp.Name = "EspBox"
					end

					-- Текст
					if not childrik:FindFirstChild("EspName") then
						local billboard = Instance.new("BillboardGui", childrik)
						billboard.Name = "EspName"
						billboard.Adornee = childrik:FindFirstChild("HumanoidRootPart") or childrik.PrimaryPart
						billboard.AlwaysOnTop = true
						billboard.Size = UDim2.new(0, 100, 0, 20)
						billboard.StudsOffset = Vector3.new(0, -3, 0)

						local label = Instance.new("TextLabel", billboard)
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.Text = childrik.Name or "Unknown"
						label.TextColor3 = Color3.fromRGB(255, 255, 255)
						label.TextScaled = true
						label.Font = Enum.Font.SourceSansBold
					end
				end
			end
		end

		-- ESP для сундуков
		if espChestActive then
			local tower = workspace:FindFirstChild("Tower")
			if tower then
				for _, room in ipairs(tower:GetChildren()) do
					if room:IsA("Model") and tonumber(room.Name) then -- комнаты "1", "2", "3"...

						-- Проверяем обычный сундук
						for _, chestName in ipairs({"Chest", "SecretChest"}) do
							local chest = room:FindFirstChild(chestName)
							if chest and chest:IsA("Model") then

								-- Настройки под разные типы сундуков
								local color = Color3.fromRGB(255, 215, 0) -- по умолчанию золото
								local text = "Chest"
								if chestName == "SecretChest" then
									color = Color3.fromRGB(128, 0, 255) -- фиолетовый для секрета
									text = "Secret Chest"
								end

								-- Бокс
								if not chest:FindFirstChild("EspBox") then
									local esp = Instance.new("BoxHandleAdornment", chest)
									esp.Adornee = chest
									esp.ZIndex = 0
									esp.Size = Vector3.new(4, 4, 4)
									esp.Transparency = 0.65
									esp.Color3 = color
									esp.AlwaysOnTop = true
									esp.Name = "EspBox"
								end

								-- Текст
								if not chest:FindFirstChild("EspName") then
									local billboard = Instance.new("BillboardGui", chest)
									billboard.Name = "EspName"
									billboard.Adornee = chest.PrimaryPart or chest:FindFirstChildWhichIsA("BasePart")
									billboard.AlwaysOnTop = true
									billboard.Size = UDim2.new(0, 100, 0, 20)
									billboard.StudsOffset = Vector3.new(0, -3, 0)

									local label = Instance.new("TextLabel", billboard)
									label.Size = UDim2.new(1, 0, 1, 0)
									label.BackgroundTransparency = 1
									label.Text = text
									label.TextColor3 = color
									label.TextScaled = true
									label.Font = Enum.Font.SourceSansBold
								end
							end
						end
					end
				end
			end
		end
	end
end)
-- === КОНЕЦ вставленного кода ===

-- Кнопки ESP handlers
espMobButton.MouseButton1Click:Connect(function()
	espMobsActive = not espMobsActive
	if espMobsActive then
		espMobButton.Text = "ESP Mobs: ON"
		espMobButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	else
		espMobButton.Text = "ESP Mobs: OFF"
		espMobButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		clearEspMobs()
	end
end)

espChestButton.MouseButton1Click:Connect(function()
	espChestActive = not espChestActive
	if espChestActive then
		espChestButton.Text = "ESP Chest: ON"
		espChestButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	else
		espChestButton.Text = "ESP Chest: OFF"
		espChestButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		clearEspChests()
	end
end)

-- Свернуть/развернуть
local isMinimized = false
local fullSize = frame.Size
local contentElements = {
	walkSpeedLabel, walkSpeedTextBox, walkspeedToggleButton,
	attackSpeedLabel, attackSpeedTextBox, attackSpeedToggleButton,
	comboLabel, comboValueTextBox, comboToggleButton,
	espMobButton, espChestButton
}

minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		for _, elem in pairs(contentElements) do elem.Visible = false end
		frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 40)
		minimizeButton.Text = "+"
	else
		for _, elem in pairs(contentElements) do elem.Visible = true end
		frame.Size = fullSize
		minimizeButton.Text = "-"
	end
end)

-- Останавливаем все циклы и убираем ESP при закрытии GUI
screenGui.Destroying:Connect(function()
	if walkspeedLoopConnection then walkspeedLoopConnection:Disconnect() end
	if attackSpeedLoopConnection then attackSpeedLoopConnection:Disconnect() end
	if comboLoopConnection then comboLoopConnection:Disconnect() end
	espMobsActive = false
	espChestActive = false
	clearEspMobs()
	clearEspChests()
end)
