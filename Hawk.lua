local lplr = game.Players.LocalPlayer
local Player = lplr
local Character = Player.Character
local Mouse = Player:GetMouse()

--//====================================================\\--
--||			   CREATED BY SHACKLUSTER
--\\====================================================//--
	
wait(0.2)
Cam = workspace.CurrentCamera

if lplr == Player then
	Cam.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
end
if lplr == Player then
	game:GetService("RunService").RenderStepped:Connect(function()
		Player.Character = Character
		Cam.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
	end)
end
Character.Parent = workspace

PlayerGui = Player.PlayerGui
Backpack = Player.Backpack
Humanoid = Character.Humanoid
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local MOUSEPOS = RootPart.Position
local TIME = 0
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
--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

Animation_Speed = 3
Frame_Speed = 0.016666666666666666
local FORCERESET = false
Frame_Speed = 1 / 80 -- (1 / 60) OR (1 / 80)
local Speed = 25
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local BMUSIC = IT("Sound", RootPart)
local VOLUME = 5
local PITCH = 0.7
local SONGID = 1074189000
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Type = "Ban"
local reason = "Ur damn skids kid"
local Rooted = false
local SINE = 0
local SIZE = 1
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
WEAPONGUI.Name = "BanishV3Gui"
local Characterb = IT("Model")
Characterb.Name = "shackisgaylol"
local CharacterA = IT("Model")
CharacterA.Name = "shackismegagaylol"
local Effects = IT("Folder", CharacterA)
Effects.Name = "Effects"
local Effects2 = IT("Folder", Characterb)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
local UNANCHOR = true
local TOBANISH = {}

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

local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
wait()



for i,v in pairs(Character:GetDescendants()) do
	if v.Name == "a" and v.Parent.Name == "Torso" then
		v.BrickColor = BrickColor.new("Really black")
		wait(0.05)
		MAINCOLOR = v.Color
	end
end


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

function CreateWeld(parent,part0,part1,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za)
local weld = Instance.new("Weld")
weld.Parent = parent
weld.Part0 = part0
weld.Part1 = part1
weld.C1 = CFrame.new(C1X,C1Y,C1Z)*CFrame.Angles(C1Xa,C1Ya,C1Za)
weld.C0 = CFrame.new(C0X,C0Y,C0Z)*CFrame.Angles(C0Xa,C0Ya,C0Za)
return weld
end

--NewSound({ID = 0,PARENT = ROOT,VOLUME = 0.5,PITCH = 1,LOOP = false,MAXDISTANCE = 1000,EMITTERSIZE = 10,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or RootPart)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
		return SOUND
	end
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
			repeat wait(1) until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
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

function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0.5, "Persimmon", "Trail", VT(0,0,0))
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = VT(0.5,DIST,0.5)
	else
		TRAIL.Size = VT(0.25,DIST,0.25)
	end
	TRAIL.CFrame = CF(FROM, TO) * CF(0, 0, -DIST/2) * ANGLES(RAD(90),RAD(0),RAD(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 10 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.008
			TRAIL.Size = TRAIL.Size + VT(0.08,0,0.08)
		end
		TRAIL:remove()
	end))
end

function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function MagicSphereCo(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function MagicBlock(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "ForceField", 0, 0.5, BRICKC(COLOR), "Effect", VT(SIZE,SIZE,SIZE), true)
	local mesh = IT("BlockMesh",wave)
	wave.CFrame = CFRAME * ANGLES(RAD(math.random(-360,360)),RAD(math.random(-360,360)),RAD(math.random(-360,360)))
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.CFrame = CFRAME * ANGLES(RAD(math.random(-360,360)),RAD(math.random(-360,360)),RAD(math.random(-360,360)))
			wave.Transparency = wave.Transparency + (0.5/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function CreateRing(SIZE, DOESROT, ROT, WAIT, CFRAME, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0, 0, 0))
	local mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "559831844", "", SIZE, VT(0, 0, 0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0, ROT, 0)
			end
			wave.Transparency = wave.Transparency + 0.5 / WAIT
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

local DECAL = IT("Decal")
function MagicRing()
	local RING = CreatePart(3, Effects, "Granite", 0, 1, "Maroon", "MagicRing", VT(0,0,0),true)
	local MESH = IT("BlockMesh",RING)
	local BOTTOMTEXTURE = DECAL:Clone()
	BOTTOMTEXTURE.Parent = RING
	BOTTOMTEXTURE.Face = "Bottom"
	BOTTOMTEXTURE.Name = "BottomTexture"
	local TOPTEXTURE = DECAL:Clone()
	TOPTEXTURE.Parent = RING
	TOPTEXTURE.Face = "Top"
	TOPTEXTURE.Name = "TopTexture"
	BOTTOMTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	TOPTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	BOTTOMTEXTURE.Color3 = C3(0,0,0)
	TOPTEXTURE.Color3 = C3(1,1,1)
	return RING,MESH,TOPTEXTURE,BOTTOMTEXTURE
end

Debris = game:GetService("Debris")

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end

--//=================================\\
--||	     WEAPON CREATION
--\\=================================//

local top = Instance.new("Shirt")
top.ShirtTemplate = "rbxassetid://4223671783"
top.Parent = Character
top.Name = "Cloth"
local bottom = Instance.new("Pants")
bottom.PantsTemplate = "rbxassetid://4094324321"
bottom.Parent = Character
bottom.Name = "Cloth"

--usedmostly on shackluster edits and shit
---------------------------------Weapon/armor creation------------------------

function WWeld(a, b, acf)
    local we = Instance.new("Weld", a)
    we.Part0 = a
    we.Part1 = b
if acf ~= nil then
    we.C0 = acf
end
end

for i = 1,10 do
wait()
end

--TORSO = script.Torso

--TORSO.Parent = Character

--WWeld(TORSO.Torso,Torso, CF(0, 0, 0)*ANGLES(RAD(176),RAD(359),RAD(180)), CF(0, 0, 0)
-------------------------------------------------------------------------------------------

local Hole = RightArm
local Particle = IT("ParticleEmitter",nil)
Particle.Enabled = false
Particle.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})
Particle.LightEmission = 0.5
Particle.Rate = 150
Particle.ZOffset = 0.2
Particle.Rotation = NumberRange.new(-180, 180)
Particle.RotSpeed = NumberRange.new(-180, 180)
Particle.Texture = "http://www.roblox.com/asset/?id=304437537"
Particle.Color = ColorSequence.new(C3(1,1,1),C3(0,0,0))

