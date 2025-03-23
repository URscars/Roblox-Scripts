--Teleport Menu by URscars with Full English Explanation

-- Get the local player and UserInputService for handling player input
local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Create a ScreenGui to hold the interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false  -- Prevent the GUI from resetting on player respawn
ScreenGui.Parent = Player.PlayerGui  -- Parent the GUI to the player's GUI

-- Create the main frame for the interface
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 225)  -- Set the size of the frame (width: 250, height: 225)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -112.5)  -- Center the frame on the screen
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Set the background color to dark gray
MainFrame.Active = true  -- Allow the frame to receive input
MainFrame.Draggable = false  -- Disable default dragging (we'll handle it manually)
MainFrame.Parent = ScreenGui  -- Parent the frame to the ScreenGui

-- Create a drag label at the top of the frame
local DragLabel = Instance.new("TextLabel")
DragLabel.Size = UDim2.new(1, 0, 0, 30)  -- Full width, 30 pixels tall
DragLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  -- Darker gray background
DragLabel.Text = "Teleport Menu by URscars"  -- Set the title text
DragLabel.TextColor3 = Color3.new(1, 1, 1)  -- White text color
DragLabel.Font = Enum.Font.SourceSansBold  -- Use a bold font
DragLabel.TextSize = 14  -- Set the text size
DragLabel.Parent = MainFrame  -- Parent the label to the main frame

-- Create a close button in the top-right corner
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)  -- 25x25 pixels
CloseButton.Position = UDim2.new(1, -30, 0, 2)  -- Position in the top-right corner
CloseButton.Text = "X"  -- Set the button text
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Red background
CloseButton.TextColor3 = Color3.new(1, 1, 1)  -- White text
CloseButton.Font = Enum.Font.SourceSansBold  -- Bold font
CloseButton.TextSize = 14  -- Text size
CloseButton.ZIndex = 2  -- Ensure the button is above other elements
CloseButton.Parent = DragLabel  -- Parent the button to the drag label

-- Handle the close button click event
CloseButton.MouseButton1Click:Connect(function()
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()  -- Destroy the GUI when the button is clicked
    end
end)

-- Create a text box for entering coordinates
local CoordinatesInput = Instance.new("TextBox")
CoordinatesInput.Size = UDim2.new(0, 210, 0, 30)  -- 210x30 pixels
CoordinatesInput.Position = UDim2.new(0, 20, 0, 40)  -- Position below the drag label
CoordinatesInput.PlaceholderText = "Enter coordinates (X,Y,Z)"  -- Placeholder text
CoordinatesInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White background
CoordinatesInput.TextColor3 = Color3.new(0, 0, 0)  -- Black text
CoordinatesInput.Text = "Enter coordinates (X,Y,Z)"  -- Default text
CoordinatesInput.Font = Enum.Font.SourceSansBold  -- Bold font
CoordinatesInput.TextSize = 14  -- Text size
CoordinatesInput.Parent = MainFrame  -- Parent the text box to the main frame

-- Filter the input to allow only numbers, commas, dots, and minus signs
CoordinatesInput:GetPropertyChangedSignal("Text"):Connect(function()
    local filteredText = CoordinatesInput.Text:gsub("[^%d.,%- ]", "")  -- Remove invalid characters
    if #filteredText > 29 then  -- Limit the text length to 29 characters
        filteredText = filteredText:sub(1, 29)
    end
    if filteredText ~= CoordinatesInput.Text then
        CoordinatesInput.Text = filteredText  -- Update the text if it was filtered
    end
end)

-- Create a teleport button
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0, 210, 0, 40)  -- 210x40 pixels
TeleportButton.Position = UDim2.new(0, 20, 0, 80)  -- Position below the coordinates input
TeleportButton.Text = "TELEPORT"  -- Button text
TeleportButton.BackgroundColor3 = Color3.fromRGB(75, 150, 75)  -- Green background
TeleportButton.TextColor3 = Color3.new(1, 1, 1)  -- White text
TeleportButton.Font = Enum.Font.SourceSansBold  -- Bold font
TeleportButton.TextSize = 14  -- Text size
TeleportButton.Parent = MainFrame  -- Parent the button to the main frame

