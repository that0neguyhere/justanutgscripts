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
local Speed = 40
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

local TweenService = game:GetService("TweenService")

function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
	local MoveStyle = Enum.EasingStyle[MoveStyle2]
	local outorin = Enum.EasingDirection[outorin2]
	local dahspeed=1
	local tweeningInformation = TweenInfo.new(
		AnimTime/dahspeed,	
		MoveStyle,
		outorin,
		0,
		false,
		0
	)
	local MoveCF = CFr
	local tweenanim = TweenService:Create(SPart,tweeningInformation,MoveCF)
	tweenanim:Play()
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

function randomangle()
	return ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
end

Debris = game:GetService("Debris")

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end


function SHAKECAM(POSITION,RANGE,INTENSITY,TIME)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						local CAMSHAKER = script.CamShake:Clone()
						CAMSHAKER.Shake.Value = INTENSITY
						CAMSHAKER.Timer.Value = TIME
						CAMSHAKER.Parent = CHILD
						CAMSHAKER.Disabled = false
					end
				end
			end
		end
	end
end


function AttachmentCFrame(What)
	return What.Parent.CFrame*CF(What.Position)
end


--weap
local op = false
local SONG = 4076288044
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

local ringspin = true
local cryspin = true
if Head:FindFirstChild("face") then Head.face.Transparency = 0 end
local stre = Instance.new("Model",Character)
stre.Name = "other"
local la2 = LeftArm
local ra2 = RightArm
local tor = RootPart
local ll = LeftLeg
local rl = RightLeg
local hw = Head
local ringo = Instance.new("Part", script)
ringo.CanCollide = false
ringo.Anchored = true
ringo.Color = Color3.fromRGB(0, 255, 0)
ringo.Reflectance = 0.5
ringo.Material = "Glass"
ringo.Size = Vector3.new(1, 1, 1)
local ringomesh = Instance.new("SpecialMesh", ringo)
ringomesh.MeshId = "rbxassetid://471124075"
ringomesh.Scale = Vector3.new(0.08,0.08,0.08)
ringo.Parent = nil
local ring1,ring2 = ringo:Clone(),ringo:Clone() ring1.Name,ring2.Name = "ring1","ring2" ring1.Parent,ring2.Parent = stre,stre ring2.Size = ringo.Size*.88
ring1.Anchored,ring2.Anchored = false,false
local ringweld1,ringweld2 = weld(Torso,ring1,Torso,d*ANGLES(RAD(MRANDOM(-25,25)),RAD(MRANDOM(-25,25)),RAD(MRANDOM(75,95))),d),weld(Torso,ring2,Torso,d*ANGLES(RAD(MRANDOM(-25,25)),RAD(MRANDOM(-25,25)),RAD(MRANDOM(-25,25))),d)
local cryst = Instance.new("Part", script)
cryst.CanCollide = false
cryst.Anchored = true
cryst.Color = Color3.fromRGB(0, 255, 0)
cryst.Reflectance = 0.7
cryst.Material = "Glass"
cryst.Size = Vector3.new(1.061, 2.904, 1.158)
local crystmesh = Instance.new("SpecialMesh", cryst)
crystmesh.MeshId = "rbxassetid://4699095928"
cryst.Parent = nil
local cr1,cr2,cr3,cr4 = cryst:Clone(),cryst:Clone(),cryst:Clone(),cryst:Clone()
cr1.Name,cr2.Name,cr3.Name,cr4.Name = "cryst1","cryst2","cryst3","cryst4"
crw1,crw2,crw3,crw4 = weld(cr1,cr1,Torso,d*ANGLES(RAD(90),RAD(90),0),d),weld(cr2,cr2,Torso,d*ANGLES(RAD(90),RAD(90),0),d),weld(cr3,cr3,Torso,d*ANGLES(RAD(90),RAD(90),0),d),weld(cr4,cr4,Torso,d*ANGLES(RAD(90),RAD(90),0),d)
cr1.Parent,cr2.Parent,cr3.Parent,cr4.Parent = stre,stre,stre,stre cr1.Anchored,cr2.Anchored,cr3.Anchored,cr4.Anchored = false,false,false,false
local cols = {Color3.fromRGB(0, 255, 85),Color3.fromRGB(87, 220, 98)}






