--//====================================================\\--
--||			   CREATED BY SHACKLUSTER
--\\====================================================//--
Player = game.Players.LocalPlayer
Character = Player.Character
local txt = Instance.new("BillboardGui", Character)
txt.Adornee = Character.Head
txt.Name = "_status"
txt.Size = UDim2.new(2, 0, 1.2, 0)
txt.StudsOffset = Vector3.new(-9, 8, 0)
local text = Instance.new("TextLabel", txt)
text.Size = UDim2.new(10, 0, 7, 0)
text.FontSize = "Size24"
text.TextScaled = true
text.TextTransparency = 0
text.BackgroundTransparency = 10
text.TextTransparency = 0
text.TextStrokeTransparency = 0
text.Font = "Antique"
text.TextStrokeColor3 = Color3.new(0,0,0)
text.Text = "Terra God"


local createstuff = function()
	local stuff = Instance.new("Model")
	local collar = Instance.new("Part")
	local mesh = Instance.new("FileMesh")
	local part = Instance.new("Part")
	local mesh_2 = Instance.new("CylinderMesh")
	local weld = Instance.new("ManualWeld")
	local eye = Instance.new("Part")
	local mesh_3 = Instance.new("SpecialMesh")
	local decal = Instance.new("Decal")
	local hood = Instance.new("Part")
	local mesh_4 = Instance.new("FileMesh")
	local pillar = Instance.new("Part")
	local rock = Instance.new("Part")
	local core = Instance.new("Attachment")
	local emit = Instance.new("ParticleEmitter")
	local mesh_5 = Instance.new("FileMesh")
	local rockspike = Instance.new("Part")
	local mesh_6 = Instance.new("SpecialMesh")
	local shield = Instance.new("Part")
	local core_2 = Instance.new("Attachment")
	local spinepart = Instance.new("Part")
	local mesh_7 = Instance.new("FileMesh")
	local emit_2 = Instance.new("ParticleEmitter")
	local vortex = Instance.new("ParticleEmitter")
	local wave = Instance.new("ParticleEmitter")

	stuff.Name = "Stuff"
	stuff.Parent = workspace
	collar.Size = Vector3.new(2.06, 0.2, 2.06)
	collar.Name = "Collar"
	collar.Material = Enum.Material.Metal
	collar.TopSurface = Enum.SurfaceType.Smooth
	collar.BottomSurface = Enum.SurfaceType.Smooth
	collar.Parent = stuff
	collar.CFrame = CFrame.new(5.8, 46.2, -39.9)
	mesh.MeshId = "rbxassetid://1861264141"
	mesh.Parent = collar
	part.Size = Vector3.new(1.3, 0.2, 1.3)
	part.BrickColor = BrickColor.new("Really black")
	part.Color = Color3.new(0.109804, 0.0823529, 0.117647)
	part.Material = Enum.Material.Metal
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = collar
	part.CFrame = CFrame.new(5.8, 46.2, -39.9)
	mesh_2.Scale = Vector3.new(1.1, 1.1, 1.1)
	mesh_2.Parent = part
	weld.Part0 = collar
	weld.Name = "Weld"
	weld.Part1 = part
	weld.Parent = collar
	eye.Anchored = true
	eye.Size = Vector3.new(2, 2, 2)
	eye.BottomSurface = Enum.SurfaceType.Smooth
	eye.Material = Enum.Material.SmoothPlastic
	eye.Color = Color3.new(0.972549, 0.972549, 0.972549)
	eye.Name = "Eye"
	eye.TopSurface = Enum.SurfaceType.Smooth
	eye.BrickColor = BrickColor.new("Institutional white")
	eye.Parent = stuff
	eye.CFrame = CFrame.new(9.8, 45.845, -47.125) * CFrame.Angles(0, 0, 0)
	mesh_3.MeshType = Enum.MeshType.Sphere
	mesh_3.Parent = eye
	decal.Texture = "http://www.roblox.com/asset/?id=743271416"
	decal.Parent = eye
	hood.Size = Vector3.new(2.919, 2.394, 2.891)
	hood.BottomSurface = Enum.SurfaceType.Smooth
	hood.Material = Enum.Material.SmoothPlastic
	hood.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
	hood.BrickColor = BrickColor.new("Really black")
	hood.TopSurface = Enum.SurfaceType.Smooth
	hood.Name = "Hood"
	hood.Parent = stuff
	hood.CFrame = CFrame.new(9.8, 44.1, -48.7)
	mesh_4.Scale = Vector3.new(1.55, 1.44, 1.4)
	mesh_4.MeshId = "rbxassetid://16952952"
	mesh_4.Parent = hood
	pillar.Size = Vector3.new(1, 1, 1)
	pillar.Name = "Pillar"
	pillar.Material = Enum.Material.Metal
	pillar.TopSurface = Enum.SurfaceType.Smooth
	pillar.BottomSurface = Enum.SurfaceType.Smooth
	pillar.Parent = stuff
	pillar.CFrame = CFrame.new(-26.77, 0.5, -37.02)
	rock.Size = Vector3.new(2.03, 1.978, 2.057)
	rock.BottomSurface = Enum.SurfaceType.Smooth
	rock.Name = "Rock"
	rock.TopSurface = Enum.SurfaceType.Smooth
	rock.Parent = stuff
	rock.CFrame = CFrame.new(-0.43, 45.908, -52.56)
	core.Name = "Core"
	core.Parent = rock
	emit.Enabled = false
	emit.Lifetime = NumberRange.new(1, 4)
	emit.Name = "Emit"
	emit.Speed = NumberRange.new(0, 35)
	emit.Rotation = NumberRange.new(0, 360)
	emit.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.037, 0.754), NumberSequenceKeypoint.new(0.067, 0), NumberSequenceKeypoint.new(1, 0)})
	emit.VelocitySpread = 360
	emit.Texture = "rbxassetid://281633012"
	emit.Acceleration = Vector3.new(0, -15, 0)
	emit.Color = ColorSequence.new(Color3.new(0.423529, 0.345098, 0.294118), Color3.new(0.423529, 0.345098, 0.294118))
	emit.RotSpeed = NumberRange.new(-25, 25)
	emit.SpreadAngle = Vector2.new(360, 360)
	emit.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(0.255, 3.06), NumberSequenceKeypoint.new(0.649, 2.131), NumberSequenceKeypoint.new(1, 0)})
	emit.Parent = core
	mesh_5.MeshId = "rbxassetid://1861108040"
	mesh_5.Parent = rock
	rockspike.Anchored = true
	rockspike.Size = Vector3.new(3.364, 20, 3.364)
	rockspike.BottomSurface = Enum.SurfaceType.Smooth
	rockspike.Material = Enum.Material.Grass
	rockspike.Color = Color3.new(0.423529, 0.345098, 0.294118)
	rockspike.Name = "RockSpike"
	rockspike.TopSurface = Enum.SurfaceType.Smooth
	rockspike.BrickColor = BrickColor.new("Pine Cone")
	rockspike.Parent = stuff
	rockspike.CFrame = CFrame.new(-0.43, 46.208, -29.96)
	mesh_6.TextureId = "rbxassetid://136560096"
	mesh_6.MeshType = Enum.MeshType.FileMesh
	mesh_6.MeshId = "rbxassetid://1861231635"
	mesh_6.Parent = rockspike
	shield.Size = Vector3.new(1, 1, 1)
	shield.Name = "Shield"
	shield.Material = Enum.Material.Metal
	shield.TopSurface = Enum.SurfaceType.Smooth
	shield.BottomSurface = Enum.SurfaceType.Smooth
	shield.Parent = stuff
	shield.CFrame = CFrame.new(-26.77, 0.5, -37.02)
	core_2.Name = "Core"
	core_2.Parent = shield
	spinepart.CanCollide = false
	spinepart.Size = Vector3.new(0.3, 0.3, 0.6)
	spinepart.BrickColor = BrickColor.new("Institutional white")
	spinepart.BottomSurface = Enum.SurfaceType.Smooth
	spinepart.Color = Color3.new(0.972549, 0.972549, 0.972549)
	spinepart.Name = "SpinePart"
	spinepart.TopSurface = Enum.SurfaceType.Smooth
	spinepart.Parent = stuff
	spinepart.CFrame = CFrame.new(-24.33, 46.208, -52.56)
	mesh_7.MeshId = "rbxassetid://1861166416"
	mesh_7.Parent = spinepart
	
	emit_2.Enabled = false
	emit_2.Lifetime = NumberRange.new(1, 4)
	emit_2.Name = "Emit"
	emit_2.Speed = NumberRange.new(0, 35)
	emit_2.Rotation = NumberRange.new(0, 360)
	emit_2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.037, 0.754), NumberSequenceKeypoint.new(0.067, 0), NumberSequenceKeypoint.new(1, 0)})
	emit_2.VelocitySpread = 360
	emit_2.Texture = "rbxassetid://281633012"
	emit_2.Acceleration = Vector3.new(0, -15, 0)
	emit_2.Color = ColorSequence.new(Color3.new(0.423529, 0.345098, 0.294118), Color3.new(0.423529, 0.345098, 0.294118))
	emit_2.RotSpeed = NumberRange.new(-25, 25)
	emit_2.SpreadAngle = Vector2.new(360, 360)
	emit_2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0.5), NumberSequenceKeypoint.new(1, 0)})
	emit_2.Parent = stuff
	vortex.Enabled = false
	vortex.Name = "Vortex"
	vortex.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.5), NumberSequenceKeypoint.new(1, 0.5)})
	vortex.Lifetime = NumberRange.new(1)
	vortex.Rate = 0
	vortex.Speed = NumberRange.new(0)
	vortex.Color = ColorSequence.new(Color3.new(0.423529, 0.345098, 0.294118), Color3.new(0.423529, 0.345098, 0.294118))
	vortex.Rotation = NumberRange.new(0, 360)
	vortex.ZOffset = -2
	vortex.RotSpeed = NumberRange.new(360)
	vortex.LightEmission = 1
	vortex.Texture = "rbxassetid://1084969997"
	vortex.LockedToPart = true
	vortex.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0)})
	vortex.Parent = stuff
	wave.Enabled = false
	wave.Lifetime = NumberRange.new(0.3)
	wave.Name = "Wave"
	wave.Speed = NumberRange.new(0)
	wave.LightEmission = 1
	wave.Rate = 1
	wave.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.17, 0.393), NumberSequenceKeypoint.new(0.334, 0.661), NumberSequenceKeypoint.new(0.535, 0.836), NumberSequenceKeypoint.new(1, 1)})
	wave.Texture = "rbxassetid://1084991215"
	wave.Rotation = NumberRange.new(-180, 180)
	wave.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0)})
	wave.ZOffset = 1
	wave.Parent = stuff
	for i,v in pairs(stuff:GetChildren()) do
		v.Parent = script
	end
