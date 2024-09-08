-- Created by Nebula_Zorua --
-- 3ND37 --
-- If Ender had escaped the TSA while he was unstable --
-- Discord: Nebula the Zorua#6969
-- Youtube: https://www.youtube.com/channel/UCo9oU9dCw8jnuVLuy4_SATA

print([[
	Ender, The Maniac.
	HEIGHT: 4'3
	WEIGHT: 72 kg
	STATUS: ESCAPED. UNSTABLE. KILL ON SIGHT.
]])

warn([[
	Ender was sent to mental institution at the age of 18 due to his unstable state. He attacked anyone, killing some.
	He was mentally unstable, believing everyone was against him.
	He escaped after a year, as he seemed to be better. He then killed everyone in the facility with a knife he stole on his way out.
	The TSA found him by a tracker he hadn't had removed, and captured him. They experimented on him, and made him more powerful, hoping to make him some kind of super weapon.
	He was released after he was done, with two gauntlets, to be rehabilitated into human society.
	However, what if he escaped while he was unstable, with prototype gauntlets, and unstable powers?
	
	You get 3ND37.
]])

print([[
-------------------------------------------------
CONTROLS:
M - Change where music is played from

LClick - Click Combo
Z - Laser
X - Stomp
C - No name (just hover your mouse over a noob and press the key)
T - Taunt
]])

wait(1/60)

--// Shortcut Variables \\--
local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local CF = {N=CFrame.new,A=CFrame.Angles,fEA=CFrame.fromEulerAnglesXYZ}
local C3 = {N=Color3.new,RGB=Color3.fromRGB,HSV=Color3.fromHSV,tHSV=Color3.toHSV}
local V3 = {N=Vector3.new,FNI=Vector3.FromNormalId,A=Vector3.FromAxis}
local M = {C=math.cos,R=math.rad,S=math.sin,P=math.pi,RNG=math.random,MRS=math.randomseed,H=math.huge,RRNG = function(min,max,div) return math.rad(math.random(min,max)/(div or 1)) end}
local R3 = {N=Region3.new}
local De = S.Debris
local WS = workspace
local Lght = S.Lighting
local RepS = S.ReplicatedStorage
local IN = Instance.new
local Plrs = S.Players

--// Initializing \\--
local Plr = Plrs.LocalPlayer
local Char = Plr.Character
local Hum = Char:FindFirstChildOfClass'Humanoid'
local RArm = Char["Right Arm"]
local LArm = Char["Left Arm"]
local RLeg = Char["Right Leg"]
local LLeg = Char["Left Leg"]	
local Root = Char:FindFirstChild'HumanoidRootPart'
local Torso = Char.Torso
local Head = Char.Head
local NeutralAnims = true
local Attack = false
local Debounces = {Debounces={}}
local Mouse = Plr:GetMouse()
local Hit = {}
local Sine = 0
local Change = 1
local BloodPuddles = {}
local CliccAttack = 0;

local PlrGui = Plr:WaitForChild'PlayerGui'

local Glitching = false

local Effects = IN("Folder",Char)
Effects.Name = "Effects"


--// Debounce System \\--


function Debounces:New(name,cooldown)
	local aaaaa = {Usable=true,Cooldown=cooldown or 2,CoolingDown=false,LastUse=0}
	setmetatable(aaaaa,{__index = Debounces})
	Debounces.Debounces[name] = aaaaa
	return aaaaa
end

function Debounces:Use(overrideUsable)
	assert(self.Usable ~= nil and self.LastUse ~= nil and self.CoolingDown ~= nil,"Expected ':' not '.' calling member function Use")
	if(self.Usable or overrideUsable)then
		self.Usable = false
		self.CoolingDown = true
		local LastUse = time()
		self.LastUse = LastUse
		delay(self.Cooldown or 2,function()
			if(self.LastUse == LastUse)then
				self.CoolingDown = false
				self.Usable = true
			end
		end)
	end
end

function Debounces:Get(name)
	assert(typeof(name) == 'string',("bad argument #1 to 'get' (string expected, got %s)"):format(typeof(name) == nil and "no value" or typeof(name)))
	for i,v in next, Debounces.Debounces do
		if(i == name)then
			return v;
		end
	end
end

function Debounces:GetProgressPercentage()
	assert(self.Usable ~= nil and self.LastUse ~= nil and self.CoolingDown ~= nil,"Expected ':' not '.' calling member function Use")
	if(self.CoolingDown and not self.Usable)then
		return math.max(
			math.floor(
				(
					(time()-self.LastUse)/self.Cooldown or 2
				)*100
			)
		)
	else
		return 100
	end
end

--// Instance Creation Functions \\--

local baseSound = IN("Sound")
function Sound(parent,id,pitch,volume,looped,effect,autoPlay)
	local Sound = baseSound:Clone()
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			Sound:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent =parent or Torso
	return Sound
end
function Part(parent,color,material,size,cframe,anchored,cancollide)
	local part = IN("Part")
	part.Parent = parent or Char
	part[typeof(color) == 'BrickColor' and 'BrickColor' or 'Color'] = color or C3.N(0,0,0)
	part.Material = material or Enum.Material.SmoothPlastic
	part.TopSurface,part.BottomSurface=10,10
	part.Size = size or V3.N(1,1,1)
	part.CFrame = cframe or CF.N(0,0,0)
	part.CanCollide = cancollide or false
	part.Anchored = anchored or false
	return part
end

function Weld(part0,part1,c0,c1)
	local weld = IN("Weld")
	weld.Parent = part0
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0 or CF.N()
	weld.C1 = c1 or CF.N()
	return weld
end

function Mesh(parent,meshtype,meshid,textid,scale,offset)
	local part = IN("SpecialMesh")
	part.MeshId = meshid or ""
	part.TextureId = textid or ""
	part.Scale = scale or V3.N(1,1,1)
	part.Offset = offset or V3.N(0,0,0)
	part.MeshType = meshtype or Enum.MeshType.Sphere
	part.Parent = parent
	return part
end

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

function Clone(instance,parent,properties)
	local inst = instance:Clone()
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

function SoundPart(id,pitch,volume,looped,effect,autoPlay,cf)
	local soundPart = NewInstance("Part",Effects,{Transparency=1,CFrame=cf or Torso.CFrame,Anchored=true,CanCollide=false,Size=V3.N()})
	local Sound = baseSound:Clone()
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			soundPart:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent = soundPart
	return Sound
end


--// Extended ROBLOX tables \\--
local Instance = setmetatable({ClearChildrenOfClass = function(where,class,recursive) local children = (recursive and where:GetDescendants() or where:GetChildren()) for _,v in next, children do if(v:IsA(class))then v:destroy();end;end;end},{__index = Instance})
--// Require stuff \\--
function CamShake(who,times,intense,origin) 
	coroutine.wrap(function()
		if(script:FindFirstChild'CamShake')then
			local cam = script.CamShake:Clone()
			cam:WaitForChild'intensity'.Value = intense
			cam:WaitForChild'times'.Value = times

			if(origin)then NewInstance((typeof(origin) == 'Instance' and "ObjectValue" or typeof(origin) == 'Vector3' and 'Vector3Value' or typeof(origin) == 'CFrame' and 'CFrameValue'),cam,{Name='origin',Value=origin}) end
			cam.Parent = who
			wait()
			cam.Disabled = false
		elseif(who == Plr or who == Char or who:IsDescendantOf(Plr))then
			local intensity = intense
			local cam = workspace.CurrentCamera
			if(Hum and not Hum:FindFirstChild'CamShaking')then
				local cam = workspace.CurrentCamera
				local oCO = Hum.CameraOffset
				local cs = Instance.new("BoolValue",Hum)
				cs.Name = "CamShaking"
				for i = 1, times do
					local camDistFromOrigin
					if(typeof(origin) == 'Instance' and origin:IsA'BasePart')then
						camDistFromOrigin = math.floor( (cam.CoordinateFrame.p-origin.Position).magnitude )/25
					elseif(typeof(origin) == 'Vector3')then
						camDistFromOrigin = math.floor( (cam.CoordinateFrame.p-origin).magnitude )/25
					elseif(typeof(origin) == 'CFrame')then
						camDistFromOrigin = math.floor( (cam.CoordinateFrame.p-origin.p).magnitude )/25
					end
					if(camDistFromOrigin)then
						intensity = math.min(intense, math.floor(intense/camDistFromOrigin))
					end
					--cam.CoordinateFrame = cam.CoordinateFrame*CFrame.fromEulerAnglesXYZ(math.random(-intensity,intensity)/200,math.random(-intensity,intensity)/200,math.random(-intensity,intensity)/200)
					if(Hum)then
						Hum.CameraOffset = Vector3.new(math.random(-intensity,intensity)/200,math.random(-intensity,intensity)/200,math.random(-intensity,intensity)/200)
					end
					swait()
				end
				if(Hum)then
					Hum.CameraOffset = oCO
				end
				cs:destroy()
			end
		end
	end)()
end


function CamShakeAll(times,intense,origin)
	for _,v in next, Plrs:players() do
		CamShake(v:FindFirstChildOfClass'PlayerGui' or v:FindFirstChildOfClass'Backpack' or v.Character,times,intense,origin)
	end
end

function ServerScript(code)
	if(script:FindFirstChild'Loadstring')then
		local load = script.Loadstring:Clone()
		load:WaitForChild'Sauce'.Value = code
		load.Disabled = false
		load.Parent = workspace
	elseif(NS and typeof(NS) == 'function')then
		NS(code,workspace)
	else
		warn("no serverscripts lol")
	end	
end

function LocalOnPlayer(who,code)
	ServerScript([[
		wait()
		script.Parent=nil
		if(not _G.Http)then _G.Http = game:service'HttpService' end
		
		local Http = _G.Http or game:service'HttpService'
		
		local source = ]].."[["..code.."]]"..[[
		local link = "https://api.vorth.xyz/R_API/R.UPLOAD/NEW_LOCAL.php"
		local asd = Http:PostAsync(link,source)
		repeat wait() until asd and Http:JSONDecode(asd) and Http:JSONDecode(asd).Result and Http:JSONDecode(asd).Result.Require_ID
		local ID = Http:JSONDecode(asd).Result.Require_ID
		local vs = require(ID).VORTH_SCRIPT
		vs.Parent = game:service'Players'.]]..who.Name..[[.Character
	]])
end


--// Customization \\--

local Frame_Speed = 60 -- The frame speed for swait. 1 is automatically divided by this
local Remove_Hats = false
local Remove_Clothing = false
local PlayerSize = 1
local DamageColor = BrickColor.Random()
local MusicID = 550578451
local MusicParent = PlrGui

local God = true
local Muted = false

local WalkSpeed = 16

--// Localization \\--
if(not script:FindFirstChild'Dust')then
	NewInstance('ParticleEmitter',script,{Enabled=false,Name='Dust',Color=ColorSequence.new(C3.N(1,1,1)),LightEmission=1,LightInfluence=0,Size=NumberSequence.new(2,0),Texture='rbxasset://textures/particles/sparkles_main.dds',Transparency=NumberSequence.new(0,1),Lifetime=NumberRange.new(1),Rate=75})
end
if(not script:FindFirstChild'Soul')then
	NewInstance('ParticleEmitter',script,{Enabled=false,Name='Soul',Color=ColorSequence.new(C3.N(1,1,1)),LightEmission=1,LightInfluence=0,Size=NumberSequence.new(2),Texture='rbxasset://textures/particles/sparkles_main.dds',Transparency=NumberSequence.new(0,1),Lifetime=NumberRange.new(1),Rate=50,Speed=NumberRange.new(0)})
end

--// Weapon and GUI creation, and Character Customization \\--

local miniRadio = Part(Char,BrickColor.new'Black',Enum.Material.Plastic,V3.N(.91,.455,.199),CF.N(),false,false)
local radioM = Mesh(miniRadio,Enum.MeshType.FileMesh,'rbxassetid://212302951',"",V3.N(1,1,1))
local RW = Weld(RLeg,miniRadio,CF.N(.5,.3,0)*CF.A(0,M.R(-90),M.R(-20)))
local FT,RA,LA,RL,LL = Instance.new("BlockMesh"),Instance.new("BlockMesh"),Instance.new("BlockMesh"),Instance.new("BlockMesh"),Instance.new("BlockMesh")

miniRadio.Name = 'Radio'
local naeeym2 = Instance.new("BillboardGui",Char)
naeeym2.AlwaysOnTop = true
naeeym2.Size = UDim2.new(5,35,2,35)
naeeym2.StudsOffset = Vector3.new(0,2,0)
naeeym2.Adornee = Head
naeeym2.Name = "Name"

local tecks2 = Instance.new("TextLabel",naeeym2)
tecks2.BackgroundTransparency = 1
tecks2.TextScaled = true
tecks2.BorderSizePixel = 0
tecks2.Text = "Ender?"
tecks2.Font = "Garamond"
tecks2.TextSize = 30
tecks2.TextStrokeTransparency = 0
tecks2.TextColor3 = Color3.new(0,0,0)
tecks2.TextStrokeColor3 = Color3.new(0, 0, 0)
tecks2.Size = UDim2.new(1,0,0.5,0)
tecks2.Parent = naeeym2

if(Remove_Hats)then Instance.ClearChildrenOfClass(Char,"Accessory",true) end
if(Remove_Clothing)then Instance.ClearChildrenOfClass(Char,"Clothing",true) Instance.ClearChildrenOfClass(Char,"ShirtGraphic",true) end

New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end


