-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EvilHub"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем фрейм для формы
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "EvilHub"
title.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Красный цвет
title.TextSize = 24
title.TextAlignment = Enum.TextAlignment.Center
title.Parent = frame

-- Метка для WalkSpeed
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, 140, 0, 30)
walkSpeedLabel.Position = UDim2.new(0, 20, 0, 40)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "WalkSpeed:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.TextSize = 18
walkSpeedLabel.TextAlignment = Enum.TextAlignment.Left
walkSpeedLabel.Parent = frame

-- TextBox для WalkSpeed
local walkSpeedTextBox = Instance.new("TextBox")
walkSpeedTextBox.Size = UDim2.new(0, 120, 0, 30)
walkSpeedTextBox.Position = UDim2.new(0, 160, 0, 40)
walkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedTextBox.Text = "16"
walkSpeedTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedTextBox.TextSize = 18
walkSpeedTextBox.Parent = frame

-- Метка для JumpPower
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0, 140, 0, 30)
jumpPowerLabel.Position = UDim2.new(0, 20, 0, 80)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Text = "JumpPower:"
jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerLabel.TextSize = 18
jumpPowerLabel.TextAlignment = Enum.TextAlignment.Left
jumpPowerLabel.Parent = frame

-- TextBox для JumpPower
local jumpPowerTextBox = Instance.new("TextBox")
jumpPowerTextBox.Size = UDim2.new(0, 120, 0, 30)
jumpPowerTextBox.Position = UDim2.new(0, 160, 0, 80)
jumpPowerTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerTextBox.Text = "7.2"
jumpPowerTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpPowerTextBox.TextSize = 18
jumpPowerTextBox.Parent = frame

-- Кнопка для применения изменений
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0, 120, 0, 40)
applyButton.Position = UDim2.new(0, 90, 0, 130)
applyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
applyButton.Text = "Apply"
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 18
applyButton.Parent = frame

-- Функция для изменения WalkSpeed и JumpPower
local function applyChanges()
    -- Получаем значения из TextBox
    local walkSpeedValue = tonumber(walkSpeedTextBox.Text)
    local jumpPowerValue = tonumber(jumpPowerTextBox.Text)

    -- Проверяем, что значения валидны
    if walkSpeedValue then
        game.Players.LocalPlayer.Humanoid.WalkSpeed = walkSpeedValue
    else
        print("Invalid WalkSpeed value")
    end

    if jumpPowerValue then
        game.Players.LocalPlayer.Humanoid.JumpPower = jumpPowerValue
    else
        print("Invalid JumpPower value")
    end
end

-- Обработчик события нажатия на кнопку
applyButton.MouseButton1Click:Connect(applyChanges)
