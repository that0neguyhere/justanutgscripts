print([[
___________________________________
  
Kyutatsuki13's Stella the [T E C H N O . F A I R Y] script
Build 0002
Mmmmmh character designed by Kyu...
  
___________________________________
]])


warn("You're whitelisted, "..game:GetService("Players").LocalPlayer.Name.." :)")

local p = game:GetService("Players").LocalPlayer 
local char = p.Character
local mouse = p:GetMouse()
local larm = char:WaitForChild("Left Arm")
local rarm = char:WaitForChild("Right Arm")
local lleg = char:WaitForChild("Left Leg")
local rleg = char:WaitForChild("Right Leg")
local hed = char:WaitForChild("Head")
local torso = char:WaitForChild("Torso")
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:FindFirstChildOfClass("Humanoid")
local debris = game:GetService("Debris")
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local rs = run.RenderStepped
local wingpose = "Idle"
local DebrisModel = Instance.new("Model",char)
DebrisModel.Name = "Debris"
repeat rs:wait() until p.CharacterAppearanceLoaded

noidle = false
shift = false
control = false
no_nosound_able = true

----------------------------------------------------------------------------

function rswait(value)
	if value ~= nil and value ~= 0 then
		for i=1,value do
			rs:wait()
		end
	else
		rs:wait()
	end
end

----------------------------------------------------------------------------

local timeposition = 0

function music(id)
	if not torso:FindFirstChild("MusicRuin") then
		soundz = Instance.new("Sound",torso)
	end
	soundz.Volume = 0
	soundz.Name = "MusicRuin"
	soundz.Looped = true
	soundz.PlaybackSpeed = 1
	soundz.SoundId = "rbxassetid://"..id
	soundz:Stop()
	soundz:Play()
	if no_nosound_able == true then
		soundz.TimePosition = timeposition
	end
end

----------------------------------------------------------------------------

function lerp(a, b, t)
	return a + (b - a)*t
end

----------------------------------------------------------------------------

function Lerp(c1,c2,al)
	local com1 = {c1.X,c1.Y,c1.Z,c1:toEulerAnglesXYZ()}
	local com2 = {c2.X,c2.Y,c2.Z,c2:toEulerAnglesXYZ()}
	for i,v in pairs(com1) do
		com1[i] = v+(com2[i]-v)*al
	end
	return CFrame.new(com1[1],com1[2],com1[3]) * CFrame.Angles(select(4,unpack(com1)))
end

----------------------------------------------------------------------------

function slerp(a, b, t)
	dot = a:Dot(b)
	if dot > 0.99999 or dot < -0.99999 then
		return t <= 0.5 and a or b
	else
		r = math.acos(dot)
		return (a*math.sin((1 - t)*r) + b*math.sin(t*r)) / math.sin(r)
	end
end

----------------------------------------------------------------------------

function clerp(c1,c2,al)

	local com1 = {c1.X,c1.Y,c1.Z,c1:toEulerAnglesXYZ()}

	local com2 = {c2.X,c2.Y,c2.Z,c2:toEulerAnglesXYZ()}

	for i,v in pairs(com1) do

		com1[i] = lerp(v,com2[i],al)

	end

	return CFrame.new(com1[1],com1[2],com1[3]) * CFrame.Angles(select(4,unpack(com1)))

end

----------------------------------------------------------------------------

function findAllNearestTorso(pos,dist)
	local list = workspace:children()
	local torso = {}
	local temp = nil
	local human = nil
	local temp2 = nil
	for x = 1, #list do
		temp2 = list[x]
		if (temp2.className == "Model") and (temp2 ~= char) then
			temp = temp2:findFirstChild("Torso")
			human = temp2:findFirstChildOfClass("Humanoid")
			if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
				if (temp.Position - pos).magnitude < dist then
					table.insert(torso,temp)
					dist = (temp.Position - pos).magnitude
				end
			end
		end
	end
	return torso
end

----------------------------------------------------------------------------

function checkIfNotPlayer(model)
	if model.CanCollide == true and model ~= char and model.Parent ~= char and model.Parent.Parent ~= char and model.Parent.Parent ~= char and model.Parent ~= DebrisModel and model.Parent.Parent ~= DebrisModel and model.Parent.Parent.Parent ~= DebrisModel and model ~= wings and model.Parent ~= wings and model.Parent.Parent ~= wings then
		return true
	else
		return false
	end
end

----------------------------------------------------------------------------

function newWeld(wp0, wp1, wc0x, wc0y, wc0z)

	local wld = Instance.new("Weld", wp1)

	wld.Part0 = wp0

	wld.Part1 = wp1

	wld.C0 = CFrame.new(wc0x, wc0y, wc0z)

	return wld

end

function weld(model)
	local parts,last = {}
	local function scan(parent)
		for _,v in pairs(parent:GetChildren()) do
			if (v:IsA("BasePart")) then
				if (last) then
					local w = Instance.new("Weld")
					w.Name = ("%s_Weld"):format(v.Name)
					w.Part0,w.Part1 = last,v
					w.C0 = last.CFrame:inverse()
					w.C1 = v.CFrame:inverse()
					w.Parent = last
				end
				last = v
				table.insert(parts,v)
			end
			scan(v)
		end
	end
	scan(model)
	for _,v in pairs(parts) do
		v.Anchored = false
		v.Locked = true
		v.Anchored = false
		v.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		v.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		v.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		v.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		v.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		v.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		v.CustomPhysicalProperties = PhysicalProperties.new(0,0,0)
	end
end

----------------------------------------------------------------------------

function calculate(part,asd)
	local Head = hed
	local RightShoulder = asd
	local RightArm = part
	local MousePosition = mouse.Hit.p
	local ToMouse = (MousePosition - Head.Position).unit
	local Angle = math.acos(ToMouse:Dot(Vector3.new(0, 1, 0)))
	local FromRightArmPos = (Head.Position + Head.CFrame:vectorToWorldSpace(Vector3.new(((Head.Size.X / 2) + (RightArm.Size.X / 2)), ((Head.Size.Y / 2) - (RightArm.Size.Z / 2)), 0)))
	local ToMouseRightArm = ((MousePosition - FromRightArmPos) * Vector3.new(1 ,0, 1)).unit
	local Look = (Head.CFrame.lookVector * Vector3.new(1, 0, 1)).unit
	local LateralAngle = math.acos(ToMouseRightArm:Dot(Look))
	if tostring(LateralAngle) == "-1.#IND" then
		LateralAngle = 0
	end
	local Cross = Head.CFrame.lookVector:Cross(ToMouseRightArm)
	if LateralAngle > (math.pi / 2) then
		LateralAngle = (math.pi / 2)
		local Torso = root
		local Point = Torso.CFrame:vectorToObjectSpace(mouse.Hit.p-Torso.CFrame.p)
		if Point.Z > 0 then
			if Point.X > -0 and RightArm == rarm then
				Torso.CFrame = CFrame.new(Torso.Position,Vector3.new(mouse.Hit.X,Torso.Position.Y,mouse.Hit.Z))*CFrame.Angles(0,math.rad(110),0)
			elseif Point.X < 0 and RightArm == rarm then
				Torso.CFrame = CFrame.new(Torso.Position,Vector3.new(mouse.Hit.X,Torso.Position.Y,mouse.Hit.Z))*CFrame.Angles(0,math.rad(-110),0)
			end
		end
	end
	if Cross.Y < 0 then
		LateralAngle = -LateralAngle
	end
	return(CFrame.Angles(((math.pi / 2) - Angle), ((math.pi / 2) + LateralAngle), math.pi/2))
end

----------------------------------------------------------------------------

function sound(id,position,vol,pitch,start,finish)
	coroutine.resume(coroutine.create(function()

		local part = Instance.new("Part",workspace)
		part.Position = position
		part.Size = Vector3.new(0,0,0)
		part.CanCollide = false
		part.Transparency = 1

		local sound = Instance.new("Sound",part)

		sound.SoundId = "rbxassetid://"..id

		repeat rs:wait() until sound.IsLoaded

		if vol ~= nil then
			sound.Volume = vol
		end

		if pitch ~= nil then
			sound.PlaybackSpeed = pitch
		end

		if start ~= nil then
			sound.TimePosition = start
		end

		if finish ~= nil then
			debris:AddItem(part,finish-start)
		else
			debris:AddItem(part,sound.TimeLength)
		end

		sound:Play()  

		return sound

	end))
end

----------------------------------------------------------------------------

function computeDirection(vec)
	local lenSquared = vec.magnitude * vec.magnitude
	local invSqrt = 1 / math.sqrt(lenSquared)
	return Vector3.new(vec.x * invSqrt, vec.y * invSqrt, vec.z * invSqrt)
end

----------------------------------------------------------------------------

local shaking = 0
function shake(num) if num > shaking then shaking = num end end
game:GetService("RunService").RenderStepped:connect(function()
	hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))*(shaking/100)
	if shaking > 0 then shaking = shaking - 1 else shaking = 0 end
end)

plr = game:GetService("Players").LocalPlayer
DebrisModel = Instance.new("Model",plr.Character)
DebrisModel.Name = "DebrisModel"

function Effect(mesh,size,transparency,material,color,position,rotation,positionchange,sizechange,rotationchange,transparencychange,acceleration)

	local part = Instance.new("Part",DebrisModel)
	part.Anchored = true
	part.CanCollide = false
	part.Size = Vector3.new(1,1,1)
	part.Transparency = transparency
	part.Material = material
	part.Color = color
	part.CFrame = CFrame.new(position)*CFrame.Angles(math.rad(rotation.X),math.rad(rotation.Y),math.rad(rotation.Z))

	local partmesh = Instance.new("SpecialMesh",part)
	if tonumber(mesh) == nil then partmesh.MeshType = mesh else partmesh.MeshId = "rbxassetid://"..mesh end
	partmesh.Scale = size

	local pvalue = Instance.new("Vector3Value",part)
	pvalue.Name = "Position"
	pvalue.Value = positionchange

	local svalue = Instance.new("Vector3Value",part)
	svalue.Name = "Size"
	svalue.Value = sizechange

	local rvalue = Instance.new("Vector3Value",part)
	rvalue.Name = "Rotation"
	rvalue.Value = rotationchange

	local tvalue = Instance.new("NumberValue",part)
	tvalue.Name = "Transparency"
	tvalue.Value = transparencychange

	local avalue = Instance.new("NumberValue",part)
	avalue.Name = "Acceleration"
	avalue.Value = acceleration

	part.Name = "EFFECT"

	return part