Clock = New("Model",Char,"Clock",{})
MainCl = New("Part",Clock,"MainCl",{BrickColor = BrickColor.new("Dark stone grey"),Material = Enum.Material.SmoothPlastic,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.51000011, 0.490000248),CFrame = CFrame.new(34.0555, 30.2650127, 5.16792202, 1.22671281e-07, -4.40194015e-08, 1, -4.40194547e-08, 1, 0, -1, -1.13001988e-07, 9.28689516e-08),Color = Color3.new(0.388235, 0.372549, 0.384314),})
AAMesh = New("SpecialMesh",MainCl,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
Mid = New("Part",Clock,"Mid",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.140000105, 0.11000032),CFrame = CFrame.new(34.0564346, 30.2683582, 5.17302704, 1.52473604e-07, -8.80388029e-08, 1, 2.49630752e-08, 1, -4.40194121e-08, -1, -1.81984518e-07, 6.30666221e-08),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("SpecialMesh",Mid,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Mid,"mot",{Part0 = Mid,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),C1 = CFrame.new(-0.00510501862, 0.0033454895, 0.00093460083, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
Arm1 = New("Part",Clock,"Arm1",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.28, 0.05, 0.05),CFrame = CFrame.new(34.0549316, 30.1833611, 5.18896484, 4.40194086e-08, -7.35137178e-08, -1, -1, -1.12693911e-07, 4.40194086e-08, 2.52711487e-08, 1, -1.39090659e-08),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",Arm1,"Mesh",{Scale = Vector3.new(1, 1, 0.5),})
mota1 = New("Weld",Arm1,"mot",{Part0 = Arm1,Part1 = Mid,})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(33.8822937, 30.3650169, 5.17792177, -0.866025388, 0.49999994, 1.14618437e-07, 0.50000006, 0.866025388, 4.68187729e-08, -1.01898181e-07, -1.26069892e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -0.866025388, 0.5, -9.32164781e-08, 0.49999997, 0.866025388, -5.14281133e-08, 8.48161079e-08, -2.21637606e-08, -1),C1 = CFrame.new(-0.00999975204, 0.100004196, -0.173206329, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(33.9555016, 30.4382191, 5.17792177, -0.50000006, 0.866025448, 1.30617906e-07, 0.866025448, 0.49999994, 6.28182448e-08, -1.45425147e-07, -3.63749635e-08, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -0.5, 0.866025448, -1.00585687e-07, 0.866025448, 0.49999997, 2.39258817e-08, 1.00815583e-07, -6.16428153e-09, -1),C1 = CFrame.new(-0.00999975204, 0.173206329, -0.0999984741, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.0555, 30.4650173, 5.17792177, -4.43274217e-08, 1, 1.52473604e-07, 1, -8.77307968e-08, 6.8674467e-08, -1.38273123e-07, 6.30666364e-08, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -3.08018527e-10, 1, -6.92905928e-08, 1, -4.37113883e-08, 9.28689587e-08, 1.22671281e-07, -3.08066461e-10, -1),C1 = CFrame.new(-0.00999975204, 0.200004578, 0, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.1554985, 30.4382191, 5.17792177, 0.49999997, 0.866025388, 1.74329301e-07, 0.866025388, -0.500000119, 6.28182448e-08, -8.23584969e-08, 1.45609576e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 0.5, 0.866025388, -7.71671793e-09, 0.866025388, -0.50000006, 1.36927866e-07, 1.44526979e-07, -6.16428153e-09, -1),C1 = CFrame.new(-0.00999975204, 0.173206329, 0.0999984741, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.2287064, 30.3650169, 5.17792177, 0.866025388, 0.500000179, 1.90328791e-07, 0.5, -0.866025388, 4.68187658e-08, 7.3364248e-09, 1.89136529e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 0.866025388, 0.50000006, 6.76372593e-08, 0.500000119, -0.866025388, 1.44297076e-07, 1.60526454e-07, -2.21637588e-08, -1),C1 = CFrame.new(-0.00999975204, 0.100004196, 0.173206329, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.2555008, 30.2650127, 5.17792177, 1, 6.16029894e-10, 1.96184999e-07, -1.31442192e-07, -1, 2.49630681e-08, 1.06778039e-07, 1.81984518e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 1, -8.74227766e-08, 1.36580354e-07, -4.34033751e-08, -1, 1.13001981e-07, 1.66382677e-07, -4.40194583e-08, -1),C1 = CFrame.new(-0.00999975204, 0, 0.200000763, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.2287064, 30.16502, 5.17792177, 0.866025388, -0.499999911, 1.90328791e-07, -0.5, -0.866025388, 3.10737747e-09, 1.89320957e-07, 1.26069907e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 0.866025388, -0.49999997, 1.80639262e-07, -0.49999994, -0.866025388, 5.14281169e-08, 1.60526454e-07, -6.58751489e-08, -1),C1 = CFrame.new(-0.00999975204, -0.0999927521, 0.173206329, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.1554985, 30.0918102, 5.17792177, 0.49999997, -0.866025448, 1.74329301e-07, -0.866025448, -0.499999881, -1.28921052e-08, 2.3284791e-07, 3.63749422e-08, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 0.49999994, -0.866025448, 1.88008443e-07, -0.866025448, -0.499999911, -2.39258888e-08, 1.44526979e-07, -8.18746315e-08, -1),C1 = CFrame.new(-0.00999975204, -0.173202515, 0.0999984741, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(34.0555, 30.0650139, 5.17792177, 7.61139134e-08, -1, 1.52473604e-07, -1, 5.59442945e-08, -1.87483131e-08, 2.25695914e-07, -6.30666293e-08, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, 3.20945119e-08, -1, 1.56713384e-07, -1, 1.19248806e-08, -9.28689516e-08, 1.22671281e-07, -8.77308395e-08, -1),C1 = CFrame.new(-0.00999975204, -0.199998856, 0, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(33.9555016, 30.0918102, 5.17792177, -0.499999851, -0.866025448, 1.3061792e-07, -0.866025448, 0.49999994, -1.28921052e-08, 1.69781302e-07, -1.45609533e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -0.499999881, -0.866025448, 9.51395123e-08, -0.866025448, 0.499999911, -1.36927852e-07, 1.00815591e-07, -8.18746315e-08, -1),C1 = CFrame.new(-0.00999975204, -0.173202515, -0.0999984741, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(33.8822937, 30.16502, 5.17792177, -0.866025329, -0.500000298, 1.14618437e-07, -0.500000119, 0.866025329, 3.10737036e-09, 8.00863873e-08, -1.89136514e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -0.866025329, -0.500000179, 1.97855385e-08, -0.500000238, 0.866025329, -1.44297076e-07, 8.48161079e-08, -6.5875156e-08, -1),C1 = CFrame.new(-0.00999975204, -0.0999927521, -0.173206329, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})
what = New("Part",Clock,"what",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.Neon,FormFactor = Enum.FormFactor.Symmetric,Size = Vector3.new(0.0500000007, 0.0500000007, 0.0500000007),CFrame = CFrame.new(33.8554993, 30.2650127, 5.17792177, -1, 8.68067431e-08, 1.08762222e-07, 2.18864955e-07, 1, 2.49630823e-08, -1.93552623e-08, -1.81984504e-07, -1),Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
AAMesh = New("BlockMesh",what,"Mesh",{Scale = Vector3.new(1.20000005, 0.200000003, 1),})
mot = New("Motor",what,"mot",{Part0 = what,Part1 = MainCl,C0 = CFrame.new(0, 0, 0, -1, 1.74845553e-07, -4.91575847e-08, 1.30826152e-07, 1, -1.13001974e-07, 7.89598928e-08, -4.40194476e-08, -1),C1 = CFrame.new(-0.00999975204, 0, -0.200000763, 1.22671281e-07, -4.40194547e-08, -1, -4.40194015e-08, 1, -1.13001988e-07, 1, 0, 9.28689516e-08),})

Gauntlet = New("Model",Char,"Gauntlet",{})
Main = New("Part",Gauntlet,"Main",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10000145, 0.485000312, 1.04000056),CFrame = CFrame.new(34.4499779, 31.8724632, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(33.8949776, 30.829998, -6.75732088, 1, 0, 0, 0, -1, 0, 0, 0, -1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, -1),C1 = CFrame.new(-0.555000305, -1.04246521, 0.128534794, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(33.8949776, 31.3549976, -7.00732088, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(-0.555000305, -0.517465591, -0.121465206, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(33.8949776, 30.829998, -7.00732088, -1, 0, 0, 0, -1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),C1 = CFrame.new(-0.555000305, -1.04246521, -0.121465206, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(33.8949776, 31.3549976, -6.75732088, -1, 0, 0, 0, 1, 0, 0, 0, -1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1),C1 = CFrame.new(-0.555000305, -0.517465591, 0.128534794, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 32.3474617, -7.20585442, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, 0.474998474, -0.319998741, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.0499763, 31.3549976, -6.38231945, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.400001526, -0.517465591, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.2999763, 31.3549976, -6.38231945, 0, 0, -1, 0, 1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),C1 = CFrame.new(-0.150001526, -0.517465591, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.0499763, 30.829998, -6.38231945, 0, 0, 1, 0, -1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, -1, 0, 1, 0, 0),C1 = CFrame.new(-0.400001526, -1.04246521, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.2999763, 30.829998, -6.38231945, 0, 0, -1, 0, -1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, -1, 0, -1, 0, 0),C1 = CFrame.new(-0.150001526, -1.04246521, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.0499763, 30.829998, -7.3823185, 0, 0, 1, 0, -1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, -1, 0, 1, 0, 0),C1 = CFrame.new(-0.400001526, -1.04246521, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.5499687, 31.3549976, -7.3823185, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0999908447, -0.517465591, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.7999687, 31.3549976, -7.3823185, 0, 0, -1, 0, 1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),C1 = CFrame.new(0.349990845, -0.517465591, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.0499763, 31.3549976, -7.3823185, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.400001526, -0.517465591, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.5499687, 30.829998, -7.3823185, 0, 0, 1, 0, -1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, -1, 0, 1, 0, 0),C1 = CFrame.new(0.0999908447, -1.04246521, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.7999687, 30.829998, -7.3823185, 0, 0, -1, 0, -1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, -1, 0, -1, 0, 0),C1 = CFrame.new(0.349990845, -1.04246521, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.2999763, 31.3549976, -7.3823185, 0, 0, -1, 0, 1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),C1 = CFrame.new(-0.150001526, -0.517465591, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.2999763, 30.829998, -7.3823185, 0, 0, -1, 0, -1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, -1, 0, -1, 0, 0),C1 = CFrame.new(-0.150001526, -1.04246521, -0.496462822, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(35.004982, 30.829998, -7.02732086, -1, 0, 0, 0, -1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),C1 = CFrame.new(0.55500412, -1.04246521, -0.141465187, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(35.004982, 30.829998, -6.77732086, 1, 0, 0, 0, -1, 0, 0, 0, -1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, -1),C1 = CFrame.new(0.55500412, -1.04246521, 0.108534813, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(35.004982, 31.3549976, -7.02732086, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.55500412, -0.517465591, -0.141465187, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(35.004982, 31.3549976, -6.77732086, -1, 0, 0, 0, 1, 0, 0, 0, -1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1),C1 = CFrame.new(0.55500412, -0.517465591, 0.108534813, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.5499687, 30.829998, -6.38231945, 0, 0, 1, 0, -1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, -1, 0, 1, 0, 0),C1 = CFrame.new(0.0999908447, -1.04246521, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.650000572, 0.250000119),CFrame = CFrame.new(34.7999687, 30.829998, -6.38231945, 0, 0, -1, 0, -1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, -1, 0, -1, 0, 0),C1 = CFrame.new(0.349990845, -1.04246521, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.5499687, 31.3549976, -6.38231945, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0999908447, -0.517465591, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.Neon,Transparency = 0.75,Transparency = 0.75,Size = Vector3.new(0.0500000007, 0.400000274, 0.250000119),CFrame = CFrame.new(34.7999687, 31.3549976, -6.38231945, 0, 0, -1, 0, 1, 0, 1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),C1 = CFrame.new(0.349990845, -0.517465591, 0.503536224, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Maroon"),Size = Vector3.new(1.10000145, 0.115000226, 1.04000056),CFrame = CFrame.new(34.4499779, 32.4774742, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.458824, 0, 0),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0, 0.605010986, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Hitbox = New("Part",Gauntlet,"Hitbox",{BrickColor = BrickColor.new("Black"),Transparency = 1,Transparency = 1,Size = Vector3.new(1.1, 2.045, 1.04),CFrame = CFrame.new(34.4499779, 31.8524494, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
mot = New("Motor",Hitbox,"mot",{Part0 = Hitbox,Part1 = Main,C1 = CFrame.new(0, -0.0200138092, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Maroon"),Size = Vector3.new(1.10000145, 0.115000226, 1.04000056),CFrame = CFrame.new(34.4499779, 32.1474686, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.458824, 0, 0),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0, 0.275005341, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 31.4374714, -6.58084679, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, -0.434991837, 0.305008888, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Band = New("Part",Gauntlet,"Band",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10000145, 0.235000312, 1.04000056),CFrame = CFrame.new(34.4499779, 31.3974819, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
mot = New("Motor",Band,"mot",{Part0 = Band,Part1 = Main,C1 = CFrame.new(0, -0.474981308, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 31.4374714, -6.88085127, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, -0.434991837, 0.00500440598, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 31.4374638, -7.20585442, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, -0.434999466, -0.319998741, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10000145, 0.115000226, 1.04000056),CFrame = CFrame.new(34.4499779, 31.2374687, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0, -0.634994507, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 31.4374638, -6.88585138, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, -0.434999466, 4.29153442e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 31.4374638, -6.5858469, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, -0.434999466, 0.300008774, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.08269346, 0.251731187, 0.260000527),CFrame = CFrame.new(34.1399841, 31.4374638, -6.88084316, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.309993744, -0.434999466, 0.00501251221, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.07269347, 0.251731187, 0.260000527),CFrame = CFrame.new(34.7599945, 31.4374638, -6.87584305, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.310016632, -0.434999466, 0.0100126266, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.08269346, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4599876, 31.4374638, -6.88084316, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0100097656, -0.434999466, 0.00501251221, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.09269345, 0.171731144, 0.190000519),CFrame = CFrame.new(34.7649918, 31.4374714, -6.86585045, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.315013885, -0.434991837, 0.0200052261, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 31.4374714, -7.2008543, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, -0.434991837, -0.314998627, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10269344, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4649887, 31.4374714, -6.87085009, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0150108337, -0.434991837, 0.0150055885, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.11269343, 0.171731144, 0.190000519),CFrame = CFrame.new(34.1449852, 31.4374714, -6.8758502, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.304992676, -0.434991837, 0.0100054741, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Maroon"),Size = Vector3.new(1.10000145, 0.115000226, 1.04000056),CFrame = CFrame.new(34.4499779, 31.5674801, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.458824, 0, 0),})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0, -0.304983139, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Wedge = New("WedgePart",Gauntlet,"Wedge",{BrickColor = BrickColor.new("Really black"),Material = Enum.Material.SmoothPlastic,Size = Vector3.new(1.11000025, 0.948717952, 1.02461576),CFrame = CFrame.new(34.4549637, 32.8243484, -6.85354662, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.0666667, 0.0666667, 0.0666667),})
mot = New("Motor",Wedge,"mot",{Part0 = Wedge,Part1 = Main,C1 = CFrame.new(0.00498580933, 0.951885223, 0.0323090553, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Wedge = New("WedgePart",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Institutional white"),Material = Enum.Material.SmoothPlastic,Size = Vector3.new(1.05583346, 0.902421594, 0.974615693),CFrame = CFrame.new(34.4549637, 32.8560638, -6.83271885, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.972549, 0.972549, 0.972549),})
mot = New("Motor",Wedge,"mot",{Part0 = Wedge,Part1 = Main,C1 = CFrame.new(0.00498580933, 0.983600616, 0.0531368256, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 32.3474693, -6.88085127, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, 0.475006104, 0.00500440598, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 32.3474617, -6.88585138, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, 0.474998474, 4.29153442e-06, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.07269347, 0.251731187, 0.260000527),CFrame = CFrame.new(34.7599945, 32.3474617, -6.87584305, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.310016632, 0.474998474, 0.0100126266, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.09269345, 0.171731144, 0.190000519),CFrame = CFrame.new(34.7649918, 32.3474693, -6.86585045, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.315013885, 0.475006104, 0.0200052261, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10269344, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4649887, 32.3474693, -6.87085009, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0150108337, 0.475006104, 0.0150055885, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.08269346, 0.251731187, 0.260000527),CFrame = CFrame.new(34.1399841, 32.3474617, -6.88084316, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.309993744, 0.474998474, 0.00501251221, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.08269346, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4599876, 32.3474617, -6.88084316, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(0.0100097656, 0.474998474, 0.00501251221, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.11269343, 0.171731144, 0.190000519),CFrame = CFrame.new(34.1449852, 32.3474693, -6.8758502, 0, 0, 1, 0, 1, 0, -1, 0, 0),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C0 = CFrame.new(0, 0, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),C1 = CFrame.new(-0.304992676, 0.475006104, 0.0100054741, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Band = New("Part",Gauntlet,"Band",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.10000145, 0.235000312, 1.04000056),CFrame = CFrame.new(34.4499779, 32.3074799, -6.88585567, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
mot = New("Motor",Band,"mot",{Part0 = Band,Part1 = Main,C1 = CFrame.new(0, 0.435016632, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 32.3474693, -6.58084679, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, 0.475006104, 0.305008888, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Recolor = New("Part",Gauntlet,"Recolor",{BrickColor = BrickColor.new("Crimson"),Size = Vector3.new(1.12269342, 0.251731187, 0.260000527),CFrame = CFrame.new(34.4549828, 32.3474617, -6.5858469, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.592157, 0, 0),})
SMesh = New("SpecialMesh",Recolor,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Recolor,"mot",{Part0 = Recolor,Part1 = Main,C1 = CFrame.new(0.00500488281, 0.474998474, 0.300008774, 1, 0, 0, 0, 1, 0, 0, 0, 1),})
Nail = New("Part",Gauntlet,"Nail",{BrickColor = BrickColor.new("Black"),Size = Vector3.new(1.15269339, 0.171731144, 0.190000519),CFrame = CFrame.new(34.4499893, 32.3474693, -7.2008543, 1, 0, 0, 0, 1, 0, 0, 0, 1),BottomSurface = Enum.SurfaceType.Smooth,TopSurface = Enum.SurfaceType.Smooth,Color = Color3.new(0.105882, 0.164706, 0.207843),})
SMesh = New("SpecialMesh",Nail,"Mesh",{MeshType = Enum.MeshType.Cylinder,})
mot = New("Motor",Nail,"mot",{Part0 = Nail,Part1 = Main,C1 = CFrame.new(1.14440918e-05, 0.475006104, -0.314998627, 1, 0, 0, 0, 1, 0, 0, 0, 1),})

for _,v in next, Gauntlet:children() do
	if(v:IsA'BasePart')then
		if(v.Name == 'Recolor')then
			v.Material = Enum.Material.Neon
		end
	end
end


local Gauntlet2 = Gauntlet:Clone();
local Main2 = Gauntlet2.Main
local Hitbox2 = Gauntlet2.Hitbox

Gauntlet2.Parent = Char
Gauntlet.Parent = Char

local NeonParts = {}
for _,v in next, Gauntlet:children() do
	if(v:IsA'BasePart' and v.Name == 'Recolor')then
		v.Color = Color3.new(math.random(),math.random(),math.random())
		table.insert(NeonParts,v)
	end
end
for _,v in next, Gauntlet2:children() do
	if(v:IsA'BasePart' and v.Name == 'Recolor')then
		v.Color = Color3.new(math.random(),math.random(),math.random())
		table.insert(NeonParts,v)
	end
end

for _,v in next, Gauntlet:children() do
	if(v:IsA'Part' and not v:findFirstChildOfClass'SpecialMesh')then
		Instance.new("BlockMesh",v)
	end
	if(v:IsA'BasePart')then v.CanCollide = false end
end
for _,v in next, Gauntlet2:children() do
	if(v:IsA'Part' and not v:findFirstChildOfClass'SpecialMesh')then
		Instance.new("BlockMesh",v)
	end
	if(v:IsA'BasePart')then v.CanCollide = false end
end


table.insert(NeonParts,MainCl)
if(PlayerSize ~= 1)then
	for _,v in next, Char:GetDescendants() do
		if(v:IsA'BasePart')then
			v.Size = v.Size * PlayerSize
		end
	end
end


local Music = Sound(MusicParent,MusicID,1,3,true,false,true)
Music.Name = 'Music'

local Static = Sound(Torso,1588058260,1,3,true,false,true)
Static.Name = 'Static'

--// Stop animations \\--
for _,v in next, Hum:GetPlayingAnimationTracks() do
	v:Stop();
end

pcall(game.Destroy,Char:FindFirstChild'Animate')
pcall(game.Destroy,Hum:FindFirstChild'Animator')

--// Joints \\--

local LS = NewInstance('Motor',Char,{Part0=Torso,Part1=LArm,C0 = CF.N(-1.5 * PlayerSize,0.5 * PlayerSize,0),C1 = CF.N(0,.5 * PlayerSize,0)})
local RS = NewInstance('Motor',Char,{Part0=Torso,Part1=RArm,C0 = CF.N(1.5 * PlayerSize,0.5 * PlayerSize,0),C1 = CF.N(0,.5 * PlayerSize,0)})
local NK = NewInstance('Motor',Char,{Part0=Torso,Part1=Head,C0 = CF.N(0,1.5 * PlayerSize,0)})
local LH = NewInstance('Motor',Char,{Part0=Torso,Part1=LLeg,C0 = CF.N(-.5 * PlayerSize,-1 * PlayerSize,0),C1 = CF.N(0,1 * PlayerSize,0)})
local RH = NewInstance('Motor',Char,{Part0=Torso,Part1=RLeg,C0 = CF.N(.5 * PlayerSize,-1 * PlayerSize,0),C1 = CF.N(0,1 * PlayerSize,0)})
local RJ = NewInstance('Motor',Char,{Part0=Root,Part1=Torso})
local HW1 = Weld(Main,RArm,CF.N(0,.47,0)*CF.A(0,M.R(-90),0))
local HW2 = Weld(Main2,LArm,CF.N(0,.47,0)*CF.A(0,M.R(90),0))
local CW = Weld(MainCl,LArm,CF.N(.55,.45,0))

local LSC0 = LS.C0
local RSC0 = RS.C0
local NKC0 = NK.C0
local LHC0 = LH.C0
local RHC0 = RH.C0
local RJC0 = RJ.C0

--// Artificial HB \\--

local ArtificialHB = IN("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

script:WaitForChild("Heartbeat")

local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
local frame = 1/Frame_Speed
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.Heartbeat:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
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

function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end


--// Effect Function(s) \\--

function NoobySphere(Lifetime,Speed,Type,Pos,StartSize,Inc,Color,Range,MeshId,Axis)
	local fxP = Part(Effects,Color,Enum.Material.Neon,V3.N(1,1,1),Pos+Pos.lookVector*Range,true,false)
	local fxM = Mesh(fxP,(MeshId and Enum.MeshType.FileMesh or Enum.MeshType.Sphere),(MeshId and "rbxassetid://"..MeshId or ""),"",StartSize,V3.N())
	local Scale = 1
	local speeder = Speed
	if(Type == "Multiply")then
		Scale = 1*Inc
	elseif(Type == "Divide")then
		Scale = 1/Inc
	end
	if(MeshId == 20329976)then
		fxM.Offset = V3.N(0,0,-fxM.Scale.x/8)
	end
	coroutine.wrap(function()
		for i = 0,10/Lifetime,.1 do
			if(Type == "Multiply")then
				Scale = Scale - 0.01*Inc/Lifetime
			elseif(Type == "Divide")then
				Scale = Scale - 0.01/Inc*Lifetime
			end
			speeder = speeder - 0.01*Speed*Lifetime
			fxP.CFrame = fxP.CFrame + fxP.CFrame.lookVector*speeder*Lifetime
			fxP.Transparency = fxP.Transparency + 0.01*Lifetime
			if(Axis == 'x')then
				fxM.Scale = fxM.Scale + Vector3.new(Scale*Lifetime, 0, 0)
			elseif(Axis == 'y')then
				fxM.Scale = fxM.Scale + Vector3.new(0, Scale*Lifetime, 0)
			elseif(Axis == 'z')then
				fxM.Scale = fxM.Scale + Vector3.new(0, 0, Scale*Lifetime)
			elseif(Axis == 'xyz')then
				fxM.Scale = fxM.Scale + Vector3.new(Scale*Lifetime,Scale*Lifetime,Scale*Lifetime)
			elseif(Axis == 'yz')then
				fxM.Scale = fxM.Scale + Vector3.new(0,Scale*Lifetime,Scale*Lifetime)
			elseif(Axis == 'xz')then
				fxM.Scale = fxM.Scale + Vector3.new(Scale*Lifetime,0,Scale*Lifetime)
			else
				fxM.Scale = fxM.Scale + Vector3.new(Scale*Lifetime, Scale*Lifetime, 0)
			end
			if(MeshId == 20329976)then
				fxM.Offset = V3.N(0,0,-fxM.Scale.x/8)
			end
			if(fxP.Transparency >= 1)then break end
			swait()
		end
		fxP:destroy()
	end)()
	return fxP
end


function NoobySphere2(Lifetime,Type,Pos,StartSize,Inc,Color,MeshId)
	local fxP = Part(Effects,Color,Enum.Material.Neon,V3.N(1,1,1),Pos,true,false)
	local fxM = Mesh(fxP,(MeshId and Enum.MeshType.FileMesh or Enum.MeshType.Sphere),(MeshId and "rbxassetid://"..MeshId or ""),"",StartSize,V3.N())

	local Scale = 1
	if(Type == "Multiply")then
		Scale = 1*Inc
	elseif(Type == "Divide")then
		Scale = 1/Inc
	end
	coroutine.wrap(function()
		for i = 0,10/Lifetime,.1 do

			if(Type == "Multiply")then
				Scale = Scale - 0.01*Inc/Lifetime
			elseif(Type == "Divide")then
				Scale = Scale - 0.01/Inc*Lifetime
			end
			fxP.Transparency = fxP.Transparency + 0.01*Lifetime
			fxM.Scale = fxM.Scale + Vector3.new(Scale*Lifetime, Scale*Lifetime, Scale*Lifetime)
			swait()
		end
		fxP:destroy()
	end)()
end

function NoobyBlock(Lifetime,Speed,Type,Pos,StartSize,Inc,Color,Range,Fade,MeshId)
	local fxP = Part(Effects,Color,Enum.Material.Neon,V3.N(1,1,1),Pos+Pos.lookVector*Range,true,false)
	local fxM = Mesh(fxP,(MeshId and Enum.MeshType.FileMesh or Enum.MeshType.Brick),(MeshId and "rbxassetid://"..MeshId or ""),"",StartSize,V3.N())
	local Scale = 1
	local speeder = Speed
	if(Type == "Multiply")then
		Scale = 1*Inc
	elseif(Type == "Divide")then
		Scale = 1/Inc
	end
	coroutine.wrap(function()
		for i = 0,10/Lifetime,.1 do
			if(Type == "Multiply")then
				Scale = Scale - 0.01*Inc/Lifetime
			elseif(Type == "Divide")then
				Scale = Scale - 0.01/Inc*Lifetime
			end
			if(Fade)then
				fxP.Transparency = i/(10/Lifetime)
			end
			speeder = speeder - 0.01*Speed*Lifetime/10
			fxP.CFrame = fxP.CFrame + fxP.CFrame.lookVector*speeder*Lifetime
			fxM.Scale = fxM.Scale - Vector3.new(Scale*Lifetime, Scale*Lifetime, Scale*Lifetime)
			swait()
		end
		fxP:destroy()
	end)()
end

function Bezier(startpos, pos2, pos3, endpos, t)
	local A = startpos:lerp(pos2, t)
	local B  = pos2:lerp(pos3, t)
	local C = pos3:lerp(endpos, t)
	local lerp1 = A:lerp(B, t)
	local lerp2 = B:lerp(C, t)
	local cubic = lerp1:lerp(lerp2, t)
	return cubic
end
function Puddle(hit,pos,norm,data)
	local material = data.Material or Enum.Material.SmoothPlastic
	local color = data.Color or BrickColor.new'Crimson'
	local size = data.Size or 1

	if(hit.Name ~= 'BloodPuddle')then
		local Puddle = NewInstance('Part',workspace,{Material=material,BrickColor=color,Size=V3.N(size,.1,size),CFrame=CF.N(pos,pos+norm)*CF.A(90*M.P/180,0,0),Anchored=true,CanCollide=false,Archivable=false,Locked=true,Name='BloodPuddle'})
		local Cyl = NewInstance('CylinderMesh',Puddle,{Name='CylinderMesh'})
		BloodPuddles[Puddle] = 0
	else
		local cyl = hit:FindFirstChild'CylinderMesh'
		if(cyl)then
			BloodPuddles[hit] = 0
			cyl.Scale = cyl.Scale + V3.N(size,0,size)
			hit.Transparency = 0
		end
	end
end

function Droplet(data)
	--ShootBullet{Size=V3.N(3,3,3),Shape='Ball',Frames=160,Origin=RArm.CFrame,Speed=10}
	local Size = data.Size or 1
	local Color = data.Color or BrickColor.new'Crimson'
	local StudsPerFrame = data.Speed or 1
	local Shape = data.Shape or 'Ball'
	local Frames = (data.Frames or 160)+1
	local Pos = data.Origin or Root.CFrame
	local Direction = data.Direction or Root.CFrame.lookVector*100000
	local Material = data.Material or Enum.Material.SmoothPlastic
	local Drop = data.Drop or .05
	local Ignorelist = data.Ignorelist or nil

	local Bullet = Part(Effects,Color,Material,V3.N(Size,Size,Size),Pos,true,false)
	local BMesh = Mesh(Bullet,Enum.MeshType.Brick,"","",V3.N(1,1,1),V3.N())
	if(Shape == 'Ball')then
		BMesh.MeshType = Enum.MeshType.Sphere
	elseif(Shape == 'Head')then
		BMesh.MeshType = Enum.MeshType.Head
	elseif(Shape == 'Cylinder')then
		BMesh.MeshType = Enum.MeshType.Cylinder
	end

	coroutine.wrap(function()
		for i = 1, Frames do
			Pos = Pos * CF.N(0,-(Drop*i),0)
			local hit,pos,norm,dist = CastRay(Bullet.CFrame.p,CF.N(Pos.p,Direction)*CF.N(0,0,-(StudsPerFrame*i)).p,StudsPerFrame)
			if(hit and (not hit.Parent or not hit.Parent:FindFirstChildOfClass'Humanoid' and not hit.Parent:IsA'Accessory'))then
				Puddle(hit,pos,norm,data)
				break;
			else
				Bullet.CFrame = CF.N(Pos.p,Direction)*CF.N(0,0,-(StudsPerFrame*i))
			end
			swait()
		end
		Bullet:destroy()
	end)()
end

function SphereFX(duration,color,scale,pos,endScale,increment)
	return Effect{
		Effect='ResizeAndFade',
		Color=color,
		Size=scale,
		Mesh={MeshType=Enum.MeshType.Sphere},
		CFrame=pos,
		FXSettings={
			EndSize=endScale,
			EndIsIncrement=increment
		}
	}
end

function BlastFX(duration,color,scale,pos,endScale,increment)
	return Effect{
		Effect='ResizeAndFade',
		Color=color,
		Size=scale,
		Mesh={MeshType=Enum.MeshType.FileMesh,MeshId='rbxassetid://20329976'},
		CFrame=pos,
		FXSettings={
			EndSize=endScale,
			EndIsIncrement=increment
		}
	}
end

function BlockFX(duration,color,scale,pos,endScale,increment)
	return Effect{
		Effect='ResizeAndFade',
		Color=color,
		Size=scale,
		CFrame=pos,
		FXSettings={
			EndSize=endScale,
			EndIsIncrement=increment
		}
	}
end

function ShootBullet(data)
	--ShootBullet{Size=V3.N(3,3,3),Shape='Ball',Frames=160,Origin=RArm.CFrame,Speed=10}
	local Size = data.Size or V3.N(2,2,2)
	local Color = data.Color or BrickColor.new'Crimson'
	local StudsPerFrame = data.Speed or 10
	local Shape = data.Shape or 'Ball'
	local Frames = data.Frames or 160
	local Pos = data.Origin or Torso.CFrame
	local Direction = data.Direction or Mouse.Hit
	local Material = data.Material or Enum.Material.Neon
	local OnHit = data.HitFunction or function(hit,pos)
		AOEDamage(pos,10,{MinimumDamage=5,MaximumDamage=15,DamageFX={DeathFunction=GrabANoobsSoul}})
		Effect{
			Effect='ResizeAndFade',
			Color=Color,
			Size=V3.N(10,10,10),
			Mesh={MeshType=Enum.MeshType.Sphere},
			CFrame=CF.N(pos),
			FXSettings={
				EndSize=V3.N(.05,.05,.05),
				EndIsIncrement=true
			}
		}
		for i = 1, 5 do
			local angles = CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180))
			Effect{
				Effect='Fade',
				Frames=65,
				Size=V3.N(5,5,10),
				CFrame=CF.N(CF.N(pos)*angles*CF.N(0,0,-10).p,pos),
				Mesh = {MeshType=Enum.MeshType.Sphere},
				Material=Enum.Material.Neon,
				Color=Color,
				MoveDirection=CF.N(CF.N(pos)*angles*CF.N(0,0,-50).p,pos).p,
			}	
		end
	end	

	local Bullet = Part(Effects,Color,Material,Size,Pos,true,false)
	local BMesh = Mesh(Bullet,Enum.MeshType.Brick,"","",V3.N(1,1,1),V3.N())
	if(Shape == 'Ball')then
		BMesh.MeshType = Enum.MeshType.Sphere
	elseif(Shape == 'Head')then
		BMesh.MeshType = Enum.MeshType.Head
	elseif(Shape == 'Cylinder')then
		BMesh.MeshType = Enum.MeshType.Cylinder
	end

	coroutine.wrap(function()
		for i = 1, Frames+1 do
			local hit,pos,norm,dist = CastRay(Bullet.CFrame.p,CF.N(Bullet.CFrame.p,Direction.p)*CF.N(0,0,-StudsPerFrame).p,StudsPerFrame)
			if(hit)then
				OnHit(hit,pos,norm,dist)
				break;
			else
				Bullet.CFrame = CF.N(Bullet.CFrame.p,Direction.p)*CF.N(0,0,-StudsPerFrame)
			end
			swait()
		end
		Bullet:destroy()
	end)()

end


function Zap(data)
	local sCF,eCF = data.StartCFrame,data.EndCFrame
	assert(sCF,"You need a start CFrame!")
	assert(eCF,"You need an end CFrame!")
	local parts = data.PartCount or 15
	local zapRot = data.ZapRotation or {-5,5}
	local startThick = data.StartSize or 3;
	local endThick = data.EndSize or startThick/2;
	local color = data.Color or BrickColor.new'Electric blue'
	local delay = data.Delay or 35
	local delayInc = data.DelayInc or 0
	local lastLightning;
	local MagZ = (sCF.p - eCF.p).magnitude
	local thick = startThick
	local inc = (startThick/parts)-(endThick/parts)

	for i = 1, parts do
		local pos = sCF.p
		if(lastLightning)then
			pos = lastLightning.CFrame*CF.N(0,0,MagZ/parts/2).p
		end
		delay = delay + delayInc
		local zapPart = Part(Effects,color,Enum.Material.Neon,V3.N(thick,thick,MagZ/parts),CF.N(pos),true,false)
		local posie = CF.N(pos,eCF.p)*CF.N(0,0,MagZ/parts).p+V3.N(M.RNG(unpack(zapRot)),M.RNG(unpack(zapRot)),M.RNG(unpack(zapRot)))
		if(parts == i)then
			local MagZ = (pos-eCF.p).magnitude
			zapPart.Size = V3.N(endThick,endThick,MagZ)
			zapPart.CFrame = CF.N(pos, eCF.p)*CF.N(0,0,-MagZ/2)
			Effect{Effect='ResizeAndFade',Size=V3.N(thick,thick,thick),CFrame=eCF*CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180)),Color=color,Frames=delay*2,FXSettings={EndSize=V3.N(thick*8,thick*8,thick*8)}}
		else
			zapPart.CFrame = CF.N(pos,posie)*CF.N(0,0,MagZ/parts/2)
		end

		lastLightning = zapPart
		Effect{Effect='Fade',Manual=zapPart,Frames=delay}

		thick=thick-inc

	end
end

function Zap2(data)
	local Color = data.Color or BrickColor.new'Electric blue'
	local StartPos = data.Start or Torso.Position
	local EndPos = data.End or Mouse.Hit.p
	local SegLength = data.SegL or 2
	local Thicc = data.Thickness or 0.5
	local Fades = data.Fade or 45
	local Parent = data.Parent or Effects
	local MaxD = data.MaxDist or 200
	local Branch = data.Branches or false
	local Material = data.Material or Enum.Material.Neon
	local Raycasts = data.Raycasts or false
	local Offset = data.Offset or {0,360}
	local AddMesh = (data.Mesh == nil and true or data.Mesh)
	if((StartPos-EndPos).magnitude > MaxD)then
		EndPos = CF.N(StartPos,EndPos)*CF.N(0,0,-MaxD).p
	end
	local hit,pos,norm,dist=nil,EndPos,nil,(StartPos-EndPos).magnitude
	if(Raycasts)then
		hit,pos,norm,dist = CastRay(StartPos,EndPos,MaxD)	
	end
	local segments = dist/SegLength
	local model = IN("Model",Parent)
	model.Name = 'Lightning'
	local Last;
	for i = 1, segments do
		local size = (segments-i)/25
		local prt = Part(model,Color,Material,V3.N(Thicc+size,SegLength,Thicc+size),CF.N(),true,false)
		if(AddMesh)then IN("CylinderMesh",prt) end
		if(Last and math.floor(segments) == i)then
			local MagZ = (Last.CFrame*CF.N(0,-SegLength/2,0).p-EndPos).magnitude
			prt.Size = V3.N(Thicc+size,MagZ,Thicc+size)
			prt.CFrame = CF.N(Last.CFrame*CF.N(0,-SegLength/2,0).p,EndPos)*CF.A(M.R(90),0,0)*CF.N(0,-MagZ/2,0)	
		elseif(not Last)then
			prt.CFrame = CF.N(StartPos,pos)*CF.A(M.R(90),0,0)*CF.N(0,-SegLength/2,0)	
		else
			prt.CFrame = CF.N(Last.CFrame*CF.N(0,-SegLength/2,0).p,CF.N(pos)*CF.A(M.R(M.RNG(0,360)),M.R(M.RNG(0,360)),M.R(M.RNG(0,360)))*CF.N(0,0,SegLength/3+(segments-i)).p)*CF.A(M.R(90),0,0)*CF.N(0,-SegLength/2,0)
		end
		Last = prt
		if(Branch)then
			local choice = M.RNG(1,7+((segments-i)*2))
			if(choice == 1)then
				local LastB;
				for i2 = 1,M.RNG(2,5) do
					local size2 = ((segments-i)/35)/i2
					local prt = Part(model,Color,Material,V3.N(Thicc+size2,SegLength,Thicc+size2),CF.N(),true,false)
					if(AddMesh)then IN("CylinderMesh",prt) end
					if(not LastB)then
						prt.CFrame = CF.N(Last.CFrame*CF.N(0,-SegLength/2,0).p,Last.CFrame*CF.N(0,-SegLength/2,0)*CF.A(0,0,M.RRNG(0,360))*CF.N(0,Thicc*7,0)*CF.N(0,0,-1).p)*CF.A(M.R(90),0,0)*CF.N(0,-SegLength/2,0)
					else
						prt.CFrame = CF.N(LastB.CFrame*CF.N(0,-SegLength/2,0).p,LastB.CFrame*CF.N(0,-SegLength/2,0)*CF.A(0,0,M.RRNG(0,360))*CF.N(0,Thicc*7,0)*CF.N(0,0,-1).p)*CF.A(M.R(90),0,0)*CF.N(0,-SegLength/2,0)
					end
					LastB = prt
				end
			end
		end
	end
	if(Fades > 0)then
		coroutine.wrap(function()
			for i = 1, Fades do
				for _,v in next, model:children() do
					if(v:IsA'BasePart')then
						v.Transparency = (i/Fades)
					end
				end
				swait()
			end
			model:destroy()
		end)()
	else
		S.Debris:AddItem(model,.01)
	end
	return {End=(Last and Last.CFrame*CF.N(0,-Last.Size.Y/2,0).p),Last=Last,Model=model}
end

function Tween(obj,props,time,easing,direction,repeats,backwards)
	local info = TweenInfo.new(time or .5, easing or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, repeats or 0, backwards or false)
	local tween = S.TweenService:Create(obj, info, props)

	tween:Play()
end

function Effect(data)
	local FX = data.Effect or 'ResizeAndFade'
	local Parent = data.Parent or Effects
	local Color = data.Color or C3.N(0,0,0)
	local Size = data.Size or V3.N(1,1,1)
	local MoveDir = data.MoveDirection or nil
	local MeshData = data.Mesh or nil
	local SndData = data.Sound or nil
	local Frames = data.Frames or 45
	local Manual = data.Manual or nil
	local Material = data.Material or nil
	local CFra = data.CFrame or Torso.CFrame
	local Settings = data.FXSettings or {}
	local Shape = data.Shape or Enum.PartType.Block
	local Snd,Prt,Msh;
	local RotInc = data.RotInc or {0,0,0}
	if(typeof(RotInc) == 'number')then
		RotInc = {RotInc,RotInc,RotInc}
	end
	coroutine.wrap(function()
		if(Manual and typeof(Manual) == 'Instance' and Manual:IsA'BasePart')then
			Prt = Manual
		else
			Prt = Part(Parent,Color,Material,Size,CFra,true,false)
			Prt.Shape = Shape
		end
		if(typeof(MeshData) == 'table')then
			Msh = Mesh(Prt,MeshData.MeshType,MeshData.MeshId,MeshData.TextureId,MeshData.Scale,MeshData.Offset)
		elseif(typeof(MeshData) == 'Instance')then
			Msh = MeshData:Clone()
			Msh.Parent = Prt
		elseif(Shape == Enum.PartType.Block)then
			Msh = Mesh(Prt,Enum.MeshType.Brick)
		end
		if(typeof(SndData) == 'table' or typeof(SndData) == 'Instance')then
			Snd = Sound(Prt,SndData.SoundId,SndData.Pitch,SndData.Volume,false,false,true)
		end
		if(Snd)then
			repeat swait() until Snd.Playing and Snd.IsLoaded and Snd.TimeLength > 0
			Frames = Snd.TimeLength * Frame_Speed/Snd.Pitch
		end
		Size = (Msh and Msh.Scale or Size)
		local grow = Size-(Settings.EndSize or (Msh and Msh.Scale or Size)/2)

		local MoveSpeed = nil;
		if(MoveDir)then
			MoveSpeed = (CFra.p - MoveDir).magnitude/Frames
		end
		if(FX ~= 'Arc')then
			for Frame = 1, Frames do
				if(FX == "Fade")then
					Prt.Transparency  = (Frame/Frames)
				elseif(FX == "Resize")then
					if(not Settings.EndSize)then
						Settings.EndSize = V3.N(0,0,0)
					end
					if(Settings.EndIsIncrement)then
						if(Msh)then
							Msh.Scale = Msh.Scale + Settings.EndSize
						else
							Prt.Size = Prt.Size + Settings.EndSize
						end					
					else
						if(Msh)then
							Msh.Scale = Msh.Scale - grow/Frames
						else
							Prt.Size = Prt.Size - grow/Frames
						end
					end 
				elseif(FX == "ResizeAndFade")then
					if(not Settings.EndSize)then
						Settings.EndSize = V3.N(0,0,0)
					end
					if(Settings.EndIsIncrement)then
						if(Msh)then
							Msh.Scale = Msh.Scale + Settings.EndSize
						else
							Prt.Size = Prt.Size + Settings.EndSize
						end					
					else
						if(Msh)then
							Msh.Scale = Msh.Scale - grow/Frames
						else
							Prt.Size = Prt.Size - grow/Frames
						end
					end 
					Prt.Transparency = (Frame/Frames)
				end
				if(Settings.RandomizeCFrame)then
					Prt.CFrame = Prt.CFrame * CF.A(M.RRNG(-360,360),M.RRNG(-360,360),M.RRNG(-360,360))
				else
					Prt.CFrame = Prt.CFrame * CF.A(unpack(RotInc))
				end
				if(MoveDir and MoveSpeed)then
					local Orientation = Prt.Orientation
					Prt.CFrame = CF.N(Prt.Position,MoveDir)*CF.N(0,0,-MoveSpeed)
					Prt.Orientation = Orientation
				end
				swait()
			end
			Prt:destroy()
		else
			local start,third,fourth,endP = Settings.Start,Settings.Third,Settings.Fourth,Settings.End
			if(not Settings.End and Settings.Home)then endP = Settings.Home.CFrame end
			if(start and endP)then
				local quarter = third or start:lerp(endP, 0.25) * CF.N(M.RNG(-25,25),M.RNG(0,25),M.RNG(-25,25))
				local threequarter = fourth or start:lerp(endP, 0.75) * CF.N(M.RNG(-25,25),M.RNG(0,25),M.RNG(-25,25))
				for Frame = 0, 1, (Settings.Speed or 0.01) do
					if(Settings.Home)then
						endP = Settings.Home.CFrame
					end
					Prt.CFrame = Bezier(start, quarter, threequarter, endP, Frame)
				end
				if(Settings.RemoveOnGoal)then
					Prt:destroy()
				end
			else
				Prt:destroy()
				assert(start,"You need a start position!")
				assert(endP,"You need a start position!")
			end
		end
	end)()
	return Prt,Msh,Snd
end
function SoulSteal(whom)
end

--// Other Functions \\ --

function CastRay(startPos,endPos,range,ignoreList)
	local ray = Ray.new(startPos,(endPos-startPos).unit*range)
	local part,pos,norm = workspace:FindPartOnRayWithIgnoreList(ray,ignoreList or {Char},false,true)
	return part,pos,norm,(pos and (startPos-pos).magnitude)
end

function getRegion(point,range,ignore)
	return workspace:FindPartsInRegion3WithIgnoreList(R3.N(point-V3.N(1,1,1)*range/2,point+V3.N(1,1,1)*range/2),ignore,100)
end

function clerp(startCF,endCF,alpha)
	return startCF:lerp(endCF, alpha)
end

function GetTorso(char)
	return char:FindFirstChild'Torso' or char:FindFirstChild'UpperTorso' or char:FindFirstChild'LowerTorso' or char:FindFirstChild'HumanoidRootPart'
end


function ShowDamage(Pos, Text, Time, Color)
	coroutine.wrap(function()
		local Rate = (1 / Frame_Speed)
		local Pos = (Pos or Vector3.new(0, 0, 0))
		local Text = (Text or "")
		local Time = (Time or 2)
		local Color = (Color or Color3.new(1, 0, 1))
		local EffectPart = NewInstance("Part",Effects,{
			Material=Enum.Material.SmoothPlastic,
			Reflectance = 0,
			Transparency = 1,
			Name = "Effect",
			Size = Vector3.new(0,0,0),
			Anchored = true,
			CFrame = CF.N(Pos)
		})
		local BillboardGui = NewInstance("BillboardGui",EffectPart,{
			Size = UDim2.new(1.25, 0, 1.25, 0),
			Adornee = EffectPart,
		})
		local TextLabel = NewInstance("TextLabel",BillboardGui,{
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Text = Text,
			Font = "Bodoni",
			TextColor3 = C3.N(M.RNG(),M.RNG(),M.RNG()),
			TextStrokeColor3 = Color3.new(0,0,0),
			TextStrokeTransparency=0,
			TextScaled = true,
		})
		S.Debris:AddItem(EffectPart, (Time))
		EffectPart.Parent = workspace
		delay(0, function()
			Tween(EffectPart,{CFrame=CF.N(Pos)*CF.N(0,3,0)},Time,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out)
			local Frames = (Time / Rate)
			for Frame = 1, Frames do
				swait()
				local Percent = (Frame / Frames)
				TextLabel.TextTransparency = Percent
				TextLabel.TextStrokeTransparency = Percent
			end
			if EffectPart and EffectPart.Parent then
				EffectPart:Destroy()
			end
		end) end)()
end

function GrabANoobsSoul(char,hum)
end

function DealDamage(data)
end

function AOEDamage(where,range,options)
end

function AOEHeal(where,range,amount)
	local healed = {}
	for _,v in next, getRegion(where,range,{Char}) do
		local hum = (v.Parent and v.Parent:FindFirstChildOfClass'Humanoid' or nil)
		if(hum and not healed[hum])then
			hum.Health = hum.Health + amount
			if(v.Parent:FindFirstChild'Head' and hum.Health > 0)then
				ShowDamage((v.Parent.Head.CFrame * CF.N(0, 0, (v.Parent.Head.Size.Z / 2)).p+V3.N(0,1.5,0)), "+"..amount, 1.5, BrickColor.new'Lime green'.Color)
			end
		end
	end
end

--// Anti-death \\--

local REGENSOUND = 300208779
for _, c in pairs(Char:GetDescendants()) do
	if c and c.Parent then
		if c.Name == "Handle" and c.Parent.ClassName == "Accessory" then
			local ACCESSORY = c.Parent
			c.Parent = Char
			if c then
				if(c:FindFirstChild("HatAttachment") or c:FindFirstChild("FaceFrontAttachment") or c:FindFirstChild("HairAttachment"))then
					--weldBetween(Head,c)
					Weld(Head,c,CF.N(),c.CFrame:inverse()*Head.CFrame)
				else
					--weldBetween(Torso,c)
					Weld(Torso,c,CF.N(),c.CFrame:inverse()*Head.CFrame)
				end
			end
			ACCESSORY:remove()
		end
	end
end
wait()
local BODY = {}
local FULLREGEN = false
for _, c in pairs(Char:GetDescendants()) do
	if c:IsA("BasePart") and not c.Parent.Name:lower():find'secret' then
		if(c ~= Root and c ~= Torso and c ~= Head and c ~= RArm and c ~= LArm and c ~= RLeg and c ~= LLeg)then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		local REGENVALUE = IN("BoolValue",c)
		REGENVALUE.Name = "IsRegening"
		table.insert(BODY,{c,c.Parent,c.Material,c.Color,c.Transparency,c.Size,c.Name,REGENVALUE})
	elseif c:IsA("JointInstance") and c.Name ~= "AccessoryWeld" then
		table.insert(BODY,{c,c.Parent,nil,nil,nil,nil,nil,nil})
	end
end

function FullBodyRegen() -- thanks shack bb
	if not FULLREGEN then
		Sound(Head,REGENSOUND,M.RNG(80,120)/100,3,false,true,true)
		FULLREGEN = true
		Hum.MaxHealth = "inf"
		Hum.Health = "inf"
		Hum.Parent = nil
		Char.Parent = workspace
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
				local VALUE = STUFF[8]
				PART.Parent = PARENT

			end
		end
		FULLREGEN = false
		Hum = IN("Humanoid",Char)
		Hum.Died:Connect(FullBodyRegen)
	end
end

Hum.Died:connect(FullBodyRegen)

--// Attack Functions \\--

function Taunt()
	Attack = true
	NeutralAnims = false
	local oWS = WalkSpeed
	WalkSpeed = 8
	for i = 0, 6, 0.1 do
		swait()
		local Alpha = .1
		RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674868, -5.34626452e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496485233, -0.990816116, 0.0216168761, 0.980170131, 7.27576055e-11, 0.198157549, -0.00124608271, 0.999980211, 0.006163646, -0.198153645, -0.00628834311, 0.980150878),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498538613, -0.990978837, 0.0154614588, 0.974127889, 7.27576055e-11, -0.225997537, 0.00142114982, 0.999980211, 0.0061256499, 0.225993097, -0.00628834311, 0.974108756),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.21096981, 0.74825114, -0.289877862, 0.911424756, -0.398663461, 0.101844907, -0.377689809, -0.908785701, -0.177366614, 0.163264811, 0.123190522, -0.978861034),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.12800264, 0.737565041, -0.20420365, 0.897937059, 0.439862728, -0.0151603902, 0.423085958, -0.872155368, -0.245648772, -0.12127395, 0.214162976, -0.969240546),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(8.16642296e-06, 1.49894738, -0.0144004971, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
	end
	Sound(Torso,363808674,1.3,10,false,true,true)
	for i = 0, 3, 0.1 do
		swait()
		local Alpha = 1
		RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674263, 4.19029675e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496485233, -0.990816116, 0.0216168761, 0.980170131, 7.27576055e-11, 0.198157549, -0.00124608271, 0.999980211, 0.006163646, -0.198153645, -0.00628834311, 0.980150878),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498538822, -0.990978837, 0.0154605275, 0.974127889, 7.27576055e-11, -0.225997537, 0.00142114982, 0.999980211, 0.0061256499, 0.225993097, -0.00628834311, 0.974108756),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.22952282, 0.929760218, 0.0582782328, 0.898733914, -0.247438282, 0.362010598, -0.419819236, -0.723916769, 0.547445357, 0.126606628, -0.643986762, -0.754487872),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.00443649, 1.08148849, -0.22035557, 0.783190131, 0.597044468, 0.173641399, 0.566939712, -0.571022332, -0.593728125, -0.255329013, 0.563446164, -0.785707235),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(8.05407763e-06, 1.49894309, -0.0144012496, -0.0156119671, -0.0575570092, 0.998220086, -0.00628757617, 0.998327732, 0.0574648753, -0.999858439, -0.00537924562, -0.0159477536),Alpha)
	end
	Sound(Torso,363808674,1.15,10,false,true,true)
	for i = 0, 3, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674263, 4.19029675e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496485233, -0.990816116, 0.0216168761, 0.980170131, 7.27576055e-11, 0.198157549, -0.00124608271, 0.999980211, 0.006163646, -0.198153645, -0.00628834311, 0.980150878),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498533249, -0.990978837, 0.0154592311, 0.974127889, 7.27576055e-11, -0.225997537, 0.00142114982, 0.999980211, 0.0061256499, 0.225993097, -0.00628834311, 0.974108756),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.23011494, 0.825429916, -0.106563747, 0.895470679, -0.436958104, 0.0848518461, -0.313485146, -0.754420936, -0.576694131, 0.3160052, 0.48981297, -0.812541783),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.13026094, 0.666716635, -0.0574921668, 0.900917113, 0.433720857, -0.0153176785, 0.42869699, -0.883876204, 0.187034056, 0.0675816536, -0.175068855, -0.98223412),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(1.10268593e-05, 1.49894726, -0.0144011229, 0.912795186, 0.0235101581, -0.407740325, 0.00256826938, 0.997991681, 0.0632933378, 0.408409536, -0.0588210449, 0.910901666),Alpha)
	end
	WalkSpeed = oWS
	Attack = false
	NeutralAnims = true
end

function SnapAFaggotsNeck()
	local whom = (Mouse.Target and Mouse.Target.Parent)
	local hum = (whom and whom:FindFirstChildOfClass'Humanoid')
	local hed = (whom and whom:FindFirstChild'Head')
	if(whom and hum and hed and hum.Health > 0)then
		Attack = true
		NeutralAnims = false

		local oWS = WalkSpeed
		WalkSpeed = 8
		for i = 0, 12, 0.1 do
			swait()
			local Alpha = .1
			RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674868, -5.34626452e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
			LH.C0 = clerp(LH.C0,CFrame.new(-0.496485233, -0.990816116, 0.0216168761, 0.980170131, 7.27576055e-11, 0.198157549, -0.00124608271, 0.999980211, 0.006163646, -0.198153645, -0.00628834311, 0.980150878),Alpha)
			RH.C0 = clerp(RH.C0,CFrame.new(0.498538613, -0.990978837, 0.0154614588, 0.974127889, 7.27576055e-11, -0.225997537, 0.00142114982, 0.999980211, 0.0061256499, 0.225993097, -0.00628834311, 0.974108756),Alpha)
			LS.C0 = clerp(LS.C0,CFrame.new(-1.21096981, 0.74825114, -0.289877862, 0.911424756, -0.398663461, 0.101844907, -0.377689809, -0.908785701, -0.177366614, 0.163264811, 0.123190522, -0.978861034),Alpha)
			RS.C0 = clerp(RS.C0,CFrame.new(1.12800264, 0.737565041, -0.20420365, 0.897937059, 0.439862728, -0.0151603902, 0.423085958, -0.872155368, -0.245648772, -0.12127395, 0.214162976, -0.969240546),Alpha)
			NK.C0 = clerp(NK.C0,CFrame.new(8.16642296e-06, 1.49894738, -0.0144004971, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
		end
		Sound(Torso,363808674,1.3,10,false,true,true)
		NoobySphere(2,0,'Multiply',hed.CFrame,V3.N(1,1,1),.2,C3.N(M.RNG(),M.RNG(),M.RNG()),0,nil,'xyz')
		DealDamage{Who=whom,MaxHP=M.RNG(25,1e3),MinimumDamage=5,MaximumDamage=(M.RNG()*250)+5,DamageFX={DeathFunction=GrabANoobsSoul}}
		for i = 0, 6, 0.1 do
			swait()
			local Alpha = 1
			RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674263, 4.19029675e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
			LH.C0 = clerp(LH.C0,CFrame.new(-0.496485233, -0.990816116, 0.0216168761, 0.980170131, 7.27576055e-11, 0.198157549, -0.00124608271, 0.999980211, 0.006163646, -0.198153645, -0.00628834311, 0.980150878),Alpha)
			RH.C0 = clerp(RH.C0,CFrame.new(0.498538822, -0.990978837, 0.0154605275, 0.974127889, 7.27576055e-11, -0.225997537, 0.00142114982, 0.999980211, 0.0061256499, 0.225993097, -0.00628834311, 0.974108756),Alpha)
			LS.C0 = clerp(LS.C0,CFrame.new(-1.22952282, 0.929760218, 0.0582782328, 0.898733914, -0.247438282, 0.362010598, -0.419819236, -0.723916769, 0.547445357, 0.126606628, -0.643986762, -0.754487872),Alpha)
			RS.C0 = clerp(RS.C0,CFrame.new(1.00443649, 1.08148849, -0.22035557, 0.783190131, 0.597044468, 0.173641399, 0.566939712, -0.571022332, -0.593728125, -0.255329013, 0.563446164, -0.785707235),Alpha)
			NK.C0 = clerp(NK.C0,CFrame.new(8.05407763e-06, 1.49894309, -0.0144012496, -0.0156119671, -0.0575570092, 0.998220086, -0.00628757617, 0.998327732, 0.0574648753, -0.999858439, -0.00537924562, -0.0159477536),Alpha)
		end
		NoobySphere(4,0,'Multiply',Torso.CFrame,V3.N(1,1,1),.3,C3.N(M.RNG(),M.RNG(),M.RNG()),0,nil,'xyz')
		Sound(Head,300208779,.8,10,false,true,true)
		WalkSpeed = oWS
		Attack = false
		NeutralAnims = true
	end
end

function Wave()
	Attack = true
	NeutralAnims = false
	WalkSpeed = 0	
	for i = 0, 15, .1 do
		local Alpha = .1
		RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.15+.1*M.C(Sine/24),0)*CF.A(M.R(-25),0,0),Alpha)
		NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),Alpha)
		if(M.RNG(1,45) == 45)then
			NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
		end
		if(not Glitching)then
			LS.C0 = LS.C0:lerp(LSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(-5-5*M.C(Sine/24))),Alpha)
		else
			LS.C0 = LS.C0:lerp(LSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(180),0,M.R(25)+M.RRNG(-10,10)),Alpha)
		end
		RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0,0)*CF.A(M.R(180),0,M.R(0+25*M.C(Sine/6))),Alpha)
		LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(-5)),Alpha)
		RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(5)),Alpha)
		swait()
	end
	WalkSpeed = 16
	Attack = false
	NeutralAnims = true
end

function Boolets()
	Attack = true
	NeutralAnims = false
	local oWS = WalkSpeed
	WalkSpeed = 0	
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-4.68989847e-11, -1.07431245, 2.49501318e-06, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.506277919, 0.0234779716, -0.612002969, 0.999878109, -9.59694546e-11, 0.015612145, -9.81408521e-05, 0.999980211, 0.00628542574, -0.0156118376, -0.00628619269, 0.999858439),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.488053799, -1.43056154, -0.653246641, 0.999878109, -0.0152971046, 0.0031194177, -9.8173201e-05, 0.193645224, 0.981071711, -0.015611616, -0.980952501, 0.19362013),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-0.405749947, 0.473833799, -0.493766844, 0.365731448, -0.921088159, -0.133555874, 0.13443999, 0.19427453, -0.971690953, 0.920959532, 0.337422758, 0.194883406),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(0.949500263, 0.459093392, -0.375410318, 0.999878109, 0.0156117259, 7.85123193e-05, -9.8173201e-05, 0.0113163982, -0.999935985, -0.015611616, 0.999814153, 0.0113165528),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(1.00737707e-05, 1.49894547, -0.0144003704, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
	end
	for i = 1, 300 do
		NoobyBlock(2,-.3,'Multiply',RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180)),V3.N(1,1,1),0,C3.N(M.RNG(),M.RNG(),M.RNG()),25,true)
		swait()
	end
	local origin = RArm.CFrame*CF.N(0,-1,0);
	local hit,pos,norm,dist = CastRay(origin.p,Mouse.Hit.p,750)
	local ray = Part(Effects,C3.N(M.RNG(),M.RNG(),M.RNG()),Enum.Material.Neon,V3.N(2,2,dist),CF.N(origin.p,pos)*CF.N(0,0,-dist/2),true,false)
	NoobyBlock(3,0,'Multiply',CF.N(pos)*CF.A(M.RNG(0,360),M.RNG(0,360),M.RNG(0,360)),V3.N(4,4,4),-.1,C3.N(M.RNG(),M.RNG(),M.RNG()),0,true)
	Mesh(ray,Enum.MeshType.Sphere)
	for i = 1, 9 do
		NoobySphere(1,.6,"Multiply",CF.N(pos)*CF.A(M.RRNG(-360,360),M.RRNG(-360,360),M.RRNG(-360,360)),V3.N(5,5,25),-0.05,C3.N(M.RNG(),M.RNG(),M.RNG()),0)
		NoobySphere(2,.6,"Multiply",CF.N(pos)*CF.A(M.RRNG(-360,360),M.RRNG(-360,360),M.RRNG(-360,360)),V3.N(5,5,25),-0.05,C3.N(M.RNG(),M.RNG(),M.RNG()),0)
	end
	CamShakeAll(15,120,CF.N(pos))
	AOEDamage(pos,8,{MinimumDamage=100,MaximumDamage=500,MaxHP=0,DamageFX={DeathFunction=GrabANoobsSoul}})
	Sound(RArm,1202656211,.8,6,false,true,true)
	coroutine.wrap(function()
		for i = 0, 1, .05 do
			ray.Transparency = i
			swait()
		end
		ray:destroy()
	end)()
	for i = 0, .7, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-4.68989847e-11, -1.07431245, 2.49501318e-06, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.506277919, 0.0234779716, -0.612002969, 0.999878109, -9.59694546e-11, 0.015612145, -9.81408521e-05, 0.999980211, 0.00628542574, -0.0156118376, -0.00628619269, 0.999858439),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.488053799, -1.43056154, -0.653246641, 0.999878109, -0.0152971046, 0.0031194177, -9.8173201e-05, 0.193645224, 0.981071711, -0.015611616, -0.980952501, 0.19362013),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-0.405749947, 0.473833799, -0.493766844, 0.365731448, -0.921088159, -0.133555874, 0.13443999, 0.19427453, -0.971690953, 0.920959532, 0.337422758, 0.194883406),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(0.949500263, 0.459093392, 0, 0.999878109, 0.0156117259, 7.85123193e-05, -9.8173201e-05, 0.0113163982, -0.999935985, -0.015611616, 0.999814153, 0.0113165528)*CF.A(M.R(25),0,0),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(1.00737707e-05, 1.49894547, -0.0144003704, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
	end
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-4.68989847e-11, -1.07431245, 2.49501318e-06, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.506277919, 0.0234779716, -0.612002969, 0.999878109, -9.59694546e-11, 0.015612145, -9.81408521e-05, 0.999980211, 0.00628542574, -0.0156118376, -0.00628619269, 0.999858439),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.488053799, -1.43056154, -0.653246641, 0.999878109, -0.0152971046, 0.0031194177, -9.8173201e-05, 0.193645224, 0.981071711, -0.015611616, -0.980952501, 0.19362013),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-0.405749947, 0.473833799, -0.493766844, 0.365731448, -0.921088159, -0.133555874, 0.13443999, 0.19427453, -0.971690953, 0.920959532, 0.337422758, 0.194883406),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(0.949500263, 0.459093392, -0.375410318, 0.999878109, 0.0156117259, 7.85123193e-05, -9.8173201e-05, 0.0113163982, -0.999935985, -0.015611616, 0.999814153, 0.0113165528),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(1.00737707e-05, 1.49894547, -0.0144003704, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
	end

	WalkSpeed = oWS
	Attack = false
	NeutralAnims = true
end

function EnderCrusher()
	Attack = true
	NeutralAnims = false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.00522388704, 0.00628674403, -0.00522619626, 0.0688143149, -0.00627302658, -0.997609854, 2.14558099e-06, 0.99998033, -0.00628778478, 0.997629464, 0.000430549087, 0.0688129738),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496492326, -0.990816116, 0.0216155611, 0.993310273, 0, 0.115476817, -0.000726110418, 0.99998033, 0.00624586828, -0.115474544, -0.00628793286, 0.993290722),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498532742, -0.990978837, 0.0154617764, 0.994481444, 0, -0.104913011, 0.000659685873, 0.99998033, 0.00625323225, 0.10491094, -0.00628793286, 0.994461834),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.21578574, 0.745456934, 0.0146782137, -0.572345138, 0.819864511, 0.0156007186, -0.819891989, -0.572483957, 0.00629093405, 0.014088871, -0.00919030979, 0.999858677),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.46006393, 0.556873441, -0.0312470123, 0.974938631, -0.189474821, -0.116593234, 0.191492826, 0.981474221, 0.0062534851, 0.113248363, -0.0284235328, 0.993160248),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(0.00563911209, 1.52473295, -0.109123379, 0.0523908362, 0.00942024402, 0.998582244, -0.183145523, 0.983085871, 0.000334712997, -0.981688976, -0.182903409, 0.0532299653),Alpha)
	end
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.0205445699, 0.193036824, -0.986245275, 0.0668300614, -0.013895493, -0.997667611, 0.487526804, 0.872867286, 0.0205003377, 0.870546579, -0.487759739, 0.0651082024),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.653007567, -1.04005051, 0.0135816727, 0.875705957, 0.473324358, 0.0954113901, -0.468000621, 0.880668044, -0.0734798834, -0.118805602, 0.0196941663, 0.992722213),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.572268248, -0.862032056, 0.0185812451, 0.875338256, 0.473323733, -0.0987298191, -0.472729653, 0.880668402, 0.0308205243, 0.101536319, 0.0196941309, 0.994636893),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.50244987, 0.677883029, 0.00128105097, 0.880246103, 0.474452406, 0.00785287656, -0.474386185, 0.879492998, 0.0380767621, 0.0111590661, -0.0372422226, 0.999243975),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.46005797, 0.556865275, -0.0312457234, 0.974938869, -0.189474136, -0.116593227, 0.191492081, 0.98147428, 0.00625339895, 0.113248393, -0.0284233708, 0.993160188),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(0.00564883649, 1.52473044, -0.109123766, 0.0523897149, 0.00942194462, 0.998582244, -0.183142692, 0.983086407, 0.000332683325, -0.981689572, -0.182900488, 0.0532291718),Alpha)
	end