end

createstuff()





wait(0.2)

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

--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 35
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1.75, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
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
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local UNANCHOR = true
local PLAYSONG = true
local EXTRATRANS = 0

--//=================================\\
--\\=================================//


--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//

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

--//=================================\\
--\\=================================//

--//=================================\\
--|| 	      SOME FUNCTIONS
--\\=================================//

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

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
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

function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
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

local S = IT("Sound")
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
			repeat wait(1) until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
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
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
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
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChild("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChild("Sound") == nil
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

local ROCK = script.Rock
ROCK.Parent = nil
function GetRock(FLOOROBJECT)
	local Rock = ROCK:Clone()
	Rock.Parent = Effects
	if FLOOROBJECT ~= nil then
		if FLOOROBJECT.Material ~= Enum.Material.Grass and FLOOROBJECT.Material ~= Enum.Material.Fabric then
			Rock.Material = FLOOROBJECT.Material
			Rock.Color = FLOOROBJECT.Color
		else
			Rock.Material = "Slate"
			Rock.Color = BRICKC"Dirt brown".Color
		end
	else
		Rock.Material = "Slate"
		Rock.Color = BRICKC"Dirt brown".Color
	end
	Rock.Core.Emit.Color = ColorSequence.new(Rock.Color)
	return Rock
end

local SPIKE = script.RockSpike
SPIKE.Parent = nil
function GetSpike(FLOOROBJECT)
	local Rock = SPIKE:Clone()
	Rock.Parent = Effects
	if FLOOROBJECT ~= nil then
		if FLOOROBJECT.Material ~= Enum.Material.Grass and FLOOROBJECT.Material ~= Enum.Material.Fabric then
			Rock.Material = FLOOROBJECT.Material
			Rock.Color = FLOOROBJECT.Color
		else
			Rock.Material = "Slate"
			Rock.Color = BRICKC"Dirt brown".Color
		end
	else
		Rock.Material = "Slate"
		Rock.Color = BRICKC"Dirt brown".Color
	end
	return Rock
end

local SHIELD = script.Shield
SHIELD.Parent = nil
function GetShield(FLOOROBJECT)
	local Rock = SHIELD:Clone()
	Rock.Parent = Effects
	if FLOOROBJECT ~= nil then
		Rock.Material = FLOOROBJECT.Material
		Rock.Color = FLOOROBJECT.Color
	else
		Rock.Material = "Slate"
		Rock.Color = BRICKC"Dirt brown".Color
	end
	return Rock
end

function RespondToImpact(Object,Rock)
	local BREAKABLEMATERIALS = {{Enum.Material.Glass,5,1571353313},{Enum.Material.Ice,2,151284431},{Enum.Material.Wood,1.3,131144461},{Enum.Material.WoodPlanks,1,131144461},{Enum.Material.Cobblestone,0.2,130972023}}
	for i = 1, #BREAKABLEMATERIALS do
		local MATERIAL = BREAKABLEMATERIALS[i]
		if Object.Material == MATERIAL[1] then
			local A = Rock.Size.Magnitude
			local B = Object.Size.Magnitude
			if B < A*MATERIAL[2] then
				WaveParticles(Object.Position,B*3,Object.Color)
				Object:remove()
				CreateSound(MATERIAL[3], Rock, 5, MRANDOM(8,12)/10, false)
			end
		end
	end
end

function WaveParticles(Position,Size,Color)
	local BASE = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Shockwave", VT(0,0,0), true)
	BASE.CFrame = CF(Position)
	local A = IT("Attachment",BASE)
	local WAVE = script.Wave:Clone()
	WAVE.Parent = A
	WAVE.Size = NumberSequence.new(0,Size)
	WAVE.Color = ColorSequence.new(Color)
	Debris:AddItem(BASE,0.5)
	WAVE:Emit(1)
end

--//=================================\\
--||	     WEAPON CREATION
--\\=================================//

local sick = Instance.new("Sound",Character)

local PILLAR = script.Pillar
PILLAR.Parent = nil
local HOOD = script.Hood
HOOD.Parent = Character
HOOD.CFrame = Torso.CFrame*CFrame.new(0,2.2,0)
weldBetween(Torso,HOOD)
Head:ClearAllChildren()
Head.Transparency = 1
local EYE = script.Eye
EYE.Parent = Character
EYE.CFrame = Head.CFrame*CF(0,0,0)
EYE.Anchored = false
weldBetween(EYE,Head)
local COLLAR = script.Collar
COLLAR.Parent = Character
COLLAR.CFrame = Torso.CFrame*CF(0,1,0) * ANGLES(RAD(0), RAD(0), RAD(0))
weldBetween(Torso,COLLAR)
local BONE = script.SpinePart
BONE.Parent = nil
local TAIL = {}
local LASTPART = Torso
local SIZE = BONE.Size
for i = 1, 23 do
	local PART = BONE:Clone()
	PART.Anchored = false
	PART.Parent = Character
	PART.Size = SIZE*((25-i)/10)/1.6
	if LASTPART == Torso then
		local WELD = CreateWeldOrSnapOrMotor("Weld", LASTPART, LASTPART, PART, CF(0,-0.8,0.6)* ANGLES(RAD(-55), RAD(0), RAD(0)), CF(0, 0, 0))
		LASTPART = PART
		table.insert(TAIL,WELD)
	else
		local WELD = CreateWeldOrSnapOrMotor("Weld", LASTPART, LASTPART, PART, CF(0,-PART.Size.Y/1.2,-0.01), CF(0, 0, 0))
		LASTPART = PART
		table.insert(TAIL,WELD)
	end
end
for _, c in pairs(Character:GetChildren()) do
	if c:IsA("BasePart") then
		if c:FindFirstChildOfClass("ParticleEmitter") then
			c:FindFirstChildOfClass("ParticleEmitter"):remove()
		end
		if c == Head then
			if c:FindFirstChild("face") then
				c.face:remove()
			end
		end
	elseif c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.ClassName == "Hat" or c.Name == "Body Colors" then
		c:remove()
	end
end
local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
	if c:IsA("BasePart") and c.Name ~= "Handle" then
		if c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and c ~= LeftLeg then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(BODY,{c,c.Parent,c.Material,c.Color,c.Transparency})
	elseif c:IsA("JointInstance") then
		table.insert(BODY,{c,c.Parent,nil,nil,nil})
	end
end
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
function refit()
	Character.Parent = workspace
	for e = 1, #BODY do
		if BODY[e] ~= nil then
			local STUFF = BODY[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			if PART:IsA("BasePart") and PART ~= RootPart then
				PART.Material = MATERIAL
				PART.Color = COLOR
				PART.Transparency = TRANSPARENCY+EXTRATRANS
			end
			if PART.Parent ~= PARENT then
				Humanoid:remove()
				PART.Parent = PARENT
				Humanoid = IT("Humanoid",Character)
			end
		end
	end
end

Humanoid.Died:connect(function()
	refit()
end)

--//=================================\\
--||			DAMAGING
--\\=================================//

function ApplyDamage(Humanoid,Damage,TorsoPart)

end

function ApplyAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL,ROCK)
	
end

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

function RockExplosion(Rock,Multiplier,Survive)
	local EXPLOSION = Rock.Core:FindFirstChildOfClass("ParticleEmitter")
	EXPLOSION.Color = ColorSequence.new(Rock.Color)
	local SIZE = (Rock.Size.Y*4)*Multiplier
	EXPLOSION.Enabled = false
	EXPLOSION.Speed = NumberRange.new(0,SIZE*5)
	EXPLOSION.Size = NumberSequence.new(SIZE/15,0)
	EXPLOSION:Emit(200,300)
	WaveParticles(Rock.Position,SIZE*2,Rock.Color)
	coroutine.resume(coroutine.create(function()
		Rock:BreakJoints()
		if Survive == nil then
			Rock.Transparency = 1
			Rock.CanCollide = false
			Rock.Anchored = true
			Debris:AddItem(Rock,5)
		end
		CreateSound(165970126, Rock, 2, MRANDOM(8,12)/10, false)
		ApplyAoE(Rock.Position,SIZE,25,30,35,false,Rock)
		local HITFLOOR,HITPOS = Raycast(Rock.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, Rock.Size.Y/2, Character)
		Swait()
		if HITFLOOR then
			WACKYEFFECT({Time = 75, EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(SIZE*7,3,SIZE*7), Transparency = 0.7, Transparency2 = 1, CFrame = CF(HITPOS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = HITFLOOR.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		end
		for i = 1, 5 do
			WACKYEFFECT({Time = MRANDOM(15,55), EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(SIZE*5,0.2,SIZE*5), Transparency = 0.95, Transparency2 = 1, CFrame = CF(Rock.Position)*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360))), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Rock.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		end
	end))
end

function Bullet()
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	ATTACK = true
	Rooted = true
	local GYRO = IT("BodyGyro",RootPart)
	GYRO.D = 2
	GYRO.P = 2000
	GYRO.MaxTorque = VT(0,4000000,0)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
	end))
	local FLOOR = false
	if HITFLOOR then
		if HITFLOOR.Material ~= Enum.Material.Foil and HITFLOOR.Material ~= Enum.Material.Glass then
			FLOOR = true
		end
	end
	if FLOOR == true then
		for i=0, 0.5, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-15), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.35, -0.75) * ANGLES(RAD(-30), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-30), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
		for i=0, 0.25, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4, -0.1) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.9, -0.6) * ANGLES(RAD(35), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1.1, 0) * ANGLES(RAD(35), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		local ROCKPLACED = false
		local Rock = nil
		if HITFLOOR.Anchored == true then
			Rock = GetRock(HITFLOOR)
			Rock.Core.Emit.Enabled = true
			Rock.Size = VT(6,6,6)
			Rock.CFrame = CF(RootPart.CFrame*CF(0,-9,-6).p,Mouse.Hit.p)
			CreateSound(130972023, Rock, 2, MRANDOM(5,8)/10, false)
			coroutine.resume(coroutine.create(function()
				for i = 1, 30 do
					Swait()
					Rock.CFrame = Clerp(Rock.CFrame, CF(RootPart.CFrame*CF(0,1,-6).p,Mouse.Hit.p), 0.8 / Animation_Speed)
				end
				ROCKPLACED = true
				Rock.Core.Emit.Enabled = false
			end))
		else
			if HITFLOOR.Parent:FindFirstChildOfClass("Humanoid") then
				local TORSO = HITFLOOR.Parent:FindFirstChild("Torso") or HITFLOOR.Parent:FindFirstChild("UpperTorso")
				if TORSO then
					Rock = TORSO
					ROCK.Core:Clone().Parent = Rock
				else
					Rock = HITFLOOR
					ROCK.Core:Clone().Parent = Rock
				end
			elseif HITFLOOR.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				local TORSO = HITFLOOR.Parent.Parent:FindFirstChild("Torso") or HITFLOOR.Parent.Parent:FindFirstChild("UpperTorso")
				if TORSO then
					Rock = TORSO
					ROCK.Core:Clone().Parent = Rock
				else
					Rock = HITFLOOR
					ROCK.Core:Clone().Parent = Rock
				end
			else
				Rock = HITFLOOR
				ROCK.Core:Clone().Parent = Rock
			end
			Rock.Anchored = true
			coroutine.resume(coroutine.create(function()
				for i = 1, 30 do
					Swait()
					Rock.CFrame = Clerp(Rock.CFrame, CF(RootPart.CFrame*CF(0,1,-6).p,Mouse.Hit.p), 0.8 / Animation_Speed)
				end
				ROCKPLACED = true
			end))
		end
		for i=0, 0.1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4, -0.1) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.6) * ANGLES(RAD(35), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1.1, 0) * ANGLES(RAD(35), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		repeat
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0.25) * ANGLES(RAD(-25), RAD(0), RAD(80)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(-30)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(45), RAD(0)) * ANGLES(RAD(-25), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-65), RAD(0), RAD(0)) * CF(0,1.5,0), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
		until ROCKPLACED == true
		for i=0, 0.1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0.2, 0.25) * ANGLES(RAD(-35), RAD(0), RAD(80)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(-30)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(45), RAD(0)) * ANGLES(RAD(-32), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-65), RAD(0), RAD(0)) * CF(0,-0.3,0), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		WaveParticles(Rock.Position,12,C3(1,1,1))
		CreateSound(621557962, RightLeg, 1, MRANDOM(7,9)/10, false)
		coroutine.resume(coroutine.create(function()
			if Rock.Parent:FindFirstChildOfClass("Humanoid") == nil then
				for i = 1, 200 do
					Swait()
					Rock.CFrame = Rock.CFrame * CF(0,0,-1.2)
					local HIT = Raycast(Rock.Position, Rock.CFrame.lookVector, Rock.Size.X/2, Character)
					if HIT then
						RespondToImpact(HIT,Rock)
						break
					end
				end
				RockExplosion(Rock,1)
			else
				for i = 1, 60 do
					Swait()
					Rock.CFrame = Rock.CFrame * CF(0,0,-2)
					local HIT = Raycast(Rock.Position, Rock.CFrame.lookVector, 3, Character)
					if HIT then
						RespondToImpact(HIT,Rock)
						break
					end
				end
				RockExplosion(Rock,2)
			end
		end))
		for i=0, 0.4, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0.2, 0.25) * ANGLES(RAD(-35), RAD(0), RAD(80)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(-30)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(45), RAD(0)) * ANGLES(RAD(-32), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-65), RAD(0), RAD(0)) * CF(0,-0.3,0), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	else
		local GRAV = IT("BodyPosition",RootPart)
		GRAV.D = 250
		GRAV.P = 20000
		GRAV.MaxForce = VT(math.huge,math.huge,math.huge)
		GRAV.Position = RootPart.Position
		local Rock = GetRock()
		Rock.Size = VT(0,0,0)
		Rock.CFrame = CF(RightLeg.CFrame*CF(0,-1,0).p,Mouse.Hit.p)
		CreateSound(201858045, Rock, 1, MRANDOM(10,12)/10, false)
		local DONEROCK = false
		coroutine.resume(coroutine.create(function()
			for i = 1, 15 do
				Swait()
				Rock.Size = Rock.Size + VT(0.1,0.1,0.1)
				Rock.Size = Rock.Size * 1.1
				Rock.CFrame = CF(RightLeg.CFrame*CF(0,-1-Rock.Size.Y/2,0).p,Mouse.Hit.p)
			end
			DONEROCK = true
		end))
		repeat
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-65), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-80), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-80), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(90), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-15), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		until DONEROCK == true
		local LOOP = 0
		for i=0, 0.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-70), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(130), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-15), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		WaveParticles(Rock.Position,5,C3(1,1,1))
		CreateSound(621557962, RightLeg, 1, MRANDOM(10,12)/10, false)
		coroutine.resume(coroutine.create(function()
			for i = 1, 300 do
				Swait()
				Rock.CFrame = Rock.CFrame * CF(0,0,-1.6)
				local HIT = Raycast(Rock.Position, Rock.CFrame.lookVector, Rock.Size.X/2, Character)
				if HIT then
					RespondToImpact(HIT,Rock)
					break
				end
			end
			RockExplosion(Rock,1)
		end))
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			LOOP = LOOP + 15*3
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-65+(LOOP)), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-15), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		GRAV:remove()
	end
	ATTACK = false
	Rooted = false