--ParticleEmitter({Speed = 5, Drag = 0, Size1 = 1, Size2 = 5, Lifetime1 = 1, Lifetime2 = 1.5, Parent = Torso, Emit = 100, Offset = 360, Enabled = false})
function ParticleEmitter(Table)
	local PRTCL = Particle:Clone()
	local Speed = Table.Speed or 5
	local Drag = Table.Drag or 0
	local Size1 = Table.Size1 or 1
	local Size2 = Table.Size2 or 5
	local Lifetime1 = Table.Lifetime1 or 1
	local Lifetime2 = Table.Lifetime2 or 1.5
	local Parent = Table.Parent or Torso
	local Emit = Table.Emit or 100
	local Offset = Table.Offset or 360
	local Acel = Table.Acel or VT(0,0,0)
	local Enabled = Table.Enabled or false
	PRTCL.Parent = Parent
	PRTCL.Size = NumberSequence.new(Size1,Size2)
	PRTCL.Lifetime = NumberRange.new(Lifetime1,Lifetime2)
	PRTCL.Speed = NumberRange.new(Speed)
	PRTCL.VelocitySpread = Offset
	PRTCL.Drag = Drag
	PRTCL.Acceleration = Acel
	if Enabled == false then
		PRTCL:Emit(Emit)
		Debris:AddItem(PRTCL,Lifetime2)
	else
		PRTCL.Enabled = true
	end
	return PRTCL
end

ParticleEmitter({Speed = 5, Drag = 0, Size1 = 1, Size2 = 5, Lifetime1 = 1, Lifetime2 = 1.5, Parent = Torso, Emit = 100, Offset = 360, Enabled = false})

for _, c in pairs(CharacterA:GetChildren()) do
	if c.ClassName == "Part" then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

CharacterA.Parent = Character

Characterb.Parent = Character


local SKILLTEXTCOLOR = C3(1,1,1)
local SKILLFONT = ""
local SKILLTEXTSIZE = 7

local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
	if c:IsA("BasePart") and c.Name ~= "Handle" then
		if c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and c ~= LeftLeg then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(BODY, {
			c,
			c.Parent,
			c.Material,
			c.Color,
			c.Transparency,
			c.Size,
			c.Name
		})
	elseif c:IsA("JointInstance") or c:IsA("Shirt") or c:IsA("Pants") then
		table.insert(BODY, {
			c,
			c.Parent,
			nil,
			nil,
			nil,
			nil,
			nil
		})
	end
end
function refit()
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
					Humanoid = IT("Humanoid", Character)
				end
			end
		end
	end
end
Humanoid.Died:connect(function()
	refit()
end)

--[[local SKILL1FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.1, 0, 0.90, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 1 Frame")
local SKILL2FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.63, 0, 0.90, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 2 Frame")
local SKILL3FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.215, 0, 0.90, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 3 Frame")
local SKILL4FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.525, 0, 0.90, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 4 Frame")
local SKILL5FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.365, 0, 0.90, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "Skill 5 Frame")
]]
--[[local SKILL1TEXT = CreateLabel(SKILL1FRAME, "[Z] Banish Bullet", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.7, "Text 1")
local SKILL2TEXT = CreateLabel(SKILL2FRAME, "[B] Ability 2", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.7, "Text 2")
local SKILL3TEXT = CreateLabel(SKILL3FRAME, "[C] Ability 3", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.7, "Text 3")
local SKILL4TEXT = CreateLabel(SKILL4FRAME, "[V] Ability 4", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.7, "Text 4")
local SKILL5TEXT = CreateLabel(SKILL5FRAME, "[X] Mercy", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.7, "Text 5")
]]

function chatfunc(text)
	local chat = coroutine.wrap(function()
	if Character:FindFirstChild("TalkingBillBoard")~= nil then
		Character:FindFirstChild("TalkingBillBoard"):destroy()
	end
	local Bill = Instance.new("BillboardGui",Character)
	Bill.Size = UDim2.new(0,100,0,40)
	Bill.StudsOffset = Vector3.new(0,3,0)
	Bill.Adornee = Character.Head
	Bill.Name = "TalkingBillBoard"
	local Hehe = Instance.new("TextLabel",Bill)
	Hehe.BackgroundTransparency = 1
	Hehe.BorderSizePixel = 0
	Hehe.Text = ""
	Hehe.Font = "SourceSansItalic"
	Hehe.TextSize = 40
	Hehe.TextStrokeTransparency = 0
	Hehe.Size = UDim2.new(1,0,0.5,0)
	coroutine.resume(coroutine.create(function()
		while Hehe ~= nil do
			Swait()	
			Hehe.Position = UDim2.new(math.random(-.4,.4),math.random(-5,5),.05,math.random(-5,5))	
			Hehe.Rotation = math.random(-5,5)
			Hehe.TextColor3 = Color3.new(0,0,0)
			Hehe.TextStrokeColor3 = Color3.new(1,1,1)
		end
	end))
	for i = 1,string.len(text),1 do
		Swait()
		Hehe.Text = string.sub(text,1,i)
	end
	Swait(90)--Re[math.random(1, 93)]
	for i = 0, 1, .025 do
		Swait()
		Bill.ExtentsOffset = Vector3.new(math.random(-i, i), math.random(-i, i), math.random(-i, i))
		Hehe.TextStrokeTransparency = i
		Hehe.TextTransparency = i
	end
	Bill:Destroy()
	end)
chat()
end

function onChatted(msg)
	chatfunc(msg)
end

Player.Chatted:connect(onChatted)

