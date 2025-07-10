local P = game.Players.LocalPlayer
local C = P.Character or P.CharacterAdded:Wait()
local R = C:WaitForChild("HumanoidRootPart")
local H = C:WaitForChild("Humanoid")


local G = Instance.new("ScreenGui", game.CoreGui)
G.Name = "BrainrotMenu"


local OB = Instance.new("TextButton", G)
OB.Size = UDim2.new(0, 100, 0, 40)
OB.Position = UDim2.new(0, 20, 0, 20)
OB.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OB.TextColor3 = Color3.new(1, 1, 1)
OB.Text = "РњРµРЅСЋ"
OB.Font = Enum.Font.GothamBold
OB.TextSize = 16
OB.Draggable = true


local M = Instance.new("Frame", G)
M.Size = UDim2.new(0, 230, 0, 260)
M.Position = UDim2.new(0, 20, 0, 70)
M.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
M.Visible = false
M.Active = true
M.Draggable = true


local L = Instance.new("TextLabel", M)
L.Size = UDim2.new(1, 0, 0, 35)
L.Position = UDim2.new(0, 0, 0, 0)
L.BackgroundTransparency = 1
L.Font = Enum.Font.GothamBold
L.Text = "by: Badoyn"
L.TextScaled = true
L.TextColor3 = Color3.fromRGB(0, 255, 0)


local tpUpCF = nil
local barrierY = -9.8 + 3
local skyPlat = nil


local function createPlat(pos)
 if skyPlat then skyPlat:Destroy() end
 local p = Instance.new("Part", workspace)
 p.Size = Vector3.new(40, 1, 40)
 p.Position = pos - Vector3.new(0, 3, 0)
 p.Anchored = true
 p.CanCollide = true
 p.Transparency = 1
 p.Name = "SkyPlatform_" .. P.Name
 skyPlat = p
end


local function smoothDown(tY)
 local conn
 conn = game:GetService("RunService").RenderStepped:Connect(function()
  local pos = R.Position
  if pos.Y <= tY then
   R.CFrame = CFrame.new(pos.X, tY, pos.Z)
   if conn then conn:Disconnect() end
   if skyPlat then skyPlat:Destroy() skyPlat = nil end
   return
  end
  R.CFrame = CFrame.new(pos.X, pos.Y - 5, pos.Z)
 end)
end


local bigJumpOn = false


local JB = Instance.new("TextButton", M)
JB.Size = UDim2.new(0.9, 0, 0, 35)
JB.Position = UDim2.new(0.05, 0, 0, 40)
JB.Text = "Р‘РѕР»СЊС€РѕР№ РџСЂС‹Р¶РѕРє в­•пёЏ"
JB.Font = Enum.Font.Gotham
JB.TextColor3 = Color3.new(1, 1, 1)
JB.BackgroundColor3 = Color3.fromRGB(40, 40, 40)


JB.MouseButton1Click:Connect(function()
 bigJumpOn = not bigJumpOn
 JB.Text = bigJumpOn and "Р‘РѕР»СЊС€РѕР№ РџСЂС‹Р¶РѕРє вњ…" or "Р‘РѕР»СЊС€РѕР№ РџСЂС‹Р¶РѕРє в­•пёЏ"
end)


H.Jumping:Connect(function(active)
 if active and bigJumpOn then
  local bv = Instance.new("BodyVelocity")
  bv.Velocity = Vector3.new(0, 100, 0)
  bv.MaxForce = Vector3.new(0, math.huge, 0)
  bv.Parent = R
  game.Debris:AddItem(bv, 0.3)
 end
end)


local TPUP = Instance.new("TextButton", M)
TPUP.Size = UDim2.new(0.9, 0, 0, 35)
TPUP.Position = UDim2.new(0.05, 0, 0, 85)
TPUP.Text = "РўРџ РІ РЅРµР±Рѕ в­•пёЏ"
TPUP.Font = Enum.Font.Gotham
TPUP.TextColor3 = Color3.new(1, 1, 1)
TPUP.BackgroundColor3 = Color3.fromRGB(40, 40, 40)