end

game:GetService("RunService").RenderStepped:connect(function()
	coroutine.resume(coroutine.create(function()

		if not plr.Character:FindFirstChild("DebrisModel") then
			DebrisModel = Instance.new("Model",plr.Character)
			DebrisModel.Name = "DebrisModel"
		end

		for i,v in pairs(DebrisModel:GetChildren()) do
			if v:IsA("BasePart") and v.Name == "EFFECT" then
				local pvalue = v:FindFirstChild("Position").Value
				local svalue = v:FindFirstChild("Size").Value
				local rvalue = v:FindFirstChild("Rotation").Value
				local tvalue = v:FindFirstChild("Transparency").Value
				local avalue = v:FindFirstChild("Acceleration").Value
				local mesh = v:FindFirstChild("Mesh")
				mesh.Scale = mesh.Scale + svalue
				v:FindFirstChild("Size").Value = v:FindFirstChild("Size").Value + (Vector3.new(1,1,1)*avalue)
				v.Transparency = v.Transparency + tvalue
				v.CFrame = CFrame.new(pvalue)*v.CFrame*CFrame.Angles(math.rad(rvalue.X),math.rad(rvalue.Y),math.rad(rvalue.Z))
				if v.Transparency >= 1 or mesh.Scale.X < 0 or mesh.Scale.Y < 0 or mesh.Scale.Z < 0 then
					v:Destroy()
				end
			end
		end

	end))
end)

----------------------------------------------------------------------------

local size = 1

newWeld(torso, larm, -1.5, 0.5, 0)
larm.Weld.C1 = CFrame.new(0, 0.5, 0)
newWeld(torso, rarm, 1.5, 0.5, 0)
rarm.Weld.C1 = CFrame.new(0, 0.5, 0)
newWeld(torso, hed, 0, 1.5, 0)
newWeld(torso, lleg, -0.5, -1, 0)
lleg.Weld.C1 = CFrame.new(0, 1, 0)
newWeld(torso, rleg, 0.5, -1, 0)
rleg.Weld.C1 = CFrame.new(0, 1, 0)
newWeld(root, torso, 0, -1, 0)
torso.Weld.C1 = CFrame.new(0, -1, 0)

emitters={}