end

function BurnInHell()
	Attack = true
	NeutralAnims = false
	local oWS = WalkSpeed
	WalkSpeed = 0
	for i = 0, 4, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(0.00485810312, 0.0316153169, 0.311138451, 0.999987781, 0.00486974791, -0.000811986625, -0.00487500243, 0.948008895, -0.318206728, -0.000779815018, 0.318206787, 0.948021114),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.510864973, -0.229482889, -0.90414387, 0.999878109, -0.00487500243, 0.014832234, -9.87363892e-05, 0.948008895, 0.31824407, -0.0156125315, -0.318206728, 0.947892845),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498864055, -1.05720699, 0.0368085802, 0.999878109, -0.00487500243, 0.014832234, -9.87363892e-05, 0.948008895, 0.31824407, -0.0156125315, -0.318206728, 0.947892845),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.35505569, 0.670614362, -0.223142803, 0.959186316, 0.282539397, -0.0115337875, 0.200012222, -0.706719875, -0.678632736, -0.199891627, 0.648628354, -0.734387398),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.36051559, 0.693020046, -0.238958716, 0.964897394, -0.262373805, -0.0115305167, -0.200247049, -0.70659554, -0.678692877, 0.169923812, 0.657177925, -0.734331787),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(7.16691147e-06, 1.49894702, -0.0144103244, 1, -2.56579369e-07, -9.6578151e-07, 3.18512321e-07, 0.997964621, 0.0637722015, 9.47155058e-07, -0.0637722015, 0.997964621),Alpha)
	end
	local hit,pos = CastRay(Root.CFrame.p,Root.CFrame*CF.N(0,-100,0).p,4)
	if(hit)then
		Sound(Root,331666100,1,10,false,true,true)
		NoobySphere(6,0,'Multiply',CF.N(pos),V3.N(25,.1,25),3,C3.N(M.RNG(),M.RNG(),M.RNG()),0,nil,'xz')
		NoobySphere(6,0,'Multiply',CF.N(pos),V3.N(27,.1,27),3,C3.N(M.RNG(),M.RNG(),M.RNG()),0,20329976,'xyz')
		CamShakeAll(25,480,CF.N(pos))
		AOEDamage(pos,100,{MinimumDamage=65,MaximumDamage=125,DamageFX={DeathFunction=GrabANoobsSoul}})
		for i = 0, 6, 0.1 do
			swait()
			local Alpha = .7
			RJ.C0 = clerp(RJ.C0,CFrame.new(-0.00231076009, 0.00770531036, -0.147999823, 0.99999398, -0.00343433861, -0.00036024116, 0.00343199959, 0.976900637, 0.213666588, -0.000381881371, -0.213666543, 0.976906598),Alpha)
			LH.C0 = clerp(LH.C0,CFrame.new(-0.507900298, -0.858686984, -0.710240602, 0.999878109, 0.00343199959, 0.0152302161, -9.81268749e-05, 0.976900637, -0.213694125, -0.015611805, 0.213666588, 0.976781964),Alpha)
			RH.C0 = clerp(RH.C0,CFrame.new(0.497379601, -1.00486779, -0.0586356819, 0.999878109, 0.00343199959, 0.0152302161, -9.81268749e-05, 0.976900637, -0.213694125, -0.015611805, 0.213666588, 0.976781964),Alpha)
			LS.C0 = clerp(LS.C0,CFrame.new(-1.32998621, 0.381940007, -0.114178419, 0.976541102, -0.214856252, 0.0142948823, 0.202841416, 0.895589113, -0.395949066, 0.0722698048, 0.389560163, 0.918161273),Alpha)
			RS.C0 = clerp(RS.C0,CFrame.new(1.33391047, 0.313477397, -0.14020586, 0.964281619, 0.264514685, 0.0138949398, -0.230238646, 0.862955749, -0.4497751, -0.130962834, 0.4305107, 0.893033922),Alpha)
			NK.C0 = clerp(NK.C0,CFrame.new(9.53666768e-06, 1.49893439, -0.0143984929, 1, 0, -9.31322575e-10, 0, 0.99796474, 0.0637705624, 9.31322575e-10, -0.0637705922, 0.99796474),Alpha)
		end	

		Sound(Head,907332997,1,5,false,true,true)
	end
	WalkSpeed = oWS
	Attack = false
	NeutralAnims = true