-- Create a label for the cycle teleport toggle
local CycleText = Instance.new("TextLabel")
CycleText.Size = UDim2.new(0, 100, 0, 20)  -- 100x20 pixels
CycleText.Position = UDim2.new(0, 20, 0, 130)  -- Position below the teleport button
CycleText.BackgroundTransparency = 1  -- Transparent background
CycleText.TextColor3 = Color3.new(1, 1, 1)  -- White text
CycleText.Text = "Cycle Teleport:"  -- Label text
CycleText.Font = Enum.Font.SourceSansBold  -- Bold font
CycleText.TextSize = 14  -- Text size
CycleText.TextXAlignment = Enum.TextXAlignment.Left  -- Left-align the text
CycleText.Parent = MainFrame  -- Parent the label to the main frame

-- Create a toggle button for cycle teleport
local CycleToggle = Instance.new("TextButton")
CycleToggle.Size = UDim2.new(0, 50, 0, 20)  -- 50x20 pixels
CycleToggle.Position = UDim2.new(0, 100, 0, 130)  -- Position next to the cycle label
CycleToggle.Text = "OFF"  -- Default text
CycleToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Red background
CycleToggle.TextColor3 = Color3.new(1, 1, 1)  -- White text
CycleToggle.Font = Enum.Font.SourceSansBold  -- Bold font
CycleToggle.TextSize = 14  -- Text size
CycleToggle.Parent = MainFrame  -- Parent the toggle to the main frame

-- Create a text box for entering the teleport interval
local IntervalInput = Instance.new("TextBox")
IntervalInput.Size = UDim2.new(0, 60, 0, 20)  -- 60x20 pixels
IntervalInput.Position = UDim2.new(0, 160, 0, 130)  -- Position next to the toggle
IntervalInput.PlaceholderText = "5 sec"  -- Placeholder text
IntervalInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White background
IntervalInput.TextColor3 = Color3.new(0, 0, 0)  -- Black text
IntervalInput.Text = "5"  -- Default value
IntervalInput.Font = Enum.Font.SourceSansBold  -- Bold font
IntervalInput.TextSize = 14  -- Text size
IntervalInput.Parent = MainFrame  -- Parent the input to the main frame

-- Filter the interval input to allow only numbers and limit to 2 characters
IntervalInput:GetPropertyChangedSignal("Text"):Connect(function()
    local filteredText = IntervalInput.Text:gsub("[^%d]", "")  -- Remove non-numeric characters
    if filteredText ~= IntervalInput.Text then
        IntervalInput.Text = filteredText  -- Update the text if it was filtered
    end
    if #IntervalInput.Text > 2 then  -- Limit to 2 characters
        IntervalInput.Text = IntervalInput.Text:sub(1, 2)
    end
end)

-- Variable to track if cycle teleport is active
local isCycling = false

-- Function to handle cycle teleportation
local function startCycleTeleport()
    while isCycling do
        local coordsText = CoordinatesInput.Text
        local coords = {}
        
        -- Extract numbers from the coordinates input
        for num in coordsText:gmatch("[-%d.]+") do
            table.insert(coords, tonumber(num))
        end
        
        -- Teleport the player if valid coordinates are entered
        if #coords >= 3 then
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
            end
        end
        
        -- Wait for the specified interval before teleporting again
        local interval = tonumber(IntervalInput.Text) or 5  -- Default to 5 seconds
        task.wait(interval)
    end
end

-- Handle the cycle toggle button click event
CycleToggle.MouseButton1Click:Connect(function()
    isCycling = not isCycling  -- Toggle the cycle state
    if isCycling then
        CycleToggle.Text = "ON"  -- Update the button text
        CycleToggle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)  -- Green background
        startCycleTeleport()  -- Start the cycle teleportation
    else
        CycleToggle.Text = "OFF"  -- Update the button text
        CycleToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)  -- Red background
    end
