local Player = game.Players.LocalPlayer
--Player = game:GetService("Players"):GetPlayerFromCharacter(script.Parent)
local Mouse = Player:GetMouse()
-----------------------------
--Player = game:GetService("Players").powertommm
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
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
local sick = Instance.new("Sound",Character)
sick.Parent = Torso
sick.Name = "comander_cool"
sick:resume()
sick.Looped = true
sick.Volume = 1

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
it = Instance.new
MODE = "1"
Animation_Speed = 3
local FORCERESET = false
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 16
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local HOODC0 = CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0))
local SHOTGUNC0 = CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local s = 0
local c = 1
local anchrd = false
local RUN = game:service'RunService'
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local AntiBanish = true
local AMODE = "box"
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local NICE = false
local VALUE3 = 9999
--ROBLOXIDLEANIMATION.Parent = Humanoid

local Effects = IT("Folder", Character)
Effects.Name = "Effects"

local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
local UNANCHOR = true
local TOBANISH = {}
local SKILLFONT = "Arcade"
--//=================================\\
--\\=================================//

local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local Plrs = S.Players
NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance)
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

function shakes(power,length)
	for i,v in pairs(game:GetService("Players"):GetChildren()) do
		local var = script.Shaker:Clone()
		var.Parent = v.Character
		local pw = var.Shakeval
		local lgth = var.MultLength
		pw.Value = power
		lgth.Value = length
		var.Disabled = false
		game:GetService("Debris"):AddItem(var, length+4)
	end
end


function localshakes(power,length)
	local var = script.Shaker:Clone()
	var.Parent = Player.Character
	local pw = var.Shakeval
	local lgth = var.MultLength
	pw.Value = power
	lgth.Value = length
	var.Disabled = false
	game:GetService("Debris"):AddItem(var, length+4)
end

local MATTER = {"Plastic","Wood","Slate","Concrete","CorrodedMetal","DiamondPlate","Foil","Grass","Ice","Marble","Granite","Brick","Pebble","Sand","Fabric","SmoothPlastic","Metal","WoodPlanks","Cobblestone","Air","Water","Rock","Glacier","Snow","Sandstone","Mud","Basalt","Ground","CrackedLava","Neon","Glass","Asphalt","LeafyGrass","Salt","Limestone","Pavement","ForceField"}

local PlayerSize = 1
local FT,FRA,FLA,FRL,FLL = Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh")
FT.MeshId,FT.Scale = "rbxasset://fonts/torso.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
FRA.MeshId,FRA.Scale = "rbxasset://fonts/rightarm.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
FLA.MeshId,FLA.Scale = "rbxasset://fonts/leftarm.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
FRL.MeshId,FRL.Scale = "rbxasset://fonts/rightleg.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
FLL.MeshId,FLL.Scale = "rbxasset://fonts/leftleg.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)

local AUDIOS = {"rbxassetid://844654533","rbxassetid://1439600000","rbxassetid://2256088590","rbxassetid://3154204326"}

if Player.Character:FindFirstChild("Animate") then
	local an = Humanoid:GetPlayingAnimationTracks()
	for i = 1, #an do
		an[i]:Stop()
	end
	Humanoid.Animator:Destroy()
	Player.Character:FindFirstChild("Animate"):Destroy()
	ANIMATOR:Destroy()
	ANIMATE:Destroy()
end
local fakerot = 0

local CHATS = {"It burns.","It's gone.","Something...Is missing.","Why is this happening?","I've been poisoned.","I Feel sick."}
local mde = "Terror"
local FONTS = {"Fantasy","Highway","SciFi"}


local heck = MRANDOM(1,5)

if heck == 1 then
	sick.SoundId = "rbxassetid://2554627018"
	sick.Pitch = 1
elseif heck == 2 then
	sick.SoundId = "rbxassetid://4933579839"
	sick.Pitch = 1
elseif heck == 3 then
	sick.SoundId = "rbxassetid://147924332"
	sick.Pitch = 1
elseif heck == 4 then
	sick.SoundId = "rbxassetid://572047178"
	sick.Pitch = 1
elseif heck == 5 then
	sick.SoundId = "rbxassetid://273304387"
	sick.Pitch = 0.7
end

--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//
--DO NOT TOUCH THIS
if Character:FindFirstChild("Adds")then wait(.2) script.Disabled = true script:Destroy() error("You Shouldn't Have Added A Banisher Gun To My Script") end

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
function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function Rwait(num)
	if num == 0 or num == nil then
		RUN.Stepped:wait()
	else
		for i=0,num do
			RUN.Stepped:wait()
		end
	end
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end
local S = IT("Sound",script)
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