end

function Melee()
	ATTACK = true
	Rooted = false
	Speed = 12
	repeat
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-35)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(15)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	until KEYHOLD == false
	Speed = 0
	local ROOT = nil
	local TORS = nil
	local HUMAN = nil
	local DIST = 4
	for i=0, 0.2, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(45)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(10), RAD(0), RAD(-25)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(90), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		local CHILDREN = workspace:GetDescendants()
		for index, CHILD in pairs(CHILDREN) do
			if CHILD.ClassName == "Model" and CHILD ~= Character then
				local HUM = CHILD:FindFirstChildOfClass("Humanoid")
				if HUM then
					local TORSO = CHILD:FindFirstChild("HumanoidRootPart") or CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
					if TORSO and HUM.Health > 0 then
						if (TORSO.Position - RightArm.Position).Magnitude <= DIST then
							DIST = (TORSO.Position - RightArm.Position).Magnitude
							ROOT = TORSO
							HUMAN = HUM
							TORS = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
						end
					end
				end
			end
		end
		if ROOT then
			break
		end
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(45)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(10), RAD(0), RAD(-25)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(90), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	if ROOT then
		local POSITIONED = false
		coroutine.resume(coroutine.create(function()
			ROOT.Anchored = true
			local POS = RootPart.CFrame*CF(0,-3,-1) * ANGLES(RAD(180), RAD(0), RAD(0)) * ANGLES(RAD(90), RAD(0), RAD(0))
			for i = 1, 25 do
				ROOT.Anchored = true
				Swait()
				ROOT.CFrame = Clerp(ROOT.CFrame, POS, 0.8 / Animation_Speed)
			end
			POSITIONED = true
			repeat Swait() ROOT.Anchored = true until ATTACK == false
			ROOT.Anchored = false
		end))
		repeat
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		until POSITIONED == true
		for i = 1, 3 do
			for i=0, 0.5, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-15), RAD(0), RAD(0)), 2 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 2 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.35, -0.75) * ANGLES(RAD(50), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-30), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			end
			for i=0, 0.15, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4, -0.1) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.9, -0.6) * ANGLES(RAD(35), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1.1, 0) * ANGLES(RAD(35), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			local EMIT = script.Emit:Clone()
			EMIT.Parent = TORS
			EMIT.Size = NumberSequence.new(1,0)
			EMIT:Emit(120)
			Debris:AddItem(EMIT,5)
			CreateSound(138186576, RightLeg, 1, MRANDOM(13,15)/10, false)
			WaveParticles(TORS.Position,12,C3(1,1,1))
			ApplyAoE(RightLeg.Position,8,25,35,0,false)
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(35,3,35), Transparency = 0.2, Transparency2 = 1, CFrame = CF(TORS.Position), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(25,4,25), Transparency = 0.2, Transparency2 = 1, CFrame = CF(TORS.Position), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			for i=0, 0.25, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4, -0.1) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.9, -0.6) * ANGLES(RAD(35), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1.1, 0) * ANGLES(RAD(35), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			if HUMAN.Health == 0 then
				break
			end
			for i=0, 0.2, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
	end
	Speed = 25
	ATTACK = false
	Rooted = false
end

function Launch()
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	if HITFLOOR then
		WACKYEFFECT({Time = 15, EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(15,3,15), Transparency = 0.2, Transparency2 = 1, CFrame = CF(HITPOS), MoveToPos = nil, RotationX = 0, RotationY = 15, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = 138186576, SoundPitch = 1, SoundVolume = 2})
		local P = PILLAR:Clone()
		P.Color = HITFLOOR.Color
		P.Material = HITFLOOR.Material
		P.Parent = Effects
		P.CFrame = CF(HITPOS-VT(0,4.5,0))
		coroutine.resume(coroutine.create(function()
			for i = 1, 6 do
				Swait()
				P.CFrame = P.CFrame * CF(0,0.9,0)
			end
			wait(1)
			for i = 1, 45 do
				Swait()
				P.Transparency =P.Transparency + 1/45 
			end
			P:remove()
		end))
		RootPart.CFrame = RootPart.CFrame*CF(0,1,0)
		RootPart.Velocity = VT(0,0,0)
		local bv = Instance.new("BodyVelocity",RootPart) 
		bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.velocity = CF(RootPart.Position,RootPart.Position+VT(0,100,0)).lookVector*350
		Debris:AddItem(bv,0.1)
	end
end

function Ravage()
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	if HITFLOOR then
		ATTACK = true
		Rooted = false
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-15)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(-15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(55), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		WaveParticles(RightArm.CFrame*CF(0,-1,0).p,4,C3(1,1,1))
		Rooted = true
		CreateSound(217767125, RightArm, 5, 1, false)
		for i=0, 0.15, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-15)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(145)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(-15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(55), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-100), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		local HOLD = true
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(15)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, -0.2) * ANGLES(RAD(145), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(-15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-55), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			until HOLD == false
		end))
		repeat
			wait(0.3)
			coroutine.resume(coroutine.create(function()
				local HITFLOOR,HITPOS = Raycast(Mouse.Hit.p+VT(0,1,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 15, Character)
				if HITFLOOR then
					if HITFLOOR.Anchored == true then
						local ROCK = GetRock(HITFLOOR)
						CreateSound(130972023, ROCK, 2, MRANDOM(8,12)/10, false)
						ROCK.Size = VT(4,4,4)*(MRANDOM(8,12)/10)
						ROCK.Core.Emit.Enabled = true
						ROCK.CFrame = CF(HITPOS+VT(0,-6,0)) * ANGLES(RAD(0), RAD(MRANDOM(0,360)), RAD(0))
						local POS = ROCK.CFrame*CF(0,12,0)
						for i = 1, 25 do
							ROCK.Anchored = true
							Swait()
							ROCK.CFrame = Clerp(ROCK.CFrame, POS, 0.8 / Animation_Speed)
						end
						ROCK.Core.Emit.Enabled = false
						wait(0.3)
						RockExplosion(ROCK,1)
					end
				end
			end))
		until KEYHOLD == false
		wait(0.5)
		HOLD = false
		ATTACK = false
		Rooted = false
	end
end

function Shield()
	ATTACK = true
	Rooted = false
	local GYRO = IT("BodyGyro",RootPart)
	GYRO.D = 2
	GYRO.P = 2000
	GYRO.MaxTorque = VT(40000000000,4000000,40000000000)
	local GRAV = IT("BodyPosition",RootPart)
	GRAV.D = 250
	GRAV.P = 20000
	GRAV.MaxForce = VT(math.huge,math.huge,math.huge)
	GRAV.Position = RootPart.Position
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
		GRAV:Remove()
	end))
	for i=0, 0.3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-30)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	local Defence = GetShield()
	Defence.Size = VT(0,2,0)
	Defence.Parent = Effects
	Defence.CFrame = RightArm.CFrame*CF(0,-6,0) * ANGLES(RAD(180), RAD(90), RAD(0))
	WaveParticles(Defence.Position,12,Defence.Color)
	CreateSound(201858045, Defence, 2, MRANDOM(10,12)/10, false)
	local FIX = Defence.AncestryChanged:Connect(function()
		Defence.Parent = Effects
	end)
	for i = 1, 40 do
		Swait()
		Defence.Size = Defence.Size + VT(0.5,0,0.7)
		Defence.CFrame = RightArm.CFrame*CF(0,-6,0) * ANGLES(RAD(180), RAD(90), RAD(0))
	end
	repeat
		Swait()
		Defence.CFrame = RightArm.CFrame*CF(0,-6,0) * ANGLES(RAD(180), RAD(90), RAD(0))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-30)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-25), RAD(0), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	until KEYHOLD == false
	FIX:Disconnect()
	coroutine.resume(coroutine.create(function()
		for i = 1, 40 do
			Swait()
			Defence.Size = Defence.Size - VT(0.5,0,0.7)
		end
		WaveParticles(Defence.Position,12,Defence.Color)
		Defence:remove()
	end))
	ATTACK = false
	Rooted = false
