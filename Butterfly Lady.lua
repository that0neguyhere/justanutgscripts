Player = game:GetService("Players").LocalPlayer
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character["HumanoidRootPart"]
Torso = Character["Torso"]
Head = Character["Head"]
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart["RootJoint"]
Neck = Torso["Neck"]
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local sick = Instance.new("Sound",Torso)

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor


Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 75
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local neck2 = CF(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
--ROBLOXIDLEANIMATION.Parent = Humanoid
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
ANIMATOR:Destroy()
local UNANCHOR = true
local HITPLAYERSOUNDS = {--[["199149137", "199149186", "199149221", "199149235", "199149269", "199149297"--]]"263032172", "263032182", "263032200", "263032221", "263032252", "263033191"}	
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)


function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end


function Clerp(a, b, t)
	return a:lerp(b,t)
end



function weld(parent, part0, part1, c0, c1)
	local w = IT("Weld")
	w.Part0 = part0
	w.Part1 = part1
	w.C0 = c0
	w.C1 = c1
	w.Parent = parent
	return w
end

local S = IT("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.EmitterSize = 5*VOLUME
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

--WACKYEFFECT({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

function WACKYEFFECT2(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLORLOOP = (Table.ColorLoop or false)
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
	local BOOMERANG = (Table.Boomerang or 0)
	local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		elseif TYPE == "Cylinder" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Cylinder", "", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1+BOOMERANG/50
			local BOOMR2 = 1+SIZEBOOMERANG/50
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
				else
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
				end
			end
			local GROWTH = nil
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
			else
				GROWTH = (SIZE - ENDSIZE)
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					if COLORLOOP == true then
						EFFECT.Color = COLOR
					end
					MSH.Scale = MSH.Scale - (VT((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.Orientation = ORI
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					if COLORLOOP == true then
						EFFECT.Color = COLOR
					end
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
						EFFECT.Orientation = ORI
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

Debris = game:GetService("Debris")

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

local cls = {Color3.fromRGB(255, 250, 82),Color3.fromRGB(78, 216, 237)}
local clsinv = {Color3.fromRGB(78, 216, 237),Color3.fromRGB(255, 250, 82)}
local loopcol

function CastLightning(Parent, FromPosition,ToPosition, Offset, Branches, Range, Thickness, Color, IsCircular, Gradient, GradientColor)
	local Zap = {}
	local LightningModel = IT("Model", Parent)
	local lastpos = FromPosition
	local steps = Branches
	local off = Offset
	local range = Range
	local distance = (FromPosition-ToPosition).Magnitude
	if distance > range then
		distance = range
	end
	local maxi = 0
	for i = 0,distance,steps do
		maxi = i
	end
	local Half = maxi / 2
	local Lightning = {}
	local Gradient = {}
	if GradientColor then
		Gradient.R = (GradientColor.R * 255) / maxi
		Gradient.G = (GradientColor.G * 255) / maxi
		Gradient.B = (GradientColor.B * 255) / maxi
	end
	for i = 0,distance,steps do
		local from = lastpos
		local offset = Vector3.new((math.random(-off,off)), (math.random(-off,off)), (math.random(-off,off)))
		local too = from + -(from-ToPosition).unit*steps + offset
		local Branch = IT("Part")
		Branch.Material = "Neon"
		Branch.Anchored = true
		Branch.CanCollide = false
		Branch.Color = Color
		Branch.FormFactor = "Custom"
		Branch.Name = "Electrode"
		if IsCircular then
			Branch.Size = Vector3.new(0,Thickness,Thickness)
		else
			Branch.Size = Vector3.new(Thickness,Thickness,0)
		end
		Branch.CastShadow = false
		if IsCircular then
			local Cyl = Instance.new("SpecialMesh", Branch)
			Cyl.MeshType = Enum.MeshType.Cylinder
		end
		Branch.Parent = LightningModel
		if IsCircular then
			Branch.Size = Vector3.new((from-too).Magnitude,Branch.Size.y,Branch.Size.Y)
		else
			Branch.Size = Vector3.new(Branch.Size.x,Branch.Size.y,(from-too).Magnitude)
		end
		if IsCircular then
			Branch.CFrame = CFrame.new(from:Lerp(too,0.5),too) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
		else
			Branch.CFrame = CFrame.new(from:Lerp(too,0.5),too) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		end
		distance = (FromPosition - ToPosition).Magnitude
		local e = distance - 255
		if Gradient then
			--Branch.Color = Color3.fromRGB(Gradient.R * i, Gradient.G * i, Gradient.B * i)
			Branch.Color = cls[MRANDOM(1,2)]
		end
		table.insert(Lightning, Branch)
		lastpos = too
		if i == 0 then
			--Branch.Color = Color3.fromRGB(0, 255,0)
			Branch.Name = "Start"
			Zap.Start = Branch
		end
		if i == maxi then
			--Branch.Color = Color3.fromRGB(0, 255,0)
			Branch.Name = "End"
			--Branch.Transparency = 1
			Zap.End = Branch
		end
	end
	local function Fade(Dur)
		coroutine.wrap(function()
			for i = 1, Dur do
				Swait()
				for i = 1, #Lightning do
					Lightning[i].Transparency = Lightning[i].Transparency + 1 / Dur
				end
			end
			for i = 1, #Lightning do
				Lightning[i]:Destroy()
			end
		end)()
	end
	local function Shrink(Dur)
		coroutine.wrap(function()
			for i = 1, Dur do
				Swait()
				for i = 1, #Lightning do
					if IsCircular then
						Lightning[i].Size = Lightning[i].Size - Vector3.new(0, Lightning[i].Size.Y, Lightning[i].Size.Z) / Dur
					else
						Lightning[i].Size = Lightning[i].Size - Vector3.new(Lightning[i].Size.X, Lightning[i].Size.Y, 0) / Dur
					end
				end
			end
			for i = 1, #Lightning do
				Lightning[i]:Destroy()
			end
			LightningModel:Destroy()
		end)()
	end
	Fade(5)
	Shrink(5)
	return Zap, LightningModel
end

function SHAKECAM(POSITION,RANGE,INTENSITY,TIME)

end


function AttachmentCFrame(What)
	return What.Parent.CFrame*CF(What.Position)
end


--weap
local SONG = 360366376
d = CF(0,0,0)
local la = IT("Weld")
local ra = IT("Weld")
RightShoulder.Parent = nil
LeftShoulder.Parent = nil
ra.Name = "ra"
ra.Part0 = Torso 
ra.C0 = CF(1.5, 0.5, 0)
ra.C1 = CF(0, 0.5, 0)
ra.Part1 = RightArm
ra.Parent = Torso  

la.Name = "la"
la.Part0 = Torso 
la.C0 = CF(-1.5, 0.5, 0)
la.C1 = CF(0, 0.5, 0) 
la.Part1 = LeftArm
la.Parent = Torso

local lh = weld(LeftLeg,Torso,LeftLeg,CF(-.5,-1,0),d)
lh.C1 = CF(0,1,0)
local rh = weld(RightLeg,Torso,RightLeg,CF(.5,-1,0),d)
rh.C1 = CF(0,1,0)

ts = game:GetService("TweenService")
--if Player.CharacterAppearanceId == Player.UserId then Character:WaitForChild("Body Colors"):Destroy() end
--[[local dcl = IT("Decal",Head) dcl.Texture = "rbxassetid://2801594973" 
local dcl2 = IT("Decal",Head) dcl2.Texture = "rbxassetid://2801767831"
local dcl3 = IT("Decal",Head) dcl3.Texture = "rbxassetid://2801696705"]]
coroutine.resume(coroutine.create(function()
	local pl = 0
	while true do
		Swait(.2)
		wait(0.2)
		if pl == #cls then pl = 0 end
		pl=pl+1
	end
end))


--dmg
function electr(MODEL)
	MODEL:BreakJoints()
	for index, CHILD in pairs(MODEL:GetChildren()) do
		if CHILD.Name == "Torso" then
			CHILD.Name = "stuff"..MRANDOM(1,10000)..""
		end
		local va = MRANDOM(30,80)
		if CHILD:IsA("BasePart") and CHILD.Name ~= "HumanoidRootPart" then
			if CHILD.Name == "Head" then
				WACKYEFFECT2({Time = MRANDOM(60,120)/2, EffectType = "Box", Size = VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z), Size2 = (VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z))*1.4, Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)], SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, SizeBoomerang = 0, Boomerang = 35})
			elseif CHILD.Name ~= "HumanoidRootPart" then
				WACKYEFFECT2({Time = MRANDOM(60,120)/2, EffectType = "Box", Size = CHILD.Size, Size2 = CHILD.Size*1.4, Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = MRANDOM(-1,1) ,Material = "Neon", Color = cls[MRANDOM(1,2)], SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, SizeBoomerang = 0, Boomerang = 35})
			end
			CHILD:remove()
		end
	end
	Debris:AddItem(MODEL,6)
end

function ApplyDamage(Humanoid,Damage)

end

function ApplyAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)

end

--attacks
function yooo()
	ATTACK = true
	--invoke lightning at random places then after 2 seconds make a column attack in a line
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-0.8,0.1,-0.6)*ANGLES(RAD(-6.8),RAD(16.6),RAD(93.3)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.5,0.1)*ANGLES(RAD(-13.7),RAD(21.2),RAD(34)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	coroutine.resume(coroutine.create(function()
		for i = 1,10 do
			Swait(.1)
			local start = RootPart.CFrame*CF(MRANDOM(-35,35),50,MRANDOM(-35,35))
			local hp,ps = CastProperRay(start.p,  start.p-VT(0,50,0), 500, Character)
			local dist = (start.p-ps).Magnitude
			if hp then
				coroutine.resume(coroutine.create(function()
					for i = 0,5 do Swait()
						CastLightning(Effects,start.p,ps,1.2,MRANDOM(10,15),dist,.35,cls[1],false,true,cls[2])
					end	
				end))
				ApplyAoE(ps,10,65,90,75,false)
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(30,.1,30)/2, Size2 = VT(30,30,30)/2, Transparency = 0, Transparency2 = 1, CFrame = CF(ps), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[1],SoundID = 821439273, SoundPitch = 1, SoundVolume = 4, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(25,.1,25)/2, Size2 = VT(30,30,30)/2, Transparency = 0, Transparency2 = 1, CFrame = CF(ps), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[2],SoundID = nil, SoundPitch = 1, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				for i =1,2 do
					WACKYEFFECT2({Time = 45, EffectType = "Wave", Size = VT(1,1,1)/2, Size2 = VT(65,.5,65)/3, Transparency = 0, Transparency2 = 1, CFrame = CF(ps)*ANGLES(RAD(MRANDOM(-10,10)),RAD(MRANDOM(-10,10)),RAD(MRANDOM(-10,10))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-10,10), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
				end
			end
		end
	end))
	for i = 0,15 do
		Swait()
		local Alpha = .3
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.4,-0.3)*ANGLES(RAD(176),RAD(29.9),RAD(-93.7)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.5,0.1)*ANGLES(RAD(-13.7),RAD(21.2),RAD(34)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.7,-0.3)*ANGLES(RAD(16.3),RAD(14.6),RAD(-179.3)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.5,0.1)*ANGLES(RAD(-13.7),RAD(21.2),RAD(34)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	local hf,hp = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 3.7, Character)
	if hf then
		coroutine.resume(coroutine.create(function()
			for i = 1,12 do
				local big = RootPart.CFrame*CF(0,0,-i*18)--*ANGLES(0,0,RAD(MRANDOM(-30,30)))
				local black,balls = Raycast(big.p+VT(0,1,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 3.7, Character)
				if hf then
					local HD = CF(balls)*ANGLES(RAD(MRANDOM(-30,30)),0,RAD(0))
					ApplyAoE(HD.p,30,0,0,159,true)
					WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(30,.1,30), Size2 = VT(30,85,30), Transparency = 0, Transparency2 = 1, CFrame = HD, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[1],SoundID = 178452221, SoundPitch = 1, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
					WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(25,.1,25), Size2 = VT(30,75,30), Transparency = 0, Transparency2 = 1, CFrame = HD, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
					for i =1,2 do
						WACKYEFFECT2({Time = 45, EffectType = "Wave", Size = VT(1,1,1), Size2 = VT(65,.5,65)/1.5, Transparency = 0, Transparency2 = 1, CFrame = HD*ANGLES(RAD(MRANDOM(-10,10)),RAD(MRANDOM(-10,10)),RAD(MRANDOM(-10,10))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-10,10), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
					end
					Swait(.09)	
				end
			end	
		end))
	end
	for i = 0,15 do
		Swait()
		local Alpha = .3
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.3,0.1)*ANGLES(RAD(-99.2),RAD(-7.1),RAD(-167.2)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.5,0.1)*ANGLES(RAD(-13.7),RAD(21.2),RAD(34)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	ATTACK = false
end

function aroundorsomething()
	ATTACK = true
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.3,0.1)*ANGLES(RAD(-99.2),RAD(-7.1),RAD(-167.2)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.5,0.1)*ANGLES(RAD(-13.7),RAD(21.2),RAD(34)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	--[[local sp1 = CreatePart(3,Effects,"Neon",0,0,"White","funny sphere",VT(2,2,2)*3,true)
	local sp2 = CreatePart(3,Effects,"Neon",0,0,"White","funny sphere",VT(2,2,2)*3,true)
	MakeForm(sp1,"Ball")
	MakeForm(sp2,"Ball")
	sp1.Color = cls[1]
	sp2.Color = cls[2]
	sp1.CFrame = Mouse.Hit
	sp2.CFrame = Mouse.Hit]]
	coroutine.resume(coroutine.create(function()


		local mpos = CF(Mouse.Hit.p)
		for i = 1,50 do
			Swait()
			WACKYEFFECT2({Time = 30, EffectType = "Sphere", Size = VT(.3,1,.3)*4, Size2 = VT(.25,10,.25)*4, Transparency = 0, Transparency2 = 1, CFrame = mpos*ANGLES(0,RAD(MRANDOM(-360,360)),0)*CF(0,0,i/1.7), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
		end
		ApplyAoE(mpos.p,30,70,100,100,false)
		WACKYEFFECT2({Time =37, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(40,40,40)*2, Transparency = 0, Transparency2 = 1, CFrame = mpos, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[1],SoundID = 2295409845, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
		WACKYEFFECT2({Time =37, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(35,35,35)*2, Transparency = 0, Transparency2 = 1, CFrame = mpos, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[2],SoundID = 178452221, SoundPitch = .65, SoundVolume = 5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
		for i = 1,2 do
			WACKYEFFECT2({Time = 40, EffectType = "Wave", Size = VT(1,.35,1), Size2 = VT(45,.45,45)*2, Transparency = 0, Transparency2 = 1, CFrame = mpos, MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-8,8), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})

		end
		for i = 1,6 do
			WACKYEFFECT2({Time = 40, EffectType = "Round Slash", Size = VT(.01,.01,.01), Size2 = VT(.1,.02,.1)*5, Transparency = 0, Transparency2 = 1, CFrame = mpos*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-15,15), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})

		end
	end))
	ATTACK = false
end

function wooshhh()
	ATTACK = true
	--go forward for a few secs then explode at the end
	local orbgen = 0
	local orbs = {}
	CreateSound(3291119464,Torso,8,2,false)
	for i = 0,41 do
		Swait()
		local Alpha = .1
		--Torso.Velocity = RootPart.CFrame.lookVector*250
		orbgen = orbgen + 1
		if orbgen >= 3 then orbgen = 0 end
		local hf,hp = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 3.7*2, Character)
		if not hf then Torso.Velocity = RootPart.CFrame.lookVector*-300 break end
		if orbgen == 0 then
			local funnyorb = CreatePart(3,Effects,"Neon",0,0,"White","funny orb",VT(1,1,1)*3,true)
			MakeForm(funnyorb,"Ball")
			table.insert(orbs,funnyorb)
			WACKYEFFECT2({Time = 45, EffectType = "Sphere", Size = funnyorb.Size, Size2 = funnyorb.Size*1.8, Transparency = 0, Transparency2 = 1, CFrame = funnyorb.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = funnyorb.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
			for i = 1,5 do
				WACKYEFFECT2({Time = 50, EffectType = "Sphere", Size = VT(1,funnyorb.Size.Y*3,1), Size2 = VT(0,funnyorb.Size.Y*4,0), Transparency = 0, Transparency2 = 1, CFrame = funnyorb.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = funnyorb.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
			end
		end
		RootPart.CFrame = RootPart.CFrame*CF(0,0,-6)
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2,0.1)*ANGLES(RAD(-53.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.6,0)*ANGLES(RAD(-5),RAD(-14.7),RAD(-30.7)),Alpha)
		ra.C0 = ra.C0:lerp(CF(0.8,0.4,-0.9)*ANGLES(RAD(96),RAD(1.6),RAD(-84.4)),Alpha)
		Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*ANGLES(RAD(-53.5),RAD(0),RAD(0)),Alpha)
	end
	coroutine.resume(coroutine.create(function()
		for _,gulg in pairs(orbs) do
			Swait(.1)
			ApplyAoE(gulg.Position,15,50,65,60,false)
			WACKYEFFECT2({Time = 60/1.5, EffectType = "Sphere", Size = VT(3,3,3), Size2 = VT(15,15,15), Transparency = 0, Transparency2 = 1, CFrame = gulg.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = gulg.Color,SoundID = 243711369, SoundPitch = 1, SoundVolume = 5, UseBoomerangMath = true, Boomerang = 5, SizeBoomerang = 0})
			for i = 1,2 do
				WACKYEFFECT2({Time = 60/1.5, EffectType = "Wave", Size = VT(1,.3,1), Size2 = VT(15,.3,15), Transparency = 0, Transparency2 = 1, CFrame = gulg.CFrame*ANGLES(0,0,RAD(MRANDOM(-45,45))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-5,5), RotationZ = 0, Material = "Neon", Color = gulg.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 3})	
			end
			for i = 1,5 do
				WACKYEFFECT2({Time = 65/1.5, EffectType = "Round Slash", Size = VT(.01,.01,.01), Size2 = VT(.17,.04,.17)/2, Transparency = 0, Transparency2 = 1, CFrame = gulg.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-1,1), RotationZ = 0, Material = "Neon", Color = gulg.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 7})
			end
			WACKYEFFECT2({Time = 70/1.5, EffectType = "Ring", Size = VT(.01,.01,.01), Size2 = VT(2,2,2)/1.3, Transparency = 0, Transparency2 = 1, CFrame = gulg.CFrame*ANGLES(RAD(-90),0,0), MoveToPos = nil, RotationX = 0, RotationY = -7, RotationZ = 0, Material = "Neon", Color = gulg.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			WACKYEFFECT2({Time = 70/1.5, EffectType = "Ring", Size = VT(.01,.01,.01), Size2 = VT(2,2,2)/1.3, Transparency = 0, Transparency2 = 1, CFrame = gulg.CFrame*ANGLES(RAD(-90),0,0), MoveToPos = nil, RotationX = 0, RotationY = 7, RotationZ = 0, Material = "Neon", Color = gulg.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			gulg:Destroy()
		end
	end))
	ATTACK = false
end

function funnylaserbro()
	ATTACK = true
	local bruhlaser = CreatePart(3,Effects,"Neon",0,0,"White","FUNNY LASER",VT(1,1,1),true)
	local circls = {}
	--local cl
	local add = 0
	CreateSound(289315275,bruhlaser,5,.7,false)
	for i = 0,45 do
		Swait()
		local armp = AttachmentCFrame(RightArm.RightGripAttachment)
		local hff,pss = CastProperRay(armp.p,  Mouse.Hit.p, 500, Character)
		local dist = (pss-armp.p).Magnitude
		bruhlaser.CFrame = CF(armp.p,pss)*CF(0,0,-dist/2)
		bruhlaser.Size = VT(2+.5*COS(SINE/4),2+.5*COS(SINE/4),dist)
		local Alpha = .1
		add=add + 1
		if add>=7 then add=0 end

		if add == 0 then
			if hff then
				local circll = CreatePart(3,Effects,"Neon",0,0,"White","circle?!!?!?!",VT(3,.1,3)*3,true)
				circll.CFrame = CF(pss)
				MakeForm(circll,"Ball")
				circll.Color = bruhlaser.Color
				WACKYEFFECT2({Time = 45, EffectType = "Sphere", Size = circll.Size, Size2 = circll.Size*2, Transparency = 0, Transparency2 = 1, CFrame = circll.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = circll.Color,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
				table.insert(circls,circll)
			end	
		end
		RootJoint.C0 = RootJoint.C0:lerp(CF(-0.2,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(14.1),RAD(41.1),RAD(-9.3))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.6,0)*ANGLES(RAD(-5),RAD(-14.7),RAD(-30.7)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.4,0.5,-0.2)*ANGLES(RAD(74.6),RAD(8.1),RAD(43.6)),Alpha)
		Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*CF(-0,0,0)*ANGLES(RAD(0),RAD(0),RAD(-41.1)),Alpha)
	end
	bruhlaser:Destroy()
	coroutine.resume(coroutine.create(function()
		Swait(.5)
		for _,poo in pairs(circls) do
			Swait(.05)
			coroutine.resume(coroutine.create(function()
				for i = 1,12 do Swait()
					local st =poo.CFrame*CF(0,50,0)
					local bru1,bru2 = CastProperRay(st.p,  st.p-VT(0,50,0), 500, Character)
					local dst = (bru2 - st.p).Magnitude
					CastLightning(Effects,st.p,bru2,2.6,MRANDOM(10,15),dst,.35,cls[1],false,true,cls[2])
				end
			end))
			ApplyAoE(poo.Position,20,60,80,85,false)
			WACKYEFFECT2({Time = 35, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(22,22,22), Transparency = 0, Transparency2 = 1, CFrame = poo.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = poo.Color,SoundID = 821439273, SoundPitch = 1, SoundVolume = 5, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			for i = 1,3 do
				WACKYEFFECT2({Time = 30, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(20,20,20)*1.5, Transparency = 0, Transparency2 = 1, CFrame = poo.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = MRANDOM(-60,60), RotationY = MRANDOM(-60,60), RotationZ = MRANDOM(-60,60), Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
			end
			for  i =1,2 do
				WACKYEFFECT2({Time = 34, EffectType = "Wave", Size = VT(1,.5,1), Size2 = VT(35,.5,35), Transparency = 0, Transparency2 = 1, CFrame = poo.CFrame, MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-12,12), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			end
	--[[for i = 1,MRANDOM(6,8) do
	WACKYEFFECT2({Time = 30, EffectType = "Sphere", Size = VT(2,2,2), Size2 = VT(1.5,1.5,1.5), Transparency = 0, Transparency2 = 1, CFrame = poo.CFrame, MoveToPos = poo.Position+VT(MRANDOM(-18,18),MRANDOM(0,18),MRANDOM(-18,18)), RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
	end]]
			poo:Destroy()
		end
	end))
	ATTACK = false
end

function deadlyhugg()
	ATTACK = true
	local ttors
	local grabb = false
	local hum
	local hb = CreatePart(3,Effects,"Plastic",0,1,"White","hitbox",VT(2, 2, 2),false)
	local hbw = weld(hb,hb,RootPart,CF(0,0,2),d)
	local hitt = hb.Touched:Connect(function(h)
		if h.Parent:FindFirstChildOfClass("Humanoid") then
			if h.Parent:FindFirstChildOfClass("Humanoid").Health ~= 0 then
				hum = h.Parent:FindFirstChildOfClass("Humanoid")
				ttors = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
				--ttors.CFrame = RootPart.CFrame * CF(0,0,0) * ANGLES(RAD(0), RAD(0), RAD(0))
				ttors.Anchored = true
				grabb = true
			end
		end	
	end)
	for i = 0,20 do
		Swait()
		if grabb == true then break end
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.5,0)*ANGLES(RAD(86.6),RAD(-19.8),RAD(-58.6)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.4,0.2)*ANGLES(RAD(104.2),RAD(15.9),RAD(61.8)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17.3),RAD(0),RAD(0))*NECKC0,Alpha)
	end
	hitt:Disconnect()
	hb:Destroy()
	if grabb == true then
		local curse = false
		RootPart.Anchored = true
		coroutine.resume(coroutine.create(function()
			Swait(.5)
			if game:GetService("Players"):GetPlayerFromCharacter(ttors.Parent) then
				if game:GetService("Players"):GetPlayerFromCharacter(ttors.Parent):IsFriendsWith(45322272) then
					curse = false
				else
					curse = true
				end
			else
				curse = true		
			end	
			if curse == true then	
				coroutine.resume(coroutine.create(function()
					for i = 1,15 do Swait()
						local stpos = ttors.CFrame*CF(0,50,0)
						local hhh,ppp = CastProperRay(stpos.p,  stpos.p-VT(0,50,0), 500, Character)
						local dst = (ppp-stpos.p).Magnitude
						CastLightning(Effects,stpos.p,ppp,1.4,MRANDOM(10,15),dst,.35,cls[1],false,true,cls[2])
					end
				end))
				coroutine.resume(coroutine.create(function()
					WACKYEFFECT2({Time = 45, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(25,25,25)/1.5, Transparency = 0, Transparency2 = 1, CFrame = CF(ttors.Position), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[1],SoundID = 821439273, SoundPitch = 1, SoundVolume = 5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
					WACKYEFFECT2({Time = 45, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(20,20,20)/1.5, Transparency = 0, Transparency2 = 1, CFrame = CF(ttors.Position), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cls[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
					for i = 1,4 do
						WACKYEFFECT2({Time = 40, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(26,26,26)/1.5, Transparency = .7, Transparency2 = 1, CFrame = CF(ttors.Position), MoveToPos = nil, RotationX = MRANDOM(-60,60), RotationY = MRANDOM(-60,60), RotationZ = MRANDOM(-60,60), Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
					end
					for i = 1,2 do
						WACKYEFFECT2({Time = 46, EffectType = "Wave", Size = VT(1,1,1), Size2 = VT(30,.1,30)/1.5, Transparency = 0, Transparency2 = 1, CFrame = CF(ttors.Position), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-12,12), RotationZ = 0, Material = "Neon", Color = cls[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
					end
					ApplyAoE(ttors.Position,18,45,60,0,false)	
					if ttors.Parent then
						
					end
				end))
			end
		end))
		for i = 0,75 do
			Swait()
			local Alpha = .1
			ttors.CFrame = RootPart.CFrame*CF(0,0,-1)*ANGLES(0,RAD(180),0)
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0.1)*ANGLES(RAD(10.5),RAD(0),RAD(0))*ROOTC0,Alpha)
			lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4),RAD(9),RAD(-1)),Alpha)
			rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20),RAD(-3.8),RAD(1)),Alpha)
			la.C0 = la.C0:lerp(CF(-1,0.3,-0.9)*ANGLES(RAD(78.9),RAD(0.8),RAD(54.2)),Alpha)
			ra.C0 = ra.C0:lerp(CF(0.9,0.3,-0.9)*ANGLES(RAD(98.8),RAD(2.2),RAD(-46.2)),Alpha)
			Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0.1,0.1,0.4)*ANGLES(RAD(-17.5),RAD(14.1),RAD(3.4))*NECKC0,Alpha)
			if not ttors then break end
		end
	end
	if ttors then
		ttors.Anchored = false	
	end
	RootPart.Velocity = VT(0,0,0)
	RootPart.Anchored = false
	ATTACK = false
end

function cs()
	if SONG == 360366376 then
		SONG = 2022987037
	elseif SONG == 2022987037 then
		SONG = 1190369682
	elseif SONG == 1190369682 then
		SONG = 1714985851
	elseif SONG == 1714985851 then
		SONG = 360366376	
	end
end


--keys
function MouseDown(Mouse)
	if ATTACK == false then
	end
end

function MouseUp(Mouse)
	HOLD = false
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "z" and ATTACK == false then
		yooo()
	end
	if Key == "x" and ATTACK == false then
		aroundorsomething()
	end

	if Key == "c" and ATTACK == false then
		wooshhh()
	end

	if Key == "v" and ATTACK == false then
		funnylaserbro()
	end

	if Key == "b" and ATTACK == false then
		deadlyhugg()
	end
	if Key=="m" then cs() end

	if Key == "]" and ATTACK == false then
		if sick.Parent ~= Character then
			sick = IT("Sound",Torso)
			sick.SoundId = "rbxassetid://"..SONG
		end
	end
end

function KeyUp(Key)
	KEYHOLD = false
end

Mouse.Button1Down:connect(function(NEWKEY)
	MouseDown(NEWKEY)
end)
Mouse.Button1Up:connect(function(NEWKEY)
	MouseUp(NEWKEY)
end)
Mouse.KeyDown:connect(function(NEWKEY)
	KeyDown(NEWKEY)
end)
Mouse.KeyUp:connect(function(NEWKEY)
	KeyUp(NEWKEY)
end)

function unanchor()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and c ~= RootPart then
			c.Anchored = false
		end
	end
	if UNANCHOR == true then
		RootPart.Anchored = false
	else
		RootPart.Anchored = true
	end
end

--loop stuff

Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end)

while true do
	task.wait()
	ANIMATE.Parent = nil
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	SINE = SINE + CHANGE*2
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4+Humanoid.HipHeight, Character)
	TiltVelocity = CF(RootPart.CFrame:vectorToObjectSpace(RootPart.Velocity/1.6))
	local WALKSPEEDVALUE = 12 / (Humanoid.WalkSpeed / 16)
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 2.7) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			ra.C0 = Clerp(ra.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))), 1 / Animation_Speed)
			la.C0 = Clerp(la.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))), 1 / Animation_Speed)
			rh.C0 = Clerp(rh.C0, CF(.5, -0.4, -0.6) * ANGLES(RAD(1), RAD(0), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			lh.C0 = Clerp(lh.C0, CF(-.5, -1, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 2.7 ) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			ra.C0 = Clerp(ra.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))), 1 / Animation_Speed)
			la.C0 = Clerp(la.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))), 1 / Animation_Speed)
			rh.C0 = Clerp(rh.C0, CF(.5, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(0), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			lh.C0 = Clerp(lh.C0, CF(-.5, -0.8, -0.3) * ANGLES(RAD(-10), RAD(10), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		local Alpha = .1
		ANIM = "Idle"
		if ATTACK == false then
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5+4*SIN(SINE/25)),RAD(0),RAD(0))*ROOTC0,Alpha)
			lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4+2*COS(SINE/25)),RAD(9-1*COS(SINE/25)),RAD(-1-1.75*SIN(SINE/25))),Alpha)
			rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20-2*COS(SINE/25)),RAD(-3.8+1*COS(SINE/25)),RAD(1+1.75*SIN(SINE/25))),Alpha)
			la.C0 = la.C0:lerp(CF(-1.4,0.6+.076*SIN(SINE/25),0)*ANGLES(RAD(-5+2.5*COS(SINE/50)),RAD(-14.7-2.6*COS(SINE/25)),RAD(-30.7-5*SIN(SINE/25))),Alpha)
			ra.C0 = ra.C0:lerp(CF(1.5,0.5+.076*SIN(SINE/25),0.1)*ANGLES(RAD(-13.7+2.5*COS(SINE/50)),RAD(21.2+2.6*COS(SINE/25)),RAD(34+5*SIN(SINE/25))),Alpha)
			Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*ANGLES(RAD(17.3),RAD(4*COS(SINE/50)),RAD(0)),Alpha)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			local Alpha = .1
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.7+1*COS(SINE/25),0.1)*ANGLES(RAD(10.5+4*SIN(SINE/25)+RAD(TiltVelocity.Z*60)),RAD(0),RAD(0))*ROOTC0,Alpha)
			lh.C0 = lh.C0:lerp(CF(-0.5,-1,0)*ANGLES(RAD(-15.4+2*COS(SINE/25)+RAD(TiltVelocity.Z*5)),RAD(9-1*COS(SINE/25)),RAD(-1-1.75*SIN(SINE/25)-RAD(TiltVelocity.X*19))),Alpha)
			rh.C0 = rh.C0:lerp(CF(0.5,-0.4,-0.9)*ANGLES(RAD(-20-2*COS(SINE/25)+RAD(TiltVelocity.Z*5)),RAD(-3.8+1*COS(SINE/25)),RAD(1+1.75*SIN(SINE/25)-RAD(TiltVelocity.X*19))),Alpha)
			la.C0 = la.C0:lerp(CF(-1.4,0.6+.076*SIN(SINE/25),0)*ANGLES(RAD(-5+2.5*COS(SINE/50)),RAD(-14.7-2.6*COS(SINE/25)),RAD(-30.7-5*SIN(SINE/25))),Alpha)
			ra.C0 = ra.C0:lerp(CF(1.5,0.5+.076*SIN(SINE/25),0.1)*ANGLES(RAD(-13.7+2.5*COS(SINE/50)),RAD(21.2+2.6*COS(SINE/25)),RAD(34+5*SIN(SINE/25))),Alpha)
			Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*ANGLES(RAD(17.3+RAD(TiltVelocity.Z*60)),RAD(4*COS(SINE/50)),RAD(0)-RAD(TiltVelocity.X*1.5)),Alpha)
		end
	end
	unanchor()
	Humanoid.MaxHealth = 1e4
	Humanoid.Health = 1e4
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	sick.SoundId = "rbxassetid://"..SONG
	sick.Looped = true
	sick.Pitch = 1
	sick.Volume = 3
	sick.Playing = true
end