TPUP.MouseButton1Click:Connect(function()
 tpUpCF = R.CFrame + Vector3.new(0, 300, 0)
 R.CFrame = tpUpCF
 createPlat(tpUpCF.Position)
 TPUP.Text = "РўРџ РІ РЅРµР±Рѕ вњ…"
end)


local TPDOWN = Instance.new("TextButton", M)
TPDOWN.Size = UDim2.new(0.9, 0, 0, 35)
TPDOWN.Position = UDim2.new(0.05, 0, 0, 130)
TPDOWN.Text = "РўРџ РќР°Р·Р°Рґ в­•пёЏ"
TPDOWN.Font = Enum.Font.Gotham
TPDOWN.TextColor3 = Color3.new(1, 1, 1)
TPDOWN.BackgroundColor3 = Color3.fromRGB(40, 40, 40)


TPDOWN.MouseButton1Click:Connect(function()
 if tpUpCF then
  smoothDown(barrierY)
  TPUP.Text = "РўРџ РІ РЅРµР±Рѕ в­•пёЏ"
 end
end)


-- вљЎ РЁРµР№РґРµСЂС‹
local shadersOn = false


local ShaderBTN = Instance.new("TextButton", M)
ShaderBTN.Size = UDim2.new(0.9, 0, 0, 35)
ShaderBTN.Position = UDim2.new(0.05, 0, 0, 175)
ShaderBTN.Text = "РЁРµР№РґРµСЂС‹ в­•пёЏ"
ShaderBTN.Font = Enum.Font.Gotham
ShaderBTN.TextColor3 = Color3.new(1, 1, 1)
ShaderBTN.BackgroundColor3 = Color3.fromRGB(40, 40, 40)


local function enableShaders()
 local L = game.Lighting


 if not L:FindFirstChild("KHK_Blur") then
  local blur = Instance.new("BlurEffect", L)
  blur.Name = "KHK_Blur"
  blur.Size = 2
 end


 if not L:FindFirstChild("KHK_Bloom") then
  local bloom = Instance.new("BloomEffect", L)
  bloom.Name = "KHK_Bloom"
  bloom.Intensity = 0.8
  bloom.Size = 56
  bloom.Threshold = 2
 end


 if not L:FindFirstChild("KHK_Color") then
  local cc = Instance.new("ColorCorrectionEffect", L)
  cc.Name = "KHK_Color"
  cc.Contrast = 0.05
  cc.Saturation = 0.1
 end
end


local function disableShaders()
 for _, name in pairs({"KHK_Blur", "KHK_Bloom", "KHK_Color"}) do
  local v = game.Lighting:FindFirstChild(name)
  if v then v:Destroy() end
 end
end


ShaderBTN.MouseButton1Click:Connect(function()
 shadersOn = not shadersOn
 ShaderBTN.Text = shadersOn and "РЁРµР№РґРµСЂС‹ вњ…" or "РЁРµР№РґРµСЂС‹ в­•пёЏ"


 if shadersOn then
  enableShaders()
 else
  disableShaders()
 end
end)


-- РљРЅРѕРїРєР° Р·Р°РєСЂС‹С‚РёСЏ
local closeBtn = Instance.new("TextButton", M)
closeBtn.Size = UDim2.new(0.9, 0, 0, 30)
closeBtn.Position = UDim2.new(0.05, 0, 0, 220)
closeBtn.Text = "Р—Р°РєСЂС‹С‚СЊ РјРµРЅСЋ"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 20)


closeBtn.MouseButton1Click:Connect(function()
 M.Visible = false
 OB.Text = "РњРµРЅСЋ"
end)


OB.MouseButton1Click:Connect(function()
 M.Visible = not M.Visible
 OB.Text = M.Visible and "РњРµРЅСЋ" or "РњРµРЅСЋ "
end)
