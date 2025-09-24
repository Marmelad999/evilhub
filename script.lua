-- Проверяем, существует ли уже GUI, чтобы не создавать новый
if game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("EvilHub") then
	print("GUI уже открыт!")
	return -- Если GUI уже существует, не создаем новый
end

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EvilHub"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем фрейм для формы
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 320)
frame.Position = UDim2.new(0.5, -200, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui

-- Функция для перетаскивания окна
local dragging = false
local dragInput, dragStart, startPos
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

-- Элементы для WalkSpeed
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, 100, 0, 30)
walkSpeedLabel.Position = UDim2.new(0, 20, 0, 50)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "WalkSpeed:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.TextSize = 20
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.Parent = frame

local walkSpeedTextBox = Instance.new("TextBox")
walkSpeedTextBox.Size = UDim2.new(0, 80, 0, 30)
walkSpeedTextBox.Position = UDim2.new(0, 130, 0, 50)
walkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedTextBox.Text = "25" -- Установил 25 по умолчанию
walkSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedTextBox.TextSize = 20
walkSpeedTextBox.Font = Enum.Font.Gotham
walkSpeedTextBox.Parent = frame

-- НОВЫЙ ПЕРЕКЛЮЧАТЕЛЬ ДЛЯ WALKSPEED (ON/OFF)
local walkspeedToggleButton = Instance.new("TextButton")
walkspeedToggleButton.Size = UDim2.new(0, 70, 0, 30)
walkspeedToggleButton.Position = UDim2.new(0, 220, 0, 50)
walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный "OFF"
walkspeedToggleButton.Text = "OFF"
walkspeedToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
walkspeedToggleButton.TextSize = 20
walkspeedToggleButton.Font = Enum.Font.GothamBold
walkspeedToggleButton.Parent = frame


-- Элементы для JumpPower
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0, 140, 0, 30)
jumpPowerLabel.Position = UDim2.new(0, 20, 0, 90)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Text = "JumpPower:"
jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerLabel.TextSize = 20
jumpPowerLabel.Font = Enum.Font.Gotham
jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpPowerLabel.Parent = frame

local jumpPowerTextBox = Instance.new("TextBox")
jumpPowerTextBox.Size = UDim2.new(0, 120, 0, 30)
jumpPowerTextBox.Position = UDim2.new(0, 160, 0, 90)
jumpPowerTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerTextBox.Text = "50"
jumpPowerTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpPowerTextBox.TextSize = 20
jumpPowerTextBox.Font = Enum.Font.Gotham
jumpPowerTextBox.Parent = frame

-- Элементы для AttackSpeed
local attackSpeedLabel = Instance.new("TextLabel")
attackSpeedLabel.Size = UDim2.new(0, 140, 0, 30)
attackSpeedLabel.Position = UDim2.new(0, 20, 0, 130)
attackSpeedLabel.BackgroundTransparency = 1
attackSpeedLabel.Text = "AttackSpeed:"
attackSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedLabel.TextSize = 20
attackSpeedLabel.Font = Enum.Font.Gotham
attackSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
attackSpeedLabel.Parent = frame

local attackSpeedTextBox = Instance.new("TextBox")
attackSpeedTextBox.Size = UDim2.new(0, 120, 0, 30)
attackSpeedTextBox.Position = UDim2.new(0, 160, 0, 130)
attackSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedTextBox.Text = "1"
attackSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
attackSpeedTextBox.TextSize = 20
attackSpeedTextBox.Font = Enum.Font.Gotham
attackSpeedTextBox.Parent = frame

-- Элементы для Combo
local comboToggleLabel = Instance.new("TextLabel")
comboToggleLabel.Size = UDim2.new(0, 140, 0, 30)
comboToggleLabel.Position = UDim2.new(0, 20, 0, 170)
comboToggleLabel.BackgroundTransparency = 1
comboToggleLabel.Text = "Auto Combo:"
comboToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
comboToggleLabel.TextSize = 20
comboToggleLabel.Font = Enum.Font.Gotham
comboToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
comboToggleLabel.Parent = frame

local comboToggleButton = Instance.new("TextButton")
comboToggleButton.Size = UDim2.new(0, 120, 0, 30)
comboToggleButton.Position = UDim2.new(0, 160, 0, 170)
comboToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
comboToggleButton.Text = "OFF"
comboToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
comboToggleButton.TextSize = 20
comboToggleButton.Font = Enum.Font.GothamBold
comboToggleButton.Parent = frame

