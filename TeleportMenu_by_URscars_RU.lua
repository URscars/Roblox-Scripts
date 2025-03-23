-- Телепорт Меню от URscars с Полным Русским Пояснением

-- Получаем локального игрока и UserInputService для обработки ввода
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Создаем ScreenGui для интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false  -- Предотвращаем сброс GUI при респавне игрока
ScreenGui.Parent = Player.PlayerGui  -- Привязываем GUI к интерфейсу игрока

-- Создаем основной фрейм для интерфейса
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 225)  -- Устанавливаем размер фрейма (ширина: 250, высота: 225)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -112.5)  -- Центрируем фрейм на экране
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Устанавливаем темно-серый цвет фона
MainFrame.Active = true  -- Разрешаем фрейму получать ввод
MainFrame.Draggable = false  -- Отключаем стандартное перетаскивание (будем обрабатывать вручную)
MainFrame.Parent = ScreenGui  -- Привязываем фрейм к ScreenGui

-- Создаем заголовок для перетаскивания в верхней части фрейма
local DragLabel = Instance.new("TextLabel")
DragLabel.Size = UDim2.new(1, 0, 0, 30)  -- Полная ширина, высота 30 пикселей
DragLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  -- Темно-серый фон
DragLabel.Text = "Teleport Menu by URscars"  -- Устанавливаем текст заголовка
DragLabel.TextColor3 = Color3.new(1, 1, 1)  -- Белый цвет текста
DragLabel.Font = Enum.Font.SourceSansBold  -- Используем жирный шрифт
DragLabel.TextSize = 14  -- Устанавливаем размер текста
DragLabel.Parent = MainFrame  -- Привязываем заголовок к основному фрейму

-- Создаем кнопку закрытия в правом верхнем углу
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)  -- Размер 25x25 пикселей
CloseButton.Position = UDim2.new(1, -30, 0, 2)  -- Позиция в правом верхнем углу
CloseButton.Text = "X"  -- Текст кнопки
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Красный фон
CloseButton.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
CloseButton.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CloseButton.TextSize = 14  -- Размер текста
CloseButton.ZIndex = 2  -- Убедимся, что кнопка выше других элементов
CloseButton.Parent = DragLabel  -- Привязываем кнопку к заголовку

-- Обрабатываем нажатие на кнопку закрытия
CloseButton.MouseButton1Click:Connect(function()
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()  -- Уничтожаем GUI при нажатии на кнопку
    end
end)

-- Создаем поле для ввода координат
local CoordinatesInput = Instance.new("TextBox")
CoordinatesInput.Size = UDim2.new(0, 210, 0, 30)  -- Размер 210x30 пикселей
CoordinatesInput.Position = UDim2.new(0, 20, 0, 40)  -- Позиция под заголовком
CoordinatesInput.PlaceholderText = "Enter coordinates (X,Y,Z)"  -- Текст-подсказка
CoordinatesInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон
CoordinatesInput.TextColor3 = Color3.new(0, 0, 0)  -- Черный текст
CoordinatesInput.Text = "Enter coordinates (X,Y,Z)"  -- Текст по умолчанию
CoordinatesInput.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CoordinatesInput.TextSize = 14  -- Размер текста
CoordinatesInput.Parent = MainFrame  -- Привязываем поле к основному фрейму

-- Фильтруем ввод, чтобы разрешить только цифры, запятые, точки и минусы
CoordinatesInput:GetPropertyChangedSignal("Text"):Connect(function()
    local filteredText = CoordinatesInput.Text:gsub("[^%d.,%- ]", "")  -- Удаляем недопустимые символы
    if #filteredText > 29 then  -- Ограничиваем длину текста до 29 символов
        filteredText = filteredText:sub(1, 29)
    end
    if filteredText ~= CoordinatesInput.Text then
        CoordinatesInput.Text = filteredText  -- Обновляем текст, если он был отфильтрован
    end
end)

-- Создаем кнопку телепортации
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0, 210, 0, 40)  -- Размер 210x40 пикселей
TeleportButton.Position = UDim2.new(0, 20, 0, 80)  -- Позиция под полем ввода координат
TeleportButton.Text = "TELEPORT"  -- Текст кнопки
TeleportButton.BackgroundColor3 = Color3.fromRGB(75, 150, 75)  -- Зеленый фон
TeleportButton.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
TeleportButton.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
TeleportButton.TextSize = 14  -- Размер текста
TeleportButton.Parent = MainFrame  -- Привязываем кнопку к основному фрейму