function printbye(Name)
	local MESSAGES = {"You cannot struggle, ","Your existance is an insult, ","Fade, ","Your existance is not desired, ","You are not permitted here, ","You are not to decide your fate, ","Be gone, ","You are already dead, ","Your live is an anomaly, ","Don't dare to return, ","Why are you resisting, ","You cannot exist here, ","Why are you struggling, ","Your fate was already decided, ","Goodbye, ","You cannot ignore my command, ","You cannot resist my command, ","You already died, "}
	chatfunc(MESSAGES[MRANDOM(1,#MESSAGES)]..Name..".")	
end

workspace.ChildAdded:connect(function(instance)
    for BANISH = 1, #TOBANISH do
		if TOBANISH[BANISH] ~= nil then
			if instance.Name == TOBANISH[BANISH] then
				coroutine.resume(coroutine.create(function()
					printbye(instance.Name)
					instance:ClearAllChildren()
					Debris:AddItem(instance,0.0005)
				end))
			end
		end
	end
end)

--//=================================\\
--||			DAMAGING
--\\=================================//

function Banish(Foe)
	if Foe then
		coroutine.resume(coroutine.create(function()
			--if game.Players:FindFirstChild(Foe.Name) then
				table.insert(TOBANISH,Foe.Name)
				printbye(Foe.Name)
			--end
			Foe.Archivable = true
			local CLONE = Foe:Clone()
			Foe:Destroy()
			CLONE.Parent = Effects
			CLONE:BreakJoints()
			local MATERIALS = {"Glass","Neon"}
			for _, c in pairs(CLONE:GetDescendants()) do
				if c:IsA("BasePart") then
					if c.Name == "Torso" or c.Name == "UpperTorso" or c == CLONE.PrimaryPart then
 						CreateSound(340722848, c, 10, 1, false)
					end
					c.Anchored = true
					c.Transparency = c.Transparency + 0.2
					c.Material = MATERIALS[MRANDOM(1,2)]
					c.Color = C3(1,1,1)
					if c.ClassName == "MeshPart" then
						c.TextureID = ""
					end
					if c:FindFirstChildOfClass("SpecialMesh") then
						c:FindFirstChildOfClass("SpecialMesh").TextureId = ""
					end
					if c:FindFirstChildOfClass("Decal") then
						c:FindFirstChildOfClass("Decal"):remove()
					end
					c.Name = "Banished"
					c.CanCollide = false
				else
					c:remove()
				end
			end
			local A = false
			for i = 1, 35 do
				if A == false then
					A = true
				elseif A == true then
					A = false
				end
				for _, c in pairs(CLONE:GetDescendants()) do
					if c:IsA("BasePart") then
						c.Anchored = true
						c.Material = MATERIALS[MRANDOM(1,2)]
						c.Transparency = c.Transparency + 0.8/35
						if A == false then
							c.CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)
						elseif A == true then
							c.CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)						
						end
					end
				end
				Swait()
			end
			CLONE:remove()
		end))
	end
end

function ApplyAoE(POSITION,RANGE,ISBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if ISBANISH == true then
							Banish(CHILD)
						else
							if ISBANISH == "Gravity" then
								HUM.PlatformStand = true
								if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
									local grav = Instance.new("BodyPosition",TORSO)
									grav.D = 15
									grav.P = 20000
									grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
									grav.position = TORSO.Position
									grav.Name = "V3BanishForce"..Player.Name
								else
									TORSO:FindFirstChild("V3BanishForce"..Player.Name).position = TORSO.Position+VT(0,0.3,0)
									TORSO.RotVelocity = VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25))
								end
							else
								HUM.PlatformStand = false
							end
						end
					elseif ISBANISH == "Gravity" then
						if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
							TORSO:FindFirstChild("V3BanishForce"..Player.Name):remove()
							HUM.PlatformStand = false
						end
					end
				end
			end
		end
	end
end


function ManualDamage(Humanoid,Damage,TorsoPart)
	local defence = Instance.new("BoolValue",Humanoid.Parent)
	defence.Name = ("HitBy"..Player.Name)
	game:GetService("Debris"):AddItem(defence, 0.001)
	Damage = Damage * DAMAGEMULTIPLIER
	if Humanoid.Health ~= 0 then
		local CritChance = MRANDOM(1,100)
		if Damage > Humanoid.Health then
			Damage = math.ceil(Humanoid.Health)
			if Damage == 0 then
				Damage = 0.1
			end
		end
		Humanoid.Health = Humanoid.Health - Damage
	end
end

local asd = Instance.new("ParticleEmitter")
asd.Color = ColorSequence.new(Color3.new(0.5, 0, 0), Color3.new(.3, 0, 0))
asd.LightEmission = .1
asd.Texture = "http://www.roblox.com/asset/?ID=291880914"
aaa = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6),NumberSequenceKeypoint.new(1, 2)})
bbb = NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(0.0636, 0), NumberSequenceKeypoint.new(1, 1)})
asd.Transparency = bbb
asd.Size = aaa
asd.ZOffset = .9
asd.Acceleration = Vector3.new(0, -15, 0)
asd.LockedToPart = false
asd.EmissionDirection = "Back"
asd.Lifetime = NumberRange.new(1, 2)
asd.Rotation = NumberRange.new(-100, 100)
asd.RotSpeed = NumberRange.new(-100, 100)
asd.Speed = NumberRange.new(10)
asd.Enabled = false
asd.VelocitySpread = 999

function getbloody(victim,amount)
	local PART = CreatePart(3, Effects, "Metal", 0, 1, "Mid gray", "Blood", victim.Size)
	PART.CFrame = victim.CFrame
	local HITPLAYERSOUNDS = {"2731462191"}
	Debris:AddItem(PART,5)
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, 2)
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, 2)
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, 2)
end

function ManualAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character and CHILD.Parent ~= Effects then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if INSTAKILL == true then
							CHILD:BreakJoints()
						else
							local DMG = MRANDOM(MINDMG,MAXDMG)
							ManualDamage(HUM,DMG,TORSO)
						end
						if FLING > 0 then
							for _, c in pairs(CHILD:GetChildren()) do
								if c:IsA("BasePart") then
									local bv = Instance.new("BodyVelocity") 
									bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
									bv.velocity = CF(POSITION,TORSO.Position).lookVector*FLING
									bv.Parent = c
									Debris:AddItem(bv,0.05)
								end
							end
						end
					end
				end
			end
		end
	end
end