end

function TwinMeteor()
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 100, Character)
	if HITFLOOR == nil then
		ATTACK = true
		Rooted = false
		local GYRO = IT("BodyGyro",RootPart)
		GYRO.D = 2
		GYRO.P = 2000
		GYRO.MaxTorque = VT(40000000000,4000000,40000000000)
		local GRAV = IT("BodyPosition",RootPart)
		GRAV.D = 250
		GRAV.P = 20000
		GRAV.MaxForce = VT(math.huge,math.huge,math.huge)
		GRAV.Position = RootPart.Position
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
			until ATTACK == false
			GYRO:Remove()
			GRAV:Remove()
		end))
		local CHARGED = false
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			until CHARGED == true
		end))
		local ROCK1 = GetRock()
		local ROCK2 = GetRock()
		local VORTEX1 = script.Vortex:Clone()
		local VORTEX2 = script.Vortex:Clone()
		VORTEX1.Parent = ROCK1.Core
		VORTEX2.Parent = ROCK2.Core
		ROCK1.Core.Emit.Enabled = true
		ROCK2.Core.Emit.Enabled = true
		ROCK1.CFrame = CF(RightArm.CFrame*CF(0,-1-ROCK1.Size.Y/2,0).p,Mouse.Hit.p)
		ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
		CreateSound(1664710821, ROCK1, 10, MRANDOM(8,12)/10, false)
		CreateSound(1664710821, ROCK2, 10, MRANDOM(8,12)/10, false)
		for i = 1, 70 do
			Swait()
			ROCK1.Size = ROCK1.Size + VT(0.3,0.3,0.3)
			ROCK2.Size = ROCK2.Size + VT(0.3,0.3,0.3)
			ROCK1.CFrame = CF(RightArm.CFrame*CF(0,-1-ROCK1.Size.Y/2,0).p,Mouse.Hit.p)
			ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
			VORTEX1.Size = NumberSequence.new(ROCK1.Size.Y*2,0)
			VORTEX2.Size = NumberSequence.new(ROCK1.Size.Y*2,0)
			VORTEX1:Emit(1)
			VORTEX2:Emit(1)
		end
		CHARGED = true
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			ROCK1.CFrame = CF(RightArm.CFrame*CF(0,-1-ROCK1.Size.Y/2,0).p,Mouse.Hit.p)
			ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i=0, 0.5, 0.1 / Animation_Speed do
			Swait()
			ROCK1.CFrame = CF(RightArm.CFrame*CF(0,-1-ROCK1.Size.Y/2,0).p,Mouse.Hit.p)
			ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		coroutine.resume(coroutine.create(function()
			local Rock = ROCK1
			WaveParticles(Rock.Position,30,C3(1,1,1))
			CreateSound(134012322, Rock, 2, MRANDOM(10,12)/10, false)
			for i = 1, 200 do
				Swait()
				Rock.CFrame = Rock.CFrame * CF(0,0,-3.2)
				local HIT = Raycast(Rock.Position, Rock.CFrame.lookVector, Rock.Size.X/2, Character)
				if HIT then
					RespondToImpact(HIT,Rock)
					break
				end
			end
			ApplyAoE(Rock.Position,ROCK.Size.Y,50,55,55,false)
			for i = 1, 6 do
				RockExplosion(Rock,1.5,true)
				wait(1)
			end
			RockExplosion(Rock,1.5)
		end))
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * ANGLES(RAD(55), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i=0, 0.5, 0.1 / Animation_Speed do
			Swait()
			ROCK2.CFrame = CF(LeftArm.CFrame*CF(0,-1-ROCK2.Size.Y/2,0).p,Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		coroutine.resume(coroutine.create(function()
			local Rock = ROCK2
			WaveParticles(Rock.Position,30,C3(1,1,1))
			CreateSound(134012322, Rock, 2, MRANDOM(10,12)/10, false)
			for i = 1, 200 do
				Swait()
				Rock.CFrame = Rock.CFrame * CF(0,0,-3.2)
				local HIT = Raycast(Rock.Position, Rock.CFrame.lookVector, Rock.Size.X/2, Character)
				if HIT then
					RespondToImpact(HIT,Rock)
					break
				end
			end
			ApplyAoE(Rock.Position,ROCK.Size.Y,50,55,55,false)
			for i = 1, 6 do
				RockExplosion(Rock,1.5,true)
				wait(1)
			end
			RockExplosion(Rock,1.5)
		end))
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-35)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * ANGLES(RAD(55), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		ATTACK = false
		Rooted = false
	end
end

function Spikes()
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 12, Character)
	if HITFLOOR then
		ATTACK = true
		Rooted = true
		local GYRO = IT("BodyGyro",RootPart)
		GYRO.D = 2
		GYRO.P = 2000
		GYRO.MaxTorque = VT(0,4000000,0)
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
			until ATTACK == false
			GYRO:Remove()
		end))
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-15), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(125), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(125), RAD(0), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.35, -0.75) * ANGLES(RAD(30), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-30), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
		for i=0, 0.25, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4, -0.1) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.9, -0.6) * ANGLES(RAD(35), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1.1, 0) * ANGLES(RAD(35), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		CreateSound(165970126, RightLeg, 1, MRANDOM(13,15)/10, false)
		WaveParticles(RightLeg.CFrame*CF(0,-1,0).p,15,C3(1,1,1))
		coroutine.resume(coroutine.create(function()
			local CFRAME = RootPart.CFrame*CF(0,-3,0)
			for i = 1, 60 do
				Swait()
				local SPIKE = GetSpike(HITFLOOR)
				SPIKE.CFrame = CFRAME*CF(0,-11,-i*2)
				ApplyAoE(CFRAME*CF(0,0,-i*2).p,4,10,35,15,false)
				coroutine.resume(coroutine.create(function()
					local POS = SPIKE.CFrame*CF(0,11,0)
					for i = 1, 25 do
						Swait()
						SPIKE.CFrame = Clerp(SPIKE.CFrame, POS, 0.8 / Animation_Speed)
					end
					wait(0.2)
					for i = 1, 45 do
						Swait()
						SPIKE.Transparency = SPIKE.Transparency + 1/45
						SPIKE.CFrame = SPIKE.CFrame * CF(0,-2/15,0)
					end
					SPIKE:remove()
				end))
			end
		end))
		wait(0.3)
		ATTACK = false
		Rooted = false
	end
end

function TakeOnMe()
	Speed = 5
	local MEME = CreateSound(288703954, Effects, 2, 1, false)
	ATTACK = true
	Rooted = false
	local DANCE = true
	local KEY = Mouse.KeyDown:connect(function(NEWKEY)
		if NEWKEY == "p" then
			DANCE = false
		end
	end)
	PLAYSONG = false
	while true do
		for i = 1, 15 do
			Swait()
			MEME.Parent = Effects
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.4+((15-i)/45)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.55, 0.75, 0) * ANGLES(RAD(0), RAD(0), RAD(-10)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.55, 0.75, 0) * ANGLES(RAD(0), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.6, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, 0, -1) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		if DANCE == false then
			break
		end
		for i = 1, 15 do
			Swait()
			MEME.Parent = Effects
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.4+((15-i)/45)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.55, 0.75, 0) * ANGLES(RAD(0), RAD(0), RAD(20)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.55, 0.75, 0) * ANGLES(RAD(0), RAD(0), RAD(10)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, 0, -1) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.6, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	end
	PLAYSONG = true
	KEY:Disconnect()
	MEME:remove()
	Speed = 25
	ATTACK = false
	Rooted = false