-- Создаем текст для переключателя циклической телепортации
local CycleText = Instance.new("TextLabel")
CycleText.Size = UDim2.new(0, 100, 0, 20)  -- Размер 100x20 пикселей
CycleText.Position = UDim2.new(0, 20, 0, 130)  -- Позиция под кнопкой телепортации
CycleText.BackgroundTransparency = 1  -- Прозрачный фон
CycleText.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
CycleText.Text = "Cycle Teleport:"  -- Текст
CycleText.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CycleText.TextSize = 14  -- Размер текста
CycleText.TextXAlignment = Enum.TextXAlignment.Left  -- Выравнивание текста по левому краю
CycleText.Parent = MainFrame  -- Привязываем текст к основному фрейму

-- Создаем переключатель для циклической телепортации
local CycleToggle = Instance.new("TextButton")
CycleToggle.Size = UDim2.new(0, 50, 0, 20)  -- Размер 50x20 пикселей
CycleToggle.Position = UDim2.new(0, 100, 0, 130)  -- Позиция рядом с текстом
CycleToggle.Text = "OFF"  -- Текст по умолчанию
CycleToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Красный фон
CycleToggle.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
CycleToggle.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CycleToggle.TextSize = 14  -- Размер текста
CycleToggle.Parent = MainFrame  -- Привязываем переключатель к основному фрейму

-- Создаем поле для ввода интервала телепортации
local IntervalInput = Instance.new("TextBox")
IntervalInput.Size = UDim2.new(0, 60, 0, 20)  -- Размер 60x20 пикселей
IntervalInput.Position = UDim2.new(0, 160, 0, 130)  -- Позиция рядом с переключателем
IntervalInput.PlaceholderText = "5 sec"  -- Текст-подсказка
IntervalInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон
IntervalInput.TextColor3 = Color3.new(0, 0, 0)  -- Черный текст
IntervalInput.Text = "5"  -- Значение по умолчанию
IntervalInput.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
IntervalInput.TextSize = 14  -- Размер текста
IntervalInput.Parent = MainFrame  -- Привязываем поле к основному фрейму

-- Фильтруем ввод интервала, чтобы разрешить только цифры и ограничить до 2 символов
IntervalInput:GetPropertyChangedSignal("Text"):Connect(function()
    local filteredText = IntervalInput.Text:gsub("[^%d]", "")  -- Удаляем нечисловые символы
    if filteredText ~= IntervalInput.Text then
        IntervalInput.Text = filteredText  -- Обновляем текст, если он был отфильтрован
    end
    if #IntervalInput.Text > 2 then  -- Ограничиваем до 2 символов
        IntervalInput.Text = IntervalInput.Text:sub(1, 2)
    end
end)

-- Переменная для отслеживания состояния циклической телепортации
local isCycling = false

-- Функция для циклической телепортации
local function startCycleTeleport()
    while isCycling do
        local coordsText = CoordinatesInput.Text
        local coords = {}
        
        -- Извлекаем числа из введенных координат
        for num in coordsText:gmatch("[-%d.]+") do
            table.insert(coords, tonumber(num))
        end
        
        -- Телепортируем игрока, если введены корректные координаты
        if #coords >= 3 then
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
            end
        end
        
        -- Ждем указанный интервал перед следующей телепортацией
        local interval = tonumber(IntervalInput.Text) or 5  -- По умолчанию 5 секунд
        task.wait(interval)
    end
end

-- Обрабатываем нажатие на переключатель циклической телепортации
CycleToggle.MouseButton1Click:Connect(function()
    isCycling = not isCycling  -- Переключаем состояние
    if isCycling then
        CycleToggle.Text = "ON"  -- Обновляем текст кнопки
        CycleToggle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)  -- Зеленый фон
        startCycleTeleport()  -- Запускаем циклическую телепортацию
    else
        CycleToggle.Text = "OFF"  -- Обновляем текст кнопки
        CycleToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Красный фон
    end
