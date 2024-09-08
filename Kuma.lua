Player=game.Players.LocalPlayer
Character=Player.Character
Character.Humanoid.Name = "noneofurbusiness"
hum = Character.noneofurbusiness
LeftArm=Character["Left Arm"]
LeftLeg=Character["Left Leg"]
RightArm=Character["Right Arm"]
RightLeg=Character["Right Leg"]
Root=Character["HumanoidRootPart"]
Head=Character["Head"]
Torso=Character["Torso"]
RootJoint = Root["RootJoint"]
Neck = Torso["Neck"]
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
walking = false
attacking = false
tauntdebounce = false
themeallow = true
secondform = false
position = nil
MseGuide = true
equipping = false
varsp = 1
settime = 0
sine = 0
sine2 = 0
ws = 38
hpheight = 1.5
change = 1
change2 = .8
dgs = 75
RunSrv = game:GetService("RunService")
RenderStepped = game:GetService("RunService").RenderStepped
removeuseless = game:GetService("Debris")
smoothen = game:GetService("TweenService")
cam = workspace.CurrentCamera
local armorparts = {}
local dmt2 = {2337250807,318340174}
local bloodfolder = Instance.new("Folder",Torso)
local tauntable = {3600135058,3600134054,3600031004}
local killable = {0}
dashing = false
mouse = Player:GetMouse()

screenGui = Instance.new("ScreenGui")
screenGui.Parent = script.Parent

RootJoint.Parent = Root
Neck.Parent = Torso
RightShoulder.Parent = Torso
LeftShoulder.Parent = Torso
RightHip.Parent = Torso
LeftHip.Parent = Torso

