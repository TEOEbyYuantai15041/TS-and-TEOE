if not MacSploit then warn("建议在MacSploit环境下执行") end

local Paint = {}

function Paint.Init()
    -- 创建画板界面
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local ClearButton = Instance.new("TextButton")

    -- 界面配置
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "PaintGui"
    
    Frame.Size = UDim2.new(0.5, 0, 0.7, 0)
    Frame.Position = UDim2.new(0.25, 0, 0.15, 0)
    Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame.Parent = ScreenGui
    
    ClearButton.Size = UDim2.new(0.1, 0, 0.05, 0)
    ClearButton.Position = UDim2.new(0.45, 0, 0.05, 0)
    ClearButton.Text = "清除画布"
    ClearButton.Parent = ScreenGui

    -- 绘制逻辑
    local drawing = false
    local lastPoint
    
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drawing = true
            lastPoint = input.Position
        end
    end)

    Frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drawing = false
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if drawing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newPoint = input.Position
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, 2, 0, (newPoint - lastPoint).Magnitude)
            line.Position = UDim2.new(0, lastPoint.X, 0, lastPoint.Y)
            line.Rotation = math.deg(math.atan2(newPoint.Y - lastPoint.Y, newPoint.X - lastPoint.X))
            line.BackgroundColor3 = Color3.new(0, 0, 0)
            line.BorderSizePixel = 0
            line.Parent = Frame
            lastPoint = newPoint
        end
    end)

    -- 清除功能
    ClearButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(Frame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
    end)
end

-- MacSploit环境检测
if MacSploit then
    Paint.Init()
else
    warn("当前注入器环境可能不兼容")
    Paint.Init() -- 尝试正常执行
end

return Paint