local comboValueLabel = Instance.new("TextLabel")
comboValueLabel.Size = UDim2.new(0, 140, 0, 30)
comboValueLabel.Position = UDim2.new(0, 20, 0, 210)
comboValueLabel.BackgroundTransparency = 1
comboValueLabel.Text = "Combo Value:"
comboValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
comboValueLabel.TextSize = 20
comboValueLabel.Font = Enum.Font.Gotham
comboValueLabel.TextXAlignment = Enum.TextXAlignment.Left
comboValueLabel.Parent = frame

local comboValueTextBox = Instance.new("TextBox")
comboValueTextBox.Size = UDim2.new(0, 120, 0, 30)
comboValueTextBox.Position = UDim2.new(0, 160, 0, 210)
comboValueTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
comboValueTextBox.Text = "1"
comboValueTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
comboValueTextBox.TextSize = 20
comboValueTextBox.Font = Enum.Font.Gotham
comboValueTextBox.Parent = frame

-- Кнопка для применения изменений (для JumpPower и AttackSpeed)
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0, 120, 0, 40)
applyButton.Position = UDim2.new(0.5, -60, 0, 260)
applyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
applyButton.Text = "Apply"
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 20
applyButton.Font = Enum.Font.GothamBold
applyButton.Parent = frame

-- --- ЛОГИКА ---

local RunService = game:GetService("RunService")

-- Переменные для управления циклами
local walkspeedActive = false
local comboActive = false
local walkspeedLoopConnection = nil
local comboLoopConnection = nil

-- Функция для применения изменений, которые НЕ требуют цикла (JumpPower, AttackSpeed)
local function applyNonLoopChanges()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	local jumpPowerValue = tonumber(jumpPowerTextBox.Text)
	local attackSpeedValue = tonumber(attackSpeedTextBox.Text)

	if jumpPowerValue then
		character:WaitForChild("Humanoid").JumpPower = jumpPowerValue
	else
		print("Invalid JumpPower value")
	end

	if attackSpeedValue then
		if character:GetAttribute("AttackSpeed") ~= nil then
			character:SetAttribute("AttackSpeed", attackSpeedValue)
		else
			print("Error: Could not find 'AttackSpeed' attribute on your character!")
		end
	else
		print("Invalid AttackSpeed value")
	end
end

-- Обработчик для кнопки переключения WalkSpeed
walkspeedToggleButton.MouseButton1Click:Connect(function()
	walkspeedActive = not walkspeedActive

	if walkspeedActive then
		walkspeedToggleButton.Text = "ON"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Зеленый

		walkspeedLoopConnection = RunService.Heartbeat:Connect(function()
			local player = game.Players.LocalPlayer
			local character = player.Character
			if not character then return end

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local walkSpeedValue = tonumber(walkSpeedTextBox.Text)

			if humanoid and walkSpeedValue and humanoid.WalkSpeed ~= walkSpeedValue then
				humanoid.WalkSpeed = walkSpeedValue
			end
		end)
	else
		walkspeedToggleButton.Text = "OFF"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный

		if walkspeedLoopConnection then
			walkspeedLoopConnection:Disconnect()
			walkspeedLoopConnection = nil
		end
	end
end)

-- Обработчик для кнопки переключения Combo
comboToggleButton.MouseButton1Click:Connect(function()
	comboActive = not comboActive

	if comboActive then
		comboToggleButton.Text = "ON"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

		comboLoopConnection = RunService.Heartbeat:Connect(function()
			local player = game.Players.LocalPlayer
			local character = player.Character
			if not character then return end

			local comboValue = tonumber(comboValueTextBox.Text)

			if comboValue and (comboValue == 1 or comboValue == 2 or comboValue == 3) then
				if character:GetAttribute("Combo") ~= nil then
					character:SetAttribute("Combo", comboValue)
				end
			end
		end)
	else
		comboToggleButton.Text = "OFF"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

		if comboLoopConnection then
			comboLoopConnection:Disconnect()
			comboLoopConnection = nil
		end
	end
end)

-- Привязываем функцию к кнопке Apply
applyButton.MouseButton1Click:Connect(applyNonLoopChanges)

-- Дополнительно: останавливаем все циклы, если GUI закрывается
screenGui.Destroying:Connect(function()
	if walkspeedLoopConnection then
		walkspeedLoopConnection:Disconnect()
	end
	if comboLoopConnection then
		comboLoopConnection:Disconnect()
	end
end)