function CreateSound2(ID, PARENT, VOLUME, PITCH, TIMEPOS, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.TimePosition = TIMEPOS
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
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


function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end

function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end

function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
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

function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end
function ApplyDamage(Humanoid,Damage)

end

function Fancy_spawntrail(LOC,AIMTO,OUCH)
	WACKYEFFECT2({Time = 25, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1.1,1.1,1.1), Transparency = 0, Transparency2 = 1, CFrame = CF(LOC), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	for i = 1, 1 do
		local POS1 = CF(LOC,AIMTO)*CF(0,0,-45).p
		local AIMPOS = CF(LOC,POS1) * CF(0,0,-45) * ANGLES(RAD(MRANDOM(-25,25)), RAD(MRANDOM(-25,25)), RAD(MRANDOM(-25,25)))*CF(0,0,MRANDOM(5,75)/10).p
		local HIT,POS = CastProperRay(LOC,AIMPOS,1000,Character)
		local DISTANCE = (POS - LOC).Magnitude
		if HIT then
			local HUM = nil
			if HIT.Parent:FindFirstChildOfClass("Humanoid") then
				HUM = HIT.Parent:FindFirstChildOfClass("Humanoid")
			elseif HIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				HUM = HIT.Parent.Parent:FindFirstChildOfClass("Humanoid")
			end
			if HUM then
				Kill3(HIT.Parent)
			end
		end

		WACKYEFFECT2({Time = 20, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = 1, SoundVolume = 4})
		WACKYEFFECT2({Time = 20, EffectType = "Box", Size = VT(0,0,DISTANCE), Size2 = VT(0.7,0.7,DISTANCE), Transparency = 0.6, Transparency2 = 1, CFrame = CF(LOC,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	end
end


function Fancy_spawntrail3(LOC,AIMTO,OUCH)
	WACKYEFFECT2({Time = 25, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1.1,1.1,1.1), Transparency = 0, Transparency2 = 1, CFrame = CF(LOC), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	for i = 1, 1 do
		local POS1 = CF(LOC,AIMTO)*CF(0,0,-45).p
		local AIMPOS = CF(LOC,POS1) * CF(0,0,-45) * ANGLES(RAD(MRANDOM(-0,0)), RAD(MRANDOM(-0,0)), RAD(MRANDOM(-0,0)))*CF(0,0,MRANDOM(5,75)/10).p
		local HIT,POS = CastProperRay(LOC,AIMPOS,1000,Character)
		local DISTANCE = (POS - LOC).Magnitude
		if HIT then
			local HUM = nil
			if HIT.Parent:FindFirstChildOfClass("Humanoid") then
				HUM = HIT.Parent:FindFirstChildOfClass("Humanoid")
			elseif HIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				HUM = HIT.Parent.Parent:FindFirstChildOfClass("Humanoid")
			end
			if HUM then
				Kill2(HUM)
				BEAN(HUM)
			end
		end
		WACKYEFFECT2({Time = 20, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = 1, SoundVolume = 4})
		WACKYEFFECT2({Time = 20, EffectType = "Box", Size = VT(0,0,DISTANCE), Size2 = VT(0.7,0.7,DISTANCE), Transparency = 0.6, Transparency2 = 1, CFrame = CF(LOC,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	end
end


function Fancy_spawntrail2(LOC,AIMTO,OUCH)
	WACKYEFFECT({Time = 25, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(0.3,0.3,0.3), Transparency = 0, Transparency2 = 1, CFrame = CF(LOC), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	for i = 1, 1 do
		local POS1 = CF(LOC,AIMTO)*CF(0,0,-45).p
		local AIMPOS = CF(LOC,POS1) * CF(0,0,-45) * ANGLES(RAD(MRANDOM(0,15)), RAD(MRANDOM(0,15)), RAD(MRANDOM(0,15)))*CF(0,0,MRANDOM(5,75)/10).p
		local HIT,POS = CastProperRay(LOC,AIMPOS,1000,Character)
		local DISTANCE = (POS - LOC).Magnitude
		WACKYEFFECT2({Time = 20, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(0.3,0.3,0.3), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		WACKYEFFECT2({Time = 20, EffectType = "Box", Size = VT(0,0,DISTANCE), Size2 = VT(0.1,0.1,DISTANCE), Transparency = 0.6, Transparency2 = 1, CFrame = CF(LOC,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"New Yeller".Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	end
end

function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0.5, "Really red", "Trail", VT(0,0,0))
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = VT(0.5,DIST,0.5)
	else
		TRAIL.Size = VT(0.25,DIST,0.25)
	end
	TRAIL.CFrame = CF(FROM, TO) * CF(0, 0, -DIST/2) * ANGLES(RAD(90),RAD(0),RAD(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 5 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.1
		end
		TRAIL:remove()
	end))
end

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
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
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
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
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

function WACKYEFFECT3(Table)
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
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - (VT((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)),RAD(MRANDOM(0,0)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
						EFFECT.CFrame = CF(EFFECT.Position)*ANGLES(RAD(ORI.X),RAD(ORI.Y),RAD(ORI.Z))
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

--WACKYEFFECT({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
function WACKYEFFECT(Table)
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
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
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
		elseif TYPE == "Block" then
			MSH = IT("BlockMesh",EFFECT) 
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		elseif TYPE == "Hat" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "173774068", "", SIZE, VT(0,0,0))
		elseif TYPE == "Arm" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "2828256740", "", SIZE, VT(0,0,0))
		elseif TYPE == "torso" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "48112070", "", SIZE, VT(0,0,0))
		elseif TYPE == "Head" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "539723444", "", SIZE, VT(0,0,0))
		elseif TYPE == "Mask" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4548197626", "", SIZE, VT(0,0,0))
		elseif TYPE == "Spike" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "2720161649", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME+1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH/TIME
				if TYPE == "Wave" then
					MSH.Offset = VT(0,0,-MSH.Scale.X/8)
				end
				EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
				if TYPE == "Block" then
					EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
				else
					EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation
					EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				SOUND.Stopped:Connect(function()
					EFFECT:remove()
				end)
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until SOUND.Playing == false
				EFFECT:remove()
			end
		end
	end))
end

function chatfunc(text)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("TalkingBillBoard")~= nil then
			Character:FindFirstChild("TalkingBillBoard"):destroy()
		end
		local Bill = Instance.new("BillboardGui",Character)
		Bill.Size = UDim2.new(0,20,0,10)
		Bill.StudsOffset = Vector3.new(0,3,0)
		Bill.Adornee = Character.Head
		Bill.Name = "TalkingBillBoard"
		local Hehe = Instance.new("TextLabel",Bill)
		Hehe.BackgroundTransparency = 1
		Hehe.BorderSizePixel = 0
		Hehe.Text = ""
		Hehe.Font = (FONTS[MRANDOM(1,#FONTS)])
		Hehe.TextSize = 30
		Hehe.TextStrokeTransparency = 0
		Hehe.Size = UDim2.new(1,0,0.5,0)
		coroutine.resume(coroutine.create(function()
			while Hehe ~= nil do
				wait()
				Hehe.TextColor3 = C3(250,250,250)
				Hehe.TextStrokeColor3 = C3(0,0,0)
				Hehe.Font = (FONTS[MRANDOM(1,#FONTS)])
				Hehe.Position = UDim2.new(math.random(-.3,.3),math.random(-3,3),.1,math.random(-3,3))	
				Hehe.Rotation = math.random(-1,1)
			end
		end))
		for i = 1,string.len(text),1 do
			wait()
			Hehe.Text = string.sub(text,1,i)
		end
		wait(3)--Re[math.random(1, 93)]
		for i = 0, 5, .035 do
			wait()
			Bill.ExtentsOffset = Vector3.new(math.random(-i, i), math.random(-i, i), math.random(-i, i))
			Hehe.TextStrokeTransparency = i
			Hehe.TextTransparency = i
		end
		Bill:Destroy()
	end)
	chat()
end

--ParticleEmitter({Speed = 0.5, Drag = 0, Size1 = 0.2, Size2 = 0, Lifetime1 = 0.3, Lifetime2 = 0.7, Parent = Dangle, Emit = 100, Offset = 360, Enabled = true, Acel = VT(0,5,0)})
function Banish(Foe)

end


function Kill2(Foe)

end

function Kill3(Foe)

end


workspace.ChildAdded:connect(function(instance)

end)
function StatLabel(CFRAME, TEXT, COLOR)
	local STATPART = CreatePart(3, Effects, "SmoothPlastic", 0, 1, "Really black", "Effect", VT())
	STATPART.CFrame = CF(CFRAME.p,CFRAME.p+VT(MRANDOM(-5,5),MRANDOM(0,5),MRANDOM(-5,5)))
	local BODYGYRO = IT("BodyGyro", STATPART)
	game:GetService("Debris"):AddItem(STATPART ,5)
	local BILLBOARDGUI = Instance.new("BillboardGui", STATPART)
	BILLBOARDGUI.Adornee = STATPART
	BILLBOARDGUI.Size = UD2(2.5, 0, 2.5 ,0)
	BILLBOARDGUI.StudsOffset = VT(-2, 2, 0)
	BILLBOARDGUI.AlwaysOnTop = false
	local TEXTLABEL = Instance.new("TextLabel", BILLBOARDGUI)
	TEXTLABEL.BackgroundTransparency = 1
	TEXTLABEL.Size = UD2(2.5, 0, 2.5, 0)
	TEXTLABEL.Text = TEXT
	TEXTLABEL.Font = SKILLFONT
	TEXTLABEL.FontSize="Size42"
	TEXTLABEL.TextColor3 = COLOR
	TEXTLABEL.TextStrokeTransparency = 0
	TEXTLABEL.TextScaled = true
	TEXTLABEL.TextWrapped = true
	coroutine.resume(coroutine.create(function(THEPART, THEBODYPOSITION, THETEXTLABEL)
		for i = 1, 10 do
			Swait()
			STATPART.CFrame = STATPART.CFrame * CF(0,0,-0.2)
			TEXTLABEL.TextTransparency = TEXTLABEL.TextTransparency + (1/10)
			TEXTLABEL.TextStrokeTransparency = TEXTLABEL.TextTransparency
		end
		THEPART.Parent = nil
	end),STATPART, TEXTLABEL)
end
function ApplyDamage2(Humanoid,Damage,TorsoPart)

end

function ApplyAoE3(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)

end
local Blk = CreatePart(0,LeftArm,"Neon",1,1,BrickColor.Random(),"aa",VT(0.005,0.005,0.005),false)
local BW = CreateWeldOrSnapOrMotor("Weld",LeftArm,LeftArm,Blk,CF(0,-2,0),CF(0,0,0))




top=it("Shirt",Character)
top.Name = "Shirt"
bottom=it("Pants",Character)
bottom.Name = "Pants"

if Player.Name ~= "Commandcodes1234" then
	for i,x in pairs(Character:GetDescendants()) do if x:IsA("Shirt") or x:IsA("Pants") then x:Destroy() end end

	top=it("Shirt",Character)
	top.Name = "Shirt"
	bottom=it("Pants",Character)
	bottom.Name = "Pants"
	Character.Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=0"
	Character.Pants.PantsTemplate = "http://www.roblox.com/asset/?id=0"
end

--[[coroutine.resume(coroutine.create(function()
	while wait() do
		end
end))--]]

local Eyes = IT("Folder", Character)
Eyes.Name = "Eyes"
local Eye = CreatePart(3, Eyes, "Neon", 0, 0, "Really white", "Eye", VT(0.5,0.5,0.5)/2,false)
MakeForm(Eye,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye, Head, Eye, CF(-0.15,0.2,-0.08) * ANGLES(RAD(0), RAD(0), RAD(0)), CF(0, 0, 0.4))
local Eye2 = CreatePart(3, Eyes, "Neon", 0, 0, "Really white", "Eye", VT(0.5,0.5,0.5)/2,false)
MakeForm(Eye2,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye2, Head, Eye2, CF(0.15,0.2,-0.08) * ANGLES(RAD(0), RAD(0), RAD(0)), CF(0, 0, 0.4))

Head.Transparency = 0

--glitch
coroutine.resume(coroutine.create(function()
	while wait() do
		if MRANDOM(1,85) == 1 and ATTACK == false then
			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CF(0,0,0), MoveToPos = LeftArm.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = RightArm.CFrame*CF(0,0,0), MoveToPos = RightArm.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(2.05,1.05,1.05), Size2 = VT(2.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = Torso.CFrame*CF(0,0,0), MoveToPos = Torso.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = LeftLeg.CFrame*CF(0,0,0), MoveToPos = LeftLeg.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = RightLeg.CFrame*CF(0,0,0), MoveToPos = RightLeg.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Head", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = Head.CFrame*CF(0,0,0), MoveToPos = Head.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		end
	end
end))


function Taunt()
	ATTACK = true
	Rooted = false
	Speed= 0
	local oh = MRANDOM(1,4)
	if oh == 1 then
		CreateSound(5139619846, Torso, 100, 1, false)
		chatfunc("This is a nightmare that you won't wake from.")
		--voiceline 2
	elseif oh == 2 then
		CreateSound(5139617636, Torso, 100, 1, false)
		chatfunc("I am the fearful reflection of what you have created.")
		--voiceline 1
	elseif oh == 3 then
		chatfunc("The nightmare is just beginning.")
		CreateSound(5139640710, Torso, 100, 1, false)
		--voiceline 3
	elseif oh == 4 then
		chatfunc("This time, death cannot save you.")
		CreateSound(5139646977, Torso, 100, 1, false)
		--voiceline 4

	end

	Eye.Color = Color3.fromRGB(250,0,0)
	Eye2.Color = Color3.fromRGB(250,0,0)

	if oh == 1 then
		for i=0, 0.1, 0.0008 / Animation_Speed do
			Swait()
			if MRANDOM(1,25) == 1 then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120))), 2 / Animation_Speed)
			end
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(0))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end
	elseif oh == 2 then
		for i=0, 0.1, 0.0007 / Animation_Speed do
			Swait()
			if MRANDOM(1,25) == 1 then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120))), 2 / Animation_Speed)
			end
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(0))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end
	elseif oh == 3 then
		for i=0, 0.1, 0.001 / Animation_Speed do
			Swait()
			if MRANDOM(1,25) == 1 then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120))), 2 / Animation_Speed)
			end
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(0))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end
	elseif oh == 4 then
		for i=0, 0.1, 0.001 / Animation_Speed do
			Swait()
			if MRANDOM(1,25) == 1 then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120)), RAD(MRANDOM(-120,120))), 2 / Animation_Speed)
			end
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(0))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end
	end
	Eye.Color = Color3.fromRGB(250,250,250)
	Eye2.Color = Color3.fromRGB(250,250,250)
	ATTACK = false
	Rooted = false
