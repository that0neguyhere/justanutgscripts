
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
local Speed = 16
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
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


function Clerp(a, b, t)
	return a:lerp(b,t)
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

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end

--WACKYEFFECT2({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), Rainbow = true SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
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
				repeat Swait() until SOUND.Playing == false
				EFFECT:remove()
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

local HSV = Color3.fromHSV
local Hue = 0
local Brightness = 0
local RainbowColor = HSV(0, 0, 0)
local Increment = 2
local Sensivity = 820
ArtificialHB.Event:Connect(function()
	Hue = Hue + Increment if Hue >= 360 then
		Hue = 0 
	end 
	Brightness = sick.PlaybackLoudness/Sensivity
	if Brightness == 1 then
		Brightness = sick.PlaybackLoudness/Sensivity	
	end
	RainbowColor = HSV(Hue / 360, Brightness, Brightness)
end)

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
	local RAINB = (Table.Rainbow) or false
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
		if TYPE == "Sphere" or TYPE == "Ball" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Cylinder" then
			MSH =  CreateMesh("SpecialMesh", EFFECT, "Cylinder", "", "", SIZE, VT(0,0,0))
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
		elseif TYPE == "Note" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1088207", "", SIZE, VT(0,0,0))
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
					if RAINB == true then
						EFFECT.Color = RainbowColor
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
					if RAINB == true then
						EFFECT.Color = RainbowColor
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

function Gyro(PARENT)
	local GYRO = IT("BodyGyro",PARENT)
	GYRO.D = 750
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0,40000000,0)
	return GYRO
end

function POSITION(PARENT)
	local grav = Instance.new("BodyPosition",PARENT)
	grav.D = 15
	grav.P = 20000
	grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
	return grav
end

function FacialShadow()
	local SHADOWS = {}
	for i = 1, 16 do
		local FACE = CreatePart(3, Effects, "Fabric", 0, 0+(i-1)/16.2, "Dark stone grey", "FaceGradient", VT(1.01,0.65,1.01),false)
		FACE.Color = C3(0,0,0)
		Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FACE
		CreateWeldOrSnapOrMotor("Weld", Head, Head, FACE, CF(0,0.35-(i-1)/25,0), CF(0, 0, 0))
		table.insert(SHADOWS,FACE)
	end
	local UNDO = function()
		for i = 1, #SHADOWS do
			SHADOWS[i]:remove()
		end
	end
	return UNDO
end

function GetRoot(MODEL,ROOT)
	if ROOT == true then
		return MODEL:FindFirstChild("HumanoidRootPart") or MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	else
		return MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	end
end

function CreateFlyingDebree(FLOOR,POSITION,AMOUNT,BLOCKSIZE,SWAIT,STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			local DEBREE = CreatePart(3, Effects, "Neon", FLOOR.Reflectance, FLOOR.Transparency, "Peal", "Debree", BLOCKSIZE, false)
			DEBREE.Material = FLOOR.Material
			DEBREE.Color = FLOOR.Color
			DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
			DEBREE.Velocity = VT(MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH))
			coroutine.resume(coroutine.create(function()
				Swait(15)
				DEBREE.Parent = workspace
				DEBREE.CanCollide = true
				Debris:AddItem(DEBREE,SWAIT)
			end))
		end
	end
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

--weap
local VOL = 3
local PITCH = 1
local d = CF(0,0,0)
local SONG = 5410083226

Player.Chatted:Connect(function(msg)
	if msg:sub(1,5) == "play/" then
		local NEWID = msg:sub(6)	
		SONG = NEWID
	end
	if msg:sub(1,4) == "vol/" then
		local NEWVOL = msg:sub(5)	
		VOL = NEWVOL
	end
	if msg:sub(1,6) == "pitch/" then
		local NEWPITCH = msg:sub(7)
		PITCH = NEWPITCH	
	end
	if msg:sub(1,4) == "plb/" then
		local NewSens = msg:sub(5)
		Sensivity = NewSens	
	end
	if msg:sub(1,8) == "timepos/" then
		local newpos = msg:sub(9)
		sick.TimePosition = newpos
	end
end)