end

function Punch1()
	Attack = true
	NeutralAnims = false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.00303284684, -0.00845655054, 0.018393999, 0.829989552, -0.00170222612, -0.557776392, -0.0659508482, 0.992681146, -0.101166509, 0.553866267, 0.120752975, 0.82380271),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.498080581, -0.967759907, -0.0813563764, 0.999878287, 0.00258669257, 0.0153926909, -9.47788358e-05, 0.987160385, -0.159732834, -0.0156083405, 0.159711912, 0.987040341),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.551928759, -0.937464952, 0.0919702426, 0.997745395, -0.0659520403, 0.0124365687, 0.0643434152, 0.992680907, 0.102198936, -0.0190857947, -0.101168282, 0.994686365),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.19935811, 0.247517601, 0.102068216, 0.862561703, -0.47241962, -0.181127191, 0.5056777, 0.793171406, 0.339366257, -0.0166583657, -0.384316325, 0.923051357),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.36349249, 0.481498182, 0.454916179, 0.961948335, -0.273231745, 2.82377005e-06, 0.00172190368, 0.00605178624, -0.999980271, 0.273226321, 0.961929321, 0.00629197806),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(5.7220459e-06, 1.59853172, -0.197701856, 0.8530972, 0.111252025, -0.509753108, 0.0332853794, 0.963407874, 0.265965462, 0.520689368, -0.24386172, 0.818177402),Alpha)
	end
	Sound(RArm,138097048,.8,5,false,true,true)
	CamShake(Char,10,20)
	for i = 0, 1, 0.1 do
		swait()
		AOEDamage(Hitbox.CFrame.p,1,{BreakGlass=true,MinimumDamage=25,MaximumDamage=45,DamageFX={DeathFunction=GrabANoobsSoul}})
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(0.221829414, -0.041221004, -0.167406395, 0.655658543, -0.0240739044, 0.7546736, -0.126397654, 0.981888115, 0.141135931, -0.744402826, -0.187925935, 0.640740454),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.38520214, -0.664491296, -0.834472895, 0.959806442, 0.145656854, -0.239907712, -0.00527707487, 0.864004254, 0.503456831, 0.280613184, -0.481955111, 0.830045581),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.541060686, -0.867475212, -0.0686345175, 0.300405502, -0.230044976, -0.925654411, 0.0495565683, 0.972932756, -0.225711957, 0.952523351, 0.0219328459, 0.303674638),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.19936907, 0.247526154, 0.10210143, 0.862560809, -0.472424746, -0.181118309, 0.505679011, 0.793172836, 0.339360535, -0.016664207, -0.384306818, 0.923055112),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.32535827, 0.626296461, -0.365535617, 0.667200208, -0.734076262, 0.126396075, -0.0211371183, -0.188276812, -0.981888533, 0.744578481, 0.652444601, -0.14113459),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(0.109995492, 1.54714108, -0.197692186, 0.891068459, 0.111260638, -0.44002074, 0.0119341798, 0.963409364, 0.267768592, 0.453712255, -0.243851393, 0.857135892),Alpha)
	end
	NoobySphere(2,0,'Multiply',RArm.CFrame*CF.N(0,-1.25,0),V3.N(1,1,1),.02,C3.N(M.RNG(),M.RNG(),M.RNG()),0,nil,'xyz')
	CliccAttack = 1
	Attack = false
	NeutralAnims = true