end


function Warp()
	WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CF(0,0,0), MoveToPos = LeftArm.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = RightArm.CFrame*CF(0,0,0), MoveToPos = RightArm.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(2.05,1.05,1.05), Size2 = VT(2.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = Torso.CFrame*CF(0,0,0), MoveToPos = Torso.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = LeftLeg.CFrame*CF(0,0,0), MoveToPos = LeftLeg.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = RightLeg.CFrame*CF(0,0,0), MoveToPos = RightLeg.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	WACKYEFFECT({Time = 100, EffectType = "Head", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = Head.CFrame*CF(0,0,0), MoveToPos = Head.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Torso.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

	local HITFLOOR,HITPOS = Raycast(Mouse.Hit.p+VT(0,1,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 100, Character)
	if HITFLOOR then
		HITPOS = HITPOS + VT(0,3.5,0)
		local POS = RootPart.Position
		RootPart.CFrame = CF(HITPOS,CF(POS,HITPOS)*CF(0,0,-100000).p)
		CreateSound(164320294,Torso,3,1.5,false)
		localshakes(0.1,5)
	end
end






local BEANED = {}



local BEANED = {}

function BEAN(skid)	
	if skid then	
		local g = game.Players:GetPlayers()
		local kickfolder = IT("Folder",Effects)
		local naeeym2 = Instance.new("BillboardGui",kickfolder)
		naeeym2.AlwaysOnTop = false
		naeeym2.Size = UDim2.new(5,35,2,35)
		naeeym2.StudsOffset = Vector3.new(0,1,0)
		naeeym2.Name = "Mark"
		local tecks2 = Instance.new("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.TextScaled = true
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Arcade"
		tecks2.TextSize = 30
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = Color3.fromRGB(0,0,0)
		tecks2.TextStrokeColor3 = Color3.fromRGB(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		tecks2.Parent = naeeym2
		--CreateSound("395664538", skid, 5, 1, false)
		local Players = game:GetService("Players")
		local die = Players:FindFirstChild(skid.Name)
		--die:Kick()
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("You were never allowed here in the first place.")
		end
		table.insert(BEANED,skid.name)
		--]]
		--CreateSound("527749592", game.Workspace, 700, 1, false)
		--CHARACTER:Remove()
	--[[
	for i,v in pairs(g) do
	--v:remove()
	end ]]--
	--[[
	if CHARACTER.Name ~= "Default Dummy" or CHARACTER.Name ~= "NPC" then
for i,v in pairs(g) do
	if string.find(string.upper(v.Name),CHARACTER) == 1 then
v:remove()
end
end
	end]]--
	--[[
		for _, p in pairs(game.Players:GetChildren()) do
		if p:FindFirstChild("CHARACTER") then

		end
	end]]--
		coroutine.resume(coroutine.create(function()
			for i = 1, 50 do
				Swait()
				for i,v in ipairs(kickfolder:GetChildren()) do
					if v.ClassName == "Part" or v.ClassName == "MeshPart" then
						v.Transparency = 1
					end
					naeeym2.Enabled = false
				end
				Swait()
				for i,v in ipairs(kickfolder:GetChildren()) do
					if v.ClassName == "Part" or v.ClassName == "MeshPart" then
						v.Transparency = 0
					end
					naeeym2.Enabled = true
				end
			end
			kickfolder:remove()
		end))
		--wait(6)
		--skid:Remove()
	end
end 


local function CheckForBan(player)
	for i = 1, #BEANED do
		if player.Name == BEANED[i] then
			player:Kick() --Ban Reason Change between the '' to change the reason!
		end
	end
end

game.Players.PlayerAdded:connect(function()
	for i,v in pairs(game.Players:GetPlayers())do
		CheckForBan(v)
	end  
end)


function TheKick()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		local HITFLOOR, HITPOS = Raycast(RightLeg.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 2 , Character)
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			local FOE = Mouse.Target.Parent
			ATTACK = true
			Rooted = true
			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(-2,0,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(2,0,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(2.05,1.05,1.05), Size2 = VT(2.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(0,0,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(0,-2,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Arm", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(0,-2,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})

			WACKYEFFECT({Time = 100, EffectType = "Head", Size = VT(1.05,1.05,1.05), Size2 = VT(1.05,1.05,1.05), Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame*CF(0,1,0), MoveToPos = ROOT.CFrame*CF(MRANDOM(-5,5),MRANDOM(-5,5),MRANDOM(-5,5)).p, RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Plastic", 	Color=Color3.fromRGB(MRANDOM(1,255),MRANDOM(1,255),MRANDOM(1,255)), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			FOE.Parent = nil
			BEAN(FOE)
			ATTACK = false
			Rooted = false
		end
	end
end

local GUN = Instance.new("Part", workspace)
GUN.Size = Vector3.new(1,1,1)
GUN.Name = "GUN"
GUN.CanCollide = false
GUN.BrickColor = BrickColor.new("Black")
GUN.Parent = Character
local GUNMESH = Instance.new("SpecialMesh", GUN)
GUNMESH.MeshId = "rbxassetid://4372594"
GUNMESH.Scale = Vector3.new(1.5,1.5,1.5)
GUN.Parent = Character
GUN.Anchored=false
local GRAB = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, GUN, CF(0, -1.75, -0.25) * ANGLES(RAD(-90), RAD(0), RAD(0)), CF(0, 0, 0))

GUN.Parent = nil

for i,v in pairs(Character:GetChildren()) do -- gets all ur characters children
	if v:IsA("Accessory") and v.Name == "ROBLOXCap" then -- dex name for the hat 
		v.Name = "ROBLOXCap" -- name it whatever you want
	end
end

Character["ROBLOXCap"].Handle.AccessoryWeld:Destroy()

local att0 = Instance.new("Attachment",Character["ROBLOXCap"].Handle) -- creates a attachment into the hat
att0.Orientation = Vector3.new(0, 0, 0) -- rotation
att0.Position = Vector3.new(0, -0.55, 0.21) -- position -- position

local att1 = Instance.new("Attachment",Head) -- what body part that the hat should be attached to (to make it work with r15 go down
-- make it a r15 body part name or just do humanoidroopart

local ap = Instance.new("AlignPosition",Character["ROBLOXCap"].Handle) -- align position
ap.Attachment0 = att0
ap.Attachment1 = att1
ap.RigidityEnabled = true -- if its false it will make the hat be wobbly

local ao = Instance.new("AlignOrientation",Character["ROBLOXCap"].Handle) -- align rotation
ao.Attachment0 = att0
ao.Attachment1 = att1
ao.RigidityEnabled = true

function Grab()
	ATTACK = true
	Rooted = true
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-10)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(0), RAD(20))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-40)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, 0.4) * ANGLES(RAD(-50), RAD(0), RAD(-40))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	att0:Destroy()
	att1:Destroy()
	ap:Destroy()
	ao:Destroy()
	local att0 = Instance.new("Attachment",Character["ROBLOXCap"].Handle) -- creates a attachment into the hat
	att0.Orientation = Vector3.new(0, 0, 0) -- rotation
	att0.Position = Vector3.new(0, 0, 0) -- position -- position

	local att1 = Instance.new("Attachment",GUN) -- what body part that the hat should be attached to (to make it work with r15 go down
	-- make it a r15 body part name or just do humanoidroopart

	local ap = Instance.new("AlignPosition",Character["ROBLOXCap"].Handle) -- align position
	ap.Attachment0 = att0
	ap.Attachment1 = att1
	ap.RigidityEnabled = true -- if its false it will make the hat be wobbly

	local ao = Instance.new("AlignOrientation",Character["ROBLOXCap"].Handle) -- align rotation
	ao.Attachment0 = att0
	ao.Attachment1 = att1
	ao.RigidityEnabled = true

	GUN.Parent = Character
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-10)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(40))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	VALUE1 = true
	ATTACK = false
	Rooted = false
end
function Away()
	ATTACK = true
	Rooted = true
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-10)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25), RAD(0), RAD(40))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-40)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, 0.4) * ANGLES(RAD(-50), RAD(0), RAD(-40))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	att0:Destroy()
	att1:Destroy()
	ap:Destroy()
	ao:Destroy()
	local att0 = Instance.new("Attachment",Character["ROBLOXCap"].Handle) -- creates a attachment into the hat
	att0.Orientation = Vector3.new(0, 0, 0) -- rotation
	att0.Position = Vector3.new(0, -0.55, 0.21) -- position -- position

	local att1 = Instance.new("Attachment",Head) -- what body part that the hat should be attached to (to make it work with r15 go down
	-- make it a r15 body part name or just do humanoidroopart

	local ap = Instance.new("AlignPosition",Character["ROBLOXCap"].Handle) -- align position
	ap.Attachment0 = att0
	ap.Attachment1 = att1
	ap.RigidityEnabled = true -- if its false it will make the hat be wobbly

	local ao = Instance.new("AlignOrientation",Character["ROBLOXCap"].Handle) -- align rotation
	ao.Attachment0 = att0
	ao.Attachment1 = att1
	ao.RigidityEnabled = true
	GUN.Parent = nil
	for i=0, 0.1, 0.01 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-10)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-10), RAD(0), RAD(20))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	VALUE1 = false
	ATTACK = false
	Rooted = false