local HEADLERP = Instance.new("ManualWeld")
HEADLERP.Parent = Head
HEADLERP.Part0 = Head
HEADLERP.Part1 = Head
HEADLERP.C0 = CFrame.new(0, -1.5, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local TORSOLERP = Instance.new("ManualWeld")
TORSOLERP.Parent = Root
TORSOLERP.Part0 = Torso
TORSOLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local ROOTLERP = Instance.new("ManualWeld")
ROOTLERP.Parent = Root
ROOTLERP.Part0 = Root
ROOTLERP.Part1 = Torso
ROOTLERP.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTARMLERP = Instance.new("ManualWeld")
RIGHTARMLERP.Parent = RightArm
RIGHTARMLERP.Part0 = RightArm
RIGHTARMLERP.Part1 = Torso
RIGHTARMLERP.C0 = CFrame.new(-1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTARMLERP = Instance.new("ManualWeld")
LEFTARMLERP.Parent = LeftArm
LEFTARMLERP.Part0 = LeftArm
LEFTARMLERP.Part1 = Torso
LEFTARMLERP.C0 = CFrame.new(1.5, 0, -0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local RIGHTLEGLERP = Instance.new("ManualWeld")
RIGHTLEGLERP.Parent = RightLeg
RIGHTLEGLERP.Part0 = RightLeg
RIGHTLEGLERP.Part1 = Torso
RIGHTLEGLERP.C0 = CFrame.new(-0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local LEFTLEGLERP = Instance.new("ManualWeld")
LEFTLEGLERP.Parent = LeftLeg
LEFTLEGLERP.Part0 = LeftLeg
LEFTLEGLERP.Part1 = Torso
LEFTLEGLERP.C0 = CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))

local function weldBetween(a, b)
	local weld = Instance.new("ManualWeld", a)
	weld.Part0 = a
	weld.Part1 = b
	weld.C0 = a.CFrame:inverse() * b.CFrame
	return weld
end

function MAKETRAIL(PARENT,POSITION1,POSITION2,LIFETIME,COLOR)
	A = Instance.new("Attachment", PARENT)
	A.Position = POSITION1
	A.Name = "A"
	B = Instance.new("Attachment", PARENT)
	B.Position = POSITION2
	B.Name = "B"
	x = Instance.new("Trail", PARENT)
	x.Attachment0 = A
	x.Attachment1 = B
	x.Enabled = true
	x.Lifetime = LIFETIME
	x.TextureMode = "Static"
	x.LightInfluence = 0
	x.Color = COLOR
	x.Transparency = NumberSequence.new(0, 1)
end

function ray(pos, di, ran, ignore)
	return workspace:FindPartOnRay(Ray.new(pos, di.unit * ran), ignore)
end

function ray2(StartPos, EndPos, Distance, Ignore)
	local di = CFrame.new(StartPos,EndPos).lookVector
	return ray(StartPos, di, Distance, Ignore)
end

function colortween(a,speed,color1)
	local z = {
		Color = color1
	}
	local tween = smoothen:Create(a,TweenInfo.new(speed,Enum.EasingStyle.Linear),z)
	tween:Play()
end

function takeDamage(victim,damage)

end

function taunt()
	coroutine.wrap(function()
		if tauntdebounce then return end
		tauntdebounce = true
		rdnm2 = tauntable[math.random(1,#tauntable)]
		coroutine.wrap(function()
			local tauntsound = Instance.new("Sound", Head)
			tauntsound.Volume = 10
			tauntsound.SoundId = "http://www.roblox.com/asset/?id="..rdnm2
			tauntsound.Looped = false
			tauntsound.Pitch = math.random(7.4,7.8)/10
			tauntsound:Play()
			wait(3)
			wait(tauntsound.TimeLength)
			tauntsound:Destroy()
			wait(1)
			tauntdebounce = false
		end)()
	end)()
end

function killtaunt()
	coroutine.wrap(function()
		if tauntdebounce then return end
		tauntdebounce = true
		rdnm2 = killable[math.random(1,#killable)]
		for i = 1, 3 do
			coroutine.wrap(function()
				local tauntsound = Instance.new("Sound", Head)
				tauntsound.Volume = 10
				tauntsound.SoundId = "http://www.roblox.com/asset/?id="..rdnm2
				tauntsound.Looped = false
				tauntsound.Pitch = 1
				tauntsound:Play()
				wait(3)
				wait(tauntsound.TimeLength)
				tauntsound:Destroy()
				wait(1)
				tauntdebounce = false
			end)()
		end
	end)()
end

function velo(a,name,pos,speed)
	local bov = Instance.new("BodyVelocity",a)
	bov.Name = name
	bov.maxForce = Vector3.new(99999,99999,99999)
	a.CFrame = CFrame.new(a.Position,pos)
	bov.velocity = a.CFrame.lookVector*speed
end
function bolt(parent,from,too,endtarget,color,size,mat,offset)
	local function iray(pos, di, ran, ignore)
		local ing={endtarget}
		return workspace:FindPartOnRayWithWhitelist(Ray.new(pos, di.unit * ran),ing)
	end
	local function iray2(StartPos, EndPos, Distance, Ignore)
		local di = CFrame.new(StartPos,EndPos).lookVector
		return iray(StartPos, di, Distance, Ignore)
	end
	lastposition = from
	local step = 16
	local distance = (from-too).magnitude
	for i = 1,distance, step do
		local from = lastposition
		local too = from + -(from-too).unit*step+ Vector3.new(math.random(-offset,offset),math.random(-offset,offset),math.random(-offset,offset))
		local bolt = Instance.new("Part",parent)
		bolt.Size = Vector3.new(size,size,(from-too).magnitude)
		bolt.Anchored = true
		bolt.CanCollide = false
		bolt.BrickColor = color
		bolt.Material = mat
		bolt.CFrame = CFrame.new(from:lerp(too,.5),too)
		lastposition = too
		coroutine.wrap(function()
			for i = 1, 5 do
				bolt.Transparency = bolt.Transparency + .2
				wait()
			end
			bolt:Destroy()
		end)()
	end
	local lastbolt = Instance.new("Part",parent)
	lastbolt.Size = Vector3.new(1,1,(from-too).magnitude)
	lastbolt.Anchored = true
	lastbolt.CanCollide = false
	lastbolt.BrickColor = color
	lastbolt.Material = mat
	lastbolt.CFrame = CFrame.new(lastposition,too)
	lastbolt.Size = Vector3.new(size,size,size)
	local start = lastposition
	local hit,endp = iray2(lastposition,too,650,lastbolt)
	local dis = (start - endp).magnitude
	lastbolt.CFrame = CFrame.new(lastposition,too) * CFrame.new(0,0,-dis/2)
	if dis < 20 then
		lastbolt.Size = Vector3.new(size,size,dis)
	else
		lastbolt.Size = Vector3.new(size,size,20)
	end
	coroutine.wrap(function()
		for i = 1, 5 do
			lastbolt.Transparency = lastbolt.Transparency + .2
			wait()
		end
		lastbolt:Destroy()
	end)()
end

dmt2random = dmt2[math.random(1,#dmt2)]
doomtheme = Instance.new("Sound", Torso)
doomtheme.Volume = 2
doomtheme.Name = "doomtheme"
doomtheme.Looped = false
doomtheme.SoundId = "rbxassetid://"..dmt2random
doomtheme:Play()
coroutine.wrap(function()
	while wait() do
		pcall(function()
			doomtheme.Ended:Wait()
			dmt2random = dmt2[math.random(1,#dmt2)]
			doomtheme.SoundId = "rbxassetid://"..dmt2random
			doomtheme:Play()
		end)
	end
end)()

chaino = Instance.new("Sound",Torso)
chaino.SoundId = "rbxassetid://3606538256"
chaino.Volume = 0
chaino.Pitch = 1.2
chaino.Looped = true
chaino:Play()

growling = Instance.new("Sound",Torso)
growling.SoundId = "rbxassetid://3606615301"
growling.Volume = 6
growling.Pitch = .95
growling.Looped = true
growling:Play()

Torso.ChildRemoved:connect(function(removed)
	if removed.Name == "doomtheme" then
		dmt2random = dmt2[math.random(1,#dmt2)]
		doomtheme = Instance.new("Sound",Torso)
		doomtheme.SoundId = "rbxassetid://"..dmt2random
		doomtheme.Name = "doomtheme"
		doomtheme.Looped = true
		doomtheme.Volume = 2
		doomtheme:Play()
	elseif removed.Name == "growling" then
		growling = Instance.new("Sound",Torso)
		growling.SoundId = "rbxassetid://3606615301"
		growling.Volume = 6
		growling.Pitch = .95
		growling.Name = "growling"
		growling.Looped = true
		growling:Play()
	elseif removed.Name == "chains" then
		chaino = Instance.new("Sound",Torso)
		chaino.SoundId = "rbxassetid://3606538256"
		chaino.Volume = 0
		chaino.Pitch = 1.2
		chaino.Looped = true
		chaino.Name = "chains"
		chaino:Play()
	end
end)

coroutine.wrap(function()
	while wait() do
		hum.WalkSpeed = ws
		hum.JumpPower = 160
	end
end)()
godmode = coroutine.wrap(function()
	for i,v in pairs(Character:GetChildren()) do
		if v:IsA("BasePart") and v ~= Root then
			v.Anchored = false
		end
	end
	while true do
		hum.MaxHealth = math.huge
		wait(0.0000001)
		hum.Health = math.huge
		swait()
	end
end)
godmode()
ff = Instance.new("ForceField", Character)
ff.Visible = false

pcall(function()
	----defaultpos----
	LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), 0.2)
	RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)), 0.2)
	ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),.2)
	RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
	LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5, 2, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
	----defaultpos----
end)

function damagealll(Radius,Position)		
	local Returning = {}		
	for _,v in pairs(workspace:GetChildren()) do		
		if v~=Character and v:FindFirstChildOfClass('Humanoid') and v:FindFirstChild('Torso') or v:FindFirstChild('UpperTorso') then
			if v:FindFirstChild("Torso") then		
				local Mag = (v.Torso.Position - Position).magnitude		
				if Mag < Radius then		
					table.insert(Returning,v)		
				end
			elseif v:FindFirstChild("UpperTorso") then	
				local Mag = (v.UpperTorso.Position - Position).magnitude		
				if Mag < Radius then		
					table.insert(Returning,v)		
				end
			end	
		end		
	end		
	return Returning		
end

function swait(num)
	if num == 0 or num == nil then
		game:service("RunService").Stepped:wait(0)
	else
		for i = 0, num do
			game:service("RunService").Stepped:wait(0)
		end
	end
end

function SOUND(PARENT,ID,VOL,LOOP,PITCH,REMOVE)
	local so = Instance.new("Sound")
	so.Parent = PARENT
	so.SoundId = "rbxassetid://"..ID
	so.Volume = VOL
	so.Looped = LOOP
	so.Pitch = PITCH
	so:Play()
	removeuseless:AddItem(so,REMOVE)
end

function meshify(parent,scale,mid,tid)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.Name = "mesh"
	mesh.Scale = scale
	mesh.MeshId = "rbxassetid://"..mid
	mesh.TextureId = "rbxassetid://"..tid
end

function blocktrail(position,size,trans,mat,color)
	local trailblock = Instance.new("Part",Torso)
	trailblock.Anchored = true
	trailblock.CanCollide = false
	trailblock.Transparency = trans
	trailblock.Material = mat
	trailblock.BrickColor = color
	trailblock.CFrame = CFrame.new(position) * CFrame.Angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))
	trailblock.Size = size
	coroutine.wrap(function()
		for i = 1, 20 do
			trailblock.Transparency = trailblock.Transparency + .05
			trailblock.Size = trailblock.Size - trailblock.Size/20
			swait()
		end
		trailblock:Destroy()
	end)()
end


function blood(parent,intensity)
	coroutine.wrap(function()
		local particlemiter1 = Instance.new("ParticleEmitter", parent)
		particlemiter1.Enabled = true
		particlemiter1.Color = ColorSequence.new(BrickColor.new("Crimson").Color)
		particlemiter1.Texture = "rbxassetid://1391189545"
		particlemiter1.Lifetime = NumberRange.new(.6)
		particlemiter1.Size = NumberSequence.new(3,3)
		particlemiter1.Transparency = NumberSequence.new(0,1)
		particlemiter1.Rate = intensity
		particlemiter1.Rotation = NumberRange.new(0,360)
		particlemiter1.Speed = NumberRange.new(6)
		particlemiter1.SpreadAngle = Vector2.new(180,180)
		wait(.2)
		particlemiter1.Enabled = false
		removeuseless:AddItem(particlemiter1,10)
	end)()
	coroutine.wrap(function()
		for i = 1, intensity/20 do
			local ray = Ray.new(parent.Position, Vector3.new(0,-25,0))
			local part, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {bloodfolder,parent.Parent,bloc,Character,blooddecal,blowd,Torso},false,true)
			if part and part.Parent ~= parent.Parent and not part.Parent:FindFirstChildOfClass("Humanoid") then
				local vbn = math.random(5,15)
				coroutine.wrap(function()
					local blooddecal = Instance.new("Part",bloodfolder)
					blooddecal.Size =  Vector3.new(vbn,.1,vbn)
					blooddecal.Transparency = 1
					blooddecal.Anchored = true
					blooddecal.Name = "blowd"
					blooddecal.CanCollide = false
					blooddecal.Position = hitPosition 
					blooddecal.Rotation = Vector3.new(0,math.random(-180,180),0)
					local blood = Instance.new("Decal",blooddecal)
					blood.Face = "Top"
					blood.Texture = "rbxassetid://1391189545"
					blood.Transparency = math.random(.1,.4)
					wait(60)
					for i = 1, 100 do
						blood.Transparency = blood.Transparency + .01
						swait()
					end
					blooddecal:Destroy()
				end)()
			else
			end
			swait()
		end
	end)()
end

function spikeball(position,scale,brickcolor,transparencyincrease)
	coroutine.wrap(function()
		local spikeball = Instance.new("Part",Torso)
		spikeball.Anchored = true
		spikeball.CanCollide = false
		spikeball.Size = Vector3.new(1,1,1)
		spikeball.BrickColor = brickcolor
		spikeball.CFrame = position
		spikeball.Transparency = .85
		local spikemesh = Instance.new("SpecialMesh",spikeball)
		spikemesh.MeshId = "rbxassetid://9982590"
		spikemesh.Scale = Vector3.new(1,1,1)
		for i = 1, 40 do
			spikeball.CFrame = spikeball.CFrame * CFrame.Angles(math.rad(0+math.random(7,14)),math.rad(0+math.random(16,21)),math.rad(0+math.random(23,29)))
			spikemesh.Scale = spikemesh.Scale + scale
			spikeball.Transparency = spikeball.Transparency + transparencyincrease/10
			swait()
		end
		spikeball:Destroy()
	end)()
end
function shockwave(position,scale,transparency,brickcolor,speed,transparencyincrease)
	coroutine.wrap(function()
		local shockwave = Instance.new("Part", Torso)
		shockwave.Size = Vector3.new(1,1,1)
		shockwave.CanCollide = false
		shockwave.Anchored = true
		shockwave.Transparency = transparency
		shockwave.BrickColor = brickcolor
		shockwave.CFrame = position
		local shockwavemesh = Instance.new("SpecialMesh", shockwave)
		shockwavemesh.Scale = Vector3.new(.5,.125,.5)
		shockwavemesh.MeshId = "rbxassetid://20329976"
		local shockwave2 = Instance.new("Part", Torso)
		shockwave2.Size = Vector3.new(1,1,1)
		shockwave2.CanCollide = false
		shockwave2.Anchored = true
		shockwave2.Transparency = shockwave.Transparency
		shockwave2.BrickColor = shockwave.BrickColor
		shockwave2.CFrame = shockwave.CFrame
		local shockwavemesh2 = Instance.new("SpecialMesh", shockwave2)
		shockwavemesh2.Scale = Vector3.new(.5,.125,.5)
		shockwavemesh2.MeshId = "rbxassetid://20329976"
		for i = 1, 40 do
			shockwave.CFrame = shockwave.CFrame * CFrame.Angles(math.rad(0),math.rad(0+speed),0)
			shockwave2.CFrame = shockwave2.CFrame * CFrame.Angles(math.rad(0),math.rad(0-speed),0)
			shockwave.Transparency = shockwave.Transparency + transparencyincrease
			shockwave2.Transparency = shockwave2.Transparency + transparencyincrease
			shockwavemesh2.Scale = shockwavemesh2.Scale + scale
			shockwavemesh.Scale = shockwavemesh.Scale + scale
			swait()
		end
		shockwave:Destroy()
		shockwave2:Destroy()
	end)()
end

function blockyeffect(brickcolor,size,trans,posi,mater,spread)
	local blocky = Instance.new("Part",Torso)
	blocky.Anchored = true
	blocky.CanCollide = false
	blocky.BrickColor = brickcolor
	blocky.Size = size
	blocky.Transparency = trans
	blocky.CFrame = posi * CFrame.Angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))
	blocky.Material = mater
	local locbloc = Instance.new("Part",Torso)
	locbloc.Anchored = true
	locbloc.CanCollide = false
	locbloc.Transparency = 1
	locbloc.Size = Vector3.new(1,1,1)
	locbloc.CFrame = blocky.CFrame * CFrame.new(math.random(-spread,spread),math.random(-spread,spread),math.random(-spread,spread))
	coroutine.wrap(function()
		local a = math.random(-180,180)
		local b = math.random(-180,180)
		local c = math.random(-180,180)
		for i = 1, 20 do
			blocky.CFrame = blocky.CFrame:lerp(CFrame.new(locbloc.Position) * CFrame.Angles(math.rad(a),math.rad(b),math.rad(c)),.2)
			blocky.Transparency = blocky.Transparency + .05
			swait()
		end
		blocky:Destroy()
		locbloc:Destroy()
	end)()