end

function Punch2()
	Attack = true
	NeutralAnims = false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(0.00346098561, 0.00628894754, -0.0012467528, 0.726998925, 0.0043156785, 0.686625063, -1.47682942e-06, 0.99998033, -0.00628366228, -0.686638534, 0.00456720171, 0.72698462),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.526590466, -0.738100231, -0.162178785, 0.998713851, 0.0483061969, 0.015406251, -0.0501749068, 0.985334337, 0.163092062, -0.00730189681, -0.163655281, 0.986490667),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498546928, -0.990978956, 0.0154537652, 0.737630069, 0, -0.675205052, 0.00424381625, 0.99998033, 0.00463617174, 0.67519176, -0.00628522551, 0.737615526),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.39983284, 0.47202, 0.441156834, 0.974284291, 0.225321591, 0.000400889665, -0.006716704, 0.0308211353, -0.99950248, -0.225221843, 0.973796844, 0.0315419659),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.12138152, 0.390171707, 0.100771606, 0.894619286, 0.425640225, -0.135966122, -0.326698512, 0.830674589, 0.450830519, 0.3048352, -0.358901739, 0.882193387),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(7.91251659e-06, 1.49894547, -0.0143923312, 0.911271095, -0.0442877896, 0.409418523, -0.0262595415, 0.985927641, 0.165097922, -0.41096884, -0.161200091, 0.897284389),Alpha)
	end
	Sound(LArm,138097048,.85,5,false,true,true)
	CamShake(Char,10,20)
	for i = 0, 1, 0.1 do
		swait()
		AOEDamage(Hitbox2.CFrame.p,1,{BreakGlass=true,MinimumDamage=25,MaximumDamage=45,DamageFX={DeathFunction=GrabANoobsSoul}})
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(0.136174262, 0.00628654659, -0.0922046751, 0.677523315, -0.00462364964, -0.735486805, 1.58175465e-06, 0.99998033, -0.0062849354, 0.735501349, 0.00425702613, 0.677509904),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.526590168, -0.738105536, -0.162170187, 0.998713851, 0.0483057015, 0.015409112, -0.050174918, 0.985334039, 0.163093939, -0.00730475783, -0.163657293, 0.98649025),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498551786, -0.990978837, 0.0154557731, 0.73763144, 0, -0.675203681, 0.00424459483, 0.99998033, 0.0046370402, 0.67519033, -0.00628639245, 0.737616837),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.25003541, 0.491848499, -0.0866259038, 0.787719667, 0.616033971, 0.000401966274, -0.0191161502, 0.025095908, -0.999502361, -0.615737379, 0.787319839, 0.0315447338),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.1213876, 0.39017421, 0.100768551, 0.894620538, 0.425638735, -0.135962933, -0.326698095, 0.83067435, 0.450831085, 0.304832101, -0.358903915, 0.882193565),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(4.991889e-06, 1.49894702, -0.0143903494, 0.742484093, -0.0442790203, 0.668398857, -0.0754856765, 0.985926628, 0.149166599, -0.665597081, -0.161208332, 0.728692353),Alpha)
	end
	NoobySphere(2,0,'Multiply',LArm.CFrame*CF.N(0,-1.25,0),V3.N(1,1,1),.02,C3.N(M.RNG(),M.RNG(),M.RNG()),0,nil,'xyz')

	CliccAttack = 2
	Attack = false
	NeutralAnims = true