end)

-- Handle the teleport button click event
TeleportButton.MouseButton1Click:Connect(function()
    local coordsText = CoordinatesInput.Text
    local coords = {}
    
    -- Extract numbers from the coordinates input
    for num in coordsText:gmatch("[-%d.]+") do
        table.insert(coords, tonumber(num))
    end
    
    -- Teleport the player if valid coordinates are entered
    if #coords >= 3 then
        local character = Player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(coords[1], coords[2], coords[3])
        end
    end
end)

-- Create a label to display the player's current position
local CoordinatesLabel = Instance.new("TextLabel")
CoordinatesLabel.Size = UDim2.new(0, 210, 0, 20)  -- 210x20 pixels
CoordinatesLabel.Position = UDim2.new(0, 20, 0, 160)  -- Position below the cycle controls
CoordinatesLabel.BackgroundTransparency = 1  -- Transparent background
CoordinatesLabel.TextColor3 = Color3.new(1, 1, 1)  -- White text
CoordinatesLabel.Text = "Current position: (0, 0, 0)"  -- Default text
CoordinatesLabel.Font = Enum.Font.SourceSansBold  -- Bold font
CoordinatesLabel.TextSize = 14  -- Text size
CoordinatesLabel.TextXAlignment = Enum.TextXAlignment.Left  -- Left-align the text
CoordinatesLabel.Parent = MainFrame  -- Parent the label to the main frame

-- Create a button to copy the current coordinates to the input field
local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0, 210, 0, 25)  -- 210x25 pixels
CopyButton.Position = UDim2.new(0, 20, 0, 190)  -- Position below the coordinates label
CopyButton.Text = "Copy Coordinates"  -- Button text
CopyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)  -- Blue background
CopyButton.TextColor3 = Color3.new(1, 1, 1)  -- White text
CopyButton.Font = Enum.Font.SourceSansBold  -- Bold font
CopyButton.TextSize = 14  -- Text size
CopyButton.Parent = MainFrame  -- Parent the button to the main frame

-- Handle the copy button click event
CopyButton.MouseButton1Click:Connect(function()
    local currentText = CoordinatesLabel.Text
    -- Extract coordinates from the label text
    local x, y, z = currentText:match("%(([%d%.%-]+),%s*([%d%.%-]+),%s*([%d%.%-]+)%)")
    
    -- Copy the coordinates to the input field if valid
    if x and y and z then
        CoordinatesInput.Text = string.format("%s, %s, %s", x, y, z)
    end
end)

-- Variables for handling frame dragging
local dragging = false
local dragStartPos
local frameStartPos

-- Handle the start of dragging
DragLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position  -- Store the initial mouse position
        frameStartPos = MainFrame.Position  -- Store the initial frame position
    end
end)

-- Handle frame movement while dragging
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos  -- Calculate the mouse movement delta
        MainFrame.Position = UDim2.new(
            frameStartPos.X.Scale,
            frameStartPos.X.Offset + delta.X,  -- Update the X position
            frameStartPos.Y.Scale,
            frameStartPos.Y.Offset + delta.Y  -- Update the Y position
        )
    end
end)

-- Handle the end of dragging
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false  -- Stop dragging
    end
end)

-- Function to update the player's current position in the label
local function updateCoordinates()
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position
        -- Format the position as (X, Y, Z) with one decimal place
        CoordinatesLabel.Text = string.format("Current position: (%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
    else
        CoordinatesLabel.Text = "Current position: N/A"  -- Display "N/A" if no character is found
    end
end

-- Get the RunService for updating the coordinates label
local RunService = game:GetService("RunService")
local connection

-- Update the coordinates label every frame
connection = RunService.Heartbeat:Connect(function()
    if ScreenGui.Parent then
        updateCoordinates()  -- Update the coordinates
    else
        connection:Disconnect()  -- Stop updating if the GUI is destroyed
    end
end)