----------------------------------------------------------------------------------------

Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
Part2 = Instance.new("Part")
Part3 = Instance.new("Part")
Part4 = Instance.new("Part")
Part5 = Instance.new("Part")
SpecialMesh6 = Instance.new("SpecialMesh")
Part7 = Instance.new("Part")
SpecialMesh8 = Instance.new("SpecialMesh")
Part9 = Instance.new("Part")
Part10 = Instance.new("Part")
Part11 = Instance.new("Part")
Model0.Name = "3"
Model0.Parent = char
Part1.Parent = Model0
Part1.Material = Enum.Material.Neon
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(1.60000002, 0.400000006, 0.100000001)
Part1.CFrame = CFrame.new(-22.6299973, 18, 15.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-22.6299973, 18, 15.5)
Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part2.Parent = Model0
Part2.Material = Enum.Material.Neon
Part2.Anchored = true
Part2.CanCollide = false
Part2.Size = Vector3.new(1.62000012, 0.419999987, 0.0800000057)
Part2.CFrame = CFrame.new(-22.6299973, 18, 15.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Position = Vector3.new(-22.6299973, 18, 15.5)
Part2.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part3.Parent = Model0
Part3.Material = Enum.Material.Neon
Part3.Anchored = true
Part3.CanCollide = false
Part3.Size = Vector3.new(1.10000002, 0.320000023, 0.0800000057)
Part3.CFrame = CFrame.new(-23.9799976, 17.9500008, 15.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Position = Vector3.new(-23.9799976, 17.9500008, 15.5)
Part3.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part4.Parent = Model0
Part4.Material = Enum.Material.Neon
Part4.Rotation = Vector3.new(-180, 0, -18.4300003)
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(0.316227764, 0.284604996, 0.100000001)
Part4.CFrame = CFrame.new(-23.5349979, 18.0149994, 15.5, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-23.5349979, 18.0149994, 15.5)
Part4.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part5.Parent = Model0
Part5.Material = Enum.Material.Neon
Part5.Rotation = Vector3.new(-180, 90, 0)
Part5.Anchored = true
Part5.CanCollide = false
Part5.Size = Vector3.new(0.0799999461, 0.320000023, 1.05000007)
Part5.CFrame = CFrame.new(-25.0549965, 17.9500008, 15.5, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part5.BottomSurface = Enum.SurfaceType.Smooth
Part5.TopSurface = Enum.SurfaceType.Smooth
Part5.Position = Vector3.new(-25.0549965, 17.9500008, 15.5)
Part5.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh6.Parent = Part5
SpecialMesh6.MeshType = Enum.MeshType.Wedge
Part7.Parent = Model0
Part7.Material = Enum.Material.Neon
Part7.Rotation = Vector3.new(-180, 90, 0)
Part7.Anchored = true
Part7.CanCollide = false
Part7.Size = Vector3.new(0.0999999419, 0.300000012, 1)
Part7.CFrame = CFrame.new(-25.0299969, 17.9500008, 15.5, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Position = Vector3.new(-25.0299969, 17.9500008, 15.5)
Part7.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh8.Parent = Part7
SpecialMesh8.MeshType = Enum.MeshType.Wedge
Part9.Parent = Model0
Part9.Material = Enum.Material.Neon
Part9.Anchored = true
Part9.CanCollide = false
Part9.Size = Vector3.new(1.10000002, 0.300000012, 0.100000001)
Part9.CFrame = CFrame.new(-23.9799976, 17.9500008, 15.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Position = Vector3.new(-23.9799976, 17.9500008, 15.5)
Part9.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part10.Name = "asd"
Part10.Parent = Model0
Part10.Material = Enum.Material.Neon
Part10.Transparency = 1
Part10.Anchored = true
Part10.CanCollide = false
Part10.Size = Vector3.new(0.400000006, 0.400000006, 0.120000005)
Part10.CFrame = CFrame.new(-22.0299969, 18, 15.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Position = Vector3.new(-22.0299969, 18, 15.5)
Part10.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part11.Parent = Model0
Part11.Material = Enum.Material.Neon
Part11.Rotation = Vector3.new(-180, 0, -18.4300003)
Part11.Anchored = true
Part11.CanCollide = false
Part11.Size = Vector3.new(0.316227764, 0.304604977, 0.0800000057)
Part11.CFrame = CFrame.new(-23.5349979, 18.0149994, 15.5, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Position = Vector3.new(-23.5349979, 18.0149994, 15.5)
Part11.Color = Color3.new(0.384314, 0.145098, 0.819608)
weld(Model0)
Model1 = Model0:Clone()
Model1.Parent = char
l1=newWeld(torso,Model0.asd,-0.8,0.8,0.5)
r1=newWeld(torso,Model1.asd,0.8,0.8,0.5)
Model1.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)

Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
Part2 = Instance.new("Part")
SpecialMesh3 = Instance.new("SpecialMesh")
Part4 = Instance.new("Part")
Part5 = Instance.new("Part")
SpecialMesh6 = Instance.new("SpecialMesh")
Part7 = Instance.new("Part")
Part8 = Instance.new("Part")
Part9 = Instance.new("Part")
Part10 = Instance.new("Part")
Part11 = Instance.new("Part")
Model0.Name = "2"
Model0.Parent = char
Part1.Parent = Model0
Part1.Material = Enum.Material.Neon
Part1.Rotation = Vector3.new(-180, 0, -18.4300003)
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(0.252982229, 0.227684006, 0.0800000057)
Part1.CFrame = CFrame.new(-23.567997, 16.0119991, 15.75, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-23.567997, 16.0119991, 15.75)
Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part2.Parent = Model0
Part2.Material = Enum.Material.Neon
Part2.Rotation = Vector3.new(-180, 90, 0)
Part2.Anchored = true
Part2.CanCollide = false
Part2.Size = Vector3.new(0.0799999535, 0.24000001, 0.800000012)
Part2.CFrame = CFrame.new(-24.7639961, 15.960001, 15.75, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Position = Vector3.new(-24.7639961, 15.960001, 15.75)
Part2.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh3.Parent = Part2
SpecialMesh3.MeshType = Enum.MeshType.Wedge
Part4.Parent = Model0
Part4.Material = Enum.Material.Neon
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(1.29600012, 0.335999995, 0.064000003)
Part4.CFrame = CFrame.new(-22.843998, 16, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-22.843998, 16, 15.75)
Part4.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part5.Parent = Model0
Part5.Material = Enum.Material.Neon
Part5.Rotation = Vector3.new(-180, 90, 0)
Part5.Anchored = true
Part5.CanCollide = false
Part5.Size = Vector3.new(0.0639999583, 0.256000012, 0.840000093)
Part5.CFrame = CFrame.new(-24.7839966, 15.960001, 15.75, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part5.BottomSurface = Enum.SurfaceType.Smooth
Part5.TopSurface = Enum.SurfaceType.Smooth
Part5.Position = Vector3.new(-24.7839966, 15.960001, 15.75)
Part5.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh6.Parent = Part5
SpecialMesh6.MeshType = Enum.MeshType.Wedge
Part7.Parent = Model0
Part7.Material = Enum.Material.Neon
Part7.Anchored = true
Part7.CanCollide = false
Part7.Size = Vector3.new(0.880000055, 0.256000012, 0.064000003)
Part7.CFrame = CFrame.new(-23.9239979, 15.960001, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Position = Vector3.new(-23.9239979, 15.960001, 15.75)
Part7.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part8.Parent = Model0
Part8.Material = Enum.Material.Neon
Part8.Rotation = Vector3.new(-180, 0, -18.4300003)
Part8.Anchored = true
Part8.CanCollide = false
Part8.Size = Vector3.new(0.252982229, 0.243683979, 0.064000003)
Part8.CFrame = CFrame.new(-23.567997, 16.0119991, 15.75, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Position = Vector3.new(-23.567997, 16.0119991, 15.75)
Part8.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part9.Parent = Model0
Part9.Material = Enum.Material.Neon
Part9.Anchored = true
Part9.CanCollide = false
Part9.Size = Vector3.new(0.880000055, 0.24000001, 0.0800000057)
Part9.CFrame = CFrame.new(-23.9239979, 15.960001, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part9.BottomSurface = Enum.SurfaceType.Smooth
Part9.TopSurface = Enum.SurfaceType.Smooth
Part9.Position = Vector3.new(-23.9239979, 15.960001, 15.75)
Part9.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part10.Parent = Model0
Part10.Material = Enum.Material.Neon
Part10.Anchored = true
Part10.CanCollide = false
Part10.Size = Vector3.new(1.28000009, 0.320000023, 0.0800000057)
Part10.CFrame = CFrame.new(-22.843998, 16, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Position = Vector3.new(-22.843998, 16, 15.75)
Part10.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part11.Name = "asd"
Part11.Parent = Model0
Part11.Material = Enum.Material.Neon
Part11.Transparency = 1
Part11.Anchored = true
Part11.CanCollide = false
Part11.Size = Vector3.new(0.320000023, 0.320000023, 0.0960000083)
Part11.CFrame = CFrame.new(-22.3639965, 16, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Position = Vector3.new(-22.3639965, 16, 15.75)
Part11.Color = Color3.new(0.0156863, 0.686275, 0.92549)
weld(Model0)
Model1 = Model0:Clone()
Model1.Parent = char
l2=newWeld(torso,Model0.asd,-0.8,0.6,0.5)
r2=newWeld(torso,Model1.asd,0.8,0.6,0.5)
Model1.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)

Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
Part2 = Instance.new("Part")
Part3 = Instance.new("Part")
Part4 = Instance.new("Part")
SpecialMesh5 = Instance.new("SpecialMesh")
Part6 = Instance.new("Part")
Part7 = Instance.new("Part")
Part8 = Instance.new("Part")
SpecialMesh9 = Instance.new("SpecialMesh")
Part10 = Instance.new("Part")
Part11 = Instance.new("Part")
Model0.Name = "1"
Model0.Parent = char
Part1.Parent = Model0
Part1.Material = Enum.Material.Neon
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(0.704000056, 0.192000017, 0.064000003)
Part1.CFrame = CFrame.new(-23.8791981, 13.9680004, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-23.8791981, 13.9680004, 15.75)
Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part2.Parent = Model0
Part2.Material = Enum.Material.Neon
Part2.Rotation = Vector3.new(-180, 0, -18.4300003)
Part2.Anchored = true
Part2.CanCollide = false
Part2.Size = Vector3.new(0.202385783, 0.194947183, 0.0512000024)
Part2.CFrame = CFrame.new(-23.5943966, 14.0095997, 15.75, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Position = Vector3.new(-23.5943966, 14.0095997, 15.75)
Part2.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part3.Parent = Model0
Part3.Material = Enum.Material.Neon
Part3.Rotation = Vector3.new(-180, 0, -18.4300003)
Part3.Anchored = true
Part3.CanCollide = false
Part3.Size = Vector3.new(0.202385783, 0.182147205, 0.064000003)
Part3.CFrame = CFrame.new(-23.5943966, 14.0095997, 15.75, 0.948683262, 0.316227764, 0, 0.316227764, -0.948683262, 0, 0, 0, -1)
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Position = Vector3.new(-23.5943966, 14.0095997, 15.75)
Part3.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part4.Parent = Model0
Part4.Material = Enum.Material.Neon
Part4.Rotation = Vector3.new(-180, 90, 0)
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(0.0639999658, 0.192000017, 0.640000045)
Part4.CFrame = CFrame.new(-24.5511971, 13.9680004, 15.75, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-24.5511971, 13.9680004, 15.75)
Part4.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh5.Parent = Part4
SpecialMesh5.MeshType = Enum.MeshType.Wedge
Part6.Parent = Model0
Part6.Material = Enum.Material.Neon
Part6.Anchored = true
Part6.CanCollide = false
Part6.Size = Vector3.new(1.03680015, 0.26879999, 0.0512000024)
Part6.CFrame = CFrame.new(-23.0151978, 14, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Position = Vector3.new(-23.0151978, 14, 15.75)
Part6.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part7.Name = "asd"
Part7.Parent = Model0
Part7.Material = Enum.Material.Neon
Part7.Transparency = 1
Part7.Anchored = true
Part7.CanCollide = false
Part7.Size = Vector3.new(0.256000012, 0.256000012, 0.0768000111)
Part7.CFrame = CFrame.new(-22.631197, 14, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part7.BottomSurface = Enum.SurfaceType.Smooth
Part7.TopSurface = Enum.SurfaceType.Smooth
Part7.Position = Vector3.new(-22.631197, 14, 15.75)
Part7.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part8.Parent = Model0
Part8.Material = Enum.Material.Neon
Part8.Rotation = Vector3.new(-180, 90, 0)
Part8.Anchored = true
Part8.CanCollide = false
Part8.Size = Vector3.new(0.0511999689, 0.20480001, 0.67200011)
Part8.CFrame = CFrame.new(-24.5671959, 13.9680004, 15.75, -4.37113883e-08, 0, 1, -8.74227766e-08, -0.99999994, -3.82137093e-15, 1, -8.74227695e-08, 4.37113883e-08)
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Position = Vector3.new(-24.5671959, 13.9680004, 15.75)
Part8.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh9.Parent = Part8
SpecialMesh9.MeshType = Enum.MeshType.Wedge
Part10.Parent = Model0
Part10.Material = Enum.Material.Neon
Part10.Anchored = true
Part10.CanCollide = false
Part10.Size = Vector3.new(1.02400005, 0.256000012, 0.064000003)
Part10.CFrame = CFrame.new(-23.0151978, 14, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Position = Vector3.new(-23.0151978, 14, 15.75)
Part10.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part11.Parent = Model0
Part11.Material = Enum.Material.Neon
Part11.Anchored = true
Part11.CanCollide = false
Part11.Size = Vector3.new(0.704000056, 0.20480001, 0.0512000024)
Part11.CFrame = CFrame.new(-23.8791981, 13.9680004, 15.75, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Position = Vector3.new(-23.8791981, 13.9680004, 15.75)
Part11.Color = Color3.new(0.384314, 0.145098, 0.819608)
weld(Model0)
Model1 = Model0:Clone()
Model1.Parent = char
l3=newWeld(torso,Model0.asd,-0.8,0.4,0.5)
r3=newWeld(torso,Model1.asd,0.8,0.4,0.5)
Model1.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)

Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
SpecialMesh2 = Instance.new("SpecialMesh")
Part3 = Instance.new("Part")
Part4 = Instance.new("Part")
SpecialMesh5 = Instance.new("SpecialMesh")
Part6 = Instance.new("Part")
SpecialMesh7 = Instance.new("SpecialMesh")
Part8 = Instance.new("Part")
SpecialMesh9 = Instance.new("SpecialMesh")
Part10 = Instance.new("Part")
Part11 = Instance.new("Part")
SpecialMesh12 = Instance.new("SpecialMesh")
Model0.Parent = char
Part1.Parent = Model0
Part1.Rotation = Vector3.new(0, 90, 0)
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(0.42840001, 0.894600034, 1.18440008)
Part1.CFrame = CFrame.new(-40.6850014, 7.97090054, 29, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-40.6850014, 7.97090054, 29)
Part1.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh2.Parent = Part1
SpecialMesh2.MeshType = Enum.MeshType.Cylinder
Part3.Parent = Model0
Part3.Rotation = Vector3.new(0, 90, 0)
Part3.Anchored = true
Part3.CanCollide = false
Part3.Size = Vector3.new(0.42840001, 0.447300076, 1.52460003)
Part3.CFrame = CFrame.new(-41, 7.74725056, 29, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Position = Vector3.new(-41, 7.74725056, 29)
Part3.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part4.Parent = Model0
Part4.Rotation = Vector3.new(0, 90, 0)
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(0.42840001, 0.894600034, 1.18440008)
Part4.CFrame = CFrame.new(-41.3149986, 7.97090054, 29, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-41.3149986, 7.97090054, 29)
Part4.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh5.Parent = Part4
SpecialMesh5.MeshType = Enum.MeshType.Cylinder
Part6.Parent = Model0
Part6.Anchored = true
Part6.CanCollide = false
Part6.Size = Vector3.new(1.71360004, 0.504000008, 0.504000008)
Part6.CFrame = CFrame.new(-41, 7.61180019, 29, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Position = Vector3.new(-41, 7.61180019, 29)
Part6.Color = Color3.new(0.384314, 0.145098, 0.819608)
SpecialMesh7.Parent = Part6
SpecialMesh7.MeshType = Enum.MeshType.Cylinder
Part8.Name = "asd"
Part8.Parent = Model0
Part8.Transparency = 1
Part8.Anchored = true
Part8.CanCollide = false
Part8.Size = Vector3.new(2.51999998, 1.25999999, 1.25999999)
Part8.CFrame = CFrame.new(-41, 7.61180019, 29, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Position = Vector3.new(-41, 7.61180019, 29)
SpecialMesh9.Parent = Part8
SpecialMesh9.Scale = Vector3.new(1.25, 1.25, 1.25)
SpecialMesh9.Scale = Vector3.new(1.25, 1.25, 1.25)
Part10.Parent = Model0
Part10.Rotation = Vector3.new(0, 90, 0)
Part10.Anchored = true
Part10.CanCollide = false
Part10.Size = Vector3.new(0.42840001, 0.894600153, 0.630000055)
Part10.CFrame = CFrame.new(-41, 7.97089958, 29, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Position = Vector3.new(-41, 7.97089958, 29)
Part10.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part11.Parent = Model0
Part11.Material = Enum.Material.Neon
Part11.Anchored = true
Part11.CanCollide = false
Part11.Size = Vector3.new(1.73879993, 0.453599989, 0.453599989)
Part11.CFrame = CFrame.new(-41, 7.61180019, 29, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Position = Vector3.new(-41, 7.61180019, 29)
Part11.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh12.Parent = Part11
SpecialMesh12.MeshType = Enum.MeshType.Cylinder
weld(Model0)
newWeld(hed,Model0.asd,0,0.15,0)

Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
Part2 = Instance.new("Part")
Part3 = Instance.new("Part")
Part4 = Instance.new("Part")
Model0.Parent = char
Part1.Parent = Model0
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(1.01999998, 1.20000005, 1.01999998)
Part1.CFrame = CFrame.new(-126, 27.1849995, 11, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-126, 27.1849995, 11)
Part1.Color = Color3.new(0.105882, 0.164706, 0.207843)
Part2.Name = "asd"
Part2.Parent = Model0
Part2.Transparency = 1
Part2.Anchored = true
Part2.CanCollide = false
Part2.Size = Vector3.new(1, 2, 1)
Part2.CFrame = CFrame.new(-126, 27.5949993, 11, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part2.BottomSurface = Enum.SurfaceType.Smooth
Part2.TopSurface = Enum.SurfaceType.Smooth
Part2.Position = Vector3.new(-126, 27.5949993, 11)
Part3.Parent = Model0
Part3.Anchored = true
Part3.CanCollide = false
Part3.Size = Vector3.new(1.01999998, 0.0799999833, 0.289999962)
Part3.CFrame = CFrame.new(-126, 26.5450001, 10.6350002, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Position = Vector3.new(-126, 26.5450001, 10.6350002)
Part3.Color = Color3.new(0.105882, 0.164706, 0.207843)
Part4.Parent = Model0
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(1.01999998, 0.0799999833, 0.590000033)
Part4.CFrame = CFrame.new(-126, 26.5450001, 11.2150002, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-126, 26.5450001, 11.2150002)
Part4.Color = Color3.new(0.105882, 0.164706, 0.207843)
weld(Model0)
Model1 = Model0:Clone()
Model1.Parent = char
newWeld(lleg,Model0.asd,0,0,0)
newWeld(rleg,Model1.asd,0,0,0)
Model0.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)
Model1.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)

Model0 = Instance.new("Model")
WedgePart1 = Instance.new("WedgePart")
WedgePart2 = Instance.new("WedgePart")
WedgePart3 = Instance.new("WedgePart")
WedgePart4 = Instance.new("WedgePart")
WedgePart5 = Instance.new("WedgePart")
WedgePart6 = Instance.new("WedgePart")
WedgePart7 = Instance.new("WedgePart")
Part8 = Instance.new("Part")
WedgePart9 = Instance.new("WedgePart")
WedgePart10 = Instance.new("WedgePart")
Part11 = Instance.new("Part")
Part12 = Instance.new("Part")
WedgePart13 = Instance.new("WedgePart")
Model0.Parent = char
WedgePart1.Name = "Part"
WedgePart1.Parent = Model0
WedgePart1.Material = Enum.Material.Neon
WedgePart1.Rotation = Vector3.new(-108, 0, -180)
WedgePart1.Anchored = true
WedgePart1.CanCollide = false
WedgePart1.FormFactor = Enum.FormFactor.Custom
WedgePart1.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart1.CFrame = CFrame.new(-96.4881439, 27.3141098, 11.1037397, -1, 1.92567839e-07, -1.35075409e-08, 4.66602721e-08, 0.309017152, 0.951056719, 1.87316914e-07, 0.951056778, -0.309017181)
WedgePart1.BottomSurface = Enum.SurfaceType.Smooth
WedgePart1.Position = Vector3.new(-96.4881439, 27.3141098, 11.1037397)
WedgePart1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart2.Name = "Part"
WedgePart2.Parent = Model0
WedgePart2.Material = Enum.Material.Neon
WedgePart2.Rotation = Vector3.new(-144, 0, 0)
WedgePart2.Anchored = true
WedgePart2.CanCollide = false
WedgePart2.FormFactor = Enum.FormFactor.Custom
WedgePart2.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart2.CFrame = CFrame.new(-96.4881439, 27.2292633, 10.9869566, 1, 1.25302876e-07, -3.53632679e-08, 1.22158227e-07, -0.809017241, 0.587785363, 4.50418014e-08, -0.587785423, -0.809017301)
WedgePart2.BottomSurface = Enum.SurfaceType.Smooth
WedgePart2.Position = Vector3.new(-96.4881439, 27.2292633, 10.9869566)
WedgePart2.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart3.Name = "Part"
WedgePart3.Parent = Model0
WedgePart3.Material = Enum.Material.Neon
WedgePart3.Rotation = Vector3.new(144, 0, 0)
WedgePart3.Anchored = true
WedgePart3.CanCollide = false
WedgePart3.FormFactor = Enum.FormFactor.Custom
WedgePart3.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart3.CFrame = CFrame.new(-96.4881439, 27.2702789, 11.0894966, 1, 1.76688729e-07, -3.53633034e-08, 1.22158212e-07, -0.809017181, -0.587785423, -1.32464464e-07, 0.587785482, -0.809017241)
WedgePart3.BottomSurface = Enum.SurfaceType.Smooth
WedgePart3.Position = Vector3.new(-96.4881439, 27.2702789, 11.0894966)
WedgePart3.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart4.Name = "Part"
WedgePart4.Parent = Model0
WedgePart4.Material = Enum.Material.Neon
WedgePart4.Anchored = true
WedgePart4.CanCollide = false
WedgePart4.FormFactor = Enum.FormFactor.Custom
WedgePart4.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart4.CFrame = CFrame.new(-96.4881439, 27.4075661, 10.9751081, 1, 1.61467536e-14, 4.37114345e-08, 8.69356246e-15, 1.00000024, 0, -4.37113421e-08, -7.05797007e-22, 1.00000036)
WedgePart4.BottomSurface = Enum.SurfaceType.Smooth
WedgePart4.Position = Vector3.new(-96.4881439, 27.4075661, 10.9751081)
WedgePart4.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart5.Name = "Part"
WedgePart5.Parent = Model0
WedgePart5.Material = Enum.Material.Neon
WedgePart5.Rotation = Vector3.new(-180, 0, -180)
WedgePart5.Anchored = true
WedgePart5.CanCollide = false
WedgePart5.FormFactor = Enum.FormFactor.Custom
WedgePart5.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart5.CFrame = CFrame.new(-96.4881439, 27.4075661, 11.0448904, -1, 1.61467536e-14, -4.37114345e-08, -8.69356246e-15, 1.00000024, 0, 4.37113421e-08, -7.05797007e-22, -1.00000036)
WedgePart5.BottomSurface = Enum.SurfaceType.Smooth
WedgePart5.Position = Vector3.new(-96.4881439, 27.4075661, 11.0448904)
WedgePart5.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart6.Name = "Part"
WedgePart6.Parent = Model0
WedgePart6.Material = Enum.Material.Neon
WedgePart6.Rotation = Vector3.new(72, 0, 0)
WedgePart6.Anchored = true
WedgePart6.CanCollide = false
WedgePart6.FormFactor = Enum.FormFactor.Custom
WedgePart6.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart6.CFrame = CFrame.new(-96.4881439, 27.380476, 11.0821753, 1, 1.92567839e-07, 1.35075409e-08, -4.66602721e-08, 0.309017152, -0.951056719, -1.87316914e-07, 0.951056778, 0.309017181)
WedgePart6.BottomSurface = Enum.SurfaceType.Smooth
WedgePart6.Position = Vector3.new(-96.4881439, 27.380476, 11.0821753)
WedgePart6.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart7.Name = "Part"
WedgePart7.Parent = Model0
WedgePart7.Material = Enum.Material.Neon
WedgePart7.Rotation = Vector3.new(-72, 0, 0)
WedgePart7.Anchored = true
WedgePart7.CanCollide = false
WedgePart7.FormFactor = Enum.FormFactor.Custom
WedgePart7.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart7.CFrame = CFrame.new(-96.4881439, 27.3141098, 10.9162607, 1, 4.58507792e-08, 1.35075773e-08, -2.70151279e-08, 0.309017092, 0.951056719, 3.94326847e-08, -0.951056778, 0.309017122)
WedgePart7.BottomSurface = Enum.SurfaceType.Smooth
WedgePart7.Position = Vector3.new(-96.4881439, 27.3141098, 10.9162607)
WedgePart7.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part8.Parent = Model0
Part8.Anchored = true
Part8.CanCollide = false
Part8.Size = Vector3.new(0.539999962, 0.149999961, 1.01999998)
Part8.CFrame = CFrame.new(-96.2506638, 27.0200005, 11, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Position = Vector3.new(-96.2506638, 27.0200005, 11)
Part8.Color = Color3.new(0.384314, 0.145098, 0.819608)
WedgePart9.Name = "Part"
WedgePart9.Parent = Model0
WedgePart9.Material = Enum.Material.Neon
WedgePart9.Rotation = Vector3.new(-36, 0, -180)
WedgePart9.Anchored = true
WedgePart9.CanCollide = false
WedgePart9.FormFactor = Enum.FormFactor.Custom
WedgePart9.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart9.CFrame = CFrame.new(-96.4881439, 27.2292633, 11.0330429, -1, 1.76688729e-07, 3.53633034e-08, -1.22158212e-07, -0.809017181, 0.587785423, 1.32464464e-07, 0.587785482, 0.809017241)
WedgePart9.BottomSurface = Enum.SurfaceType.Smooth
WedgePart9.Position = Vector3.new(-96.4881439, 27.2292633, 11.0330429)
WedgePart9.Color = Color3.new(0.0156863, 0.686275, 0.92549)
WedgePart10.Name = "Part"
WedgePart10.Parent = Model0
WedgePart10.Material = Enum.Material.Neon
WedgePart10.Rotation = Vector3.new(108, 0, -180)
WedgePart10.Anchored = true
WedgePart10.CanCollide = false
WedgePart10.FormFactor = Enum.FormFactor.Custom
WedgePart10.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart10.CFrame = CFrame.new(-96.4881439, 27.380476, 10.9378242, -1, 4.58507792e-08, -1.35075773e-08, 2.70151279e-08, 0.309017092, -0.951056719, -3.94326847e-08, -0.951056778, -0.309017122)
WedgePart10.BottomSurface = Enum.SurfaceType.Smooth
WedgePart10.Position = Vector3.new(-96.4881439, 27.380476, 10.9378242)
WedgePart10.Color = Color3.new(0.0156863, 0.686275, 0.92549)
Part11.Parent = Model0
Part11.Anchored = true
Part11.CanCollide = false
Part11.Size = Vector3.new(1.01999998, 0.440000027, 1.01999998)
Part11.CFrame = CFrame.new(-96.0106659, 27.3150005, 11, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part11.BottomSurface = Enum.SurfaceType.Smooth
Part11.TopSurface = Enum.SurfaceType.Smooth
Part11.Position = Vector3.new(-96.0106659, 27.3150005, 11)
Part11.Color = Color3.new(0.384314, 0.145098, 0.819608)
Part12.Name = "asd"
Part12.Parent = Model0
Part12.Transparency = 1
Part12.Anchored = true
Part12.CanCollide = false
Part12.Size = Vector3.new(1, 2, 1)
Part12.CFrame = CFrame.new(-96.0106659, 27.9549999, 11, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Position = Vector3.new(-96.0106659, 27.9549999, 11)
WedgePart13.Name = "Part"
WedgePart13.Parent = Model0
WedgePart13.Material = Enum.Material.Neon
WedgePart13.Rotation = Vector3.new(36, 0, -180)
WedgePart13.Anchored = true
WedgePart13.CanCollide = false
WedgePart13.FormFactor = Enum.FormFactor.Custom
WedgePart13.Size = Vector3.new(0.069781214, 0.174453035, 0.069781214)
WedgePart13.CFrame = CFrame.new(-96.4881439, 27.2702789, 10.9305029, -1, 1.25302876e-07, 3.53632679e-08, -1.22158227e-07, -0.809017241, -0.587785363, -4.50418014e-08, -0.587785423, 0.809017301)
WedgePart13.BottomSurface = Enum.SurfaceType.Smooth
WedgePart13.Position = Vector3.new(-96.4881439, 27.2702789, 10.9305029)
WedgePart13.Color = Color3.new(0.0156863, 0.686275, 0.92549)
weld(Model0)
Model1 = Model0:Clone()
Model1.Parent = char
newWeld(larm,Model0.asd,0,0,0)
newWeld(rarm,Model1.asd,0,0,0)
Model1.asd.Weld.C1 = CFrame.Angles(0,math.rad(180),0)
--[[
Model0 = Instance.new("Model")
Part1 = Instance.new("Part")
SpecialMesh2 = Instance.new("SpecialMesh")
Part3 = Instance.new("Part")
Part4 = Instance.new("Part")
SpecialMesh5 = Instance.new("SpecialMesh")
Part6 = Instance.new("Part")
SpecialMesh7 = Instance.new("SpecialMesh")
Part8 = Instance.new("Part")
SpecialMesh9 = Instance.new("SpecialMesh")
Part10 = Instance.new("Part")
SpecialMesh11 = Instance.new("SpecialMesh")
Part12 = Instance.new("Part")
SpecialMesh13 = Instance.new("SpecialMesh")
Part14 = Instance.new("Part")
Part15 = Instance.new("Part")
Part16 = Instance.new("Part")
Part17 = Instance.new("Part")
Part18 = Instance.new("Part")
SpecialMesh19 = Instance.new("SpecialMesh")
Part20 = Instance.new("Part")
SpecialMesh21 = Instance.new("SpecialMesh")
Part22 = Instance.new("Part")
Model0.Parent = char
Part1.Parent = Model0
Part1.Rotation = Vector3.new(-90, 0, 90)
Part1.Anchored = true
Part1.CanCollide = false
Part1.Size = Vector3.new(0.0500000007, 0.170000002, 0.349999964)
Part1.CFrame = CFrame.new(-62.0849991, 28.1099987, 10.312499, 1.71961681e-14, -0.99999994, -3.93402502e-07, -4.37113883e-08, -3.93402445e-07, 1, -0.99999994, 0, -4.37113847e-08)
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.Position = Vector3.new(-62.0849991, 28.1099987, 10.312499)
Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh2.Parent = Part1
SpecialMesh2.MeshType = Enum.MeshType.Wedge
Part3.Parent = Model0
Part3.Anchored = true
Part3.CanCollide = false
Part3.Size = Vector3.new(2.02000022, 1.16000009, 1.01999998)
Part3.CFrame = CFrame.new(-62, 28.414999, 10.8424988, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part3.BottomSurface = Enum.SurfaceType.Smooth
Part3.TopSurface = Enum.SurfaceType.Smooth
Part3.Position = Vector3.new(-62, 28.414999, 10.8424988)
Part3.Color = Color3.new(0.129412, 0.329412, 0.72549)
Part4.Parent = Model0
Part4.Rotation = Vector3.new(-90, 0, -90)
Part4.Anchored = true
Part4.CanCollide = false
Part4.Size = Vector3.new(0.0500000007, 0.140000015, 0.159999996)
Part4.CFrame = CFrame.new(-61.9300003, 28.8049984, 10.312499, 8.74227837e-08, 0.99999994, -1.31134158e-07, -4.37113741e-08, 1.31134158e-07, 1, 0.99999994, -8.74227695e-08, 4.37113812e-08)
Part4.BottomSurface = Enum.SurfaceType.Smooth
Part4.TopSurface = Enum.SurfaceType.Smooth
Part4.Position = Vector3.new(-61.9300003, 28.8049984, 10.312499)
Part4.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh5.Parent = Part4
SpecialMesh5.MeshType = Enum.MeshType.Wedge
Part6.Parent = Model0
Part6.Rotation = Vector3.new(-90, 0, -90)
Part6.Anchored = true
Part6.CanCollide = false
Part6.Size = Vector3.new(0.0500000007, 0.170000002, 0.349999964)
Part6.CFrame = CFrame.new(-61.9150009, 28.1099987, 10.312499, 8.74227979e-08, 0.99999994, -3.05979711e-07, -4.37113599e-08, 3.05979682e-07, 1, 0.99999994, -8.74227695e-08, 4.37113812e-08)
Part6.BottomSurface = Enum.SurfaceType.Smooth
Part6.TopSurface = Enum.SurfaceType.Smooth
Part6.Position = Vector3.new(-61.9150009, 28.1099987, 10.312499)
Part6.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh7.Parent = Part6
SpecialMesh7.MeshType = Enum.MeshType.Wedge
Part8.Parent = Model0
Part8.Rotation = Vector3.new(90, 0, 90)
Part8.Anchored = true
Part8.CanCollide = false
Part8.Size = Vector3.new(0.0500000007, 0.170000002, 0.639999986)
Part8.CFrame = CFrame.new(-62.0849991, 28.6049995, 10.312499, -8.74227908e-08, -0.99999994, 2.18556934e-07, 4.3711367e-08, -2.1855692e-07, -1, 0.99999994, -8.74227695e-08, 4.37113812e-08)
Part8.BottomSurface = Enum.SurfaceType.Smooth
Part8.TopSurface = Enum.SurfaceType.Smooth
Part8.Position = Vector3.new(-62.0849991, 28.6049995, 10.312499)
Part8.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh9.Parent = Part8
SpecialMesh9.MeshType = Enum.MeshType.Wedge
Part10.Parent = Model0
Part10.Rotation = Vector3.new(90, 0, -90)
Part10.Anchored = true
Part10.CanCollide = false
Part10.Size = Vector3.new(0.0500000007, 0.140000015, 0.119999997)
Part10.CFrame = CFrame.new(-61.9300003, 28.9449997, 10.312499, -5.73205661e-15, 0.99999994, 1.31134158e-07, 4.37113883e-08, 1.31134158e-07, -1, -0.99999994, 0, -4.37113847e-08)
Part10.BottomSurface = Enum.SurfaceType.Smooth
Part10.TopSurface = Enum.SurfaceType.Smooth
Part10.Position = Vector3.new(-61.9300003, 28.9449997, 10.312499)
Part10.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh11.Parent = Part10
SpecialMesh11.MeshType = Enum.MeshType.Wedge
Part12.Parent = Model0
Part12.Rotation = Vector3.new(90, 0, 90)
Part12.Anchored = true
Part12.CanCollide = false
Part12.Size = Vector3.new(0.0500000007, 0.140000015, 0.119999997)
Part12.CFrame = CFrame.new(-62.0699997, 28.9449997, 10.312499, -8.74227766e-08, -0.99999994, 4.37113847e-08, 4.37113812e-08, -4.37113847e-08, -1, 0.99999994, -8.74227695e-08, 4.37113812e-08)
Part12.BottomSurface = Enum.SurfaceType.Smooth
Part12.TopSurface = Enum.SurfaceType.Smooth
Part12.Position = Vector3.new(-62.0699997, 28.9449997, 10.312499)
Part12.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh13.Parent = Part12
SpecialMesh13.MeshType = Enum.MeshType.Wedge
Part14.Parent = Model0
Part14.Anchored = true
Part14.CanCollide = false
Part14.Size = Vector3.new(0.700000226, 0.860000074, 0.550000012)
Part14.CFrame = CFrame.new(-61.3300018, 28.6349983, 10.5874987, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part14.BottomSurface = Enum.SurfaceType.Smooth
Part14.TopSurface = Enum.SurfaceType.Smooth
Part14.Position = Vector3.new(-61.3300018, 28.6349983, 10.5874987)
Part14.Color = Color3.new(0.105882, 0.164706, 0.207843)
Part15.Parent = Model0
Part15.Anchored = true
Part15.CanCollide = false
Part15.Size = Vector3.new(2.0400002, 0.860000074, 0.49999997)
Part15.CFrame = CFrame.new(-62, 28.6349983, 11.1124992, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part15.BottomSurface = Enum.SurfaceType.Smooth
Part15.TopSurface = Enum.SurfaceType.Smooth
Part15.Position = Vector3.new(-62, 28.6349983, 11.1124992)
Part15.Color = Color3.new(0.105882, 0.164706, 0.207843)
Part16.Name = "asd"
Part16.Parent = Model0
Part16.Transparency = 1
Part16.Anchored = true
Part16.CanCollide = false
Part16.Size = Vector3.new(2, 2, 1)
Part16.CFrame = CFrame.new(-62, 28.0450001, 10.8424988, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part16.BottomSurface = Enum.SurfaceType.Smooth
Part16.TopSurface = Enum.SurfaceType.Smooth
Part16.Position = Vector3.new(-62, 28.0450001, 10.8424988)
Part17.Parent = Model0
Part17.Anchored = true
Part17.CanCollide = false
Part17.Size = Vector3.new(2.02000022, 0.390000075, 1.01999998)
Part17.CFrame = CFrame.new(-62, 27.2299995, 10.8424988, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part17.BottomSurface = Enum.SurfaceType.Smooth
Part17.TopSurface = Enum.SurfaceType.Smooth
Part17.Position = Vector3.new(-62, 27.2299995, 10.8424988)
Part17.Color = Color3.new(0.129412, 0.329412, 0.72549)
Part18.Parent = Model0
Part18.Rotation = Vector3.new(90, 0, -90)
Part18.Anchored = true
Part18.CanCollide = false
Part18.Size = Vector3.new(0.0500000007, 0.170000002, 0.639999986)
Part18.CFrame = CFrame.new(-61.9150009, 28.6049995, 10.312499, -1.33747976e-14, 0.99999994, 3.05979711e-07, 4.37113883e-08, 3.05979682e-07, -1, -0.99999994, 0, -4.37113847e-08)
Part18.BottomSurface = Enum.SurfaceType.Smooth
Part18.TopSurface = Enum.SurfaceType.Smooth
Part18.Position = Vector3.new(-61.9150009, 28.6049995, 10.312499)
Part18.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh19.Parent = Part18
SpecialMesh19.MeshType = Enum.MeshType.Wedge
Part20.Parent = Model0
Part20.Rotation = Vector3.new(-90, 0, 90)
Part20.Anchored = true
Part20.CanCollide = false
Part20.Size = Vector3.new(0.0500000007, 0.140000015, 0.159999996)
Part20.CFrame = CFrame.new(-62.0699997, 28.8049984, 10.312499, 9.55342711e-15, -0.99999994, -2.18556934e-07, -4.37113883e-08, -2.1855692e-07, 1, -0.99999994, 0, -4.37113847e-08)
Part20.BottomSurface = Enum.SurfaceType.Smooth
Part20.TopSurface = Enum.SurfaceType.Smooth
Part20.Position = Vector3.new(-62.0699997, 28.8049984, 10.312499)
Part20.Color = Color3.new(0.0156863, 0.686275, 0.92549)
SpecialMesh21.Parent = Part20
SpecialMesh21.MeshType = Enum.MeshType.Wedge
Part22.Parent = Model0
Part22.Anchored = true
Part22.CanCollide = false
Part22.Size = Vector3.new(0.700000226, 0.860000074, 0.550000012)
Part22.CFrame = CFrame.new(-62.6699982, 28.6349983, 10.5874987, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Part22.BottomSurface = Enum.SurfaceType.Smooth
Part22.TopSurface = Enum.SurfaceType.Smooth
Part22.Position = Vector3.new(-62.6699982, 28.6349983, 10.5874987)
Part22.Color = Color3.new(0.105882, 0.164706, 0.207843)
weld(Model0)
newWeld(torso,Model0.asd,0,0,0)
]]
hair = Instance.new("Part",hed)
hair.Color = Color3.fromRGB(0, 100, 255)
hairm = Instance.new("SpecialMesh",hair)
hairm.MeshId = "rbxassetid://433031789"
hairm.Scale = Vector3.new(0.7,0.65,0.65)
hweld = newWeld(hed,hair,0,0,0)
hweld.C0 = CFrame.new(0.075,0.2,0)*CFrame.Angles(math.rad(0),math.rad(180),0)

hair = Instance.new("Part",hed)
hair.Color = Color3.fromRGB(0, 100, 255)
hairm = Instance.new("SpecialMesh",hair)
hairm.MeshId = "rbxassetid://1389466576"
hairm.Scale = Vector3.new(0.035,0.035,0.03)
hweld = newWeld(hed,hair,0,0,0)
hweld.C0 = CFrame.new(0,-0.1,0.2)*CFrame.Angles(math.rad(0),math.rad(0),0)

local jumped = false

function Lightning(Part0,Part1,Times,Offset,Color,Thickness,Trans)
	local magz = (Part0 - Part1).magnitude
	local curpos = Part0
	local trz = {-Offset,Offset} 
	for i=1,Times do
		local li = Instance.new("Part", DebrisModel)
		li.TopSurface =0
		li.Material = Enum.Material.Neon
		li.BottomSurface = 0
		li.Anchored = true
		li.Locked = true
		li.Transparency = Trans or 0.4
		li.Color = Color
		li.formFactor = "Custom"
		li.CanCollide = false
		li.Size = Vector3.new(Thickness,Thickness,magz/Times)
		local lim = Instance.new("BlockMesh",li)
		local Offzet = Vector3.new(trz[math.random(1,2)],trz[math.random(1,2)],trz[math.random(1,2)])
		local trolpos = CFrame.new(curpos,Part1)*CFrame.new(0,0,magz/Times).p+Offzet
		if Times == i then
			local magz2 = (curpos - Part1).magnitude
			li.Size = Vector3.new(Thickness,Thickness,magz2)
			li.CFrame = CFrame.new(curpos,Part1)*CFrame.new(0,0,-magz2/2)
		else
			li.CFrame = CFrame.new(curpos,trolpos)*CFrame.new(0,0,magz/Times/2)
		end
		curpos = li.CFrame*CFrame.new(0,0,magz/Times/2).p
		li.Name = "LIGHTNING"
	end
end
local woosh = false
local debounce = false
mouse.KeyDown:connect(function(key)
	if key == "e" and debounce == false then
		debounce = true
		noidle = true
		sound(1202656211,root.Position,10,math.random(300,350)/100)
		local tempattach=Instance.new("Attachment",root)
		tempattach.Position = Vector3.new(0,0,-20)
		for i=1,10 do rs:wait()
			local temppos = root.Position
			root.CFrame = CFrame.new(tempattach.WorldPosition)*CFrame.Angles(0,math.rad(root.Orientation.Y),0)
			root.Velocity = Vector3.new()
			for i,v in pairs(findAllNearestTorso(root.Position,30)) do
			end
			Lightning(root.Position+Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2)),temppos+Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2)), math.random(2,4), 2, Color3.fromHSV(0.5+math.random(0,1000)/10000,math.random(500,1000)/1000,1), .5, .56)
			woosh = true
			hed.Weld.C0 = CFrame.new(0, 1.5, -.1) * CFrame.Angles(0,0,0)
			hed.Weld.C1 = CFrame.Angles(math.rad(-20),0,0)
			larm.Weld.C0 = CFrame.new(-1.5,0.5,0)*CFrame.Angles(math.rad(-40),math.rad(0),math.rad(-5))
			rarm.Weld.C0 = CFrame.new(1.5,0.5,0)*CFrame.Angles(math.rad(-40),math.rad(0),math.rad(5))
			torso.Weld.C0 = CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-40),math.rad(0), math.rad(0))
			lleg.Weld.C0 = CFrame.new(-0.5,-0.6,-1)*CFrame.Angles(math.rad(-70),math.rad(0),math.rad(-1))
			rleg.Weld.C0 = CFrame.new(0.5,-0.95,0)*CFrame.Angles(math.rad(-30),math.rad(0),math.rad(1))
		end
		noidle = false
		debounce = false
	end
end)

mouse.KeyDown:connect(function(key)
	if key == "r" and debounce == false then
		debounce = true
		noidle = true
		local bg = Instance.new("BodyGyro",root)
		bg.Name = "lolnochara"
		bg.P = 10000
		bg.D = 100
		bg.MaxTorque = Vector3.new(10000,10000,10000)
		if jumped == false then
			root.CFrame = CFrame.new(root.Position,Vector3.new(mouse.Hit.x,root.Position.Y,mouse.Hit.z))
			bg.CFrame = CFrame.new(root.Position,Vector3.new(mouse.Hit.x,root.Position.Y,mouse.Hit.z))
		else
			root.CFrame = CFrame.new(root.Position,mouse.Hit.p)
			bg.CFrame = CFrame.new(root.Position,mouse.Hit.p)
		end
		local spd = 0.4
		for i=1,10 do rs:wait()
			if jumped == false then
				bg.CFrame = CFrame.new(root.Position,Vector3.new(mouse.Hit.x,root.Position.Y,mouse.Hit.z))
			else
				bg.CFrame = CFrame.new(root.Position,mouse.Hit.p)
			end
			hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0,1.5,-.1)     *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.new(0,0,0)         *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
			larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.5,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
			rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.5,0)  *CFrame.Angles(math.rad(90),math.rad(0),math.rad(50)), spd)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, -0.5, 0)  *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
			lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.2,-1)*CFrame.Angles(math.rad(-50),math.rad(-10),math.rad(-1)), spd)
			rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,-0.95,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(6)), spd)
		end

		sound(1202656211,root.Position,10,math.random(90,110)/100)

		local Position = rarm.Position-rarm.CFrame.upVector
		local Target = mouse.Hit.p
		local direction = Target - Position
		local direction = computeDirection(direction)
		local ray = Ray.new(Position, (Target-Position).unit*1048)
		local part, endPoint = workspace:FindPartOnRay(ray, char)

		for i,v in pairs(findAllNearestTorso(endPoint,30)) do
		end

		local Part0 = Effect(Enum.MeshType.Sphere,Vector3.new(2,(Position-endPoint).magnitude,2),0,Enum.Material.Neon,Color3.fromHSV(0,0,1),root.Position,Vector3.new(90,0,0),Vector3.new(),Vector3.new(-0.1,0,-0.1),Vector3.new(),0,-0.005)
		local pos = Position + (direction * (Part0.Mesh.Scale.Y/2))
		Part0.CFrame = CFrame.new(pos,  pos + direction) * CFrame.Angles((math.pi/2)+math.rad(180), 0, 0)

		for i=1,4 do
			Lightning(rarm.Position-rarm.CFrame.upVector,endPoint, math.random(5,6), 2, Color3.fromHSV(0.5+math.random(0,1000)/10000,math.random(500,1000)/1000,1), .5, .56)
		end

		if part then
			sound(821439273,endPoint,10,math.random(90,110)/100)
			for i=1,5 do
				Effect(Enum.MeshType.Sphere,Vector3.new(1,1,1)*math.random(4,10),0,Enum.Material.Neon,Color3.fromHSV(0.5+math.random(0,1000)/10000,math.random(500,1000)/1000,1),endPoint+Vector3.new(math.random(-2,2)*5,math.random(-2,2)*5,math.random(-2,2)*5),Vector3.new(),Vector3.new(),Vector3.new(1,1,1),Vector3.new(),0.04,-0.002)
			end
		end

		bg:Destroy()
		local spd = 0.5
		for i=1,5 do rs:wait()
			hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0,1.5,-.1)     *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.new(0,0,0)         *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
			larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.5,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
			rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.5,0)  *CFrame.Angles(math.rad(160),math.rad(0),math.rad(50)), spd)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, -0.5, 0)  *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
			lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.2,-1)*CFrame.Angles(math.rad(-50),math.rad(-10),math.rad(-1)), spd)
			rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,-0.95,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(6)), spd)
		end
		noidle = false
		debounce = false
	end
end)

mouse.KeyDown:connect(function(key)
	if key == "q" and debounce == false then
		debounce = true
		noidle = true
		local mousepos = mouse.Hit.p
		if (mousepos-root.Position).magnitude <= 150 then
			sound(1202657035,mousepos,10,math.random(150,170)/100)
			local spd = 0.4
			for i=1,10 do rs:wait()
				hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0,1.5,-.1)     *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
				hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.new(0,0,0)         *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
				larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.5,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), spd)
				rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.5,0)  *CFrame.Angles(math.rad(170),math.rad(0),math.rad(50)), spd)
				torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, -0.5, 0)  *CFrame.Angles(math.rad(0),math.rad(40),math.rad(0)), spd)
				lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.2,-1)*CFrame.Angles(math.rad(-50),math.rad(-10),math.rad(-1)), spd)
				rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,-0.95,0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(6)), spd)
			end
			for i,v in pairs(findAllNearestTorso(mousepos,15)) do
			end
			local tempcolor = Color3.fromHSV(0.5+math.random(0,1000)/10000,0.5,1)
			coroutine.resume(coroutine.create(function()
				for i=1,2 do rs:wait() rs:wait() rs:wait() rs:wait() rs:wait() rs:wait() rs:wait() rs:wait() 
					Effect(Enum.MeshType.Sphere,Vector3.new(10,10,10)*5,0.999,Enum.Material.Neon,tempcolor,mousepos,Vector3.new(),Vector3.new(),Vector3.new(-0.3,-0.3,-0.3),Vector3.new(),-0.005,-0.05)
				end
			end))
			Effect(Enum.MeshType.Sphere,Vector3.new(5,5,5),0,Enum.Material.Neon,tempcolor,mousepos,Vector3.new(),Vector3.new(),Vector3.new(2,2,2),Vector3.new(),0.03,0)
			Effect(Enum.MeshType.Sphere,Vector3.new(20,20,20),0,Enum.Material.Neon,tempcolor,mousepos,Vector3.new(),Vector3.new(),Vector3.new(-0.4,30,-0.4),Vector3.new(),0,0)
		end
		noidle = false
		debounce = false
	end