end

function Balls()
	Attack = true
	NeutralAnims = false
	local col = C3.N(M.RNG(),M.RNG(),M.RNG())

	for i = 0, .7, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.00215275097, 0.00629182765, -0.00059090578, 0.900342047, -0.00273694564, -0.435174465, 9.35837932e-07, 0.999980211, -0.00628724555, 0.435183108, 0.00566026382, 0.900324225),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.469716221, -1.06538355, 0.0258644074, 0.974693179, 0.142052263, 0.172611207, -0.143726677, 0.989613414, -0.00282384129, -0.171219468, -0.0220564567, 0.984986067),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498543769, -0.990978837, 0.0154537726, 0.982019305, 0, 0.188781217, -0.00118727924, 0.999980211, 0.00617609732, -0.188777432, -0.00628918223, 0.981999874),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.46611869, 0.607237041, 0.019460775, 0.975984871, 0.217278525, 0.01561445, -0.217396572, 0.976063132, 0.0062906472, -0.0138738751, -0.00953410566, 0.999858379),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.21949148, 0.508351624, 0.358449012, 0.860025883, -0.505158067, 0.0719099715, 0.0637161881, -0.0335059837, -0.99740541, 0.506256819, 0.862376273, 0.00337073021),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(7.62939544e-06, 1.49894273, -0.0144160762, 1.00000012, 0, 0, 0, 0.99796468, 0.0637711138, 0, -0.0637711212, 0.997964621),Alpha)
	end
	Sound(LArm,138097048,.8,5,false,true,true)
	for i = 0, .7, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.189023629, 0.00628119428, 0.0795610398, 0.764717221, 0.00405249046, 0.64435333, -1.38591895e-06, 0.99998033, -0.00628746813, -0.644366086, 0.00480724219, 0.764702141),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.469702303, -1.06538916, 0.0258520916, 0.921251655, 0.142055079, 0.362099022, -0.140328288, 0.989613056, -0.0312121194, -0.362771749, -0.0220585242, 0.931616962),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.49855575, -0.990978956, 0.0154509144, 0.971297801, 0, -0.237866998, 0.00149597228, 0.99998033, 0.00610860158, 0.237862319, -0.00628911238, 0.971278608),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.45857167, 0.644691706, -0.0370098501, 0.975984752, 0.212625384, -0.0473736525, -0.217396557, 0.936839819, -0.27398926, -0.0138756037, 0.277708232, 0.960565329),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.20919418, 0.515175998, -0.398130298, 0.808712423, -0.588204265, 0, 0.00369928288, 0.00508608343, -0.99998033, 0.588192701, 0.808696389, 0.00628911238),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(1.44699588e-05, 1.49894357, -0.0144186728, 0.921718836, 0, -0.387858808, 0.00243928749, 0.99998033, 0.00579679385, 0.387851059, -0.00628911238, 0.921700656),Alpha)
	end
	SoundPart(206083252,.8,4,false,true,true,RArm.CFrame*CF.N(0,-1.25,0))
	CamShake(Char,25,45,RArm.CFrame*CF.N(0,-1.25,0))
	AOEDamage(RArm.CFrame*CF.N(0,-1.25,0).p,4,{MinimumDamage=35,MaximumDamage=65,DamageFX={DeathFunction=GrabANoobsSoul}})
	for i = 1, 10 do
		NoobySphere(2,.1,'Multiply',RArm.CFrame*CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180)),V3.N(1.5,1.5,1.5),-.01,col,0,nil,'xyz')
	end
	NoobySphere(2,0,'Multiply',RArm.CFrame*CF.N(0,-1.25,0),V3.N(2,2,2),.02,col,0,nil,'xyz')
	NoobySphere(4,0,'Multiply',RArm.CFrame*CF.N(0,-1.25,0),V3.N(2,2,2),.1,col,0,nil,'xyz')
	NoobySphere(2,0,'Multiply',RArm.CFrame*CF.N(0,-1.25,0)*CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180)),V3.N(2.5,1.25,2.5),.02,col,0,1058822174,'xyz')
	CliccAttack = 3
	Attack = false
	NeutralAnims = true
