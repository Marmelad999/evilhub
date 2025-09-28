-- Загружаем библиотеку (твоя ссылка)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Marmelad999/evilhub/refs/heads/main/library"))()

-- Проверка игрока и PlayerGui
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("EvilHub") then
	warn("GUI уже открыт!")
	return
end

-- Флаги и подключения
local walkspeedActive, attackSpeedActive, comboActive = false, false, false
local walkspeedLoopConnection, attackSpeedLoopConnection, comboLoopConnection = nil, nil, nil
local espActive = false
local AutoPotionEnabled = false

-- Создаём GUI через библиотеку
local screenGui = Library:CreateScreenGui("EvilHub", playerGui)
local frame = Library:CreateFrame(screenGui, UDim2.new(0, 400, 0, 350), UDim2.new(0.5, -200, 0.5, -175), Color3.fromRGB(30, 30, 30))
Library:MakeDraggable(frame, 40)

-- Заголовок и кнопки управления
local title = Library:CreateLabel(frame, "EvilHub", UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), 28)
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.GothamBold

local closeButton = Library:CreateButton(frame, "X", UDim2.new(0, 30, 0, 30), UDim2.new(1, -40, 0, 5), Color3.fromRGB(255, 0, 0))
local minimizeButton = Library:CreateButton(frame, "-", UDim2.new(0, 30, 0, 30), UDim2.new(1, -80, 0, 5), Color3.fromRGB(200, 200, 200))
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Позиционирование элементов
local startY = 50
local spacingY = 50
local labelX = 20
local textboxX = 190
local toggleX = 300
local elementWidth = 80
local elementHeight = 30

-- Создаём элементы через библиотеку

-- Walk Speed
local walkSpeedLabel = Library:CreateLabel(frame, "Walk Speed:", UDim2.new(0, 100, 0, elementHeight), UDim2.new(0, labelX, 0, startY), 20)
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
local walkSpeedTextBox = Library:CreateTextBox(frame, "20", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, textboxX, 0, startY))
local walkspeedToggleButton = Library:CreateButton(frame, "OFF", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, toggleX, 0, startY), Color3.fromRGB(255, 0, 0))

-- Attack Speed
local attackSpeedLabel = Library:CreateLabel(frame, "Attack Speed:", UDim2.new(0, 140, 0, elementHeight), UDim2.new(0, labelX, 0, startY + spacingY), 20)
attackSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
local attackSpeedTextBox = Library:CreateTextBox(frame, "15", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, textboxX, 0, startY + spacingY))
local attackSpeedToggleButton = Library:CreateButton(frame, "OFF", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, toggleX, 0, startY + spacingY), Color3.fromRGB(255, 0, 0))

-- Combo
local comboLabel = Library:CreateLabel(frame, "Auto Combo:", UDim2.new(0, 140, 0, elementHeight), UDim2.new(0, labelX, 0, startY + spacingY * 2), 20)
comboLabel.TextXAlignment = Enum.TextXAlignment.Left
local comboValueTextBox = Library:CreateTextBox(frame, "1", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, textboxX, 0, startY + spacingY * 2))
local comboToggleButton = Library:CreateButton(frame, "OFF", UDim2.new(0, elementWidth, 0, elementHeight), UDim2.new(0, toggleX, 0, startY + spacingY * 2), Color3.fromRGB(255, 0, 0))

-- ESP (одна кнопка)
local espButton = Library:CreateButton(frame, "ESP: OFF", UDim2.new(0, 200, 0, 40), UDim2.new(0.5, -100, 0, startY + spacingY * 3 + 10), Color3.fromRGB(255, 0, 0))

-- AutoPotion
local autoPotionBtn = Library:CreateButton(frame, "AutoPotion: OFF", UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0, startY + spacingY * 4 + 10), Color3.fromRGB(50, 50, 50))
autoPotionBtn.Font = Enum.Font.SourceSansBold
autoPotionBtn.TextSize = 20

-- Вспомогательные функции
local function getModelBasePart(model)
	if not model then return nil end
	if model:FindFirstChild("HumanoidRootPart") and model.HumanoidRootPart:IsA("BasePart") then
		return model.HumanoidRootPart
	end
	if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then
		return model.PrimaryPart
	end
	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("BasePart") then return child end
	end
	return nil
end