end)

music(1032975381)

--[[for i,v in pairs(char:GetChildren()) do
if v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
local emitter = Instance.new("ParticleEmitter",v)
emitter.LightEmission = 1
emitter.Transparency = NumberSequence.new(0.95,1)
emitter.Size = NumberSequence.new(0.5)
emitter.SpreadAngle = Vector2.new(360,360)
emitter.Speed = NumberRange.new(1)
emitter.Lifetime = NumberRange.new(0.75)
emitter.Texture = "rbxassetid://744949545"
emitter.Rate = 20
emitter.Color = ColorSequence.new(Color3.new(0,1,1))
emitter.LockedToPart = true
table.insert(emitters,emitter)
end
end]]

velocityYFall=0
velocityYFall2=0
velocityYFall3=0
velocityYFall4=0
neckrotY=0
neckrotY2=0
torsorotY=0
torsorotY2=0
torsoY=0
torsoY2=0
colored = 0
sine = 0
change=0.4
movement=5
timeranim=0
running = false
glitched = false
backup = hed.Weld.C1
glitchedC1 = hed.Weld.C1
glitchedenabled = false

mouse.KeyDown:connect(function(key)
	key = string.lower(key)
	if string.byte(key) == 48 then
		running = true
		local keyup = mouse.KeyUp:connect(function(key)
			if string.byte(key) == 48 then
				running = false
			end
		end)
		repeat rs:wait() until running == false
		keyup:disconnect()
	end
end)