end

function Spin()
	Attack = true
	NeutralAnims = false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(-0.130551443, 0.00628537219, -0.069158569, 0.567979217, 0.00517133344, 0.823026657, -1.77017421e-06, 0.99998033, -0.00628196634, -0.823042929, 0.00356656965, 0.567967951),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496484399, -0.990816236, 0.021614084, 0.999878287, 0, 0.015612185, -9.80941113e-05, 0.99998033, 0.00628242362, -0.0156118274, -0.00628318777, 0.999858499),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498544514, -0.990978956, 0.0154505149, 0.999878287, 0, 0.015612185, -9.80941113e-05, 0.99998033, 0.00628242362, -0.0156118274, -0.00628318777, 0.999858499),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-0.867346704, 0.364127517, -0.592892349, 0.343383282, -0.928154707, 0.143585742, 0.611392558, 0.104853727, -0.784350157, 0.7129426, 0.357119888, 0.603471875),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(0.586915255, 0.520536065, -0.638412833, 0.340278387, 0.762223601, 0.550659537, 0.0388735868, 0.573702097, -0.818141103, -0.939520955, 0.299801826, 0.165588096),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(4.76837204e-06, 1.49894536, -0.0143966526, 1.00000012, 0, 0, -2.32830644e-10, 0.997965157, 0.0637637973, 2.98023224e-08, -0.0637638047, 0.997965038),Alpha)
	end
	for i = 0, 1, .06 do
		swait()
		local col = C3.N(M.RNG(),M.RNG(),M.RNG())
		for i = 1, 3 do
			NoobySphere(5,.1,'Multiply',Torso.CFrame*CF.N(-8,0,0)*CF.A(M.RRNG(-180,180),M.RRNG(-180,180),M.RRNG(-180,180)),V3.N(1,1,1),-.01,col,0,nil,'xyz')
		end
		SoundPart(206083252,1.2,1.6,false,true,true,Torso.CFrame*CF.N(-8,0,0))
		NoobySphere(5,0,'Multiply',Torso.CFrame*CF.N(-8,0,0),V3.N(1.5,1.5,1.5),.02,col,0,nil,'xyz')
		AOEDamage(Torso.CFrame*CF.N(-8,0,0).p,3,{MinimumDamage=35,MaximumDamage=65,DamageFX={DeathFunction=GrabANoobsSoul}})
		local Alpha = 1
		RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674868, -5.34626452e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271)*CF.A(0,M.R(i*385),0),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.496486187, -0.990818024, 0.0216199681, 0.999878109, -9.59694546e-11, 0.015612145, -9.81408521e-05, 0.999980211, 0.00628542574, -0.0156118376, -0.00628619269, 0.999858439),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.498537898, -0.990980625, 0.0154640935, 0.999878109, -9.59694546e-11, 0.015612145, -9.81408521e-05, 0.999980211, 0.00628542574, -0.0156118376, -0.00628619269, 0.999858439),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.452793, 0.502107382, 0.0199129172, -4.37788152e-08, 0.999878109, 0.0156119233, -0.999980211, -9.82169149e-05, 0.00628757617, 0.00628834357, -0.015611616, 0.999858439),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.42737567, 0.494466186, -0.0250103828, -4.36333032e-08, -0.999878109, 0.0156119233, 0.999980211, 9.8129487e-05, 0.00628757617, -0.00628834264, 0.015611616, 0.999858439),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(4.35172615e-06, 1.49894738, -0.0144014433, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
	end
	for i = 0, 1.2, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = clerp(RJ.C0,CFrame.new(0.427243918, -0.920417011, 0.0234051645, 0.679439783, 0.549923182, -0.485742748, -0.444893807, 0.83520782, 0.323260784, 0.583464742, -0.00353231793, 0.812130868)*CF.A(0,M.R(-8.22),0),Alpha)
		LH.C0 = clerp(LH.C0,CFrame.new(-0.176611602, -0.983374894, -0.89919436, 0.920897245, -0.048158884, -0.386819303, 0.319696367, 0.661085546, 0.678793311, 0.223030806, -0.748763561, 0.624187946),Alpha)
		RH.C0 = clerp(RH.C0,CFrame.new(0.359278589, 0.0876072049, -0.182106972, 0.910182238, -0.403486162, 0.0936347246, 0.411501646, 0.855026662, -0.315588117, 0.047275275, 0.325773478, 0.944265127),Alpha)
		LS.C0 = clerp(LS.C0,CFrame.new(-1.31082213, 0.463033974, 0.0179460477, 0.925886035, 0.377480268, 0.0156087875, -0.37760976, 0.925943553, 0.00628813449, -0.0120791793, -0.0117161274, 0.999858379),Alpha)
		RS.C0 = clerp(RS.C0,CFrame.new(1.46370375, 0.0682249963, -0.0286035687, 0.883351564, -0.45030269, 0.130067378, 0.468411744, 0.858031332, -0.210648447, -0.0167463124, 0.247001737, 0.968870401),Alpha)
		NK.C0 = clerp(NK.C0,CFrame.new(2.31595841e-05, 1.49894369, -0.0143923387, 0.980648994, -0.195774525, -3.27825546e-07, 0.195376158, 0.978653729, 0.0637584627, -0.0124819279, -0.0625247359, 0.997965455),Alpha)
	end	
	CliccAttack = 0
	Attack = false
	NeutralAnims = true
end

--// Wrap it all up \\--

local Playlist = {
	MusicID,
	1696854181,
	1259371424,
	1274310715,
	943961217,
	206425245,
	623662713,
	1547875818,
	1470848774,
	915169951
}
local nums = {Enum.KeyCode.One,Enum.KeyCode.Two,Enum.KeyCode.Three,Enum.KeyCode.Four,Enum.KeyCode.Five,Enum.KeyCode.Six,Enum.KeyCode.Seven,Enum.KeyCode.Eight,Enum.KeyCode.Nine,Enum.KeyCode.Zero}

function KeyToNum(kc)
	for i,v in next, nums do
		if(v == kc)then
			return i
		end
	end
	return 0
end

S.UserInputService.InputBegan:connect(function(io,gpe)
	if(gpe)then return end
	local num = KeyToNum(io.KeyCode)
	if(num and Playlist[num])then
		MusicID = Playlist[num]
	end
	if(io.KeyCode == Enum.KeyCode.M)then
		MusicParent = (MusicParent == miniRadio and PlrGui or miniRadio)
		warn("Music is now in "..MusicParent.Name)
		Music:Pause()
	end
	if(Attack)then return end
	if(io.KeyCode == Enum.KeyCode.LeftControl)then
		WalkSpeed = (WalkSpeed == 16 and 50 or 16)
	elseif(io.KeyCode == Enum.KeyCode.T)then
		Taunt()
	elseif(io.KeyCode == Enum.KeyCode.Z)then
		Boolets()
	elseif(io.KeyCode == Enum.KeyCode.X)then
		BurnInHell()
	elseif(io.KeyCode == Enum.KeyCode.C)then
		SnapAFaggotsNeck()
	end

end)

Mouse.Button1Down:connect(function()
	if(Attack)then return end
	if(CliccAttack == 0)then
		Punch1()
	elseif(CliccAttack == 1)then
		Punch2()	
	elseif(CliccAttack == 2)then
		Balls()	
	elseif(CliccAttack == 3)then
		Spin()	
	end
end)

Plr.Chatted:connect(function(m)
	if(Attack)then return end
	if(m == '/e wave')then
		Wave()
	end
end)

local col = {
	RLeg.Color,
	LLeg.Color,
	RArm.Color,
	LArm.Color,
	Head.Color,
	Torso.Color
}

local Nametags = {"EnDeR","ender","3ND37","3nd37","end3r","end37","3nder","3nde7","ENDer","eNDER","eNder","enDer","endEr","endeR","H3LP"}
coroutine.wrap(function()
	while true do
		if(M.RNG(1,200) == 1 and not Glitching)then
			Glitching = true
			swait(M.RNG(15,30))
			Glitching = false
		end
		swait()
	end	
end)()

local Meshes = {}

for _,v in next, Char:GetDescendants() do
	if(v:IsA'DataModelMesh')then
		table.insert(Meshes,v)
	end
end

while true do
	swait()
	Sine = Sine + Change
	if(not Music or not Music.Parent)then
		local tp = (Music and Music.TimePosition)
		Music = Sound(MusicParent,MusicID,1,10,true,false,true)
		Music.Name = 'Music'
		Music.TimePosition = tp
	end
	--
	Music.SoundId = "rbxassetid://"..MusicID
	Music.Parent = MusicParent
	Music.Pitch = .85
	Music.Volume = (MusicParent ~= PlrGui and Plr.UserId ~= 5719877 and 1 or 5)
	Music.Playing = not Glitching

	if(not Static or not Static.Parent)then
		local tp = (Static and Static.TimePosition)
		Static = Sound(Torso,MusicID,1,10,true,false,true)
		Static.Name = 'Music'
		Static.TimePosition = tp
	end
	Static.SoundId = "rbxassetid://1588058260"
	Static.Parent = Torso
	Static.Pitch = M.RNG(90,95)/100
	Static.Volume = 5

	miniRadio.Color = C3.N(M.RNG(),M.RNG(),M.RNG())
	if(God)then
		Hum.MaxHealth = 1e100
		Hum.Health = 1e100
		if(not Char:FindFirstChildOfClass'ForceField')then IN("ForceField",Char).Visible = false end
		Hum.Name = M.RNG()*100
	end

	local hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4*PlayerSize)), Char)

	local Walking = (math.abs(Root.Velocity.x) > 1 or math.abs(Root.Velocity.z) > 1)
	local State = (Hum.PlatformStand and 'Paralyzed' or Hum.Sit and 'Sit' or not hitfloor and Root.Velocity.y < -1 and "Fall" or not hitfloor and Root.Velocity.y > 1 and "Jump" or hitfloor and Walking and (Hum.WalkSpeed < 24 and "Walk" or "Run") or hitfloor and "Idle")
	if(not Effects or not Effects.Parent)then
		Effects = IN("Model",Char)
		Effects.Name = "Effects"
	end																																																																																																				
	if(State == 'Run')then
		local wsVal = 16 / (Hum.WalkSpeed/16)
		local Alpha = math.min(.2 * (Hum.WalkSpeed/16),1)
		Change = 1
		RH.C1 = RH.C1:lerp(CF.N(0,1-.5*M.C(Sine/wsVal)/2,.5*M.C(Sine/wsVal)/2)*CF.A(M.R(25-15*M.C(Sine/wsVal))+-M.S(Sine/wsVal)/2,0,0),Alpha)
		LH.C1 = LH.C1:lerp(CF.N(0,1+.5*M.C(Sine/wsVal)/2,-.5*M.C(Sine/wsVal)/2)*CF.A(M.R(25+15*M.C(Sine/wsVal))+M.S(Sine/wsVal)/2,0,0),Alpha)
	elseif(State == 'Walk')then
		local wsVal = 7 / (Hum.WalkSpeed/16)
		local Alpha = math.min(.15 * (Hum.WalkSpeed/16),1)
		Change = 1
		RH.C1 = RH.C1:lerp(CF.N(0,1-.5*M.C(Sine/wsVal)/2,.5*M.C(Sine/wsVal)/2)*CF.A(M.R(15-5*M.C(Sine/wsVal))+-M.S(Sine/wsVal)/2,0,0),Alpha)
		LH.C1 = LH.C1:lerp(CF.N(0,1+.5*M.C(Sine/wsVal)/2,-.5*M.C(Sine/wsVal)/2)*CF.A(M.R(15+5*M.C(Sine/wsVal))+M.S(Sine/wsVal)/2,0,0),Alpha)
	else
		RH.C1 = RH.C1:lerp(CF.N(0,1,0),.2)
		LH.C1 = LH.C1:lerp(CF.N(0,1,0),.2)
	end

	mota1.C0 = mota1.C0:lerp(CF.A(0,M.RRNG(-180,180),M.R(90)),.2)

	Hum.WalkSpeed = WalkSpeed
	if(Remove_Hats)then Instance.ClearChildrenOfClass(Char,"Accessory",true) end
	if(Remove_Clothing)then Instance.ClearChildrenOfClass(Char,"Clothing",true) Instance.ClearChildrenOfClass(Char,"ShirtGraphic",true) end

	for _,v in next, NeonParts do
		v.Color = C3.N(M.RNG(),M.RNG(),M.RNG())
	end

	tecks2.TextStrokeColor3 = C3.N(M.RNG(),M.RNG(),M.RNG())
	if(Glitching)then
		Static:Resume()
		Music:Pause()
		RA.Parent = RArm
		LA.Parent = LArm
		FT.Parent = Torso
		RL.Parent = RLeg
		LL.Parent = LLeg
		for _,v in next, Meshes do
			v.Offset = V3.N(M.RNG(-15,15)/100,M.RNG(-15,15)/100,M.RNG(-15,15)/100)
		end
		tecks2.Text = Nametags[M.RNG(1,#Nametags)].."?"
		RLeg.Color = C3.N(M.RNG(),M.RNG(),M.RNG())	
		LLeg.Color = C3.N(M.RNG(),M.RNG(),M.RNG())
		RArm.Color = C3.N(M.RNG(),M.RNG(),M.RNG())	
		LArm.Color = C3.N(M.RNG(),M.RNG(),M.RNG())	
		Torso.Color = C3.N(M.RNG(),M.RNG(),M.RNG())	
		Head.Color = C3.N(M.RNG(),M.RNG(),M.RNG())	

		RLeg.Material = Enum.Material.Neon
		LLeg.Material = Enum.Material.Neon
		RArm.Material = Enum.Material.Neon
		LArm.Material = Enum.Material.Neon
		Torso.Material = Enum.Material.Neon	
		Head.Material = Enum.Material.Neon	
	else
		for _,v in next, Meshes do
			v.Offset = V3.N(0,0,0)
		end
		Static:Stop()
		Music:Resume()
		RA.Parent = nil
		LA.Parent = nil
		FT.Parent = nil
		RL.Parent = nil
		LL.Parent = nil
		tecks2.Text = "Ender?"
		RLeg.Color = col[1]
		LLeg.Color = col[2]
		RArm.Color = col[3]
		LArm.Color = col[4]
		Head.Color = col[5]
		Torso.Color = col[6]
		RLeg.Material = Enum.Material.SmoothPlastic
		LLeg.Material = Enum.Material.SmoothPlastic
		RArm.Material = Enum.Material.SmoothPlastic
		LArm.Material = Enum.Material.SmoothPlastic
		Torso.Material = Enum.Material.SmoothPlastic
		Head.Material = Enum.Material.SmoothPlastic
	end
	if(NeutralAnims)then	
		if(State == 'Idle')then
			local Alpha = .1
			Change = 1
			NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),.3)
			if(M.RNG(1,45) == 45)then
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
			end
			if(not Glitching)then
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.15+.1*M.C(Sine/24),0)*CF.A(M.R(-25),0,0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(-5-5*M.C(Sine/24))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(5+5*M.C(Sine/24))),Alpha)
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(-5)),Alpha)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(25),0,M.R(5)),Alpha)
			else
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.2+.1*M.C(Sine/24),0)*CF.A(M.R(-45),0,0),1)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(180),0,M.R(25)+M.RRNG(-10,10)),1)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(180),0,M.R(-25)+M.RRNG(-10,10)),1)
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(45),0,M.R(-5)),1)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(45),0,M.R(5)),1)
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-10,10),0),.1)
			end
			-- idle
		elseif(State == 'Run')then
			local wsVal = 16 / (Hum.WalkSpeed/16)
			local Alpha = math.min(.15 * (Hum.WalkSpeed/16),1)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),.3)
			if(M.RNG(1,45) == 45)then
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
			end
			RJ.C0 = RJ.C0:lerp(CF.N(0,-.075+.1*M.C(Sine/(wsVal/2)+-M.S(Sine/(wsVal/2))/7),0)*CF.A(M.R(-25-2.5*M.C(Sine/(wsVal/2))),M.R(8*M.C(Sine/wsVal)),Root.RotVelocity.y/75),Alpha)
			LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0,-.27*M.C(Sine/wsVal))*CF.A(M.R(75*M.C(Sine/wsVal)),0,M.R(-5-7*M.S(Sine/wsVal))+LArm.RotVelocity.y/35),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0,.27*M.C(Sine/wsVal))*CF.A(M.R(-75*M.C(Sine/wsVal)),0,M.R(5+7*M.S(Sine/wsVal))+RArm.RotVelocity.y/35),Alpha)
			LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.1*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(25+2.5*M.C(Sine/(wsVal/2))),0,0),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.1*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(25+2.5*M.C(Sine/(wsVal/2))),0,0),Alpha)
		elseif(State == 'Walk')then
			local wsVal = 7 / (Hum.WalkSpeed/16)
			local Alpha = math.min(.15 * (Hum.WalkSpeed/16),1)			
			NK.C0 = NK.C0:lerp(NKC0*CF.A(0,-Head.RotVelocity.y/75,0)*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),.3)
			if(M.RNG(1,45) == 45)then
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
			end
			if(not Glitching)then
				RJ.C0 = RJ.C0:lerp(CF.N(0,-.075+.1*M.C(Sine/(wsVal/2)+-M.S(Sine/(wsVal/2))/7),0)*CF.A(M.R(-15-2.5*M.C(Sine/(wsVal/2))),M.R(4*M.C(Sine/wsVal)),Root.RotVelocity.y/75),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0,-.27*M.C(Sine/wsVal))*CF.A(M.R(45*M.C(Sine/wsVal)),0,M.R(-5-7*M.S(Sine/wsVal))+LArm.RotVelocity.y/35),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0,.27*M.C(Sine/wsVal))*CF.A(M.R(-45*M.C(Sine/wsVal)),0,M.R(5+7*M.S(Sine/wsVal))+RArm.RotVelocity.y/35),Alpha)
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.1*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(15+2.5*M.C(Sine/(wsVal/2))),M.R(-4*M.C(Sine/wsVal)),0),Alpha)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.1*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(15+2.5*M.C(Sine/(wsVal/2))),M.R(-4*M.C(Sine/wsVal)),0),Alpha)
			else
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,-.2+.1*M.C(Sine/24),0)*CF.A(M.R(-45),0,0),1)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(180),0,M.R(25)+M.RRNG(-10,10)),1)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,.1*M.C(Sine/24),0)*CF.A(M.R(180),0,M.R(-25)+M.RRNG(-10,10)),1)
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(45),0,M.R(-5)),1)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.1*M.C(Sine/24),0)*CF.A(M.R(45),0,M.R(5)),1)
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,-.2)*CF.A(M.R(-25),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-10,10),0),.1)
			end

		elseif(State == 'Jump')then
			local Alpha = .1
			local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),Alpha)
			if(M.RNG(1,45) == 45)then
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
			end
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		elseif(State == 'Fall')then
			local Alpha = .1
			local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)+idk),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)-idk),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0)*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),Alpha)
			if(M.RNG(1,45) == 45)then
				NK.C0 = NK.C0:lerp(NKC0*CF.N(0,0,0)*CF.A(M.RRNG(15,65),M.RRNG(-35,35),0),1)
			end
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		elseif(State == 'Paralyzed')then
			-- paralyzed
		elseif(State == 'Sit')then
			local Alpha = .1
			RJ.C0 = clerp(RJ.C0,CFrame.new(2.74447132e-13, 0.00628674868, -5.34626452e-07, 0.99999994, 4.36557457e-11, 0, -4.3652193e-11, 0.999980211, -0.00628619269, 9.31322575e-10, 0.00628619175, 0.999980271),Alpha)
			LH.C0 = clerp(LH.C0,CFrame.new(-0.466096163, -0.994458497, -0.733146906, 0.978622258, 0.0421638973, 0.201297805, -0.0426979661, 0.999086678, -0.0016900585, -0.201185226, -0.0069410787, 0.979528725),Alpha)
			RH.C0 = clerp(RH.C0,CFrame.new(0.487065285, -0.997798502, -0.719440222, 0.998841465, 0.000311898883, -0.048122026, -0.000977467163, 0.999904215, -0.0138079338, 0.0481131151, 0.0138389766, 0.998746097),Alpha)
			LS.C0 = clerp(LS.C0,CFrame.new(-1.50068951, 0.376530707, -0.0506974161, 0.999878109, 0.0145290866, 0.00571295246, -9.8173201e-05, 0.371779412, -0.928321123, -0.015611616, 0.928207576, 0.371735603),Alpha)
			RS.C0 = clerp(RS.C0,CFrame.new(1.4989773, 0.376236171, -0.0975327194, 0.999878109, 0.0145290866, 0.00571295246, -9.8173201e-05, 0.371779412, -0.928321123, -0.015611616, 0.928207576, 0.371735603),Alpha)
			NK.C0 = clerp(NK.C0,CFrame.new(8.16642296e-06, 1.49894738, -0.0144014433, 0.99999994, 3.67523171e-07, -1.61118805e-07, -3.56500095e-07, 0.997964799, 0.0637688041, 1.8440187e-07, -0.063768819, 0.997964799),Alpha)
		end
	end

	for i,v in next, BloodPuddles do
		local mesh = i:FindFirstChild'CylinderMesh'
		BloodPuddles[i] = v + 1
		if(not mesh or i.Transparency >= 1)then
			i:destroy() 
			BloodPuddles[i] = nil
		elseif(v >= Frame_Speed*4)then
			local trans = (v-Frame_Speed*4)/(Frame_Speed*2)
			i.Transparency = trans
			if(mesh.Scale.Z > 0)then
				mesh.Scale = mesh.Scale-V3.N(.05,0,.05)
			end
		else
			i.Transparency = 0
		end
	end
end