--dmg
function aaa(MODEL)
	MODEL:BreakJoints()
	for index, CHILD in pairs(MODEL:GetChildren()) do
		if CHILD:IsA("BasePart") and CHILD.Name ~= "HumanoidRootPart" then
			if CHILD.Name == "Head" then
				WACKYEFFECT2({Time = 120, EffectType = "Box", Size = VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z), Size2 = (VT(CHILD.Size.Z,CHILD.Size.Y,CHILD.Size.Z)), Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = CHILD.Position+VT(MRANDOM(-30,30)/10,MRANDOM(-30,30)/10,MRANDOM(-30,30)/10), RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color =RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, SizeBoomerang = 0, Boomerang = 35})
			elseif CHILD.Name ~= "HumanoidRootPart" then
				WACKYEFFECT2({Time = 120, EffectType = "Box", Size = CHILD.Size, Size2 = CHILD.Size, Transparency = CHILD.Transparency, Transparency2 = 1, CFrame = CHILD.CFrame, MoveToPos = CHILD.Position+VT(MRANDOM(-30,30)/10,MRANDOM(-30,30)/10,MRANDOM(-30,30)/10), RotationY = 0, RotationZ = 0 ,Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, SizeBoomerang = 0, Boomerang = 35})
			end
			if CHILD.Name == "Torso" or CHILD.Name == "UpperTorso" then
				--WACKYEFFECT2({Time = 80, EffectType = "Box", Size = VT(0.2,0.2,0.2)*CHILD.Size.Magnitude, Size2 = VT(6,6,6)*CHILD.Size.Magnitude, Transparency = 0.6, Transparency2 = 1, CFrame = CF(CHILD.Position), MoveToPos = nil, RotationX = 10, RotationY = 0, RotationZ = 0, Material = "Neon", Color = cube.Color, SoundID = nil, SoundPitch = 2, SoundVolume = 10, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 50})
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
function beamm()
	ATTACK = true
	local done = false
	local b = false
	for i = 0,25 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0)*ANGLES(RAD(-90),RAD(0),RAD(-180)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.9,0.3,0.1)*ANGLES(RAD(-90),RAD(73.2),RAD(63.7)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92),RAD(-2.9),RAD(179.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,0)*ANGLES(RAD(0),RAD(-86.2),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-1,-0.3)*ANGLES(RAD(0),RAD(82.1),RAD(0)),Alpha)	
	end
	local sp = CreatePart(3,Effects,"Neon",0,0,"White","magic lol",VT(2,2,2),true)
	spawn(function() repeat Swait() sp.Color = RainbowColor sp.CFrame = RightArm.CFrame * CF(0,-1,0) until b == true end)
	MakeForm(sp,"Ball")
	sp.CFrame = RightArm.CFrame * CF(0,-1,0)
	WACKYEFFECT2({EffectType = "Sphere", Size = sp.Size * 0.9, Size2 = sp.Size * 2, Transparency = 0.24, Transparency2 = 1, CFrame = sp.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = 1448044156, SoundPitch = 1, SoundVolume = 3.5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	for i = 1,MRANDOM(4,8) do
		local pp = CF(sp.Position) * ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
		WACKYEFFECT2({EffectType = "Note", Size = VT(.1,.1,.1),Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = pp,MoveToPos = pp * CF(0,sp.Size.X*2,0).p,RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Neon", Color = RainbowColor, Rainbow = true,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 15})	
	end
	for i = 0,21 do
		Swait()
		local Alpha = .13
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0)*ANGLES(RAD(-90),RAD(0),RAD(-180)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.8,-0.1,0.3)*ANGLES(RAD(-108.3),RAD(43.1),RAD(79.9)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92),RAD(-2.9),RAD(179.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,0)*ANGLES(RAD(0),RAD(-86.2),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-1,-0.3)*ANGLES(RAD(0),RAD(82.1),RAD(0)),Alpha)	
	end
	for i = 0,35 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,-0.1,-0.5)*ANGLES(RAD(-123.1),RAD(0),RAD(-180)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.8,0,0.2)*ANGLES(RAD(-92.8),RAD(53.2),RAD(70.4)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92),RAD(-2.9),RAD(179.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,0)*ANGLES(RAD(33.1),RAD(-86.2),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-0.8,-0.3)*ANGLES(RAD(33.1),RAD(82.1),RAD(0)),Alpha)	
	end
	coroutine.resume(coroutine.create(function()
		repeat Swait(.05)
			wait(0.001)
			WACKYEFFECT2({EffectType = "Sphere", Size = sp.Size * 1.2, Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = sp.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = 1, SoundVolume = 3.5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})	
		until done == true	
	end))
	for i = 0,10 do
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,-0.4,0.4)*ANGLES(RAD(-70.6),RAD(0),RAD(-180)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.2,0.2,-0.4)*ANGLES(RAD(-26.5),RAD(69),RAD(91)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92),RAD(-2.9),RAD(179.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-0.7,-0.1)*ANGLES(RAD(-19.4),RAD(-86.2),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-0.8,-0.4)*ANGLES(RAD(-19.4),RAD(82.1),RAD(0)),Alpha)	
	end
	b = true
	local hj = false
	local portal = CreatePart(3,Effects,"Neon",0,0,"White","I am going to beat you to death.",VT(1,0,1),true)
	MakeForm(portal,"Ball")
	portal.CFrame = RootPart.CFrame * CF(-10,50,-15)
	spawn(function() repeat Swait() portal.Color = RainbowColor until hj == true end)
	coroutine.resume(coroutine.create(function()
		sp.CFrame = CF(sp.Position,portal.Position)
		for i = 0,17 do
			Swait()
			sp.CFrame = sp.CFrame * CF(0,0,-2)
		end
		portal.CFrame = sp.CFrame
		portal.Orientation = VT(0,0,0)
		for i = 0,25,5 do
			Swait()
			portal.Size = VT(1*i,0,1*i)
		end
		Debris:AddItem(sp,.001)
		WACKYEFFECT2({EffectType = "Sphere", Size = portal.Size * .9, Size2 = portal.Size * 1.2, Transparency = 0, Transparency2 = 1, CFrame = portal.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 10, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = 419447292, SoundPitch = 1, SoundVolume = 3.5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})
		Swait(.9)
		local hi = CreatePart(3,Effects,"Neon",0,1,"White",":WHENYOU:",VT(1,1,1),true)
		hi.CFrame = portal.CFrame * CF(portal.Position.X - portal.Position.X,portal.Position.Y-portal.Position.Y*2,portal.Position.Z-portal.Position.Z)
		local HIT,POS = CastProperRay(portal.Position,  hi.Position, 500, Character)
		local DISTANCE = (POS - portal.Position).Magnitude
		ApplyAoE(POS,26,0,0,0,true)
		WACKYEFFECT2({EffectType = "Sphere", Size = portal.Size * .9, Size2 = portal.Size * 1.2, Transparency = 0, Transparency2 = 1, CFrame = portal.CFrame * CF(0,-.1,0), MoveToPos = nil, RotationX = 0, RotationY = 10, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = 1, SoundVolume = 3.5, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
		WACKYEFFECT2({Time = 60, EffectType = "Box", Size = Vector3.new(5,5,DISTANCE), Size2 = Vector3.new(28,28,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CF(portal.Position,POS)*CF(0,0,-DISTANCE/2)*ANGLES(0,RAD(0),0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = -10, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = 763717897, SoundPitch = 1, SoundVolume = 8, Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
		WACKYEFFECT2({Time = 60, EffectType = "Box", Size = Vector3.new(2.5,2.5,DISTANCE), Size2 = Vector3.new(18,18,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CF(portal.Position,POS)*CF(0,0,-DISTANCE/2)*ANGLES(0,RAD(0),0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = -10, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = 1, SoundVolume = 8, Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
		for i = 0,12 do
			local brr = CF(portal.Position)* CF(MRANDOM(-15,15),0,MRANDOM(-15,15))
			WACKYEFFECT2({Time = MRANDOM(40,60),EffectType = "Box", Size = VT(1.3,1.3,1.3), Size2 = VT(1.3,1.3,1.3), Transparency = 0.3, Transparency2 = 1, CFrame = brr, MoveToPos = brr * CF(0,-MRANDOM(8,15),0).p, RotationX = MRANDOM(-30,30), RotationY = MRANDOM(-30,30), RotationZ = MRANDOM(-30,30), Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
		end
		WACKYEFFECT2({Time = 70, EffectType = "Box", Size = VT(5,0,5), Size2 = VT(49,0,49), Transparency = 0, Transparency2 = 1, CFrame = CF(POS) * CF(0,.1,0), MoveToPos = nil, RotationX = 0, RotationY = -7, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 20})
		WACKYEFFECT2({Time = 70, EffectType = "Sphere", Size = VT(4.5,4.5,4.5), Size2 = VT(45,45,45), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
		for i = 1,25 do
			WACKYEFFECT2({Time = MRANDOM(50,70), EffectType = "Sphere", Size = VT(0,0,0), Size2 = VT(1.7,1.7,1.7), Transparency = 0, Transparency2 = 1, CFrame = CF(POS) * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = POS + VT(MRANDOM(-35,35),MRANDOM(-35,35),MRANDOM(-35,35)), RotationX = 0, RotationY =  0, RotationZ =  0, Material = "Neon", Color = RainbowColor, Rainbow = true, SoundID = nil, SoundPitch = .5, SoundVolume = 10, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})	
		end
		Swait(.5)
		for i = 0,25,.05 do
			Swait()
			portal.Size = VT(portal.Size.X-i,0,portal.Size.Z-i)	
		end
		hj = true	
	end))
	for i = 0,26 do
		Swait()
		local Alpha = .25
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,-0.4,0.5)*ANGLES(RAD(-56.9),RAD(0),RAD(-180)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.1,0.7,-0.3)*ANGLES(RAD(-26.5),RAD(69),RAD(-166.4)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92),RAD(-2.9),RAD(179.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-0.8,0)*ANGLES(RAD(-33.1),RAD(-86.2),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-1,-0.3)*ANGLES(RAD(-33.1),RAD(82.1),RAD(0)),Alpha)	
	end
	done = true
	ATTACK = false	
end

function groovy()
	ATTACK = true
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			local pp = CF(RightArm.Position) * CF(0.5,1.3,0.5) * ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			WACKYEFFECT2({EffectType = "Note", Size = VT(.05,.05,.05),Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = pp,MoveToPos = pp * CF(0,RightArm.Size.X*3,0).p,RotationX = MRANDOM(-5,5), RotationY = MRANDOM(-5,5), RotationZ = MRANDOM(-5,5), Material = "Neon", Color = RainbowColor, Rainbow = true,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 15})	
		until ATTACK == false	
	end))
	for i = 0,20 do
		Swait()
		local Alpha = .1
		RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,0,-0.1)*ANGLES(RAD(-90),RAD(0),RAD(125)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7,0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.7,-0.3)*ANGLES(RAD(-22.9),RAD(71.6),RAD(-170.9)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0.1,1,0)*ANGLES(RAD(-88.8),RAD(-3.3),RAD(-125)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-0.7,-1,0.4)*ANGLES(RAD(0),RAD(-31.4),RAD(0)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(1,-1,0)*ANGLES(RAD(0),RAD(83),RAD(0)),Alpha)	
	end
	WACKYEFFECT2({Time = 90, EffectType = "Box", Size = VT(17,0,17), Size2 = VT(25,0,25), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(0,-2.9,0), MoveToPos = nil, RotationX = 0, RotationY = 9, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = 191395766, SoundPitch = .5, SoundVolume = 9, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 10})
	WACKYEFFECT2({Time = 90, EffectType = "Box", Size = VT(17,0,17)/1.2, Size2 = VT(25,0,25)/2, Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(0,-2.9,0), MoveToPos = nil, RotationX = 0, RotationY = -9, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 10})
	WACKYEFFECT2({Time = 90, EffectType = "Box", Size = VT(17,0,17)/2, Size2 = VT(25,0,25)/2, Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(0,-2.9,0), MoveToPos = nil, RotationX = 0, RotationY = -9, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 10})
	WACKYEFFECT2({Time = 90, EffectType = "Box", Size = VT(17,0,17)/3, Size2 = VT(25,0,25)/3, Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(0,-2.9,0), MoveToPos = nil, RotationX = 0, RotationY = 9, RotationZ = 0, Material = "Neon", Color = RainbowColor, Rainbow = true ,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 10})
	for i = 1,25 do
		WACKYEFFECT2({Time = 100, EffectType = "Note", Size = VT(.15,.15,.15), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(0,-2.9,0), MoveToPos = Torso.Position + VT(MRANDOM(-20,20),MRANDOM(-20,20),MRANDOM(-20,20)), RotationX = MRANDOM(-7,7), RotationY = MRANDOM(-7,7), RotationZ = MRANDOM(-7,7), Material = "Neon", Color = C3(1,1,1), Rainbow = true,SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})	
	end
	ApplyAoE(RootPart.Position,13,0,0,0,true)
	for i = 0,16 do
		Swait()
		local Alpha = .25
		RootJoint.C0 = RootJoint.C0:lerp(CF(0,-1.1,0)*ANGLES(RAD(-106.7),RAD(0),RAD(-109.9)),Alpha)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1.1,0.3,0.2)*ANGLES(RAD(-90),RAD(-48.3),RAD(-90)),Alpha)
		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.1,0,-0.4)*ANGLES(RAD(-22.9),RAD(71.6),RAD(45.1)),Alpha)
		Neck.C0 =Neck.C0:lerp(CF(0.2,1,0)*ANGLES(RAD(-93.4),RAD(0.9),RAD(109.9)),Alpha)
		LeftHip.C0 = LeftHip.C0:lerp(CF(-0.8,-1.6,-0.5)*ANGLES(RAD(70.6),RAD(-72.7),RAD(153)),Alpha)
		RightHip.C0 = RightHip.C0:lerp(CF(0.9,0.4,-0.6)*ANGLES(RAD(-62.4),RAD(73.2),RAD(69.1)),Alpha)
	end
	ATTACK = false
end


--keys
function MouseDown(Mouse)
	if ATTACK == false then
	end
end

function MouseUp(Mouse)
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "q" and ATTACK == false then
		HOLD = false
	end

	if Key == "z" and ATTACK == false then
		beamm()
	end

	if Key == "c" and ATTACK == false then
	end

	if Key == "x" and ATTACK == false then
		groovy()
	end

	if Key == "]" and ATTACK == false then
		if sick.Parent ~= Torso then
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
	Swait()
	script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	local num = 1000 - sick.PlaybackLoudness
	SINE = SINE + CHANGE*2
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4+Humanoid.HipHeight, Character)
	local WALKSPEEDVALUE = 12 / (Humanoid.WalkSpeed / 16)
	local TiltVelocity = CF(RootPart.CFrame:vectorToObjectSpace(RootPart.Velocity/1.6))
	local SideSt = math.clamp((RootPart.Velocity*RootPart.CFrame.rightVector).X+(RootPart.Velocity*RootPart.CFrame.rightVector).Z,-Humanoid.WalkSpeed,Humanoid.WalkSpeed)
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
			local Alpha = .1
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,0 + 0.07 * COS(SINE/35),0)*ANGLES(RAD(-90),RAD(0),RAD(-180)),Alpha)
			LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.7 + 0.09 * SIN(SINE/35),0.7)*ANGLES(RAD(90),RAD(-38.6),RAD(90)),Alpha)
			RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5+ 0.09 * SIN(SINE/35),0)*ANGLES(RAD(-90),RAD(87 - 5 * COS(SINE/35)),RAD(90 + 1.5 * SIN(SINE/35))),Alpha)
			Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-92 - sick.PlaybackLoudness/25),RAD(-2.9 + sick.PlaybackLoudness/25),RAD(179.9)),Alpha)
			if sick.PlaybackLoudness < 400 then
				LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1- 0.07 * COS(SINE/35),0)*ANGLES(RAD(0),RAD(-86.2),RAD(0)),Alpha)
				RightHip.C0 = RightHip.C0:lerp(CF(1,-.8- 0.07 * COS(SINE/35) - sick.PlaybackLoudness/1500,-0.3)*ANGLES(RAD(0),RAD(82.1),RAD(0)),Alpha)
			elseif sick.PlaybackLoudness > 400 then
				local Alpha = .1
				LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1- 0.07 * COS(SINE/35),0)*ANGLES(RAD(0),RAD(-86.2),RAD(0)),Alpha)
				RightHip.C0 = RightHip.C0:lerp(CF(1,-.8- 0.07 * COS(SINE/35) - sick.PlaybackLoudness/1500,-0.3)*ANGLES(RAD(0),RAD(82.1),RAD(0)),Alpha)
			end
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		--credits to creterisk lol since im a lazy mf
		if ATTACK == false then
			local Alpha = .1
			RootJoint.C0 = RootJoint.C0:lerp(CF(0,0,0 - 0.10 * COS(SINE/(WALKSPEEDVALUE/2)))*ANGLES(RAD(-92+3*SIN(SINE/(WALKSPEEDVALUE/2)))+RAD(TiltVelocity.z)*1,RAD(0),RAD(-180+10*COS(SINE/WALKSPEEDVALUE))),Alpha)
			LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.5,0)*ANGLES(RAD(-25*COS(SINE/WALKSPEEDVALUE))+SIN(SINE/WALKSPEEDVALUE)/2.5,RAD(-90)-RAD(TiltVelocity.X)*0.5,RAD(0)),Alpha)
			RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(25*COS(SINE/WALKSPEEDVALUE))-SIN(SINE/WALKSPEEDVALUE)/2.5,RAD(90)-RAD(TiltVelocity.X)*0.5,RAD(0)),Alpha)
			Neck.C0 =Neck.C0:lerp(CF(0,1,0)*ANGLES(RAD(-90+1.5*COS(SINE/WALKSPEEDVALUE)),RAD(0),RAD(-180-10*COS(SINE/WALKSPEEDVALUE))-RAD(TiltVelocity.x)*3),Alpha)
			LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1+0.35*COS(SINE/WALKSPEEDVALUE)/2,0-0.5*COS(SINE/WALKSPEEDVALUE)/2)*ANGLES(RAD(-5+15*COS(SINE/WALKSPEEDVALUE))+RootPart.RotVelocity.Y/75+SIN(SINE/WALKSPEEDVALUE)/2.5*-RAD(TiltVelocity.z)*10,RAD(-90-5*COS(SINE/WALKSPEEDVALUE)),RAD(0))--[[*ANGLES(RAD(0-2*COS(SINE/WALKSPEEDVALUE)),RAD(0),RAD(0+25*SIN(SINE/WALKSPEEDVALUE)*RAD(TiltVelocity.x)*5.5))]],Alpha)
			RightHip.C0 = RightHip.C0:lerp(CF(1,-1-0.35*COS(SINE/WALKSPEEDVALUE)/2,0+0.5*COS(SINE/WALKSPEEDVALUE)/2)*ANGLES(RAD(-5-15*COS(SINE/WALKSPEEDVALUE))-RootPart.RotVelocity.Y/-75+-SIN(SINE/WALKSPEEDVALUE)/2.5*-RAD(TiltVelocity.z)*10,RAD(90-5*COS(SINE/WALKSPEEDVALUE)),RAD(0))--[[* ANGLES(RAD(0+2*COS(SINE/WALKSPEEDVALUE)),RAD(0),RAD(0+25*SIN(SINE/WALKSPEEDVALUE)*-RAD(TiltVelocity.x)*5.5))]],Alpha)
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
	sick.SoundId = "rbxassetid://5410083226"
	sick.Looped = true
	sick.Pitch = PITCH
	sick.Volume = VOL
	sick.Playing = true
end

--//=================================\\
--\\=================================//





--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--