-- Универсальный ESP: принимает Model или BasePart
local function createEsp(target, text, color, size)
	if not target then return end

	-- определяем adornnee (BasePart)
	local adornee = nil
	if target:IsA("Model") then
		adornee = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	elseif target:IsA("BasePart") then
		adornee = target
	else
		-- не поддерживаем другие типы
		return
	end

	if not adornee then return end

	-- если уже есть, не создаём
	if adornee:FindFirstChild("EspBox") or adornee:FindFirstChild("EspName") then
		return
	end

	-- BoxHandleAdornment
	local espBox = Instance.new("BoxHandleAdornment")
	espBox.Name = "EspBox"
	espBox.Adornee = adornee
	espBox.ZIndex = 0
	espBox.Size = size or Vector3.new(4, 4, 4)
	espBox.Transparency = 0.65
	espBox.Color3 = color or Color3.fromRGB(255, 255, 255)
	espBox.AlwaysOnTop = true
	espBox.Parent = adornee

	-- BillboardGui (имя)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "EspName"
	billboard.Adornee = adornee
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 120, 0, 24)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.Parent = adornee

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text or "Unknown"
	label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
	label.TextScaled = true
	label.Font = Enum.Font.SourceSansBold
	label.Parent = billboard
end

-- Очистка ESP (удаляет только наши EspName/EspBox)
local function clearEsp()
	for _, inst in ipairs(workspace:GetDescendants()) do
		-- удаляем BoxHandleAdornment и BillboardGui с нашими именами
		if inst:IsA("BoxHandleAdornment") and inst.Name == "EspBox" then
			pcall(function() inst:Destroy() end)
		elseif inst:IsA("BillboardGui") and inst.Name == "EspName" then
			pcall(function() inst:Destroy() end)
		end
	end
end

-- Кнопка ESP
espButton.MouseButton1Click:Connect(function()
	espActive = not espActive
	espButton.Text = espActive and "ESP: ON" or "ESP: OFF"
	espButton.BackgroundColor3 = espActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 0, 0)
	if not espActive then
		clearEsp()
	end
end)

-- Логика кнопок WalkSpeed / AttackSpeed / Combo
walkspeedToggleButton.MouseButton1Click:Connect(function()
	walkspeedActive = not walkspeedActive
	if walkspeedActive then
		walkspeedToggleButton.Text = "ON"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		if walkspeedLoopConnection then walkspeedLoopConnection:Disconnect() walkspeedLoopConnection = nil end
		walkspeedLoopConnection = RunService.Heartbeat:Connect(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChildOfClass("Humanoid") then
				local value = tonumber(walkSpeedTextBox.Text)
				if value then char.Humanoid.WalkSpeed = value end
			end
		end)
	else
		walkspeedToggleButton.Text = "OFF"
		walkspeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if walkspeedLoopConnection then walkspeedLoopConnection:Disconnect() walkspeedLoopConnection = nil end
	end
end)

attackSpeedToggleButton.MouseButton1Click:Connect(function()
	attackSpeedActive = not attackSpeedActive
	if attackSpeedActive then
		attackSpeedToggleButton.Text = "ON"
		attackSpeedToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		if attackSpeedLoopConnection then attackSpeedLoopConnection:Disconnect() attackSpeedLoopConnection = nil end
		attackSpeedLoopConnection = RunService.Heartbeat:Connect(function()
			local char = LocalPlayer.Character
			if char and char:GetAttribute("AttackSpeed") ~= nil then
				local value = tonumber(attackSpeedTextBox.Text)
				if value then char:SetAttribute("AttackSpeed", value) end
			end
		end)
	else
		attackSpeedToggleButton.Text = "OFF"
		attackSpeedToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if attackSpeedLoopConnection then attackSpeedLoopConnection:Disconnect() attackSpeedLoopConnection = nil end
	end
end)

comboToggleButton.MouseButton1Click:Connect(function()
	comboActive = not comboActive
	if comboActive then
		comboToggleButton.Text = "ON"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		if comboLoopConnection then comboLoopConnection:Disconnect() comboLoopConnection = nil end
		comboLoopConnection = RunService.Heartbeat:Connect(function()
			local char = LocalPlayer.Character
			if char and char:GetAttribute("Combo") ~= nil then
				local value = tonumber(comboValueTextBox.Text)
				if value and (value == 1 or value == 2 or value == 3) then
					char:SetAttribute("Combo", value)
				end
			end
		end)
	else
		comboToggleButton.Text = "OFF"
		comboToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if comboLoopConnection then comboLoopConnection:Disconnect() comboLoopConnection = nil end
	end
end)