icolor=1
imode=false

didjump = false
jumppower = 0
freeze = false
debounceimpact = false

function jumpimpact()
	if debounceimpact == false then
		debounceimpact = true
		if jumppower < -150 then jumppower = -150 end
		shake(-jumppower/5)
		for i=1,-jumppower/20 do rs:wait()
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.Angles(0,0,0), 0.05)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, (jumppower/20)-hum.HipHeight, 0) * CFrame.Angles(math.rad(0),math.rad(0), math.rad(0)), 0.05)
		end
		debounceimpact = false
	end
end

rs:connect(function()

	for i,v in pairs(DebrisModel:GetChildren()) do
		if v.Name == "LIGHTNING" then
			local vm = v:FindFirstChildOfClass("BlockMesh")
			vm.Scale = vm.Scale - Vector3.new(0.1,0.1,0)
			if vm.Scale.X <= 0 then
				v:Destroy()
			end
		end
	end

	if icolor > 1 then
		imode = false
	elseif icolor < 0 then
		imode = true
	end

	if imode == true then
		icolor = icolor + 0.01
	else
		icolor = icolor - 0.01
	end

	for i,v in pairs(emitters) do
		v.Acceleration = root.CFrame.upVector*(666/200)
	end

	if p.Character.Parent == nil then
		local model = Instance.new("Model")
		model.Name = p.Name
		p.Character = model
		for i,v in pairs(char:GetChildren()) do
			v.Parent = p.Character
		end
	end

	char = p.Character
	if p.Character.Parent ~= workspace then
		p.Character.Parent = workspace
	end
	for i,v in pairs(char:GetChildren()) do
		if v:IsA("Accoutrement") then
			if v.Handle:FindFirstChild("Mesh") then
				v.Handle:FindFirstChild("Mesh").Offset = Vector3.new()
				v.Handle.Transparency = 0
			end
		elseif v:IsA("BasePart") then
			v.Anchored = false
			if v:FindFirstChildOfClass("BodyPosition") then
				v:FindFirstChildOfClass("BodyPosition"):Destroy()
			end
			if v:FindFirstChildOfClass("BodyVelocity") then
				v:FindFirstChildOfClass("BodyVelocity"):Destroy()
			end
			if v:FindFirstChildOfClass("BodyGyro") and v:FindFirstChildOfClass("BodyGyro").Name ~= "lolnochara" then
				v:FindFirstChildOfClass("BodyGyro"):Destroy()
			end
			if v:FindFirstChild("Mesh") then
				v:FindFirstChild("Mesh").Offset = Vector3.new()
			end
			if not DebrisModel:FindFirstChild(v.Name.."FORCEFIELD") then
				local force = Instance.new("Part",DebrisModel)
				force.Name = v.Name.."FORCEFIELD"
				if v ~= hed then
					force.Size = v.Size+(Vector3.new(1,1,1)*0.2)
				else
					force.Size = (Vector3.new(1,1,1)*v.Size.Y)+(Vector3.new(1,1,1)*0.2)
				end
				force.CanCollide = false
				force.Transparency = 1
				force.Color = Color3.new(0,1,1)
				force.Material = Enum.Material.Neon
				newWeld(v,force,0,0,0)
			else
				if not DebrisModel:FindFirstChild(v.Name.."FORCEFIELD"):FindFirstChildOfClass("Weld") then
					newWeld(v,DebrisModel:FindFirstChild(v.Name.."FORCEFIELD"),0,0,0)
				end
			end
			if v.Name ~= "HumanoidRootPart" then
				v.Transparency = 0
			else
				v.Transparency = 1
			end
		end
	end

	if freeze == false then
		if running == false then
			hum.WalkSpeed = 12
			change=0.4
			movement=5
		else
			hum.WalkSpeed = (666/10)
			if (torso.Velocity*Vector3.new(1, 0, 1)).magnitude >= 5 then
				change=1
			else
				change=0.4
			end
			movement=15
		end
	else
		hum.WalkSpeed = 1
		change=0.4
		movement=5
	end

	if -root.Velocity.Y/1.5 > -5 and -root.Velocity.Y/1.5 < 150 then
		velocityYFall = root.Velocity.Y/1.5
	else
		if -root.Velocity.Y/1.5 < -5 then
			velocityYFall = 5
		elseif -root.Velocity.Y/1.5 > 150 then
			velocityYFall = -150
		end
	end

	if -root.Velocity.Y/180 > 0 and -root.Velocity.Y/180 < 1.2 then
		velocityYFall2 = root.Velocity.Y/180
	else
		if -root.Velocity.Y/180 < 0 then
			velocityYFall2 = 0
		elseif -root.Velocity.Y/180 > 1.2 then
			velocityYFall2 = -1.2
		end
	end

	if -root.Velocity.Y/1.5 > -5 and -root.Velocity.Y/1.5 < 50 then
		velocityYFall3 = root.Velocity.Y/1.5
	else
		if -root.Velocity.Y/1.5 < -5 then
			velocityYFall3 = 5
		elseif -root.Velocity.Y/1.5 > 50 then
			velocityYFall3 = -50
		end
	end

	if -root.Velocity.Y/1.5 > -50 and -root.Velocity.Y/1.5 < 20 then
		velocityYFall4 = root.Velocity.Y/1.5
	else
		if -root.Velocity.Y/180 < -5 then
			velocityYFall4 = 5
		elseif -root.Velocity.Y/180 > 50 then
			velocityYFall4 = -50
		end
	end

	if root.RotVelocity.Y/6 < 1 and root.RotVelocity.Y/6 > -1 then
		neckrotY = root.RotVelocity.Y/6
	else
		if root.RotVelocity.Y/6 < -1 then
			neckrotY = -1
		elseif root.RotVelocity.Y/6 > 1 then
			neckrotY = 1
		end
	end

	if root.RotVelocity.Y/8 < 0.6 and root.RotVelocity.Y/8 > -0.6 then
		neckrotY2 = root.RotVelocity.Y/8
	else
		if root.RotVelocity.Y/8 < -0.6 then
			neckrotY2 = -0.6
		elseif root.RotVelocity.Y/8 > 0.6 then
			neckrotY2 = 0.6
		end
	end

	if root.RotVelocity.Y/6 < 0.2 and root.RotVelocity.Y/6 > -0.2 then
		torsorotY = root.RotVelocity.Y/6
	else
		if root.RotVelocity.Y/6 < -0.2 then
			torsorotY = -0.2
		elseif root.RotVelocity.Y/6 > 0.2 then
			torsorotY = 0.2
		end
	end

	if root.RotVelocity.Y/8 < 0.2 and root.RotVelocity.Y/8 > -0.2 then
		torsorotY2 = root.RotVelocity.Y/8
	else
		if root.RotVelocity.Y/8 < -0.2 then
			torsorotY2 = -0.2
		elseif root.RotVelocity.Y/8 > 0.2 then
			torsorotY2 = 0.2
		end
	end

	torsoY = -(torso.Velocity*Vector3.new(1, 0, 1)).magnitude/20
	torsoY2 = -(torso.Velocity*Vector3.new(1, 0, 1)).magnitude/36

	local ray1 = Ray.new(root.Position+Vector3.new(size,0,0),Vector3.new(0, -4, 0))
	local part1, endPoint = workspace:FindPartOnRay(ray1, char)

	local ray2 = Ray.new(root.Position-Vector3.new(size,0,0),Vector3.new(0, -4, 0))
	local part2, endPoint = workspace:FindPartOnRay(ray2, char)

	local ray3 = Ray.new(root.Position+Vector3.new(0,0,size/2),Vector3.new(0, -4, 0))
	local part3, endPoint = workspace:FindPartOnRay(ray3, char)

	local ray4 = Ray.new(root.Position-Vector3.new(0,0,size/2),Vector3.new(0, -4, 0))
	local part4, endPoint = workspace:FindPartOnRay(ray4, char)

	local ray5 = Ray.new(root.Position+Vector3.new(size,0,size/2),Vector3.new(0, -4, 0))
	local part5, endPoint = workspace:FindPartOnRay(ray5, char)

	local ray6 = Ray.new(root.Position-Vector3.new(size,0,size/2),Vector3.new(0, -4, 0))
	local part6, endPoint = workspace:FindPartOnRay(ray6, char)

	local ray7 = Ray.new(root.Position+Vector3.new(size,0,-size/2),Vector3.new(0, -4, 0))
	local part7, endPoint = workspace:FindPartOnRay(ray7, char)

	local ray8 = Ray.new(root.Position-Vector3.new(size,0,-size/2),Vector3.new(0, -4, 0))
	local part8, endPoint = workspace:FindPartOnRay(ray8, char)

	local ray = Ray.new(root.Position,Vector3.new(0, -6, 0))
	local part, endPoint = workspace:FindPartOnRay(ray, char)

	if part1 or part2 or part3 or part4 or part5 or part6 or part7 or part8 then jumped = false else endPoint = 0 jumped = true end

	local rlegray = Ray.new(rleg.Position+Vector3.new(0,size/2,0),Vector3.new(0, -1.75, 0))
	local rlegpart, rlegendPoint = workspace:FindPartOnRay(rlegray, char)

	local llegray = Ray.new(lleg.Position+Vector3.new(0,size/2,0),Vector3.new(0, -1.75, 0))
	local llegpart, llegendPoint = workspace:FindPartOnRay(llegray, char)

	if hum.Health > 0 and noidle == false then
		if (torso.Velocity*Vector3.new(1, 0, 1)).magnitude >= 5 and jumped == false then
			hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0, 1.5, -.1) * CFrame.Angles(0,0,0), 0.4)
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.Angles(math.rad(-20),0,0), 0.1)
			larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.5,0)*CFrame.Angles(math.rad(-40-20*math.cos(sine/15)),math.rad(0+5*math.sin(sine/15)),math.rad(-5-5*math.sin(sine/15))), 0.2)
			rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.5,0)*CFrame.Angles(math.rad(-40-20*math.cos(sine/15)),math.rad(0-5*math.sin(sine/15)),math.rad(5+5*math.sin(sine/15))), 0.2)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, -0.5-0.5*math.sin(sine/15), 0) * CFrame.Angles(math.rad(-40),math.rad(0), math.rad(0)), 0.1)
			lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.6,-1)*CFrame.Angles(math.rad(-70-20*math.cos(sine/15)),math.rad(0-5*math.sin(sine/15)),math.rad(-1)), 0.2)
			rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,-0.95,0)*CFrame.Angles(math.rad(-30-20*math.cos(sine/15)),math.rad(0+5*math.sin(sine/15)),math.rad(1)), 0.2)
		elseif jumped == true then
			didjump = true
			jumppower = root.Velocity.Y
			hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0, 1.5, -.1) * CFrame.Angles(0,0,0), 0.4)
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.Angles(math.rad(-velocityYFall3/5),0,0), 0.1)
			larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.55-velocityYFall3/70,0)*CFrame.Angles(math.rad(-velocityYFall3/10),math.rad(0),math.rad(velocityYFall)), 0.2)
			rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.55-velocityYFall3/70,0)*CFrame.Angles(math.rad(-velocityYFall3/10),math.rad(0),math.rad(-velocityYFall)), 0.2)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(velocityYFall3/10),math.rad(0), math.rad(0)), 0.1)
			lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.925,0)*CFrame.Angles(math.rad(-35),math.rad(0),math.rad(-2)), 0.2)
			rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,0,-0.8)*CFrame.Angles(math.rad(-25),math.rad(0),math.rad(2)), 0.2)
		elseif (torso.Velocity*Vector3.new(1, 0, 1)).magnitude < 5 then
			hed.Weld.C0 = Lerp(hed.Weld.C0, CFrame.new(0, 1.5, -.1) * CFrame.Angles(math.rad((torso.Velocity*Vector3.new(1, 0, 1)).magnitude/35),0, 0), 0.4)
			hed.Weld.C1 = Lerp(hed.Weld.C1, CFrame.Angles(0.05*math.sin(sine/16)+0.15,0.05*math.cos(sine/32),0.01*math.cos(sine/32)), 0.1)
			larm.Weld.C0 = Lerp(larm.Weld.C0, CFrame.new(-1.5,0.55-(0.1)*math.cos(sine/16)/3,-0.05-0.1*math.cos(sine/16))*CFrame.Angles(math.rad(-2+4*math.cos(sine/16)),math.rad(-5-5*math.sin(sine/16)),math.rad(-6+2*math.cos(sine/16))), 0.2)
			rarm.Weld.C0 = Lerp(rarm.Weld.C0, CFrame.new(1.5,0.55-(0.1)*math.cos(sine/16)/3,-0.05-0.1*math.cos(sine/16))*CFrame.Angles(math.rad(170+4*math.cos(sine/16)),math.rad(5+5*math.sin(sine/16)),math.rad(-20-2*math.cos(sine/16))), 0.2)
			torso.Weld.C0 = Lerp(torso.Weld.C0, CFrame.new(0, (-0.5-(0.1)*math.cos(sine/16)-hum.HipHeight)+0.5*math.sin(sine/15), -0.1*math.cos(sine/16)) * CFrame.Angles(math.rad(-2-4*math.cos(sine/16)),math.rad(0), math.rad(0-1*math.cos(sine/32))), 0.1)
			lleg.Weld.C0 = Lerp(lleg.Weld.C0, CFrame.new(-0.5,-0.2+(0.1)*math.cos(sine/16),-1)*CFrame.Angles(math.rad(-50+2*math.cos(sine/16)),math.rad(-10+2*math.cos(sine/16)),math.rad(-1+1*math.cos(sine/32))), 0.2)
			rleg.Weld.C0 = Lerp(rleg.Weld.C0, CFrame.new(0.5,-0.95+(0.1)*math.cos(sine/16),0)*CFrame.Angles(math.rad(10+2*math.cos(sine/16)),math.rad(10-2*math.cos(sine/16)),math.rad(1+1*math.cos(sine/32))), 0.2)
		end
	end
	l1.C0 = CFrame.new(-0.8,0.8,0.5)*CFrame.Angles(0,0.2,-0.1+0.6*math.cos(sine/15))
	r1.C0 = CFrame.new(0.8,0.8,0.5)*CFrame.Angles(0,-0.2,0.1-0.6*math.cos(sine/15))

	l2.C0 = CFrame.new(-0.8,0.4,0.5)*CFrame.Angles(0,0.4,0.5*math.cos(sine/15))
	r2.C0 = CFrame.new(0.8,0.4,0.5)*CFrame.Angles(0,-0.4,-0.5*math.cos(sine/15))

	l3.C0 = CFrame.new(-0.8,0,0.5)*CFrame.Angles(0,0.6,0.1+0.5*math.cos(sine/15))
	r3.C0 = CFrame.new(0.8,0,0.5)*CFrame.Angles(0,-0.6,-0.1-0.5*math.cos(sine/15))
	if didjump == true and jumped == false and jumppower < 0 then
		didjump = false
		jumpimpact()
	end
	if math.sin(sine/15) < -0.5 and woosh == false and jumped == false then
		woosh = true
	elseif math.sin(sine/15) > -0.5 then
		woosh = false
	end
	--timeposition = soundz.TimePosition
	sine = sine + change
	hum.Health = math.huge
	hum.MaxHealth = math.huge
end)