function Dismember(MAN,DOWHAT)
	for index, CHILD in pairs(MAN:GetDescendants()) do
		if CHILD:IsA("Script") or CHILD:IsA("LocalScript") then
			CHILD:Destroy()
		end
	end
	if DOWHAT == "Ragdoll" then
		local HUM = MAN:FindFirstChildOfClass("Humanoid")
		if HUM then
			HUM.Health = 0
		end
		if MAN:FindFirstChild("UpperTorso") then
			local SCRIPT = script.R15Ragdoll:Clone()
			SCRIPT.Parent = MAN
			SCRIPT.Disabled = false
		else
			local SCRIPT = script.R6Ragdoll:Clone()
			SCRIPT.Parent = MAN
			SCRIPT.Disabled = false
		end
		MAN:BreakJoints()
	else
		local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
		local HED = MAN:FindFirstChild("Head")
		if TORSO and HED then
			if DOWHAT == "Head" then
				if TORSO:FindFirstChild("TorsoA4") then
					TORSO:FindFirstChild("TorsoA4"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintHead") then
					MAN:FindFirstChild("RagdollConstraintHead"):Remove()
				end
				HED:BreakJoints()
			elseif DOWHAT == "RightArm" then
				if TORSO:FindFirstChild("TorsoA3") then
					TORSO:FindFirstChild("TorsoA3"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintRightUpperArm") then
					MAN:FindFirstChild("RagdollConstraintRightUpperArm"):Remove()
				end
			elseif DOWHAT == "LeftArm" then
				if TORSO:FindFirstChild("TorsoA2") then
					TORSO:FindFirstChild("TorsoA2")
				elseif MAN:FindFirstChild("RagdollConstraintLeftUpperArm") then
					MAN:FindFirstChild("RagdollConstraintLeftUpperArm"):Remove()
				end
			elseif DOWHAT == "Legs" then
				if TORSO.Name == "Torso" then
					if TORSO:FindFirstChild("TorsoA") then
						TORSO:FindFirstChild("TorsoA"):Remove()
					end
					if TORSO:FindFirstChild("TorsoA1") then
						TORSO:FindFirstChild("TorsoA1"):Remove()
					end
				elseif MAN:FindFirstChild("RagdollConstraintUpperTorso") then
					MAN:FindFirstChild("RagdollConstraintUpperTorso"):Remove()
				end
			end
		end
	end
end

function AttachmentCFrame(A)
	return A.Parent.CFrame*CF(A.Position)
end

function R15Ragdoll(character,KeepArms)
	character:BreakJoints()
	coroutine.resume(coroutine.create(function()
		recurse(character, function(_,v)
			if v:IsA("Attachment") then
				v.Axis = Vector3.new(0, 1, 0)
				v.SecondaryAxis = Vector3.new(0, 0, 1)
				v.Rotation = Vector3.new(0, 0, 0)
			end
		end)
		for _,child in next,character:GetChildren() do
			if child:IsA("Accoutrement") then
				for _,part in next,child:GetChildren() do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						local attachment1 = part:FindFirstChildOfClass("Attachment")
						local attachment0 = getAttachment0(character,attachment1.Name)
						if attachment0 and attachment1 then
							local constraint = Instance.new("HingeConstraint")
							constraint.Attachment0 = attachment0
							constraint.Attachment1 = attachment1
							constraint.LimitsEnabled = true
							constraint.UpperAngle = 0
							constraint.LowerAngle = 0
							constraint.Parent = character
						end
						ArtificialHitbox(part)
					elseif part.Name == "HumanoidRootPart" then
						part:remove()
					end
				end
			end
		end
		
		ragdollJoint(character,character.LowerTorso, character.UpperTorso, "Waist", "BallSocket", {
			{"LimitsEnabled",true};
			{"UpperAngle",5};
		})
		if character:FindFirstChild("Head") then
			ragdollJoint(character,character.UpperTorso, character.Head, "Neck", "BallSocket", {
				{"LimitsEnabled",true};
				{"UpperAngle",15};
			})
		end
		
		local handProperties = {
			{"LimitsEnabled", true};
			{"UpperAngle",0};
			{"LowerAngle",0};
		}
		ragdollJoint(character,character.LeftLowerArm, character.LeftHand, "LeftWrist", "Hinge", handProperties)
		ragdollJoint(character,character.RightLowerArm, character.RightHand, "RightWrist", "Hinge", handProperties)
		
		local shinProperties = {
			{"LimitsEnabled", true};
			{"UpperAngle", 0};
			{"LowerAngle", -75};
		}
		ragdollJoint(character,character.LeftUpperLeg, character.LeftLowerLeg, "LeftKnee", "Hinge", shinProperties)
		ragdollJoint(character,character.RightUpperLeg, character.RightLowerLeg, "RightKnee", "Hinge", shinProperties)
		
		local footProperties = {
			{"LimitsEnabled", true};
			{"UpperAngle", 15};
			{"LowerAngle", -45};
		}
		ragdollJoint(character,character.LeftLowerLeg, character.LeftFoot, "LeftAnkle", "Hinge", footProperties)
		ragdollJoint(character,character.RightLowerLeg, character.RightFoot, "RightAnkle", "Hinge", footProperties)
		if KeepArms == true then
			ragdollJoint(character,character.UpperTorso, character.RightUpperArm, "RightShoulder", "BallSocket")
			ragdollJoint(character,character.RightUpperArm, character.RightLowerArm, "RightElbow", "BallSocket")
			ragdollJoint(character,character.UpperTorso, character.LeftUpperArm, "LeftShoulder", "BallSocket")
			ragdollJoint(character,character.LeftUpperArm, character.LeftLowerArm, "LeftElbow", "BallSocket")
		end
		ragdollJoint(character,character.LowerTorso, character.LeftUpperLeg, "LeftHip", "BallSocket")
		ragdollJoint(character,character.LowerTorso, character.RightUpperLeg, "RightHip", "BallSocket")
		Debris:AddItem(character,5)
	end))
end

function Ragdoll(Character2,CharTorso,KeepArms)
	coroutine.resume(coroutine.create(function()
		Character2:BreakJoints()
		local hum = Character2:findFirstChild("Humanoid")
		hum:remove()
		local function Scan(ch)
			local e
			for e = 1,#ch do
				Scan(ch[e]:GetChildren())
				if ch[e].ClassName == "Weld" or ch[e].ClassName == "Motor6D" then
					ch[e]:remove()
				end
			end
		end
		local NEWHUM = IT("Humanoid")
		NEWHUM.Name = "Corpse"
		NEWHUM.Health = 0
		NEWHUM.MaxHealth = 0
		NEWHUM.PlatformStand = true
		NEWHUM.Parent = Character2
		NEWHUM.DisplayDistanceType = "None"
	
		local ch = Character2:GetChildren()
		local i
		for i = 1,#ch do
			if ch[i].Name == "THandle1" or ch[i].Name == "THandle2" then
				ch[i]:remove()
			end
		end
	
		local Torso2 = Character2.Torso
		local movevector = Vector3.new()
	
		if Torso2 then
			movevector = CFrame.new(CharTorso.Position,Torso2.Position).lookVector
			local Head = Character2:FindFirstChild("Head")
			if Head then
				local Neck = Instance.new("Weld")
				Neck.Name = "Neck"
				Neck.Part0 = Torso2
				Neck.Part1 = Head
				Neck.C0 = CFrame.new(0, 1.5, 0)
				Neck.C1 = CFrame.new()
				Neck.Parent = Torso2
	
			end
			local Limb = Character2:FindFirstChild("Right Arm")
			if Limb and KeepArms == true then
	
				Limb.CFrame = Torso2.CFrame * CFrame.new(1.5, 0, 0)
				local Joint = Instance.new("Glue")
				Joint.Name = "RightShoulder"
				Joint.Part0 = Torso2
				Joint.Part1 = Limb
				Joint.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				Joint.C1 = CFrame.new(-0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				Joint.Parent = Torso2
	
				local B = Instance.new("Part")
				B.TopSurface = 0
				B.BottomSurface = 0
				B.formFactor = "Symmetric"
				B.Size = Vector3.new(1, 1, 1)
				B.Transparency = 1
				B.CFrame = Limb.CFrame * CFrame.new(0, -0.5, 0)
				B.Parent = Character2
				local W = Instance.new("Weld")
				W.Part0 = Limb
				W.Part1 = B
				W.C0 = CFrame.new(0, -0.5, 0)
				W.Parent = Limb
	
			end
			local Limb = Character2:FindFirstChild("Left Arm")
			if Limb and KeepArms == true then
	
				Limb.CFrame = Torso2.CFrame * CFrame.new(-1.5, 0, 0)
				local Joint = Instance.new("Glue")
				Joint.Name = "LeftShoulder"
				Joint.Part0 = Torso2
				Joint.Part1 = Limb
				Joint.C0 = CFrame.new(-1.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				Joint.C1 = CFrame.new(0, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				Joint.Parent = Torso2
	
				local B = Instance.new("Part")
				B.TopSurface = 0
				B.BottomSurface = 0
				B.formFactor = "Symmetric"
				B.Size = Vector3.new(1, 1, 1)
				B.Transparency = 1
				B.CFrame = Limb.CFrame * CFrame.new(0, -0.5, 0)
				B.Parent = Character2
				local W = Instance.new("Weld")
				W.Part0 = Limb
				W.Part1 = B
				W.C0 = CFrame.new(0, -0.5, 0)
				W.Parent = Limb
	
			end
			local Limb = Character2:FindFirstChild("Right Leg")
			if Limb then
	
				Limb.CFrame = Torso2.CFrame * CFrame.new(0.5, -2, 0)
				local Joint = Instance.new("Glue")
				Joint.Name = "RightHip"
				Joint.Part0 = Torso2
				Joint.Part1 = Limb
				Joint.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				Joint.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
				Joint.Parent = Torso2
	
				local B = Instance.new("Part")
				B.TopSurface = 0
				B.BottomSurface = 0
				B.formFactor = "Symmetric"
				B.Size = Vector3.new(1, 1, 1)
				B.Transparency = 1
				B.CFrame = Limb.CFrame * CFrame.new(0, -0.5, 0)
				B.Parent = Character2
				local W = Instance.new("Weld")
				W.Part0 = Limb
				W.Part1 = B
				W.C0 = CFrame.new(0, -0.5, 0)
				W.Parent = Limb
	
			end
			local Limb = Character2:FindFirstChild("Left Leg")
			if Limb then
	
				Limb.CFrame = Torso2.CFrame * CFrame.new(-0.5, -2, 0)
				local Joint = Instance.new("Glue")
				Joint.Name = "LeftHip"
				Joint.Part0 = Torso2
				Joint.Part1 = Limb
				Joint.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				Joint.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
				Joint.Parent = Torso2
	
				local B = Instance.new("Part")
				B.TopSurface = 0
				B.BottomSurface = 0
				B.formFactor = "Symmetric"
				B.Size = Vector3.new(1, 1, 1)
				B.Transparency = 1
				B.CFrame = Limb.CFrame * CFrame.new(0, -0.5, 0)
				B.Parent = Character2
				local W = Instance.new("Weld")
				W.Part0 = Limb
				W.Part1 = B
				W.C0 = CFrame.new(0, -0.5, 0)
				W.Parent = Limb
	
			end
			--[
			local Bar = Instance.new("Part")
			Bar.TopSurface = 0
			Bar.BottomSurface = 0
			Bar.formFactor = "Symmetric"
			Bar.Size = Vector3.new(1, 1, 1)
			Bar.Transparency = 1
			Bar.CFrame = Torso2.CFrame * CFrame.new(0, 0.5, 0)
			Bar.Parent = Character2
			local Weld = Instance.new("Weld")
			Weld.Part0 = Torso2
			Weld.Part1 = Bar
			Weld.C0 = CFrame.new(0, 0.5, 0)
			Weld.Parent = Torso2
			--]]
		end
		Character2.Parent = workspace
		Debris:AddItem(Character2,5)
	
		return Character2,Torso2
	end))
end

local BEANED = {}

function Ban(bitch)	
if bitch then	
g = game.Players:GetPlayers()
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
	tecks2.Font = "SciFi"
	tecks2.TextSize = 30
	tecks2.TextStrokeTransparency = 0
	tecks2.TextColor3 = Color3.new(1,0,0)
	tecks2.TextStrokeColor3 = Color3.new(1,0,0)
	tecks2.Size = UDim2.new(1,0,0.5,0)
	tecks2.Parent = naeeym2
-- CreateSound("2570187601", bitch, 600, 1, false)
local Players = game:GetService("Players")
local fag = Players:FindFirstChild(bitch.Name)
--faggut:Kick()
	if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
	end
		if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
		end
			if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
			end
				if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
				end
					if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
					end
						if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
						end
												if Players:FindFirstChild("Drago_TH") then
						end
						table.insert(BEANED,bitch.name)
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
	--bitch:Remove()
end
end

local function CheckForBan(player)
	for i = 1, #BEANED do
		if player.Name == BEANED[i] then
			player:Kick("Ur mom gay skids") --Ban Reason Change between the '' to change the reason!
		end
	end
end


game.Players.PlayerAdded:connect(function()
	for i,v in pairs(game.Players:GetPlayers())do
		CheckForBan(v)
	end  
end)


function Kick(bitch)
g = game.Players:GetPlayers()
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
	tecks2.Font = "SciFi"
	tecks2.TextSize = 30
	tecks2.TextStrokeTransparency = 0
	tecks2.TextColor3 = Color3.new(1,0,0)
	tecks2.TextStrokeColor3 = Color3.new(1,0,0)
	tecks2.Size = UDim2.new(1,0,0.5,0)
	tecks2.Parent = naeeym2
-- CreateSound("2570187601", bitch, 600, 1, false)
local Players = game:GetService("Players")
local fag = Players:FindFirstChild(bitch.Name)
--faggut:Kick()
	if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
	end
		if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
		end
			if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
			end
				if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
				end
					if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
					end
						if Players:FindFirstChild(bitch.Name) then
	fag:Kick(reason)
	end
	--[[
		for i,v in pairs(fag.Name) do
		if (v:lower() == newPlayer.Name:lower()) then
			newPlayer:Remove()
		end
	end]]--
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
	--bitch:Remove()
end


function ApplyAoE(POSITION,RANGE,ISBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if ISBANISH == true then
							Banish(CHILD)
						else
							if ISBANISH == "Gravity" then
								HUM.PlatformStand = true
								if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
									local grav = Instance.new("BodyPosition",TORSO)
									grav.D = 15
									grav.P = 20000
									grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
									grav.position = TORSO.Position
									grav.Name = "V3BanishForce"..Player.Name
								else
									TORSO:FindFirstChild("V3BanishForce"..Player.Name).position = TORSO.Position+VT(0,0.3,0)
									TORSO.RotVelocity = VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25))
								end
							else
								HUM.PlatformStand = false
							end
						end
					elseif ISBANISH == "Gravity" then
						if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
							TORSO:FindFirstChild("V3BanishForce"..Player.Name):remove()
							HUM.PlatformStand = false
						end
					end
				end
			end
		end
	end
end

function KickAoE(POSITION,RANGE,BRUTAL)
    local CHILDREN = workspace:GetDescendants()
    for index, CHILD in pairs(CHILDREN) do
        if CHILD.ClassName == "Model" and CHILD ~= Character then
            local HUM = CHILD:FindFirstChildOfClass("Humanoid")
            if HUM then
                local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
                if TORSO then
                    if (TORSO.Position - POSITION).Magnitude <= RANGE then
                        if BRUTAL == true then
	if Type == "Banish" then
                            KickThatNigger(CHILD)
	elseif Type == "Ban" then
		Ban(CHILD)
	elseif Type == "Kick" then
		Kick(CHILD)
			--elseif Type == "Tangle" then
		--Entangle(CHILD)
		end
                        else
                            CHILD:BreakJoints()
                        end
                    end
                end
            end
        end
    end
end

local PE=Instance.new("ParticleEmitter",art)
PE.LightEmission=.8
PE.Color = ColorSequence.new(BRICKC("Really red").Color)
PE.Lifetime=NumberRange.new(0.35,1.5)
PE.Rotation=NumberRange.new(0,360)
PE.Rate=999
PE.VelocitySpread = 10000
PE.Acceleration = Vector3.new(0,0,0)
PE.Drag = 5
PE.Speed = NumberRange.new(0,0,0)
PE.Texture="http://www.roblox.com/asset/?id=833874434"
PE.ZOffset = -1.5
PE.Name = "PE"
PE.Enabled = false

function particles(art)
	local PARTICLES = PE:Clone()
	PARTICLES.Parent = art
end

function KillChildren(v)
	v:BreakJoints()
	for _, c in pairs(v:GetChildren()) do
		if c.ClassName == "Part" or c.ClassName == "MesPart" then
			if c.Transparency < 1 then
				if c:FindFirstChildOfClass("Decal") then
					c:FindFirstChildOfClass("Decal"):remove()
				end
				particles(c)
				c.PE.Enabled = true
				c.Parent = Effects
				c.CanCollide = false
				c.Material = "Neon"
				c.Color = C3(1,0,0)
				c.Transparency = 0
				local grav = Instance.new("BodyPosition",c)
				grav.P = 20000
				grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
				grav.position = c.Position + VT(MRANDOM(-0.1,0.1),MRANDOM(-0.1,0.1),MRANDOM(-0.1,0.1))
				grav.Name = "GravityForce"
				coroutine.resume(coroutine.create(function()
				for i = 1, 50 do
					Swait()
					c.Transparency = c.Transparency + 0.01
				end
				c.PE.Enabled = false
				Debris:AddItem(c,2)
				end))
			end
		end
	end
end

function killnearest(position,range)
	for i,v in ipairs(workspace:GetChildren()) do
	local body = v:GetChildren()
		for part = 1, #body do
			if((body[part].ClassName == "Part" or body[part].ClassName == "MeshPart") and v ~= Character) then
				if(body[part].Position - position).Magnitude < range then
					if v.ClassName == "Model" then
						KillChildren(v)
					end
				end
			end
		end
	end
end

function Dismember(MAN,DOWHAT)
	for index, CHILD in pairs(MAN:GetDescendants()) do
		if CHILD:IsA("Script") or CHILD:IsA("LocalScript") then
			CHILD:Destroy()
		end
	end
	if DOWHAT == "Ragdoll" then
		local HUM = MAN:FindFirstChildOfClass("Humanoid")
		if HUM then
			HUM.Health = 0
		end
		if MAN:FindFirstChild("UpperTorso") then
			local SCRIPT = script.R15Ragdoll:Clone()
			SCRIPT.Parent = MAN
			SCRIPT.Disabled = false
		else
			local SCRIPT = script.R6Ragdoll:Clone()
			SCRIPT.Parent = MAN
			SCRIPT.Disabled = false
		end
		MAN:BreakJoints()
	else
		local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
		local HED = MAN:FindFirstChild("Head")
		if TORSO and HED then
			if DOWHAT == "Head" then
				if TORSO:FindFirstChild("TorsoA4") then
					TORSO:FindFirstChild("TorsoA4"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintHead") then
					MAN:FindFirstChild("RagdollConstraintHead"):Remove()
				end
				HED:BreakJoints()
			elseif DOWHAT == "RightArm" then
				if TORSO:FindFirstChild("TorsoA3") then
					TORSO:FindFirstChild("TorsoA3"):Remove()
				elseif MAN:FindFirstChild("RagdollConstraintRightUpperArm") then
					MAN:FindFirstChild("RagdollConstraintRightUpperArm"):Remove()
				end
			elseif DOWHAT == "LeftArm" then
				if TORSO:FindFirstChild("TorsoA2") then
					TORSO:FindFirstChild("TorsoA2")
				elseif MAN:FindFirstChild("RagdollConstraintLeftUpperArm") then
					MAN:FindFirstChild("RagdollConstraintLeftUpperArm"):Remove()
				end
			elseif DOWHAT == "Legs" then
				if TORSO.Name == "Torso" then
					if TORSO:FindFirstChild("TorsoA") then
						TORSO:FindFirstChild("TorsoA"):Remove()
					end
					if TORSO:FindFirstChild("TorsoA1") then
						TORSO:FindFirstChild("TorsoA1"):Remove()
					end
				elseif MAN:FindFirstChild("RagdollConstraintUpperTorso") then
					MAN:FindFirstChild("RagdollConstraintUpperTorso"):Remove()
				end
			end
		end
	end
end

function ManSlaughter(MAN)
	if MAN then
		local ROOT = MAN:FindFirstChild("HumanoidRootPart")
		if ROOT then
			ROOT:Remove()
		end
		local MANHUM = MAN:FindFirstChildOfClass("Humanoid")
		if MANHUM then
			MANHUM.BreakJointsOnDeath = false
			MANHUM.Health = 0
		end
		if MAN:FindFirstChild("R6Ragdoll") == nil and MAN:FindFirstChild("R15Ragdoll") == nil then
			if MAN:FindFirstChild("UpperTorso") then
				local SCRIPT = script.R15Ragdoll:Clone()
				SCRIPT.Parent = MAN
				SCRIPT.Disabled = false
			else
				local SCRIPT = script.R6Ragdoll:Clone()
				SCRIPT.Parent = MAN
				SCRIPT.Disabled = false
			end
			local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
			if TORSO then
				NewSound({ID = 146594648,PARENT = TORSO,VOLUME = 1,PITCH = MRANDOM(8,12)/10,LOOP = false,MAXDISTANCE = 75,EMITTERSIZE = 15,PLAYING = true,PLAYONREMOVE = false,DOESDEBRIS = true})
			end
		end
		MAN:BreakJoints()
		if MAN:FindFirstChild("Slaughtered") == nil then
			local MARK = IT("Folder",MAN)
			MARK.Name = "Slaughtered"
		else
			if MAN:FindFirstChild("Slaughtered") then
				local TORSO = MAN:FindFirstChild("Torso") or MAN:FindFirstChild("UpperTorso")
				if TORSO then
					TORSO.RotVelocity = VT(0,MRANDOM(-25,25),0)
				end
			end
		end
	end
end

function ApplyDamage2(Humanoid,Damage,OneShot)
	Damage = Damage * DAMAGEMULTIPLIER
	local DEAD = false
	if Humanoid.Health < 2000 and OneShot == false then
		if Humanoid.Health - Damage > 0 then
			DamageRemote:FireServer("Damage",Humanoid)
		else
			DamageRemote:FireServer("BJoints",Humanoid.Parent)
			DEAD = true
		end
	else
		DEAD = true
		DamageRemote:FireServer("BJoints",Humanoid.Parent)
	end
	if DEAD == true then
		local PARTS = {}
		for index, CHILD in pairs(Humanoid.Parent:GetChildren()) do
			if CHILD:IsA("BasePart") then
				table.insert(PARTS,CHILD)
			end
		end
		coroutine.resume(coroutine.create(function()
			repeat
				Swait()
				local PIECE = nil
				if MRANDOM(1,5) == 1 then
					for E = 1, #PARTS do
						if MRANDOM(1,5) == 1 then
							PIECE = PARTS[E]
							table.remove(PARTS,E)
							break
						end
					end
				end
				if PIECE ~= nil then
					local RandomSize = {VT(6,6,6),VT(10,10,10),VT(20,20,20)}
					if PIECE.Name == "Head" then
						getbloody(PIECE,3)
						WACKYEFFECT({Time = 65, EffectType = "Round Slash", Size = VT(0.3,0,0.3), Size2 = VT(0.4,0,0.4), Transparency = PIECE.Transparency, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), RotationX = MRANDOM(-25,25)/10, RotationY = MRANDOM(-25,25)/10, RotationZ = MRANDOM(-25,25)/10, Material = "Neon", Color = C3(1,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
						WACKYEFFECT({Time = 45, EffectType = "Sphere", Size = VT(4,4,4), Size2 = RandomSize[MRANDOM(1,#RandomSize)], Transparency = 0.5, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), RotationX = MRANDOM(-25,25)/10, RotationY = MRANDOM(-25,25)/10, RotationZ = MRANDOM(-25,25)/10, Material = "Neon", Color = C3(1,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
					else
						getbloody(PIECE,1)
						WACKYEFFECT({Time = 65, EffectType = "Round Slash", Size = VT(0.3,0,0.3), Size2 = VT(0.4,0,0.4), Transparency = PIECE.Transparency, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), MRANDOM(-25,25)/10, RotationY = MRANDOM(-25,25)/10, RotationZ = MRANDOM(-25,25)/10, Material = "Glass", Color = C3(1,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
						WACKYEFFECT({Time = 75, EffectType = "Sphere", Size = VT(4,4,4), Size2 = RandomSize[MRANDOM(1,#RandomSize)], Transparency = 0.5, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), RotationX = MRANDOM(-25,25)/10, RotationY = MRANDOM(-25,25)/10, RotationZ = MRANDOM(-25,25)/10, Material = "Neon", Color = C3(1,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
					end
					DamageRemote:FireServer("Remove",PIECE)
				end
			until #PARTS == 0
		end))
	end
end

function BulletDetection(FROM,TO,BRUTAL)
	local AIMHIT,AIMPOS,NORMAL = CastProperRay(FROM,TO,2000,Character)
	coroutine.resume(coroutine.create(function()
		if AIMHIT ~= nil then
			if AIMHIT.Parent ~= Character then
				if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") or AIMHIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
					if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") then
						if BRUTAL == true then
							if lplr == Player then
		                      DamageRemote:FireServer("C00l",AIMHIT.Parent:FindFirstChildOfClass("Humanoid"))
		                     end
						else
							getbloody(AIMHIT,3)
							AIMHIT.Parent:BreakJoints()
							if AIMHIT.Name == "Head" then
								AIMHIT.Name = "HEADSHOT"
								AIMHIT:remove()
							end
						end
					else
						if BRUTAL == true then
							if lplr == Player then
		                      DamageRemote:FireServer("C00l",AIMHIT.Parent:FindFirstChildOfClass("Humanoid"))
							                     end
						end
					end
				end
			end
		end
	end))
	SpawnTrail(FROM,AIMPOS)
	return AIMHIT,AIMPOS,NORMAL
end

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

function Bomb()
 local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
	if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
	 local HUM = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
	  local TORSO = HUM.Parent:FindFirstChild("Torso") or HUM.Parent:FindFirstChild("UpperTorso")
	   if TORSO and HUM.Health > 0 then
			ATTACK = true
			Rooted = false
			local GYRO = IT("BodyGyro",RootPart)
			GYRO.D = 275
			GYRO.P = 20000
			GYRO.MaxTorque = VT(0,40000,0)
			local grav = Instance.new("BodyPosition",TORSO)
			grav.D = 1500
			grav.P = 20000
			grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
			grav.position = TORSO.Position+VT(0,0,0)
			CreateSound(429459101, TORSO, 0.5, 1, false)
	for i=0, 4, 0.1 / Animation_Speed do
		Swait()
		GYRO.cframe = CF(RootPart.Position,TORSO.Position)
		WACKYEFFECT({Time = 12, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CF(0,-1.5,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 0, SoundPitch = 2, SoundVolume = 0.8})
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 15)) * ANGLES(RAD(0), RAD(0), RAD(-65)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(8), RAD(MRANDOM(-10,10)), RAD(65)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(120), RAD(MRANDOM(-15,15)), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(-68), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
		CreateSound(884348443, TORSO, 5, 0.8, false)
		for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		WACKYEFFECT({Time = 12, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CF(0,-1.5,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 0, SoundPitch = 2, SoundVolume = 0.8})
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 15)) * ANGLES(RAD(0), RAD(0), RAD(-65)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(8), RAD(MRANDOM(-10,10)), RAD(65)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4, 0) * ANGLES(RAD(160), RAD(MRANDOM(-15,15)), RAD(-70)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(-68), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		end
	GYRO:Remove()
	ATTACK = false
	Rooted = false
	end
	end
end

function Bomb2()
local TARGET = Mouse.Target
   if TARGET ~= nil then
   if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
   local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
   local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
   if ROOT and HUM.Health > 0 then
   local FOE = Mouse.Target.Parent
   RootPart.CFrame = ROOT.CFrame*CF(0,0,4.2)
   ROOT.Anchored = true
   local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
local HUM = Mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
local TORSO = HUM.Parent:FindFirstChild("Torso") or HUM.Parent:FindFirstChild("UpperTorso")
if TORSO and HUM.Health > 0 then
ATTACK = true
Rooted = true
Rooted = true
	for i=0, 3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 15)) * ANGLES(RAD(0), RAD(0), RAD(65)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(8), RAD(0), RAD(65)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(68), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
		local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
		local CHILDREN = workspace:GetDescendants()
		for index, CHILD in pairs(CHILDREN) do
			if CHILD.ClassName == "Model" and CHILD ~= Character then
				local HUM = CHILD:FindFirstChildOfClass("Humanoid")
				if HUM then
					local TORSO = CHILD:FindFirstChild("Head")
					if TORSO then
						if (TORSO.Position - RootPart.Position).Magnitude <= 7 then
						    getbloody(TORSO,5)
			                SHAKECAM(HITPOS, 15, 2, 130)
							TORSO:remove()
							if CHILD:FindFirstChild("Torso") then
								Ragdoll(CHILD,Torso,true)
							elseif CHILD:FindFirstChild("UpperTorso") then
								R15Ragdoll(CHILD,true)
							end
						end
					end
				end
			end
		end
	    CreateSound(887549720, TORSO, 5, 1, false)
		for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 15)) * ANGLES(RAD(0), RAD(0), RAD(-90)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(8), RAD(0), RAD(120)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 15), -0.01) * ANGLES(RAD(0), RAD(-65), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		end
	ATTACK = false
	Rooted = false
	end
	end
end
end
end
end

function Taunt()
	ATTACK = true
	Rooted = true
    CreateSound(3331892166, Head, 10, 0.9, false)
	for i=0, 4, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 2)) * ANGLES(RAD(10), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-10), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(COS(10 * SINE / 2)), RAD(0)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(COS(-10 * SINE / 2)), RAD(COS(-10 * SINE / 2)), RAD(-8)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 2), -0.01) * ANGLES(RAD(10), RAD(75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 2), -0.01) * ANGLES(RAD(10), RAD(-75), RAD(0)) * ANGLES(RAD(-7), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end


function Zone()
	ATTACK = true
	Rooted = true
        local GYRO = IT("BodyGyro",RootPart)
        GYRO.D = 175
        GYRO.P = 20000
        GYRO.MaxTorque = VT(0,40000,0)
        GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
	for i=0, 0.3, 0.1 / Animation_Speed do
		Swait()
        GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(35)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(MRANDOM(-10,10)), RAD(35)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-78), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	repeat
	for i=0, 0.1, 0.1 / Animation_Speed do
		Swait()
        GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(35)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(MRANDOM(-10,10)), RAD(35)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-78), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
			local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
	    BulletDetection(Hole.Position,Mouse.Hit.p,true)
		local HIT,POS = CastProperRay(Hole.Position,MOUSEPOS,1000,Character)
		local DISTANCE = (POS - Hole.Position).Magnitude
		WACKYEFFECT({Time = 12, EffectType = "Block", Size = VT(0,0,0), Size2 = VT(0.8,0.8,0.8), Transparency = 0, Transparency2 = 1, CFrame = CF(Hole.CFrame.p), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 3207841110, SoundPitch = 1.2, SoundVolume = 2})
		WACKYEFFECT({Time = 8, EffectType = "Box", Size = VT(0,0,DISTANCE), Size2 = VT(0.1,0.1,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CF(Hole.CFrame.p,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	for i=0, 0.01, 0.1 / Animation_Speed do
		Swait()
        GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(35)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0.3) * ANGLES(RAD(100), RAD(MRANDOM(-10,10)), RAD(35)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-78), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	  until KEYHOLD == false
		for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(35)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(35)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-78), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	GYRO:Remove()
	ATTACK = false
	Rooted = false
	end



--//=================================\\
--||	  ASSIGN THINGS TO KEYS
--\\=================================//

-------------------------------------

Humanoid.Animator.Parent = nil

-------------------------------------


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
		Zone()
		end
	
		if Key == "t" and ATTACK == false then
		Taunt()
		end
		
	    if Key == "r" and ATTACK == false then
		Bomb2()
		end
		
	if Key == "e" and ATTACK == false then
		Bomb()
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


function unanchor()
	if UNANCHOR == true then
		g = CharacterA:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" then
				g[i].Anchored = false
			end
		end
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

local GLITCH = 0

local CONNECT = nil

local ActualVelocity = Vector3.new(0,0,0)


while true do
	Swait()
	ANIMATE.Parent = nil
	if Character:FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid",Character)
	end
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
	    v:Stop();
	end
local ADD = Humanoid.WalkSpeed*2
		local TORSOVELOCITY = (ActualVelocity * Vector3.new(1, 0, 1)).magnitude
	local TORSOVELOCITY_Y = ActualVelocity.Y
	if lplr == Player then
		TORSOVELOCITY = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
		TORSOVELOCITY_Y = RootPart.Velocity.Y
	end
local TORSOVERTICALVELOCITY = RootPart.Velocity.y
local NameClan = 0
local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 5, Character)
local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	SINE = SINE + CHANGE
	if ANIM == "Walk" and TORSOVELOCITY > 1 then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(-TORSOVERTICALVELOCITY), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 25), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.555 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), -0.7 * COS(SINE / WALKSPEEDVALUE) +0.2+ 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(-TORSOVERTICALVELOCITY)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(85 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.555 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), 0.7 * COS(SINE / WALKSPEEDVALUE) +0.2+ -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(-TORSOVERTICALVELOCITY)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(85 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-0)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(15)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(-8), RAD(0), RAD(8 * SIN(SINE / 8))), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(8 * SIN(SINE / 8))), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(15)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 - 0.1 * SIN(SINE / 25)) * ANGLES(RAD(0), RAD(0), RAD(25)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(8 * SIN(SINE / 26)), RAD(-25 - 8.5 * SIN(SINE / 25))), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15 - 1 * SIN(SINE / 26)), RAD(-10), RAD(6 + 8.5 * SIN(SINE / 25))) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.4, -0) * ANGLES(RAD(0), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.1 * SIN(SINE / 25), -0.01) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 + 0.1 * SIN(SINE / 25), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0.3, 0) * ANGLES(RAD(16), RAD(0), RAD(15 * COS(SINE / WALKSPEEDVALUE))), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-16 - 8.5 * SIN(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-10 * COS(SINE / WALKSPEEDVALUE))), 0.15 / Animation_Speed)
		    RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(165), RAD(-10), RAD(6)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		    LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-(8+(ADD*1.25))* COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-22 * COS(SINE / (WALKSPEEDVALUE)))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(86-35*COS(SINE / WALKSPEEDVALUE)), RAD(0)) * ANGLES(RAD(0), RAD(10 * COS(SINE / WALKSPEEDVALUE)), RAD(0)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-86-35*COS(SINE / WALKSPEEDVALUE)), RAD(0)) * ANGLES(RAD(0), RAD(10 * COS(SINE / WALKSPEEDVALUE)), RAD(0)), 0.15 / Animation_Speed)
		end
	end
	unanchor()
	Humanoid.MaxHealth = "inf"
	Humanoid.Health = "inf"
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
			BMUSIC.SoundId = "rbxassetid://" .. SONGID
	BMUSIC.Looped = true
	BMUSIC.Pitch = PITCH
	BMUSIC.Volume = VOLUME
	BMUSIC.Playing = true
	BMUSIC.EmitterSize = 35
	if BMUSIC.Parent ~= RootPart then
		print("Fixing music")
		BMUSIC = IT("Sound", RootPart)
		BMUSIC.SoundId = "rbxassetid://" .. SONGID
		BMUSIC.Looped = true
		BMUSIC.Pitch = PITCH
		BMUSIC.Volume = VOLUME
		BMUSIC.Playing = true
		BMUSIC.EmitterSize = 25
		BMUSIC.TimePosition = TIMESTAMP
		FIXING = true
	elseif FIXING == false then
		TIMESTAMP = BMUSIC.TimePosition
	else
		FIXING = false
	end
	end

--//=================================\\
--\\=================================//





--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--