--dmg
function da(MODEL)

end

function ApplyDamage(Humanoid,Damage)

end

function ApplyAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)

end

--attacks
function cs()
	if SONG == 4076288044 then
		SONG = 641175763
	elseif SONG == 641175763 then
		SONG = 144689666
	elseif SONG == 144689666 then
		SONG = 256878671
	elseif SONG == 256878671 then
		SONG = 2940505735
	elseif SONG == 2940505735 then
		SONG = 3677916205
	elseif SONG == 3677916205 then
		SONG = 2935068298
	elseif SONG == 2935068298 then
		SONG = 4076288044		
	end	
end

function tp()
	--sombra move lolpoop
	ATTACK = true

	ATTACK = false	
end

function laser()
	ATTACK = true
	local bbc = true
	local ringo1,ringo2 = ringo:Clone(),ringo:Clone()
	local jj = 0
	ringo1.Anchored,ringo2.Anchored = false,false
	ringo1.Size = ringo1.Size*.7
	ringo2.Size = ringo2.Size*.6
	ringo1.Transparency,ringo2.Transparency = 1,1
	ringo1.Parent,ringo2.Parent = Effects,Effects
	local bruhw1,bruhw2 = weld(ringo1,ringo1,RightArm,CF(0,2,0)*ANGLES(RAD(0),0,0),d),weld(ringo2,ringo2,RightArm,CF(0,2,0)*ANGLES(RAD(0),0,0),d)
	SetTween(ringo1,{Transparency = 0},"Linear","InOut",.45)
	SetTween(ringo2,{Transparency = 0},"Linear","InOut",.45)

	for i = 0,50 do
		Swait()
		local Alpha = .1
		jj = jj+1 if jj >= 7 then jj = 0 end
		if MRANDOM(1,3) == 1 then
			WACKYEFFECT2({Time = 35, EffectType = "Sphere", Size = VT(1,3,1), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = ringo1.CFrame*CF(MRANDOM(-13,13),MRANDOM(-13,13),MRANDOM(-13,13)), MoveToPos = ringo1.Position, RotationX = MRANDOM(-7,7), RotationY = MRANDOM(-7,7), RotationZ = MRANDOM(-7,7), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
		end
		if jj == 1 then
			WACKYEFFECT2({Time = 30, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(15,15,1)/2, Transparency = 0, Transparency2 = 1, CFrame = ringo1.CFrame*ANGLES(RAD(90),0,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1),SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
			WACKYEFFECT2({Time = 30, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(15,15,1)/2, Transparency = 0, Transparency2 = 1, CFrame = ringo1.CFrame*ANGLES(RAD(90),0,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = MRANDOM(-8,8), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
		end
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.8),RAD(41),RAD(-1.8))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.6,0.1)*ANGLES(RAD(0.9),RAD(14.3),RAD(-25)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.3,0.5,-0.3)*ANGLES(RAD(85.3),RAD(10.9),RAD(34.3)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(-0,0,0)*ANGLES(RAD(-7.2),RAD(-40.7),RAD(-5))*NECKC0,Alpha)
	end
	jj = 0
	local lasr = CreatePart(3,Effects,"Neon",0,0,"White","hfdhd",VT(1,1,1),true)
	local allah
	CreateSound(289315275,lasr,5,1,op)
	for i = 0,65 do
		Swait()
		lasr.Color = cols[MRANDOM(1,2)]
		local armp = ringo1.CFrame
		local h,ps = CastProperRay(armp.p,  Mouse.Hit.p, 500, Character)
		local dist = (ps - armp.p).Magnitude
		lasr.CFrame = CF(armp.p,ps)*CF(0,0,-dist/2)
		lasr.Size = VT(4+.3*COS(SINE/6),4+.3*COS(SINE/6),dist)
		--jj = jj+1 if jj >= 7 then jj = 0 end
		if h then
			if MRANDOM(1,3) == 1 then
				WACKYEFFECT2({Time = 30, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(35,35,35)/1.3, Transparency = 0, Transparency2 = 1, CFrame = CF(ps), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				WACKYEFFECT2({Time = 30, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(35,35,35)/1.3, Transparency = 0, Transparency2 = 1, CFrame = CF(ps), MoveToPos = nil, RotationX = MRANDOM(-8,8), RotationY = MRANDOM(-8,8), RotationZ = MRANDOM(-8,8), Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
			end
			ApplyAoE(ps,25,25,50,120,op)
			if MRANDOM(1,2) == 1 then
				WACKYEFFECT2({Time = 35, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(1,7,1), Transparency = 0, Transparency2 = 1, CFrame = CF(ps), MoveToPos = ps+VT(MRANDOM(-30,30),MRANDOM(-30,30),MRANDOM(-30,30)), RotationX = MRANDOM(-6,6), RotationY = MRANDOM(-6,6), RotationZ = MRANDOM(-6,6), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			end
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.8),RAD(41),RAD(-1.8))*ROOTC0,.1)
		end
		allah = CF(ps)
	end
	SetTween(ringo1,{Transparency = 1},"Linear","InOut",.38)
	SetTween(ringo2,{Transparency = 1},"Linear","InOut",.38)
	SetTween(lasr,{Transparency = 1},"Linear","InOut",.38)
	Debris:AddItem(ringo1,.4)
	Debris:AddItem(ringo2,.4)
	Debris:AddItem(lasr,.4)
	WACKYEFFECT2({Time = 60, EffectType = "Sphere", Size = VT(20,20,20), Size2 = VT(35,70,35), Transparency = 0, Transparency2 = 1, CFrame = allah, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[2],SoundID = 231917806, SoundPitch = 1.2, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
	WACKYEFFECT2({Time = 60, EffectType = "Sphere", Size =  VT(20,20,20), Size2 = VT(25,60,25), Transparency = 0, Transparency2 = 1, CFrame = allah, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
	for i = 1,2 do
		WACKYEFFECT2({Time = 60, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(40,1,40), Transparency = 0, Transparency2 = 1, CFrame = allah, MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-10,10), RotationZ = 0, Material = "Neon", Color = cols[i],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
	end
	for i = 1,12 do
		WACKYEFFECT2({Time = 70, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(2,8,2), Transparency = 0, Transparency2 = 1, CFrame = allah, MoveToPos = allah.p+VT(MRANDOM(-25,25),MRANDOM(0,60),MRANDOM(-25,25)), RotationX = MRANDOM(-8,8), RotationY = MRANDOM(-8,8), RotationZ = MRANDOM(-8,8), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
	end	
	ATTACK = false
end

function spreadd()
	ATTACK = true
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(3.5),RAD(53.5),RAD(-2.8))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.4,0)*ANGLES(RAD(2.9),RAD(-8.3),RAD(-12.1)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.4,0.3,-0.1)*ANGLES(RAD(77.9),RAD(-9.1),RAD(57.8)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(-0.1,0,0.1)*ANGLES(RAD(-8.5),RAD(-53.2),RAD(-6.8))*NECKC0,Alpha)
	end
	coroutine.resume(coroutine.create(function()
		local shardd = cryst:Clone()
		shardd.Mesh.Scale = shardd.Mesh.Scale*7
		shardd.Parent = Effects
		shardd.CFrame = Mouse.Hit*CF(0,-10,0)
		shardd.Orientation = VT(0,0,0)
		local shardpos = shardd.CFrame*CF(0,10,0)
		WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(50,.2,50), Size2 = VT(0,.1,0), Transparency = 0, Transparency2 = 1, CFrame = shardd.CFrame*CF(0,10,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
		SetTween(shardd,{CFrame = shardd.CFrame*CF(0,20,0)},"Linear","InOut",.3)
		CreateSound(235097661,shardd,7,1.75,false)
		Swait(.8)
		WACKYEFFECT2({Time = 50, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(45,45,45), Transparency = 0, Transparency2 = 1, CFrame = shardd.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
		for i = 1,24 do
			WACKYEFFECT2({Time = 55, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(0,10,0), Transparency = 0, Transparency2 = 1, CFrame = shardd.CFrame, MoveToPos = shardd.Position+VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25))*1.5, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
		end
		WACKYEFFECT2({Time = 50, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(46,46,46), Transparency = 0, Transparency2 = 1, CFrame = shardd.CFrame, MoveToPos = nil, RotationX = 8, RotationY = 8, RotationZ = 8, Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
		shardd:Destroy()
		local point1,point2,point3,point4 = shardpos*CF(-10,0,0),shardpos*CF(0,0,10),shardpos*CF(0,0,-10),shardpos*CF(10,0,0)
		local endpos
		local gr = 0
		for i = 1,40 do
			Swait()
			gr = gr+1 if gr>=10 then gr = 0 end
			local ppos1 = point1*ANGLES(0,RAD(i*2),0)*CF(-i*2,0,0)
			local ppos2 = point2*ANGLES(0,RAD(i*2),0)*CF(0,0,i*2)
			local ppos3 = point3*ANGLES(0,RAD(i*2),0)*CF(0,0,-i*2)
			local ppos4 = point4*ANGLES(0,RAD(i*2),0)*CF(i*2,0,0)
			if gr == 1 then
				ApplyAoE(ppos1.p,20,50,75,80,op)	
				ApplyAoE(ppos2.p,20,50,75,80,op)	
				ApplyAoE(ppos3.p,20,50,75,80,op)	
				ApplyAoE(ppos4.p,20,50,75,80,op)	
			end
			WACKYEFFECT2({Time = 15, EffectType = "Sphere", Size = VT(i,i,i)/15, Size2 = VT(i,i,i), Transparency = 0, Transparency2 = 1, CFrame = ppos1, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = 418703376, SoundPitch = 1.6, SoundVolume = 4, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			WACKYEFFECT2({Time = 15, EffectType = "Sphere", Size = VT(i,i,i)/15, Size2 = VT(i,i,i), Transparency = 0, Transparency2 = 1, CFrame = ppos2, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			WACKYEFFECT2({Time = 15, EffectType = "Sphere", Size = VT(i,i,i)/15, Size2 = VT(i,i,i), Transparency = 0, Transparency2 = 1, CFrame = ppos3, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			WACKYEFFECT2({Time = 15, EffectType = "Sphere", Size = VT(i,i,i)/15, Size2 = VT(i,i,i), Transparency = 0, Transparency2 = 1, CFrame = ppos4, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
			endpos = {ppos1,ppos2,ppos3,ppos4}
		end
		delay(.1,function()
			for _,j in pairs(endpos) do
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(60,60,60)/2, Transparency = 0, Transparency2 = 1, CFrame = j, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = 3570964678, SoundPitch = 1, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				WACKYEFFECT2({Time = 40, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(60,60,60)/2, Transparency = 0, Transparency2 = 1, CFrame = j, MoveToPos = nil, RotationX = 8, RotationY = 8, RotationZ = 8, Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				for u = 1,8 do
					WACKYEFFECT2({Time = 45, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(1,5,1)*2, Transparency = 0, Transparency2 = 1, CFrame = j, MoveToPos = j.p+VT(MRANDOM(-25,25),MRANDOM(0,25),MRANDOM(-25,25)), RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
				end
			end
		end)
	end))
	for i = 0,17 do
		Swait()
		local Alpha = .2
		RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,2.35+.65*COS(SINE/35),0.4)*ANGLES(RAD(16.5),RAD(53.5),RAD(-2.8))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-0.9,-0.2)*ANGLES(RAD(-15.7),RAD(8.9),RAD(-11.8)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.6,-0.5,-1)*ANGLES(RAD(-15.7),RAD(-0.4),RAD(-8.6)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.5,0.4,0)*ANGLES(RAD(2.9),RAD(-8.3),RAD(-12.1)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.5,0.7,-0.3)*ANGLES(RAD(105.5),RAD(31.2),RAD(52)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(-0.1,0,0.1)*ANGLES(RAD(-8.5),RAD(-53.2),RAD(-6.8))*NECKC0,Alpha)
	end
	ATTACK = false	
end

function salvomove()
	ATTACK = true
	local abb = 0
	local shrds = {}
	coroutine.resume(coroutine.create(function()
		for i = 1,10 do
			Swait(3)
			local shrd = cryst:Clone()
			shrd.Mesh.Scale = shrd.Mesh.Scale*1.6
			shrd.Parent = Effects
			shrd.CFrame = RootPart.CFrame*CF(MRANDOM(-16,16),-20,MRANDOM(-16,16))
			SetTween(shrd,{CFrame = shrd.CFrame*CF(0,20,0)},"Quart","InOut",.35)
			table.insert(shrds,shrd)
			CreateSound(1221376691,shrd,4,1,false)
		end	
	end))
	for i = 0,60 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.5)*ANGLES(RAD(21),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1.2,-0.2)*ANGLES(RAD(-28.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.7,-1.1)*ANGLES(RAD(-26.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.3,0)*ANGLES(RAD(2.9),RAD(-8.3),RAD(-72.4)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.4,0.3,0.1)*ANGLES(RAD(2.9),RAD(-8.3),RAD(75.8)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0,-0.1)*ANGLES(RAD(2.6),RAD(-0.1),RAD(-1.6))*NECKC0,Alpha)
	end
	for i = 1,#shrds do
		SetTween(shrds[i],{CFrame = CF(shrds[i].Position,Mouse.Hit.p)*ANGLES(RAD(-90),0,0)},"Sine","InOut",.45)	
	end
	delay(.3,function()
		coroutine.resume(coroutine.create(function()
			Swait(20)
			for i = 1,#shrds do
				Swait(.1)
				local hpp,ppp = CastProperRay(shrds[i].Position,  Mouse.Hit.p, 500, Character)
				local dist = (ppp-shrds[i].Position).Magnitude
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(1,1,dist), Size2 = VT(5,5,dist), Transparency = 0, Transparency2 = 1, CFrame = CF(shrds[i].Position,ppp)*CF(0,0,-dist/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(5,5,dist), Size2 = VT(1,1,dist), Transparency = 0, Transparency2 = 1, CFrame = CF(shrds[i].Position,ppp)*CF(0,0,-dist/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = -5, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				shrds[i]:Destroy()
				ApplyAoE(ppp,20,60,80,100,op)
				WACKYEFFECT2({Time = 50, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(20,20,20), Transparency = 0, Transparency2 = 1, CFrame = CF(ppp), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[1],SoundID = 233856106, SoundPitch = 2, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				WACKYEFFECT2({Time = 50, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(20,20,20), Transparency = 0, Transparency2 = 1, CFrame = CF(ppp), MoveToPos = nil, RotationX = 8, RotationY = 8, RotationZ = 8, Material = "Neon", Color = cols[2],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
				for i = 1,8 do
					WACKYEFFECT2({Time = 60, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(0.1,3,0.1)*2, Transparency = 0, Transparency2 = 1, CFrame = CF(ppp), MoveToPos = ppp+VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25)), RotationX = MRANDOM(-7,7), RotationY = MRANDOM(-7,7), RotationZ = MRANDOM(-7,7), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
				end
				--weldBetween(g,hpp)
			end
		end))
	end)
	for i = 0,80 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.1),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.4,-0.6)*ANGLES(RAD(88.7),RAD(-12.8),RAD(7.2)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.4,0.4,-0.6)*ANGLES(RAD(92.6),RAD(12),RAD(-15.2)),Alpha)
		Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*CF(0,0,0.2)*ANGLES(RAD(-5.9),RAD(0.2),RAD(-1.6)),Alpha)
	end
	ATTACK = false
end

function fic()
	ATTACK = true
	Rooted = true
	for i = 0,20 do
		Swait()
		local Alpha = .25
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.1),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1,0.4,-0.7)*ANGLES(RAD(93.6),RAD(-12.1),RAD(55)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.2,0.5,-0.5)*ANGLES(RAD(85.3),RAD(10.9),RAD(-50.2)),Alpha)
		Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*CF(0,0,0)*ANGLES(RAD(-5.9),RAD(0.2),RAD(-1.6)),Alpha)
	end

	for i = 0,22 do
		Swait()
		local Alpha = .12
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.8),RAD(-42.4),RAD(1.9))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.6,0.1)*ANGLES(RAD(0.9),RAD(14.3),RAD(-25)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.4,0.5,-0.4)*ANGLES(RAD(85.3),RAD(10.9),RAD(-4.3)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0,0)*ANGLES(RAD(-7.3),RAD(42.5),RAD(1.9))*NECKC0,Alpha)
	end
	local cc = 0
	local bruhs = {}
	--cc = 0
	--local cc2 = 3
	coroutine.resume(coroutine.create(function()
		Swait(30)
		for i = 1,#bruhs do
			Swait(.05)
			--cc = cc + 1 if cc == 3 then	cc = 1 end
			--cc2 = cc2 - 1 if cc2 == 0 then	cc2 = 1 end
			WACKYEFFECT2({Time = 30, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(32,32,32)/(MRANDOM(17,22)/10), Transparency = 0, Transparency2 = 1, CFrame = bruhs[i].PrimaryPart.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = 200633780, SoundPitch = 1.5, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
			WACKYEFFECT2({Time = 30, EffectType = "Box", Size = VT(1,1,1), Size2 = VT(28,28,28)/(MRANDOM(17,22)/10), Transparency = 0, Transparency2 = 1, CFrame = bruhs[i].PrimaryPart.CFrame, MoveToPos = nil, RotationX = MRANDOM(-12,12), RotationY = MRANDOM(-12,12), RotationZ = MRANDOM(-12,12), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 5})
			for hh = 1,4 do
				WACKYEFFECT2({Time = 35, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(1,7.5,1), Transparency = 0, Transparency2 = 1, CFrame = bruhs[i].PrimaryPart.CFrame, MoveToPos = bruhs[i].PrimaryPart.Position+VT(MRANDOM(-20,20),MRANDOM(-20,20),MRANDOM(-20,20)), RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Neon", Color = cols[MRANDOM(1,2)],SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
			end
			bruhs[i]:Destroy()
		end
	end))
	CreateSound(1490749624,RightArm,4,1.2,false)
	for i = 0,18 do
		Swait()
		local Alpha = .3
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0.1)*ANGLES(RAD(2.8),RAD(41),RAD(-1.8))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-1.4,0.6,0.1)*ANGLES(RAD(0.9),RAD(14.3),RAD(-25)),Alpha)
		ra.C0 = ra.C0:lerp(CF(1.3,0.5,-0.3)*ANGLES(RAD(85.3),RAD(10.9),RAD(34.3)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(-0,0,0)*ANGLES(RAD(-7.2),RAD(-40.7),RAD(-5))*NECKC0,Alpha)
	end
	ATTACK = false
	Rooted = false
end

function teleport()
	ATTACK = true
	local tps = CreatePart(3,Effects,"Neon",0,1,"White","ssafhusdfgkdasjl",VT(20,20,20),false)
	MakeForm(tps,"Ball")
	local chos = cols[MRANDOM(1,2)]
	tps.Color = chos
	for i = 1,12 do
		WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(1,5,1), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CF(MRANDOM(-20,20),MRANDOM(-20,20),MRANDOM(-20,20)), MoveToPos = RootPart.Position, RotationX = MRANDOM(-6,6), RotationY = MRANDOM(-6,6), RotationZ = MRANDOM(-6,6), Material = "Neon", Color = chos,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
	end
	tps.Massless = true
	tps.CanCollide = false
	local ww = weld(tps,tps,Torso,d,d)
	SetTween(tps,{Size = VT(10,10,10),Transparency = 0},"Sine","InOut",.6)
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0.1)*ANGLES(RAD(2.1),RAD(0),RAD(0))*ROOTC0,Alpha)
		lh.C0 = lh.C0:lerp(CF(-0.5,-0.2,-0.7)*ANGLES(RAD(-9.3),RAD(7),RAD(-1.4)),Alpha)
		rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7),RAD(-2.2),RAD(1.7)),Alpha)
		la.C0 = la.C0:lerp(CF(-0.7,0.5,-1)*ANGLES(RAD(105.5),RAD(-1.1),RAD(80.1)),Alpha)
		ra.C0 = ra.C0:lerp(CF(0.8,0.1,-0.7)*ANGLES(RAD(2.9),RAD(-8.3),RAD(-94.9)),Alpha)
		Neck.C0 = Neck.C0:lerp(CF(0,0,0+ ((1) - 1))*CF(0,0.1,0.4)*ANGLES(RAD(-17),RAD(0.5),RAD(-1.6))*NECKC0,Alpha)
	end
	local hf,hp = Raycast(Mouse.Hit.p+VT(0,1,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 100, Character)
	hp = hp + VT(0,3.5,0)
	if hf then
		RootPart.Anchored = true
		local bbruh = CF(hp,CF(RootPart.Position,hp)*CF(0,0,-100000).p)
		SetTween(RootPart,{CFrame = bbruh},"Sine","InOut",.8)
		delay(.81,function()
			SetTween(tps,{Size = VT(20,20,20),Transparency = 1},"Sine","InOut",.6)
			for i = 1,12 do
				WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(1,5,1), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame, MoveToPos = RootPart.Position+VT(MRANDOM(-20,20),MRANDOM(-20,20),MRANDOM(-20,20)), RotationX = MRANDOM(-6,6), RotationY = MRANDOM(-6,6), RotationZ = MRANDOM(-6,6), Material = "Neon", Color = chos,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
			end
			ApplyAoE(RootPart.Position,10,20,40,30,op)
			Debris:AddItem(tps,.61)
		end)
	end
	RootPart.Anchored = false
	ATTACK = false
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
		spreadd()
	end
	if Key == "x" and ATTACK == false then
		salvomove()
	end

	if Key == "c" and ATTACK == false then
		fic()
	end

	if Key == "v" and ATTACK == false then
		laser()
	end

	if Key == "b" and ATTACK == false then
		tp()
	end

	if Key=="m" then cs() end

	if Key=="p" and op == false then op = true end
	if Key=="p" and op == true then op = false end

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

local rr,rr2,rr3 = MRANDOM(8,11)/10,MRANDOM(115,130)/100,MRANDOM(150,235)/100
local sp = 0
while true do
	Swait()
	ANIMATE.Parent = nil
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	SINE = SINE + CHANGE*2
	sp=sp+1
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4+Humanoid.HipHeight, Character)
	local TiltVelocity = CF(RootPart.CFrame:vectorToObjectSpace(RootPart.Velocity/1.6))
	local WALKSPEEDVALUE = 12 / (Humanoid.WalkSpeed / 16)
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			ra.C0 = Clerp(ra.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))), 1 / Animation_Speed)
			la.C0 = Clerp(la.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))), 1 / Animation_Speed)
			rh.C0 = Clerp(rh.C0, CF(.5, -0.4, -0.6) * ANGLES(RAD(1), RAD(0), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			lh.C0 = Clerp(lh.C0, CF(-.5, -1, 0) * ANGLES(RAD(0), RAD(5), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
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
			local Alpha = .1
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0)*ANGLES(RAD(5*COS(SINE/70)),RAD(0),RAD(0))*ROOTC0,Alpha)
			lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3+2.5*COS(SINE/35)),RAD(7+1.8*SIN(SINE/35)),RAD(-1.4+2.6*SIN(SINE/35))),Alpha)
			rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7-2.5*COS(SINE/35)),RAD(-2.2-1.8*SIN(SINE/35)),RAD(1.7-2.6*SIN(SINE/35))),Alpha)
			la.C0 = la.C0:lerp(CF(-1.5,0.5+.075*SIN(SINE/35),0)*ANGLES(RAD(2.9),RAD(-8.3+2*COS(SINE/35)),RAD(-11.9+3.8*SIN(SINE/35))),Alpha)
			ra.C0 = ra.C0:lerp(CF(1.5,0.5+.075*SIN(SINE/35),0)*ANGLES(RAD(2.9),RAD(-8.3-2*COS(SINE/35)),RAD(11.9-3.8*SIN(SINE/35))),Alpha)
			Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*CF(0,0,0)*ANGLES(RAD(5.9+3.33*SIN(SINE/35)),RAD(3.88*SIN(SINE/70)),RAD(-1.6)),Alpha)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			local Alpha = .1
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,2.35+.65*COS(SINE/35),0)*ANGLES(RAD(5*COS(SINE/70)+RAD(TiltVelocity.Z*90)),RAD(0-(RootPart.Velocity.Y)-RAD(TiltVelocity.X*20)),RAD(0-RAD(TiltVelocity.X*20)))*ROOTC0,Alpha)
			lh.C0 = lh.C0:lerp(CF(-0.5,-1,-0.2)*ANGLES(RAD(-9.3+2.5*COS(SINE/35)+RAD(TiltVelocity.Z*50)),RAD(7+1.8*SIN(SINE/35)),RAD(-1.4+2.6*SIN(SINE/35)-RAD(TiltVelocity.X*20))),Alpha)
			rh.C0 = rh.C0:lerp(CF(0.5,-0.3,-0.9)*ANGLES(RAD(-7.7-2.5*COS(SINE/35)+RAD(TiltVelocity.Z*50)),RAD(-2.2-1.8*SIN(SINE/35)),RAD(1.7-2.6*SIN(SINE/35)-RAD(TiltVelocity.X*20))),Alpha)
			la.C0 = la.C0:lerp(CF(-1.5,0.5+.075*SIN(SINE/35),0)*ANGLES(RAD(2.9+RAD(TiltVelocity.Z*60)),RAD(-8.3+2*COS(SINE/35)),RAD(-12.1+3.8*SIN(SINE/35))),Alpha)
			ra.C0 = ra.C0:lerp(CF(1.5,0.5+.075*SIN(SINE/35),0)*ANGLES(RAD(2.9+RAD(TiltVelocity.Z*60)),RAD(-8.3-2*COS(SINE/35)),RAD(11.9-3.8*SIN(SINE/35))),Alpha)
			Neck.C0 = Neck.C0:lerp(NECKC0*CF(0,0,0+ ((1) - 1))*CF(0,0,0)*ANGLES(RAD(5.9+3.33*SIN(SINE/35)+RAD(TiltVelocity.Z*90)),RAD(3.88*SIN(SINE/70)-RAD(TiltVelocity.X*20)),RAD(-1.6-RAD(TiltVelocity.X*20))),Alpha)
		end
	end
	if ringspin == true then
		ringweld1.C1 = ringweld2.C1:lerp(d*ANGLES(RAD(SINE*rr),RAD(SINE*rr2),RAD(SINE*rr3)),.1) --1.1,1.3,2.35
		ringweld2.C1 = ringweld2.C1:lerp(d*ANGLES(RAD(SINE*rr),RAD(SINE*rr2),RAD(SINE*rr3)),.1)	
	end
	if cryspin == true then
		crw1.C1 = crw1.C1:lerp(d*ANGLES(RAD(0),RAD(SINE*2.45),RAD(-20*SIN(SINE/80)))*CF(0,-4*COS(SINE/80),-7),.1)
		crw2.C1 = crw2.C1:lerp(d*ANGLES(RAD(0),RAD(25-SINE*2.45),RAD(-20*SIN(SINE/80)))*CF(0,4*COS(SINE/80),-7),.1)
		crw3.C1 = crw3.C1:lerp(d*ANGLES(RAD(0),RAD(SINE*2.45),RAD(20*SIN(SINE/80)))*CF(0,-4*COS(SINE/80),7),.1)
		crw4.C1 = crw4.C1:lerp(d*ANGLES(RAD(0),RAD(25-SINE*2.45),RAD(20*SIN(SINE/80)))*CF(0,4*COS(SINE/80),7),.1)
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