end
function Reload()
	ATTACK = true
	Rooted = true
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(10)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-30))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(30)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-30))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(10), RAD(0), RAD(-30)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(50)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-30))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, 0.2) * ANGLES(RAD(-40), RAD(0), RAD(50)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(20)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-30))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(20), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-5)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-30))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.6, 0.6, 0) * ANGLES(RAD(50), RAD(0), RAD(25)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	for i=0, 0.1, 0.02 / Animation_Speed do
		Swait()
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-20)), 0.35 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(60), RAD(0), RAD(-40))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.7, 0.5, -0.5) * ANGLES(RAD(70), RAD(0), RAD(25)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
	end
	VALUE3 = 9999
	ATTACK = false
	Rooted = false
end
function Kill_Bullet()
	ATTACK = true
	Rooted = true

	if VALUE3 == 0 then
		chatfunc("No ammo.")
		for i=0, 0.1, 0.004 / Animation_Speed do
			Swait()
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-25*COS(SINE/4))), 0.35 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.2+ 0.2*COS(SINE/53.5), -0.3) * ANGLES(RAD(90+ 15*COS(SINE/54.5) ), RAD(0), RAD(-70))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end		
	elseif VALUE3 > 0 then
		for i=0, 0.1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(90)), 0.35 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 0.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
		end	
	end
	if VALUE3 > 0 then
		repeat
			if VALUE3 > 0 then
				for i=0, 0.1, 0.1 / Animation_Speed do
					Swait()
					turnto(Mouse.Hit.p)
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(90)), 0.35 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 0.5 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
				end
				local HIT,POS = CastProperRay(GUN.Position, Mouse.Hit.p, 1000, Character)
				Fancy_spawntrail(GUN.CFrame*CF(0,0,-GUN.Size.Z/2).p,Mouse.Hit.p,1)
				if HIT ~= nil then
					if HIT.Parent ~= workspace and HIT.Parent.ClassName ~= "Folder" then
					end
				end
				VALUE3 = VALUE3-1
				CreateSound(408950203,Torso,5,MRANDOM(8,11)/10,false)
				for i=0, 0.1, 0.04 / Animation_Speed do
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(90)), 0.35 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 0.25 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(15), RAD(90)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
				end
			elseif VALUE3 == 0 then
				for i=0, 0.1, 0.1 / Animation_Speed do
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(90)), 0.35 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 0.25 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(15), RAD(90)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
				end
			end
		until KEYHOLD == false
	end
	ATTACK = false
	Rooted = false