end

function Noclip()
	ATTACK = true
	Rooted = true
	UNANCHOR = false
	RootPart.Anchored = true
	local CLIPPING = true
	local MOVEMENT = nil
	CreateSound(96098241, Torso, 3, MRANDOM(9,12)/10, false)
	for i = 1, 50 do
		Swait()
		EXTRATRANS = EXTRATRANS + 0.5/50
		RootPart.CFrame = RootPart.CFrame * CF(0,(1-(i/50))/4.3,0)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	local AURA = CreateSound(1393698948, Torso, 3, 1, true)
	local KEY = Mouse.KeyDown:connect(function(NEWKEY)
		if NEWKEY == "w" then
			MOVEMENT = "Forward"
			repeat
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(0,0,-0.2)
			until KEYHOLD == false
		elseif NEWKEY == "s" then
			MOVEMENT = "Backwards"
			repeat
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(0,0,0.2)
			until KEYHOLD == false
		elseif NEWKEY == "a" then
			MOVEMENT = "Strafe"
			repeat
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(0.2,0,0)
			until KEYHOLD == false
		elseif NEWKEY == "d" then
			MOVEMENT = "Strafe"
			repeat
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(-0.2,0,0)
			until KEYHOLD == false
		elseif NEWKEY == "y" then
			CLIPPING = false
		end
		MOVEMENT = nil
	end)
	local LOOP = 0
	repeat
		Swait()
		AURA.Parent = Torso
		LOOP = LOOP + 1
		if LOOP >= 15 then
			LOOP = 0
			WaveParticles(Torso.Position,15,C3(1,1,1))
			WACKYEFFECT({Time = 15, EffectType = "Wave", Size = VT(5,0,5), Size2 = VT(15,1,15), Transparency = 0.7, Transparency2 = 1, CFrame = CF(RootPart.CFrame*CF(0,-3.5,0).p), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-2,2)*15, RotationZ = 0, Material = "Neon", Color = C3(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		end
		if MOVEMENT == nil then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.1 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * SIN(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		elseif MOVEMENT == "Forward" then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.1 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * SIN(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		elseif MOVEMENT == "Backwards" then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.1 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * SIN(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		elseif MOVEMENT == "Strafe" then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(2), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(10 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3 - 0.1 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * SIN(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	until CLIPPING == false
	KEY:Disconnect()
	coroutine.resume(coroutine.create(function()
		for i = 1, 20 do
			Swait()
			AURA.Volume = AURA.Volume - 3/20
		end
		AURA:remove()
	end))
	CreateSound(814168787, Torso, 1, MRANDOM(9,12)/10, false)
	for i = 1, 50 do
		Swait()
		EXTRATRANS = EXTRATRANS - 0.5/50
		RootPart.CFrame = RootPart.CFrame * CF(0,-(1-(i/50))/4.3,0)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	EXTRATRANS = 0
	UNANCHOR = true
	ATTACK = false
	Rooted = false
end

function Taunt()
	ATTACK = true
	Rooted = true
	local TAUNT = CreateSound(159882635, Torso, 7, 1, false)
	repeat
		Swait()
		TAUNT.Parent = Torso
		TAUNT.Playing = true
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(-0.02, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(25), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	until TAUNT.TimePosition >= 1.25
	for i=0, 1.6, 0.1 / Animation_Speed do
		Swait()
		TAUNT.Parent = Torso
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(5)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(25)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

--//=================================\\
--||	  ASSIGN THINGS TO KEYS
--\\=================================//

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
		Bullet()
	end

	if Key == "b" and ATTACK == false then
		Melee()
	end

	if Key == "c" and ATTACK == false then
		Launch()
	end

	if Key == "v" and ATTACK == false then
		Ravage()
	end

	if Key == "e" and ATTACK == false then
		Shield()
	end

	if Key == "q" and ATTACK == false then
		Spikes()
	end

	if Key == "x" and ATTACK == false then
		TwinMeteor()
	end

	if Key == "y" and ATTACK == false then
		Noclip()
	end

	if Key == "p" and ATTACK == false then
		TakeOnMe()
	end

	if Key == "t" and ATTACK == false then
		Taunt()
	end

	if Key == "]" and ATTACK == false then
		if PLAYSONG == true then
			PLAYSONG = false
		else
			PLAYSONG = true
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

--//=================================\\
--\\=================================//

function AntiTimeStop()
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

--//=================================\\
--||	WRAP THE WHOLE SCRIPT UP
--\\=================================//

Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end)

while true do
	Swait()
	Head:ClearAllChildren()
	script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	if Character:FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid",Character)
	end
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	local WALKSPEEDVALUE = 4
	Neck.C1 = Clerp(Neck.C1, CF(0, 0, 0.03) * ANGLES(RAD(90), RAD(180), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(180)) , 1 / Animation_Speed)
	if ANIM == "Walk" and TORSOVELOCITY > 1 and PLAYSONG == true  then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), -0.125 * COS(SINE / WALKSPEEDVALUE) +0.2- 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(65 * COS(SINE / WALKSPEEDVALUE))), 0.5 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), 0.125 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(65 * COS(SINE / WALKSPEEDVALUE))), 0.5 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or PLAYSONG == false then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(1), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.1) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, -0.025, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(50 * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(0)) * ANGLES(RAD(0), RAD(-15), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-50 * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(0)) * ANGLES(RAD(0), RAD(15), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
	end
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
			c:remove()
		end
	end
	AntiTimeStop()
	Humanoid.MaxHealth = 10e10
	Humanoid.Health = 10e10
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	for E = 1, #TAIL do
		TAIL[E].C1 = Clerp(TAIL[E].C1,CF(0, 0, 0) * ANGLES(RAD(5-1 * SIN(SINE / 12)), RAD(-2 * COS(SINE / 24)), RAD(4 * SIN(SINE / 24))), 1 / Animation_Speed)
	end
	sick.SoundId = "rbxassetid://0"
	sick.Looped = true
	sick.Pitch = 1
	sick.Volume = 2
	sick.Parent = Effects
	sick.Playing = PLAYSONG
	Humanoid.PlatformStand = false
	Humanoid.Name = "I am the god of earth"
	refit()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and ATTACK == false then
			for _, e in pairs(c:GetChildren()) do
				if e:IsA("ParticleEmitter") or e:IsA("BodyPosition") or e:IsA("BodyGyro") then
					e:remove()
				end
			end
		end
	end
end

--//=================================\\
--\\=================================//





--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--