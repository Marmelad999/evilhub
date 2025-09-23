-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EvilHub"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем фрейм для формы (увеличим размер)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черная рамка
frame.Parent = screenGui

-- Функция для перемещения формы
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
title.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Красный цвет
title.TextSize = 28
title.Font = Enum.Font.GothamBold  -- Исправлено на правильное свойство Font
title.TextXAlignment = Enum.TextXAlignment.Center  -- Горизонтальное выравнивание
title.TextYAlignment = Enum.TextYAlignment.Center  -- Вертикальное выравнивание
title.Parent = frame

-- Кнопка закрытия (крестик)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold  -- Исправлено на правильное свойство Font
closeButton.Parent = frame
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy() -- Закрываем GUI
end)

-- Метка для WalkSpeed
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, 140, 0, 30)
walkSpeedLabel.Position = UDim2.new(0, 20, 0, 50)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "WalkSpeed:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.TextSize = 20
walkSpeedLabel.Font = Enum.Font.Gotham -- Используем правильное свойство Font
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.TextYAlignment = Enum.TextYAlignment.Center
walkSpeedLabel.Parent = frame

-- TextBox для WalkSpeed
local walkSpeedTextBox = Instance.new("TextBox")
walkSpeedTextBox.Size = UDim2.new(0, 120, 0, 30)
walkSpeedTextBox.Position = UDim2.new(0, 160, 0, 50)
walkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedTextBox.Text = "16"
walkSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedTextBox.TextSize = 20
walkSpeedTextBox.Font = Enum.Font.Gotham
walkSpeedTextBox.TextXAlignment = Enum.TextXAlignment.Center
walkSpeedTextBox.TextYAlignment = Enum.TextYAlignment.Center
walkSpeedTextBox.Parent = frame

-- Метка для JumpPower
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0, 140, 0, 30)
jumpPowerLabel.Position = UDim2.new(0, 20, 0, 100)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Text = "JumpPower:"
jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerLabel.TextSize = 20
jumpPowerLabel.Font = Enum.Font.Gotham
jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpPowerLabel.TextYAlignment = Enum.TextYAlignment.Center
jumpPowerLabel.Parent = frame

-- TextBox для JumpPower
local jumpPowerTextBox = Instance.new("TextBox")
jumpPowerTextBox.Size = UDim2.new(0, 120, 0, 30)
jumpPowerTextBox.Position = UDim2.new(0, 160, 0, 100)
jumpPowerTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerTextBox.Text = "7.2"
jumpPowerTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpPowerTextBox.TextSize = 20
jumpPowerTextBox.Font = Enum.Font.Gotham
jumpPowerTextBox.TextXAlignment = Enum.TextXAlignment.Center
jumpPowerTextBox.TextYAlignment = Enum.TextYAlignment.Center
jumpPowerTextBox.Parent = frame

-- Кнопка для применения изменений
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0, 120, 0, 40)
applyButton.Position = UDim2.new(0, 90, 0, 160)
applyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
applyButton.Text = "Apply"
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 20
applyButton.Font = Enum.Font.GothamBold
applyButton.Parent = frame

-- Функция для изменения WalkSpeed и JumpPower
local function applyChanges()
	-- Получаем значения из TextBox
	local walkSpeedValue = tonumber(walkSpeedTextBox.Text)
	local jumpPowerValue = tonumber(jumpPowerTextBox.Text)

	-- Проверяем, что значения валидны
	if walkSpeedValue then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkSpeedValue
	else
		print("Invalid WalkSpeed value")
	end

	if jumpPowerValue then
		local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

		-- Убедимся, что JumpPower используется
		humanoid.UseJumpPower = true  -- Включаем кастомный JumpPower

		-- Применяем JumpPower
		humanoid.JumpPower = jumpPowerValue
	else
		print("Invalid JumpPower value")
	end
end


-- Обработчик события нажатия на кнопку
applyButton.MouseButton1Click:Connect(applyChanges)