end
function Kill()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		local HITFLOOR, HITPOS = Raycast(RightLeg.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 2 , Character)
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			local FOE = Mouse.Target.Parent
			ATTACK = true
			Rooted = true
			Kill2(FOE)
			ATTACK = false
			Rooted = false
		end
	end
end

function switch2()
	ATTACK = true
	Rooted = true
	AMODE = "box"
	local heck = MRANDOM(1,5)
	sick.TimePosition = 0
	if heck == 1 then
		sick.SoundId = "rbxassetid://2554627018"
		sick.Pitch = 1
	elseif heck == 2 then
		sick.SoundId = "rbxassetid://4933579839"
		sick.Pitch = 1
	elseif heck == 3 then
		sick.SoundId = "rbxassetid://147924332"
		sick.Pitch = 1
	elseif heck == 4 then
		sick.SoundId = "rbxassetid://572047178"
		sick.Pitch = 1
	elseif heck == 5 then
		sick.SoundId = "rbxassetid://273304387"
		sick.Pitch = 0.7
	end
	ATTACK = false
	Rooted = false
end

function switch()
	ATTACK = true
	Rooted = true
	AMODE = "radio"
	local heck = MRANDOM(1,5)
	sick.TimePosition = 0
	if heck == 1 then
		sick.SoundId = "rbxassetid://441393407"
		sick.Pitch = 0.8
	elseif heck == 2 then
		sick.SoundId = "rbxassetid://361511879"
		sick.Pitch = 0.6
	elseif heck == 3 then
		sick.SoundId = "rbxassetid://550578451"
		sick.Pitch = 0.6
	elseif heck == 4 then
		sick.SoundId = "rbxassetid://463112599"
		sick.Pitch = 0.8
	elseif heck == 5 then
		sick.SoundId = "rbxassetid://584467172"
		sick.Pitch = 0.9
	end
	ATTACK = false
	Rooted = false