end)

-- Обрабатываем нажатие на кнопку телепортации
TeleportButton.MouseButton1Click:Connect(function()
    local coordsText = CoordinatesInput.Text
    local coords = {}
    
    -- Извлекаем числа из введенных координат
    for num in coordsText:gmatch("[-%d.]+") do
        table.insert(coords, tonumber(num))
    end
    
    -- Телепортируем игрока, если введены корректные координаты
    if #coords >= 3 then
        local character = Player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
        end
    end
end)

-- Создаем текст для отображения текущей позиции игрока
local CoordinatesLabel = Instance.new("TextLabel")
CoordinatesLabel.Size = UDim2.new(0, 210, 0, 20)  -- Размер 210x20 пикселей
CoordinatesLabel.Position = UDim2.new(0, 20, 0, 160)  -- Позиция под элементами управления
CoordinatesLabel.BackgroundTransparency = 1  -- Прозрачный фон
CoordinatesLabel.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
CoordinatesLabel.Text = "Current position: (0, 0, 0)"  -- Текст по умолчанию
CoordinatesLabel.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CoordinatesLabel.TextSize = 14  -- Размер текста
CoordinatesLabel.TextXAlignment = Enum.TextXAlignment.Left  -- Выравнивание текста по левому краю
CoordinatesLabel.Parent = MainFrame  -- Привязываем текст к основному фрейму

-- Создаем кнопку для копирования текущих координат в поле ввода
local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0, 210, 0, 25)  -- Размер 210x25 пикселей
CopyButton.Position = UDim2.new(0, 20, 0, 190)  -- Позиция под текстом координат
CopyButton.Text = "Copy Coordinates"  -- Текст кнопки
CopyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)  -- Синий фон
CopyButton.TextColor3 = Color3.new(1, 1, 1)  -- Белый текст
CopyButton.Font = Enum.Font.SourceSansBold  -- Жирный шрифт
CopyButton.TextSize = 14  -- Размер текста
CopyButton.Parent = MainFrame  -- Привязываем кнопку к основному фрейму

-- Обрабатываем нажатие на кнопку копирования координат
CopyButton.MouseButton1Click:Connect(function()
    local currentText = CoordinatesLabel.Text
    -- Извлекаем координаты из текста
    local x, y, z = currentText:match("%(([%d%.%-]+),%s*([%d%.%-]+),%s*([%d%.%-]+)%)")
    
    -- Копируем координаты в поле ввода, если они корректны
    if x and y and z then
        CoordinatesInput.Text = string.format("%s, %s, %s", x, y, z)
    end
end)

-- Переменные для обработки перетаскивания фрейма
local dragging = false
local dragStartPos
local frameStartPos

-- Обрабатываем начало перетаскивания
DragLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position  -- Запоминаем начальную позицию мыши
        frameStartPos = MainFrame.Position  -- Запоминаем начальную позицию фрейма
    end
end)

-- Обрабатываем перемещение фрейма при перетаскивании
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos  -- Вычисляем смещение мыши
        MainFrame.Position = UDim2.new(
            frameStartPos.X.Scale,
            frameStartPos.X.Offset + delta.X,  -- Обновляем позицию по X
            frameStartPos.Y.Scale,
            frameStartPos.Y.Offset + delta.Y  -- Обновляем позицию по Y
        )
    end
end)

-- Обрабатываем завершение перетаскивания
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false  -- Останавливаем перетаскивание
    end
end)

-- Функция для обновления текущей позиции игрока в тексте
local function updateCoordinates()
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position
        -- Форматируем позицию как (X, Y, Z) с одним знаком после запятой
        CoordinatesLabel.Text = string.format("Current position: (%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
    else
        CoordinatesLabel.Text = "Current position: N/A"  -- Отображаем "N/A", если персонаж не найден
    end
end

-- Получаем RunService для обновления текста координат
local RunService = game:GetService("RunService")
local connection

-- Обновляем текст координат каждый кадр
connection = RunService.Heartbeat:Connect(function()
    if ScreenGui.Parent then
        updateCoordinates()  -- Обновляем координаты
    else
        connection:Disconnect()  -- Останавливаем обновление, если GUI уничтожен
    end
end)