-- AutoPotion
autoPotionBtn.MouseButton1Click:Connect(function()
	AutoPotionEnabled = not AutoPotionEnabled
	autoPotionBtn.Text = AutoPotionEnabled and "AutoPotion: ON" or "AutoPotion: OFF"
	autoPotionBtn.BackgroundColor3 = AutoPotionEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
end)

task.spawn(function()
	while task.wait(0.5) do
		if AutoPotionEnabled then
			local char = nil
			if workspace:FindFirstChild("Characters") then
				char = workspace.Characters:FindFirstChild(LocalPlayer.Name)
			end
			if not char then
				char = workspace:FindFirstChild(LocalPlayer.Name)
			end

			if char and char.GetAttribute then
				local hp = char:GetAttribute("HP")
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if hp and humanoid and humanoid.MaxHealth and humanoid.MaxHealth > 0 then
					if hp / humanoid.MaxHealth <= 0.45 then
						local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
						if events and events:FindFirstChild("UsePotion") then
							events.UsePotion:FireServer(1)
							task.wait(1)
						end
					end
				end
			end
		end
	end
end)

-- ESP loop (мобы + объекты в башне)
task.spawn(function()
	while task.wait(0.5) do
		if espActive then
			-- ESP для мобов (ищем модели с Humanoid)
			for _, desc in ipairs(workspace:GetDescendants()) do
				if desc:IsA("Model") and desc:FindFirstChild("Humanoid") and desc ~= LocalPlayer.Character then
					local basePart = getModelBasePart(desc)
					if basePart and not basePart:FindFirstChild("EspBox") then
						pcall(function()
							createEsp(desc, desc.Name, Color3.fromRGB(255, 48, 48), Vector3.new(4, 5, 1))
						end)
					end
				end
			end

			-- ESP для объектов в башне (Chest, SecretChest, EXPBook, Ruby)
			local tower = workspace:FindFirstChild("Tower")
			if tower then
				for _, room in ipairs(tower:GetChildren()) do
					if room:IsA("Model") and tonumber(room.Name) then
						for _, objName in ipairs({"Chest", "SecretChest", "EXPBook", "Ruby"}) do
							local obj = room:FindFirstChild(objName)
							if obj then
								local color, text = Color3.fromRGB(255, 215, 0), "Chest"
								if objName == "SecretChest" then
									color, text = Color3.fromRGB(128, 0, 255), "Secret Chest"
								elseif objName == "EXPBook" then
									color, text = Color3.fromRGB(0, 200, 255), "EXP Book"
								elseif objName == "Ruby" then
									color, text = Color3.fromRGB(255, 0, 255), "Ruby"
								end

								-- Если это модель (Chest/SecretChest/EXPBook as Model)
								if obj:IsA("Model") then
									local basePart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
									if basePart and not basePart:FindFirstChild("EspBox") then
										pcall(function()
											createEsp(obj, text, color, Vector3.new(4, 4, 4))
										end)
									end
								else
									-- Если это BasePart (например Ruby как MeshPart)
									if obj:IsA("BasePart") then
										if not obj:FindFirstChild("EspBox") then
											pcall(function()
												createEsp(obj, text, color, Vector3.new(2, 2, 2))
											end)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

-- Свернуть/развернуть
local isMinimized = false
local fullSize = frame.Size
local contentElements = {
	walkSpeedLabel, walkSpeedTextBox, walkspeedToggleButton,
	attackSpeedLabel, attackSpeedTextBox, attackSpeedToggleButton,
	comboLabel, comboValueTextBox, comboToggleButton,
	espButton, autoPotionBtn
}

minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, elem in ipairs(contentElements) do
		if elem and elem.Parent then elem.Visible = not isMinimized end
	end
	if isMinimized then
		frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 40)
		minimizeButton.Text = "+"
	else
		frame.Size = fullSize
		minimizeButton.Text = "-"
	end
end)

-- Очистка при закрытии GUI
screenGui.Destroying:Connect(function()
	if walkspeedLoopConnection then walkspeedLoopConnection:Disconnect() end
	if attackSpeedLoopConnection then attackSpeedLoopConnection:Disconnect() end
	if comboLoopConnection then comboLoopConnection:Disconnect() end
	espActive = false
	clearEsp()
end)