end

--[[
--refit by godcat
local Regen = {}
delay(1,function()
	local Descendants = Character:GetDescendants()
	
	for i = 1,#Descendants do
		local E = Descendants[i]
		if E:IsA("BasePart") and not E:IsDescendantOf(Effects) then
			E.CustomPhysicalProperties = PhysicalProperties.new(Enum.Material.Wood)
			table.insert(Regen,{E,E.Parent,E.Color,E.Size,E.Material})
		end
		if E:IsA("JointInstance") then
			table.insert(Regen,{E,E.Parent,nil,nil,nil})
		end
	end
end)

for e = 1, #Regen do
	if Regen[e] ~= nil then
		local STUFF = Regen[e]
		local PART = STUFF[1]
		local PARENT = STUFF[2]
		local MATERIAL = STUFF[3]
		local COLOR = STUFF[4]
		local TRANSPARENCY = STUFF[5]
		if PART.ClassName == "Part" and PART ~= Body.RootPart then
			PART.Material = MATERIAL
			PART.Color = COLOR
			PART.Transparency = TRANSPARENCY
		end
		PART.AncestryChanged:Connect(function()
			PART.Parent = PARENT
		end)
	end
end

function Refit()
	for i = 1,#Regen do
		local E = Regen[i]
		local PART = E[1]
		local PARENT = E[2]
		local COLOR = E[3]
		local SIZE = E[4]
		local MATERIAL = E[5]
		
		if PART:IsA("BasePart") and PART.Parent ~= PARENT then
			PART.Color = COLOR
			PART.Size = SIZE
			PART.Material = MATERIAL
		end
		if PART.Parent ~= PARENT then
			Humanoid.Parent = nil
			PART.Parent = PARENT
			Humanoid.Parent = Character
		end
	end
	Humanoid.Parent = Character
end

local BODY = {}

for e = 1, #BODY do
	if BODY[e] ~= nil then
		local STUFF = BODY[e]
		local PART = STUFF[1]
		local PARENT = STUFF[2]
		local MATERIAL = STUFF[3]
		local COLOR = STUFF[4]
		local TRANSPARENCY = STUFF[5]
		if PART.ClassName == "Part" and PART ~= RootPart then
			PART.Material = MATERIAL
			PART.Color = COLOR
			PART.Transparency = TRANSPARENCY
		end
		PART.AncestryChanged:Connect(function()
			PART.Parent = PARENT
		end)
	end
end

function Refit2()
	Character.Parent = workspace
	Effects.Parent = Character
	for e = 1, #BODY do
		if BODY[e] ~= nil then
			local STUFF = BODY[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			--local SIZE = STUFF[6]
			local NAME = STUFF[7]
			if PART.ClassName == "Part" and PART ~= RootPart then
				PART.Material = MATERIAL
				PART.Transparency = TRANSPARENCY
				PART.Name = NAME
			end
			if PART.Parent ~= PARENT then
				if PART.Name == "Head" or PART.Name == "Neck" or PART.Name == "Torso" then
					Humanoid:remove()
				end
				PART.Parent = PARENT
				if PART.Name == "Head" or PART.Name == "Neck" or PART.Name == "Torso" then
					Humanoid = IT("Humanoid",Character)
				end
			end
		end
	end
end


Humanoid.Died:Connect(Refit)
Humanoid.HealthChanged:Connect(function()
	if Humanoid.Health <= 1 then
		Humanoid.Health = math.huge
		Refit()
	end
end)--]]

function MouseDown(Mouse)
	if ATTACK == false then
	end
end

function MouseUp(Mouse)
	HOLD = false
end
function KeyDown(Key)
	KEYHOLD = true
	if Key == "q" and ATTACK == false then
		Warp()
	end
	if Key == "x" and ATTACK == false then
		TheKick()
	end
	if Key == "c" and ATTACK == false and VALUE1 == true then
		Kill_Bullet()
	end
	if Key == "r" and ATTACK == false and VALUE3 == 0 and VALUE1 == true then
		Reload()
	end
	if Key == "z" and ATTACK == false then
		Kill()
	end
	if Key == "g" and ATTACK == false then
		if AMODE == "box" then
			switch()
		elseif AMODE == "radio" then
			switch2()
		end
	end
	if Key == "f" and ATTACK == false then
		if VALUE1 == false then
			Grab()
		elseif VALUE1 == true then
			Away()
		end
	end
	if Key == "n" then
		if AMODE == "box" then
			local heck = MRANDOM(1,5)
			sick.TimePosition = 0
			if heck == 1 then
				sick.SoundId = "rbxassetid://2554627018"
				sick.Pitch = 1
			elseif heck == 2 then
				sick.SoundId = "rbxassetid://4933579839"
				sick.Pitch = 1
			elseif heck == 3 then
				sick.SoundId = "rbxassetid://147924332"
				sick.Pitch = 1
			elseif heck == 4 then
				sick.SoundId = "rbxassetid://572047178"
				sick.Pitch = 1
			elseif heck == 5 then
				sick.SoundId = "rbxassetid://273304387"
				sick.Pitch = 0.7
			end
		elseif AMODE == "radio" then
			local heck = MRANDOM(1,5)
			sick.TimePosition = 0
			if heck == 1 then
				sick.SoundId = "rbxassetid://441393407"
				sick.Pitch = 0.8
			elseif heck == 2 then
				sick.SoundId = "rbxassetid://361511879"
				sick.Pitch = 0.6
			elseif heck == 3 then
				sick.SoundId = "rbxassetid://550578451"
				sick.Pitch = 0.6
			elseif heck == 4 then
				sick.SoundId = "rbxassetid://463112599"
				sick.Pitch = 0.8
			elseif heck == 5 then
				sick.SoundId = "rbxassetid://584467172"
				sick.Pitch = 0.9
			end
		end
	end
	if Key == "t" and ATTACK == false then
		Taunt()
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

if Character:FindFirstChildOfClass("Humanoid") == nil then
	Humanoid = Instance.new("Humanoid",Character)
end

while true do
	Swait()
	ANIMATE.Parent = nil
	if Character:FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid",Character)
	end

	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	if ANIM == "Walk" and TORSOVELOCITY > 1 then
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(20))* RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 0.2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), 0.2 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(10), RAD(0), RAD(20))* RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(10), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 0.2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.2 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
			if mde == "Terror" then
				local call = MRANDOM(1,85)
				Speed = 5
				if AMODE == "box" then
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(15*COS(SINE/50)), RAD(-25*COS(SINE/55))), 0.35 / Animation_Speed)
				elseif AMODE == "radio" then
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0+math.random(-15,15)/100, 0+math.random(-15,15)/100, 0+math.random(-15,15)/100) * ANGLES(RAD(10+MRANDOM(-15,15)), RAD(15*COS(SINE/50)+MRANDOM(-15,15)), RAD(-25*COS(SINE/55)+MRANDOM(-15,15))), 0.35 / Animation_Speed)
				end
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0 , 0 , 0+0.1*COS(SINE/35)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
				if AMODE == "box" then
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.2+ 0.2*COS(SINE/53.5), -0.3) * ANGLES(RAD(90+ 15*COS(SINE/54.5) ), RAD(0), RAD(-70))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
				elseif AMODE == "radio" then
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1+math.random(-15,15)/100, 0.2+ 0.2*COS(SINE/53.5)+math.random(-15,15)/100, -0.3+math.random(-15,15)/100) * ANGLES(RAD(90+ 15*COS(SINE/54.5) ), RAD(0), RAD(-70))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
				end
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4+0.1*COS(SINE/54.5), 0) * ANGLES(RAD(0), RAD(0), RAD(-10+10*COS(SINE/53.5))) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1-0.1*COS(SINE/35), 0) * ANGLES(RAD(0), RAD(-5), RAD(2)) * ANGLES(RAD(0), RAD(90), RAD(0)), 0.35 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1-0.1*COS(SINE/35) , 0) * ANGLES(RAD(0), RAD(5), RAD(-2)) * ANGLES(RAD(0), RAD(-90), RAD(0)), 0.35 / Animation_Speed)
			end
		end	
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			Speed = 5
			local Testwalk1 = Humanoid.MoveDirection*Torso.CFrame.LookVector
			local Testwalk2 = Humanoid.MoveDirection*Torso.CFrame.RightVector
			LOOKVEC = Testwalk1.X+Testwalk1.Z
			RIGHTVEC = Testwalk2.X+Testwalk2.Z
			local RIGHTHIPSECOND = CF(LOOKVEC/10 * COS(SINE / 18),0,0)*ANGLES(SIN(RIGHTVEC/5) * COS(SINE / 18),0,SIN(-LOOKVEC/2) * COS(SINE / 18))
			local LEFTHIPSECOND = CF(-LOOKVEC/10 * COS(SINE / 18),0,0)*ANGLES(SIN(RIGHTVEC/5) * COS(SINE / 18),0,SIN(-LOOKVEC/2) * COS(SINE / 18))
			local RIGHTARMSECOND = CF(LOOKVEC/10 * COS(SINE / 18),0,0)*ANGLES(SIN(RIGHTVEC/5) * COS(SINE / 18),0,SIN(-LOOKVEC/2) * COS(SINE / 18))
			local LEFTARMSECOND = CF(-LOOKVEC/10 * COS(SINE / 18),0,0)*ANGLES(SIN(RIGHTVEC/5) * COS(SINE / 18),0,SIN(-LOOKVEC/2) * COS(SINE / 18))

			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0 , -0.185 + 0.055 * COS(SINE / 10) + -SIN(SINE / 10) / 8) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.35 / Animation_Speed)
			if AMODE == "box" then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(15*COS(SINE/50)), RAD(-25*COS(SINE/55))), 0.35 / Animation_Speed)
			elseif AMODE == "radio" then
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0+math.random(-15,15)/100, 0+math.random(-15,15)/100, 0+math.random(-15,15)/100) * ANGLES(RAD(10+MRANDOM(-15,15)), RAD(15*COS(SINE/50)+MRANDOM(-15,15)), RAD(-25*COS(SINE/55)+MRANDOM(-15,15))), 0.35 / Animation_Speed)
			end
			if VALUE1 == true then
				if AMODE == "box" then
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.2+ 0.2*COS(SINE/53.5), -0.3) * ANGLES(RAD(90+ 15*COS(SINE/54.5) ), RAD(0), RAD(-70))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
				elseif AMODE == "radio" then
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1+math.random(-15,15)/100, 0.2+ 0.2*COS(SINE/53.5)+math.random(-15,15)/100, -0.3+math.random(-15,15)/100) * ANGLES(RAD(90+ 15*COS(SINE/54.5) ), RAD(0), RAD(-70))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
				end
			elseif VALUE1 == false then
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(25* COS(SINE / 18)), RAD(0), RAD(0))* RIGHTSHOULDERC0, 0.35 / Animation_Speed)
			end
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25* COS(SINE / 18)), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1+ 0.2 * SIN(SINE / 18), 0)* ANGLES(RAD(0),RAD(90),RAD(0))*RIGHTHIPSECOND*ANGLES(RAD(0),RAD(0),RAD(0 - 5 * COS(SINE / 18))), 0.8 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1- 0.2 * SIN(SINE / 18), 0)* ANGLES(RAD(0),RAD(-90),RAD(0))*LEFTHIPSECOND*ANGLES(RAD(0),RAD(0),RAD(0 - 5 * COS(SINE / 18))), 0.8 / Animation_Speed)
		end
	end
	Player.Chatted:connect(function(message)
		if message:sub(1,5) == "play/"  then
			sick.SoundId = "rbxassetid://"..message:sub(6)
		elseif message:sub(1,6) == "pitch/"  then
			sick.PlaybackSpeed = message:sub(7)
		elseif message:sub(1,4) == "vol/"  then
			sick.Volume = message:sub(5) 
		elseif message:sub(1,5) == "skip/"  then
			sick.TimePosition = message:sub(6)
		elseif message:sub(1,10) == "effects/on"  then
			NICE = true
		elseif message:sub(1,11) == "effects/off"  then
			NICE = false
		end
	end)

	Humanoid.MaxHealth = math.huge
	Humanoid.Health = math.huge
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	if Head:FindFirstChild("face") then
		Head.face.Texture = "rbxassetid://0"
	end
end

-------------------------------------------------