end

coroutine.wrap(function()
	for _,n in pairs(Character:GetChildren()) do
		if n:IsA("Accessory") then n:Destroy() end
	end
	for i,v in pairs(Character:GetChildren()) do
		if v.Name == "Animate" then
		end
	end
end)()

taunt()

mouse.KeyDown:connect(function(Press)
	Press=Press:lower()
	if Press=='m' then
		immortality()
		for i,v in pairs(Player.Character:GetDescendants()) do
			if v:IsA("BodyVelocity") then
				v:Destroy()
			end
		end
	elseif Press=='q' then
		if walking then
			if debounce then return end
			debounce = true
			dashing = true
			coroutine.wrap(function()
				for i = 1, 60 do
					if not walking then break end
					varsp = varsp + .016
					ws = ws + 1.2
					chaino.Pitch = chaino.Pitch + .008
					swait()
				end
			end)()
			while walking do
				Hit = damagealll(8,Root.Position)
				for _,v in pairs(Hit) do
					if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
						slachtoffer = v:FindFirstChildOfClass("Humanoid")
						takeDamage(slachtoffer,math.random(4,28))
						vel = Instance.new("BodyVelocity",v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")) 
						vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
						torso = v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")
						vel.velocity = CFrame.new(Root.Position,torso.Position).lookVector*125
						blood(torso,200)
						SOUND(torso,1193237596,8,false,math.random(7,9)/10,10)
						local borb = Instance.new("Part",Torso)
						borb.Anchored = true
						borb.CanCollide = false
						borb.Shape = "Ball"
						borb.Size = Vector3.new(1,1,1)
						borb.Material = "Neon"
						borb.BrickColor = BrickColor.new("White")
						borb.CFrame = torso.CFrame
						spikeball(borb.CFrame,Vector3.new(1.5,1.5,1.5),BrickColor.new("White"),.05)
						coroutine.wrap(function()
							for i = 1, 20 do
								hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
								borb.Size = borb.Size + Vector3.new(1.5,1.5,1.5)
								borb.Transparency = borb.Transparency + .05
								swait()
							end
							hum.CameraOffset = Vector3.new(0,0,0)
							borb:Destroy()
						end)()
						removeuseless:AddItem(vel,.1)
					end
				end
				swait(4)
			end
			debounce = false
			attacking = false
			dashing = false
			chaino.Pitch = 1
			ws = 38
			varsp = 1
		end
	elseif Press=='u' then
		if mouse.Target ~= nil and mouse.Target.Parent ~= Character and mouse.Target.Parent.Parent ~= Character and mouse.Target.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
			local enemyhum = mouse.Target.Parent:FindFirstChildOfClass("Humanoid")
			if enemyhum.Health < 1 then return end
			local ETorso = enemyhum.Parent:FindFirstChild("Torso") or enemyhum.Parent:FindFirstChild("LowerTorso")
			if (ETorso.Position - Torso.Position).magnitude < 16 then
				if debounce then return end
				debounce = true
				attacking = true
				chaino.Volume = 0
				ws = 0
				local locatetor = Instance.new("Part",Torso)
				locatetor.Size = Vector3.new(1,1,1)
				locatetor.Anchored = true
				locatetor.Transparency = 1
				locatetor.CanCollide = false
				locatetor.CFrame = Root.CFrame * CFrame.new(0,-3,-6)
				ETorso.CFrame = locatetor.CFrame * CFrame.Angles(0,math.rad(180),0)
				for i = 1, 20 do
					ETorso.CFrame = locatetor.CFrame * CFrame.Angles(0,math.rad(180),0)
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(3.1,1.1,0)*CFrame.Angles(math.rad(52.8),math.rad(-4.8),math.rad(22.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.3,1.6,2.5)*CFrame.Angles(math.rad(38.3),math.rad(-6),math.rad(12.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-3.2,1.5,-0.4)*CFrame.Angles(math.rad(49.8),math.rad(-8.9),math.rad(-18.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-1,4,1.3)*CFrame.Angles(math.rad(35.3),math.rad(-0.1),math.rad(-0.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -.1, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)),.4)
					swait()
				end
				locatetor.CFrame = Root.CFrame * CFrame.new(0,-3,-3)
				local toweld = weldBetween(ETorso,locatetor)
				toweld.C0 = CFrame.new(1,-.5,2.5) * CFrame.Angles(math.rad(90),math.rad(90),0)
				local shockwavee = Instance.new("Part",Torso)
				shockwavee.Size = Vector3.new(1,1,1)
				shockwavee.Anchored = true
				shockwavee.CanCollide = false
				shockwavee.CFrame = ETorso.CFrame
				shockwavee.Transparency = 0
				shockwavee.Material = "Neon"
				shockwavee.BrickColor = BrickColor.new("White")
				shockwavee.Shape = "Ball"
				spikeball(shockwavee.CFrame,Vector3.new(.7,.7,.7),BrickColor.new("White"),.05)
				coroutine.wrap(function()
					for i = 1, 20 do
						shockwavee.Size = shockwavee.Size + Vector3.new(.8,.8,.8)
						shockwavee.Transparency = shockwavee.Transparency + .05
						swait()
					end
					shockwavee:Destroy()
				end)()
				enemyhum:takeDamage(math.random(7,11))
				SOUND(ETorso,1193237596,8,false,math.random(7,9)/10,10)
				for i = 1, 20 do
					hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(2.3,2.4,0.2)*CFrame.Angles(math.rad(85.1),math.rad(21.8),math.rad(22.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.8,3.3,0.9)*CFrame.Angles(math.rad(-16.8),math.rad(-12.5),math.rad(-3.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-2.2,2.8,0.3)*CFrame.Angles(math.rad(75.3),math.rad(-27.9),math.rad(-30.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-1.3,2.4,-0.6)*CFrame.Angles(math.rad(-83),math.rad(0.9),math.rad(11.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -1.8, 0) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)),.4)
					swait()
				end
				for i = 1, 20 do
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(-1,3.5,-0.1)*CFrame.Angles(math.rad(34.2),math.rad(-35.2),math.rad(155))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.7,3.4,1.4)*CFrame.Angles(math.rad(23.5),math.rad(-0.4),math.rad(9.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(1.3,3.5,-0.4)*CFrame.Angles(math.rad(33.2),math.rad(31.2),math.rad(-160.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.6,3.5,1.2)*CFrame.Angles(math.rad(21.2),math.rad(6.7),math.rad(-13.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-1.18,2)*CFrame.Angles(math.rad(30),math.rad(-0.1),math.rad(0.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					swait()
				end
				for i = 1, 6 do
					enemyhum:takeDamage(math.random(3,6))
					blood(ETorso,50)
					SOUND(ETorso,1193237596,8,false,math.random(7,9)/10,10)
					shockwave(ETorso.CFrame * CFrame.Angles(math.rad(90),0,0),Vector3.new(.8,.15,.8),.2,BrickColor.new("White"),math.random(16,21),.05)
					shockwave(ETorso.CFrame * CFrame.Angles(math.rad(90),0,0),Vector3.new(2.2,.7,2.2),.5,BrickColor.new("White"),math.random(4,8),.05)
					local shockwavee = Instance.new("Part",Torso)
					shockwavee.Size = Vector3.new(1,1,1)
					shockwavee.Anchored = true
					shockwavee.CanCollide = false
					shockwavee.CFrame = ETorso.CFrame
					shockwavee.Transparency = .35
					shockwavee.Material = "Neon"
					shockwavee.BrickColor = BrickColor.new("White")
					shockwavee.Shape = "Ball"
					spikeball(shockwavee.CFrame,Vector3.new(.4,.4,.4),BrickColor.new("White"),.05)
					coroutine.wrap(function()
						for i = 1, 20 do
							shockwavee.Size = shockwavee.Size + Vector3.new(.5,.5,.5)
							shockwavee.Transparency = shockwavee.Transparency + .05
							swait()
						end
						shockwavee:Destroy()
					end)()
					for i = 1, 10 do
						hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(2.8,1.5,-0.2)*CFrame.Angles(math.rad(-69.8),math.rad(13),math.rad(18.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4,3.1,-1.1)*CFrame.Angles(math.rad(-40.7),math.rad(-31.6),math.rad(27.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-2.3,0.4,2)*CFrame.Angles(math.rad(-100.9),math.rad(-4.3),math.rad(37.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5,2.7,1.3)*CFrame.Angles(math.rad(3.7),math.rad(-16.3),math.rad(-13.1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-55), math.rad(-45), math.rad(0)),.4)
						swait()
					end
					enemyhum:takeDamage(math.random(3,6))
					blood(ETorso,50)
					SOUND(ETorso,1193237596,8,false,math.random(7,9)/10,10)
					shockwave(ETorso.CFrame * CFrame.Angles(math.rad(90),0,0),Vector3.new(.8,.15,.8),.2,BrickColor.new("White"),math.random(16,21),.05)
					shockwave(ETorso.CFrame * CFrame.Angles(math.rad(90),0,0),Vector3.new(2.2,.7,2.2),.5,BrickColor.new("White"),math.random(4,8),.05)
					local shockwavee = Instance.new("Part",Torso)
					shockwavee.Size = Vector3.new(1,1,1)
					shockwavee.Anchored = true
					shockwavee.CanCollide = false
					shockwavee.CFrame = ETorso.CFrame
					shockwavee.Transparency = .35
					shockwavee.Material = "Neon"
					shockwavee.BrickColor = BrickColor.new("White")
					shockwavee.Shape = "Ball"
					spikeball(shockwavee.CFrame,Vector3.new(.4,.4,.4),BrickColor.new("White"),.05)
					coroutine.wrap(function()
						for i = 1, 20 do
							shockwavee.Size = shockwavee.Size + Vector3.new(.5,.5,.5)
							shockwavee.Transparency = shockwavee.Transparency + .05
							swait()
						end
						shockwavee:Destroy()
					end)()
					for i = 1, 10 do
						hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
						LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(2.5,-0.2,0.4)*CFrame.Angles(math.rad(-80.9),math.rad(34.3),math.rad(-3.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.8,2.9,1.5)*CFrame.Angles(math.rad(12.7),math.rad(26.1),math.rad(16.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-3.1,1.6,-0.4)*CFrame.Angles(math.rad(-71.2),math.rad(-7.2),math.rad(-34.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.1,2.9,-0.4)*CFrame.Angles(math.rad(-46.8),math.rad(23.2),math.rad(-17.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
						ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-55), math.rad(45), math.rad(0)),.4)
						swait()
					end
					swait()
				end
				hum.CameraOffset = Vector3.new(0,0,0)
				for i = 1, 20 do
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(2.1,0.1,0)*CFrame.Angles(math.rad(-112.8),math.rad(42.1),math.rad(32.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(1,3.9,-1.3)*CFrame.Angles(math.rad(-45.3),math.rad(-7.3),math.rad(-3.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-2.9,1.5,-1)*CFrame.Angles(math.rad(46.4),math.rad(-10.8),math.rad(-6.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-1,1.4,2.9)*CFrame.Angles(math.rad(80.4),math.rad(-0.4),math.rad(-0.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-0.1,0)*CFrame.Angles(math.rad(-30),math.rad(-0.1),math.rad(0.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
					swait()
				end
				toweld:Destroy()
				Hit = damagealll(8,locatetor.Position)
				for _,v in pairs(Hit) do
					if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
						slachtoffer = v:FindFirstChildOfClass("Humanoid")
						takeDamage(slachtoffer,math.random(11,21))
						vel = Instance.new("BodyVelocity",v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")) 
						vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
						torso = v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")
						vel.velocity = CFrame.new(Root.Position,torso.Position).lookVector*250
						blood(torso,200)
						SOUND(torso,1193237596,8,false,math.random(7,9)/10,10)
						local borb = Instance.new("Part",Torso)
						borb.Anchored = true
						borb.CanCollide = false
						borb.Shape = "Ball"
						borb.Size = Vector3.new(1,1,1)
						borb.Material = "Neon"
						borb.BrickColor = BrickColor.new("White")
						borb.CFrame = torso.CFrame
						spikeball(borb.CFrame,Vector3.new(1.5,1.5,1.5),BrickColor.new("White"),.05)
						coroutine.wrap(function()
							for i = 1, 20 do
								hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
								borb.Size = borb.Size + Vector3.new(1.5,1.5,1.5)
								borb.Transparency = borb.Transparency + .05
								swait()
							end
							hum.CameraOffset = Vector3.new(0,0,0)
							borb:Destroy()
						end)()
						removeuseless:AddItem(vel,.1)
					end
				end
				for i = 1, 20 do
					LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(2.9,1.4,-1)*CFrame.Angles(math.rad(53.4),math.rad(17.7),math.rad(7.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5,3.5,2.2)*CFrame.Angles(math.rad(43.9),math.rad(-5.9),math.rad(7.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-2.8,1.4,-0.6)*CFrame.Angles(math.rad(55.6),math.rad(-9.3),math.rad(-16.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-1,3,-2.5)*CFrame.Angles(math.rad(-79.9),math.rad(-0.4),math.rad(0.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-0.4,0)*CFrame.Angles(math.rad(30),math.rad(-0.1),math.rad(-0.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
					swait()
				end
				locatetor:Destroy()
				ws = 38
				attacking = false
				debounce = false
				hum.CameraOffset = Vector3.new(0,0,0)
			end
		end
	elseif Press=='y' then
		if debounce then return end
		debounce = true
		attacking = true
		chaino.Volume = 0
		ws = 0
		local g1 = Instance.new("BodyGyro", nil)
		g1.CFrame = Root.CFrame
		g1.Parent = Root
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,90000,0)
		for i = 1, 20 do
			g1.CFrame = g1.CFrame:lerp(CFrame.new(Root.Position,mouse.Hit.p),.11)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.4,0.65,-0.05)*CFrame.Angles(math.rad(-128.7),math.rad(4.8),math.rad(21.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5,1.95,0.45)*CFrame.Angles(math.rad(10.6),math.rad(-13.6),math.rad(2.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.4,0.4,-0.15)*CFrame.Angles(math.rad(-139.2),math.rad(-9.3),math.rad(-33.7))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.35,1.45,-0.05)*CFrame.Angles(math.rad(-38.6),math.rad(-1.6),math.rad(-9.1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,1,0)*CFrame.Angles(math.rad(30),0,0),.4)
			swait()
		end
		local didhit = false
		local mate = nil
		local colo = nil
		local ray = Ray.new(Root.Position,Vector3.new(0,-10,0))
		local tabd = {bloodfolder,Character}
		local part, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {bloodfolder,Root,Character,blooddecal,blowd,Torso},false,true)
		if part then
			didhit = true
			mate = part.Material
			colo = part.BrickColor
		else
			didhit = false
		end
		if didhit then
			local hitbox = Instance.new("Part",Torso)
			hitbox.Size = Vector3.new(1,1,1)
			hitbox.Anchored = true
			hitbox.Transparency = 1
			hitbox.CanCollide = false
			hitbox.CFrame = Root.CFrame * CFrame.new(0,0,-7)
			local ba = Instance.new("Part",Torso)
			ba.Size = Vector3.new(1,1,1)
			ba.Anchored = true
			ba.CanCollide = false
			ba.Transparency = 1
			ba.CFrame = hitbox.CFrame * CFrame.new(7,-5,0)
			local ba2 = ba:Clone() ba2.Parent = Torso ba2.CFrame = hitbox.CFrame * CFrame.new(-5,-5,0)
			local grast = Instance.new("Part",Torso)
			grast.Size = Vector3.new(7,25,5)
			grast.Anchored = true
			grast.CanCollide = true
			grast.Transparency = 0
			grast.Material = mate
			grast.BrickColor = colo
			grast.CFrame = hitbox.CFrame * CFrame.new(0,-5,0) * CFrame.Angles(math.rad(math.random(-10,10)),math.rad(0),math.rad(math.random(-10,10)))
			shockwave(CFrame.new(hitbox.Position) * CFrame.new(0,-5,0),Vector3.new(3,.8,3),.25,BrickColor.new("White"),math.random(16,21),.05)
			shockwave(CFrame.new(hitbox.Position) * CFrame.new(0,-5,0),Vector3.new(2,1.5,2),.25,BrickColor.new("White"),math.random(8,11),.05)
			shockwave(CFrame.new(hitbox.Position) * CFrame.new(0,-5,0),Vector3.new(6,.35,6),.25,BrickColor.new("White"),math.random(16,21),.05)
			SOUND(grast,3302387879,10,false,math.random(8,9)/10,10)
			coroutine.wrap(function()
				for i = 1, 10 do
					hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
					grast.CFrame = grast.CFrame * CFrame.new(0,0+1,0)
					swait()
				end
				hum.CameraOffset = Vector3.new(0,0,0)
			end)()
			for i = 1, 20 do
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.45,0.4,-0.3)*CFrame.Angles(math.rad(15.7),math.rad(3.6),math.rad(12.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.65,0.9,1.4)*CFrame.Angles(math.rad(65.9),math.rad(6.7),math.rad(-0.5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.55,0.7,-0.3)*CFrame.Angles(math.rad(11.4),math.rad(0),math.rad(-11.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4,1.7,0.55)*CFrame.Angles(math.rad(-7),math.rad(8.3),math.rad(-6.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-0.6,0)*CFrame.Angles(math.rad(-2),0,0),.2)
				swait()
			end
			for i = 1, 20 do
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-.1,0)*CFrame.Angles(math.rad(-15),math.rad(-30),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(0.2,0.3,1.4)*CFrame.Angles(math.rad(-62.1),math.rad(41.9),math.rad(-73.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4,2,0.2)*CFrame.Angles(math.rad(-13.6),math.rad(-34.9),math.rad(-0.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.25,1.2,0.2)*CFrame.Angles(math.rad(-18.4),math.rad(19.8),math.rad(-38.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(0,0.05,1.35)*CFrame.Angles(math.rad(121.3),math.rad(16.7),math.rad(-14.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				swait()
			end
			SOUND(grast,2974876428,8,false,math.random(8,11)/10,10)
			SOUND(grast,2017948224,8,false,math.random(9,11)/10,10)
			local shockwave = Instance.new("Part",Torso)
			shockwave.Size = Vector3.new(1,1,1)
			shockwave.Anchored = true
			shockwave.CanCollide = false
			shockwave.CFrame = grast.CFrame * CFrame.new(0,-5.5,0)
			shockwave.Transparency = 0
			shockwave.Material = "Neon"
			shockwave.BrickColor = BrickColor.new("White")
			shockwave.Shape = "Ball"
			spikeball(shockwave.CFrame,Vector3.new(1,1,1),BrickColor.new("White"),.05)
			coroutine.wrap(function()
				for i = 1, 20 do
					shockwave.Size = shockwave.Size + Vector3.new(2,2,2)
					shockwave.Transparency = shockwave.Transparency + .05
					swait()
				end
				shockwave:Destroy()
			end)()
			coroutine.wrap(function()
				local a = math.random(-10,10)
				local b = math.random(-10,10)
				for i = 1, 75 do
					ba.CFrame = ba.CFrame * CFrame.new(0,0,0-5)
					ba2.CFrame = ba2.CFrame * CFrame.new(0,0,0-5)
					hitbox.CFrame = hitbox.CFrame * CFrame.new(0,0,0-5)
					grast.CFrame = hitbox.CFrame * CFrame.Angles(math.rad(a),0,math.rad(b))
					Hit = damagealll(0,grast.Position)
					for _,v in pairs(Hit) do
						if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
							slachtoffer = v:FindFirstChildOfClass("Humanoid")
							takeDamage(slachtoffer,math.random(5,11))
							vel = Instance.new("BodyVelocity",v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")) 
							vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
							torso = v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")
							vel.velocity = CFrame.new(grast.Position,torso.Position).lookVector*225
							blood(torso,100)
							SOUND(torso,1193237596,8,false,math.random(0,0)/10,10)
							local borb = Instance.new("Part",Torso)
							borb.Anchored = true
							borb.CanCollide = false
							borb.Shape = "Ball"
							borb.Size = Vector3.new(1,1,1)
							borb.Material = "Neon"
							borb.BrickColor = BrickColor.new("White")
							borb.CFrame = torso.CFrame
							spikeball(borb.CFrame,Vector3.new(.75,.75,.75),BrickColor.new("White"),.05)
							coroutine.wrap(function()
								for i = 1, 20 do
									hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
									borb.Size = borb.Size + Vector3.new(.75,.75,.75)
									borb.Transparency = borb.Transparency + .05
									swait()
								end
								hum.CameraOffset = Vector3.new(0,0,0)
								borb:Destroy()
							end)()
							removeuseless:AddItem(vel,.1)
						end
					end
					local didhit = false
					local mate = nil
					local colo = nil
					local ray = Ray.new(ba.Position,Vector3.new(0,-5,0))
					local tabd = {bloodfolder,Character}
					local part, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {bloodfolder,Root,Character,blooddecal,blowd,Torso},false,true)
					if part then
						didhit = true
						mate = part.Material
						colo = part.BrickColor
					else
						didhit = false
					end
					if didhit then
						local gra = Instance.new("Part",Torso)
						gra.Anchored = true
						gra.CanCollide = true
						gra.CFrame = ba.CFrame * CFrame.Angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))
						gra.Material = mate
						gra.BrickColor = colo
						gra.Size = Vector3.new(5,5,5)
						local gra2 = gra:Clone() gra2.Parent = Torso gra2.CFrame = ba2.CFrame * CFrame.Angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))
						coroutine.wrap(function()
							wait(25)
							for i = 1, 20 do
								gra.Transparency = gra.Transparency + .05
								gra2.Transparency = gra.Transparency
								swait()
							end
							gra:Destroy()
							gra2:Destroy()
						end)()
					end
					swait()
				end
				for i = 1, 40 do
					hitbox.CFrame = hitbox.CFrame * CFrame.new(0,0,0-5)
					grast.CFrame = hitbox.CFrame * CFrame.Angles(math.rad(a),0,math.rad(b))
					grast.Transparency = grast.Transparency + .025
					swait()
				end
				ba:Destroy()
				ba2:Destroy()
				grast:Destroy()
				hitbox:Destroy()
			end)()
			coroutine.wrap(function()
				for i = 1, 10 do
					hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
					swait()
				end
				hum.CameraOffset = Vector3.new(0,0,0)
			end)()
			for i = 1, 30 do
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0)*CFrame.Angles(math.rad(15),math.rad(30),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0.9,-0.1)*CFrame.Angles(math.rad(-18.2),math.rad(4.4),math.rad(30.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4,2.05,0.5)*CFrame.Angles(math.rad(42),math.rad(34.9),math.rad(-2.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.15,1.45,-0.25)*CFrame.Angles(math.rad(19.2),math.rad(-23.9),math.rad(-45.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.55,0.75,-1.45)*CFrame.Angles(math.rad(-79.9),math.rad(-1.9),math.rad(1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				swait()
			end
		end
		removeuseless:AddItem(g1,.001)
		debounce = false
		attacking = false
		ws = 38
	elseif Press=='r' then
		if debounce then return end
		debounce = true
		attacking = true
		chaino.Volume = 0 
		ws = 16
		local g1 = Instance.new("BodyGyro", nil)
		g1.CFrame = Root.CFrame
		g1.Parent = Root
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,90000,0)
		for i = 1, 25 do
			g1.CFrame = g1.CFrame:lerp(CFrame.new(Root.Position,mouse.Hit.p),.11)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-.1,0)*CFrame.Angles(math.rad(-15),math.rad(-30),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(0.2,0.3,1.4)*CFrame.Angles(math.rad(-62.1),math.rad(41.9),math.rad(-73.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.4,2,0.2)*CFrame.Angles(math.rad(-13.6),math.rad(-34.9),math.rad(-0.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.25,1.2,0.2)*CFrame.Angles(math.rad(-18.4),math.rad(19.8),math.rad(-38.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(0,0.05,1.35)*CFrame.Angles(math.rad(121.3),math.rad(16.7),math.rad(-14.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			swait()
		end
		ws = 0
		local hitbox = Instance.new("Part",Torso)
		hitbox.Size = Vector3.new(1,1,1)
		hitbox.Anchored = true
		hitbox.CanCollide = false
		hitbox.CFrame = Root.CFrame * CFrame.new(0,0,-5)
		hitbox.Transparency = 1
		Hit = damagealll(0,hitbox.Position)
		for _,v in pairs(Hit) do
			if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
				slachtoffer = v:FindFirstChildOfClass("Humanoid")
				takeDamage(slachtoffer,math.random(0,0))
				vel = Instance.new("BodyVelocity",v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")) 
				vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
				torso = v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")
				vel.velocity = CFrame.new(Root.Position,torso.Position).lookVector*275
				blood(torso,200)
				SOUND(torso,1193237596,8,false,math.random(7,9)/10,10)
				local borb = Instance.new("Part",Torso)
				borb.Anchored = true
				borb.CanCollide = false
				borb.Shape = "Ball"
				borb.Size = Vector3.new(1,1,1)
				borb.Material = "Neon"
				borb.BrickColor = BrickColor.new("White")
				borb.CFrame = torso.CFrame
				spikeball(borb.CFrame,Vector3.new(.75,.75,.75),BrickColor.new("White"),.05)
				coroutine.wrap(function()
					for i = 1, 20 do
						hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
						borb.Size = borb.Size + Vector3.new(.75,.75,.75)
						borb.Transparency = borb.Transparency + .05
						swait()
					end
					hum.CameraOffset = Vector3.new(0,0,0)
					borb:Destroy()
				end)()
				removeuseless:AddItem(vel,.1)
			end
		end
		for i = 1, 20 do
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-.1,0)*CFrame.Angles(math.rad(15),math.rad(30),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.25,0.95,-1.2)*CFrame.Angles(math.rad(49.6),math.rad(53.8),math.rad(-7.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.35,2.15,0.1)*CFrame.Angles(math.rad(22.8),math.rad(29.1),math.rad(2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.3,1,-0.65)*CFrame.Angles(math.rad(47.1),math.rad(-28.9),math.rad(-5.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.6,0.15,-1.3)*CFrame.Angles(math.rad(-106.1),math.rad(-28.4),math.rad(6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.4)
			swait()
		end
		ws = 38
		removeuseless:AddItem(g1,.001)
		debounce = false
		attacking = false
	elseif Press=='e' then
		if debounce then return end
		debounce = true
		attacking = true
		for i = 1, 20 do
			local plant2 = hum.MoveDirection*Torso.CFrame.LookVector
			local plant3 = hum.MoveDirection*Torso.CFrame.RightVector
			local plant = plant2.Z + plant2.X
			local plant4 = plant3.Z + plant3.X
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,0.65,0.05)*CFrame.Angles(math.rad(-129.4),math.rad(4.5),math.rad(18))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5,0.65,1.2)*CFrame.Angles(math.rad(84.4),math.rad(13.5),math.rad(-4.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,0.5,0.15)*CFrame.Angles(math.rad(-129),math.rad(-5),math.rad(-13.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4,1.25,1.05)*CFrame.Angles(math.rad(12.8),math.rad(-1.8),math.rad(-6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(30),math.rad(0),math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 42)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			swait()
		end
		local didhit = false
		local mate = nil
		local colo = nil
		local ray = Ray.new(Root.Position,Vector3.new(0,-15,0))
		local tabd = {bloodfolder,Character}
		local part, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {bloodfolder,Root,Character,blooddecal,blowd,Torso},false,true)
		if part then
			didhit = true
			mate = part.Material
			colo = part.BrickColor
		else
			didhit = false
		end
		if didhit then
			shockwave(CFrame.new(Root.Position) * CFrame.new(0,-2.1,0),Vector3.new(2,1,2),.25,BrickColor.new("White"),math.random(16,21),.05)
			shockwave(CFrame.new(Root.Position) * CFrame.new(0,-2.1,0),Vector3.new(4,.5,4),.25,BrickColor.new("White"),math.random(16,21),.05)
			shockwave(CFrame.new(Root.Position) * CFrame.new(0,-2.1,0),Vector3.new(5,4,5),.25,BrickColor.new("White"),math.random(8,11),.05)
			shockwave(CFrame.new(Root.Position) * CFrame.new(0,-2.1,0),Vector3.new(10,2,10),.25,BrickColor.new("White"),math.random(8,11),.05)
			local bbo = Instance.new("Part",Torso)
			bbo.Size = Vector3.new(3,3,3)
			bbo.Anchored = true
			bbo.CanCollide = false
			bbo.Material = "Neon"
			bbo.BrickColor = BrickColor.new("White")
			bbo.Shape = "Ball"
			bbo.Transparency = .2
			bbo.CFrame = Root.CFrame * CFrame.new(0,-3,0)
			local bbo2 = bbo:Clone() bbo2.Parent = Torso bbo2.Transparency = .85 bbo2mesh = Instance.new("SpecialMesh",bbo2) bbo2mesh.MeshId = "rbxassetid://9982590" bbo2mesh.Scale = Vector3.new(2,2,2)
			local bbo3 = bbo:Clone() bbo3.Parent = Torso bbo3.Transparency = .85 bbo3mesh = Instance.new("SpecialMesh",bbo3) bbo3mesh.MeshId = "rbxassetid://9982590" bbo3mesh.Scale = Vector3.new(2,2,2)
			coroutine.wrap(function()
				for i = 1, 20 do
					hum.CameraOffset = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
					bbo2.CFrame = bbo2.CFrame * CFrame.Angles(math.rad(0+math.random(7,14)),math.rad(0+math.random(16,21)),math.rad(0+math.random(23,29)))
					bbo2mesh.Scale = bbo2mesh.Scale + Vector3.new(4,4,4)
					bbo2.Transparency = bbo2.Transparency + .007
					bbo3.CFrame = bbo3.CFrame * CFrame.Angles(math.rad(0+math.random(7,14)),math.rad(0+math.random(16,21)),math.rad(0+math.random(23,29)))
					bbo3mesh.Scale = bbo3mesh.Scale + Vector3.new(2,2,2)
					bbo3.Transparency = bbo3.Transparency + .007
					bbo.Size = bbo.Size + Vector3.new(3,3,3)
					bbo.Transparency = bbo.Transparency + .05
					swait()
				end
				hum.CameraOffset = Vector3.new(0,0,0)
				bbo3:Destroy()
				bbo2:Destroy()
				bbo:Destroy()
			end)()
			local sd = Instance.new("Part",Torso)
			sd.Anchored = true
			sd.CanCollide = false
			sd.Size = Vector3.new(1,1,1)
			sd.Transparency = 1
			sd.CFrame = bbo.CFrame
			SOUND(sd,3302387879,10,false,math.random(8,9)/10,10)
			coroutine.wrap(function()
				local b = Instance.new("Part",Torso)
				b.Size = Vector3.new(1,1,1)
				b.Anchored = true
				b.CanCollide = false
				b.CFrame = bbo.CFrame
				b.Transparency = 1
				local t = 0
				for i = 1, 36 do
					t = t + 10
					local b2 = b:Clone() b2.Parent = Torso b2.Transparency = 1
					b2.CFrame = b.CFrame * CFrame.new(0,-2,0) * CFrame.Angles(0,math.rad(t),math.rad(0)) * CFrame.new(20,0,0) 
					local grassblock = Instance.new("Part",Torso)
					grassblock.Size = Vector3.new(4,4,4)
					grassblock.BrickColor = colo
					grassblock.Material = mate
					grassblock.Anchored = true
					grassblock.CanCollide = true
					grassblock.CFrame = b2.CFrame * CFrame.Angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))
					local ray = Ray.new(grassblock.Position,Vector3.new(0,-5,0))
					local tabd = {bloodfolder,Character}
					local part, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, {bloodfolder,grassblock,Character,blooddecal,blowd,Torso},false,true)
					if part then
						coroutine.wrap(function()
							wait(15)
							for i = 1, 20 do
								grassblock.Transparency = grassblock.Transparency + .05
								swait()
							end
							grassblock:Destroy()
						end)()
					else
						grassblock:Destroy()
					end
				end
			end)()
			Hit = damagealll(0,bbo.Position)
			for _,v in pairs(Hit) do
				if v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
					slachtoffer = v:FindFirstChildOfClass("Humanoid")
					takeDamage(slachtoffer,math.random(0,0))
					vel = Instance.new("BodyVelocity",v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")) 
					vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
					torso = v:FindFirstChild("Torso") or v:FindFirstChild("UpperTorso")
					vel.velocity = CFrame.new(Root.Position,torso.Position).lookVector*250
					blood(torso,200)
					removeuseless:AddItem(vel,.1)
				end
			end
		end
		ws = 0
		for i = 1, 30 do
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.25,0.8,-0.55)*CFrame.Angles(math.rad(54.3),math.rad(20.9),math.rad(-0.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.65,0.85,1.25)*CFrame.Angles(math.rad(58.9),math.rad(7.7),math.rad(-0.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.2,0.4,-0.7)*CFrame.Angles(math.rad(50),math.rad(-23.1),math.rad(-0.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4,1.45,0.6)*CFrame.Angles(math.rad(-17.3),math.rad(0),math.rad(-5.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-1.6,0)*CFrame.Angles(math.rad(-10),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			swait()
		end
		ws = 39
		debounce = false
		attacking = false
	elseif Press=='t' then
		taunt()
	end
end)

checks1 = coroutine.wrap(function() -------Checks
	while true do
		hf = ray(Root.Position,(CFrame.new(Root.Position,Root.Position-Vector3.new(0,2,0))).lookVector,3*3,Character)
		if Root.Velocity.y > 10 and hf == nil then
			position = "Jump"
		elseif Root.Velocity.y < -10 and hf == nil then
			position = "Falling"
		elseif Root.Velocity.Magnitude < 5 and hf ~= nil then
			position = "Idle"
		elseif Root.Velocity.Magnitude > 5 and hf ~= nil then
			position = "Walking"
		else
		end
		wait()
	end
end)
checks1()

OrgnC0 = Neck.C0 * CFrame.new(0,0,1.7)
immortal = {}
for i,v in pairs(Character:GetDescendants()) do
	if v:IsA("BasePart") and v.Name ~= "lmagic" and v.Name ~= "rmagic" then
		if v ~= Root and v ~= Torso and v ~= Head and v ~= RightArm and v ~= LeftArm and v ~= RightLeg and v.Name ~= "lmagic" and v.Name ~= "rmagic" and v ~= LeftLeg then
			v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(immortal,{v,v.Parent,v.Material,v.Color,v.Transparency})
	elseif v:IsA("JointInstance") then
		table.insert(immortal,{v,v.Parent,nil,nil,nil})
	end
end
for e = 1, #immortal do
	if immortal[e] ~= nil then
		local STUFF = immortal[e]
		local PART = STUFF[1]
		local PARENT = STUFF[2]
		local MATERIAL = STUFF[3]
		local COLOR = STUFF[4]
		local TRANSPARENCY = STUFF[5]
		if levitate then
			if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= eyo1 and PART.Name ~= eyo2 and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
				PART.Material = MATERIAL
				PART.Color = COLOR
				PART.Transparency = TRANSPARENCY
			end
			PART.AncestryChanged:connect(function()
				PART.Parent = PARENT
			end)
		else
			if PART.ClassName == "Part" and PART ~= Root and PART.Name ~= "lmagic" and PART.Name ~= "rmagic" then
				PART.Material = MATERIAL
				PART.Color = COLOR
				PART.Transparency = TRANSPARENCY
			end
			PART.AncestryChanged:connect(function()
				PART.Parent = PARENT
			end)
		end
	end
end
function immortality()
	for e = 1, #immortal do
		if immortal[e] ~= nil then
			local STUFF = immortal[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			if PART.ClassName == "Part" and PART == Root then
				PART.Material = MATERIAL
				PART.Color = COLOR
				PART.Transparency = TRANSPARENCY
			end
			if PART.Parent ~= PARENT then
				hum:Destroy()
				PART.Parent = PARENT
				hum = Instance.new("Humanoid",Character)
				hum.Name = "noneofurbusiness"
			end
		end
	end
end
coroutine.wrap(function()
	while true do
		hum:SetStateEnabled("Dead",false) hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		if hum.Health < .1 then
			immortality()
		end
		swait()
	end
end)()

local anims = coroutine.wrap(function()
	while true do
		settime = 0.05
		sine = sine + change
		sine2 = sine2 + change2
		if position == "Jump" and not attacking then
			change = 1
			ws = 75
			walking = false
			local plant2 = hum.MoveDirection*Torso.CFrame.LookVector
			local plant3 = hum.MoveDirection*Torso.CFrame.RightVector
			local plant = plant2.Z + plant2.X
			local plant4 = plant3.Z + plant3.X
			chaino.Volume = 0
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0)*CFrame.Angles(math.rad(plant - -plant*-25),math.rad(0),math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 42)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.45,0.65,-0.35)*CFrame.Angles(math.rad(30.1),math.rad(0),math.rad(14.8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.25,1.25,1.2)*CFrame.Angles(math.rad(20.9),math.rad(-3.5),math.rad(13.1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.45,0.6,-0.3)*CFrame.Angles(math.rad(29.9),math.rad(0),math.rad(-15.2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.4,1.4,0.75)*CFrame.Angles(math.rad(27.2),math.rad(2.9),math.rad(-11.1))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
		elseif position == "Falling" and not attacking then
			change = 1
			walking = false
			ws = 70
			chaino.Volume = 0
			local plant2 = hum.MoveDirection*Torso.CFrame.LookVector
			local plant3 = hum.MoveDirection*Torso.CFrame.RightVector
			local plant = plant2.Z + plant2.X
			local plant4 = plant3.Z + plant3.X
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,0,0)*CFrame.Angles(math.rad(plant - -plant*25),math.rad(0),math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 42)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.5,1.3,0.15)*CFrame.Angles(math.rad(-165.4),math.rad(0.2),math.rad(4.4))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.6,0.75,1.15)*CFrame.Angles(math.rad(45.5),math.rad(2.5),math.rad(9.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.5,1.25,0.2)*CFrame.Angles(math.rad(-165.6),math.rad(-2.3),math.rad(-5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5,1.5,0.3)*CFrame.Angles(math.rad(6.4),math.rad(-1.7),math.rad(-6.3))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
		elseif position == "Walking" and not attacking then
			change = varsp
			walking = true
			chaino.Volume = 10
			local plant2 = hum.MoveDirection*Torso.CFrame.LookVector
			local plant3 = hum.MoveDirection*Torso.CFrame.RightVector
			local plant = plant2.Z + plant2.X
			local plant4 = plant3.Z + plant3.X
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.4,0.5 - .4 * math.sin(sine/8),-.2 + .75 * math.sin(sine/8))*CFrame.Angles(math.rad(10 + 70 * -math.sin(sine/8)),math.rad(10),math.rad(5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.5,1.65 - plant - -plant + .2 - .35 * math.sin(sine/8),plant - -plant/10*.8+1.4*math.sin(sine/8))*CFrame.Angles(math.rad(plant - -plant*30 + 70 * math.sin(sine/8)),math.rad(-plant4 - plant4 * 15),math.rad(-plant4 - plant4 *math.sin(sine/8)* 15))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			if dashing then
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-.25 + .25 * math.sin(sine/4),0)*CFrame.Angles(math.rad(plant - -plant*-30),math.rad(5 * -math.sin(sine/8) + plant4 - -plant4*math.sin(sine/8)*5),math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 42)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-0.8,-0.15,0.35)*CFrame.Angles(math.rad(-90 + 3 * math.sin(sine/8)),math.rad(-64.2),math.rad(-4.9))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			else
				ws = 38
				ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,-.25 + .25 * math.sin(sine/4),0)*CFrame.Angles(math.rad(plant - -plant*-12),math.rad(5 * -math.sin(sine/8) + plant4 - -plant4*math.sin(sine/8)*5),math.rad(-plant4 - plant4*15) + Root.RotVelocity.Y / 42)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
				RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.4,0.5 -.4 * -math.sin(sine/8),-.2 + .75 * -math.sin(sine/8))*CFrame.Angles(math.rad(10 + 70 * math.sin(sine/8)),math.rad(-10),math.rad(-5))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			end
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.5,1.65 - plant - -plant + .2 - .7 *-math.sin(sine/8),plant - -plant/10*.8 + 1.4 * -math.sin(sine/8))*CFrame.Angles(math.rad(plant - -plant*30 + 70 * -math.sin(sine/8)), math.rad(-plant4 - plant4*15), math.rad(-plant4 - plant4*math.sin(sine/8)*15))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
		elseif position == "Idle" and not attacking then
			change = 1
			walking = false
			chaino.Volume = 0
			RIGHTARMLERP.C0 = RIGHTARMLERP.C0:lerp(CFrame.new(-1.55, 0.4 - .15 * -math.sin(sine/16),-0.15)*CFrame.Angles(math.rad(4.1 + 2 * math.sin(sine/16)),math.rad(-4.6),math.rad(-15.1 - 3 * math.sin(sine/16)))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTARMLERP.C0 = LEFTARMLERP.C0:lerp(CFrame.new(1.45,0.3 - .15 * -math.sin(sine/16),0.55)*CFrame.Angles(math.rad(-7.4 + 4 * math.sin(sine/16)),math.rad(-24 - 3 * math.sin(sine/16)),math.rad(9 + 4 * math.sin(sine/16)))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			ROOTLERP.C0 = ROOTLERP.C0:lerp(CFrame.new(0,.1 * math.sin(sine/16),0) * CFrame.Angles(math.rad(0 * math.sin(sine/16)), math.rad(45), math.rad(0)),.2)
			RIGHTLEGLERP.C0 = RIGHTLEGLERP.C0:lerp(CFrame.new(-0.3,2.1 + .1 * math.sin(sine/16),0.4)*CFrame.Angles(math.rad(-1.5),math.rad(57.7),math.rad(-6.7))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
			LEFTLEGLERP.C0 = LEFTLEGLERP.C0:lerp(CFrame.new(0.05,2.05 + .1 * math.sin(sine/16),0.55)*CFrame.Angles(math.rad(11.1),math.rad(-72.4),math.rad(14.6))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),.25)
		end
		swait()
	end
end)
anims()
warn("UNACCEPTABLE. Made by Supr14")