local plr=game:GetService("Players").LocalPlayer
local char=plr.Character
local mouse=plr:GetMouse()
local tors=char:waitForChild"Torso"
local root=char:waitForChild"HumanoidRootPart"
local head=char:waitForChild"Head"
local larm=char:waitForChild"Left Arm"
local rarm=char:waitForChild"Right Arm"
local lleg=char:waitForChild"Left Leg"
local rleg=char:waitForChild"Right Leg"
local neck=tors:waitForChild"Neck"
local rs=tors:waitForChild"Right Shoulder"
local ls=tors:waitForChild"Left Shoulder"
local rh=tors:waitForChild"Right Hip"
local lh=tors:waitForChild"Left Hip"
local rj=root:waitForChild"RootJoint"
local hum=char:waitForChild"Humanoid"
local suit=Instance.new("Model")
local suit2=Instance.new("Model")
local effects=Instance.new("Folder")
local pants=Instance.new("Pants")
local shirt=Instance.new("Shirt")
local walls=Instance.new("Folder")

local rightogSin=CFrame.new(1,.5,.3)*CFrame.Angles(0,math.rad(90),0)*CFrame.Angles(math.rad(45),0,-math.rad(32))
local leftogSin=CFrame.new(-1,.5,.3)*CFrame.Angles(0,-math.rad(90),0)*CFrame.Angles(math.rad(45),0,math.rad(32))
local nec=CFrame.new(0,1,0)*CFrame.Angles(-math.rad(90),0,math.rad(180))
local rightog=CFrame.new(1,.5,.3)*CFrame.Angles(0,math.rad(90),0)
local leftog=CFrame.new(-1,.5,.3)*CFrame.Angles(0,-math.rad(90),0)
local rootCF=CFrame.Angles(-1.57,0,3.14)
local lhCF=CFrame.new(-1,-1,0)*CFrame.Angles(0,-math.rad(90),0)
local rhCF=CFrame.new(1,-1,0)*CFrame.Angles(0,math.rad(90),0)	

local Head=head
local Torso=tors
local RootPart=root

local ass_kicking_mode=false


----------------------------------------
char.Head.Mesh.MeshType=Enum.MeshType.Head
char.Head.Mesh.Scale=Vector3.new(1.25,1.25,1.25)
head.face:destroy()
suit.Parent=char
effects.Parent=char
effects.Name="Effects"
suit.Name="Add-ons"
suit2.Parent=suit
suit2.Name="Face"
walls.Parent=effects
----------------------------------------


function weld(p0,p1,c0,c1,par)
	local w = Instance.new("Weld", par)
	w.Part0 = p0
	w.Part1 = p1
	w.C0 = c0 or CFrame.new()
	w.C1 = c1 or CFrame.new()
	return w
end

function swait(num)
	if num==nil or num<=0 then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i=1,num do
			game:GetService("RunService").RenderStepped:wait()			
		end		
	end
end

hand1Determination = Instance.new("Model")
hand1Determination.Name ="Red"
hand2Perseverance = Instance.new("Model")
hand2Perseverance.Name ="Purple"
hand3Patience = Instance.new("Model")
hand3Patience.Name = "Cyan"
hand4Integrity = Instance.new("Model")
hand4Integrity.Name = "Blue"
hand5Bravery = Instance.new("Model")
hand5Bravery.Name = "Orange"
hand6Justice = Instance.new("Model")
hand6Justice.Name = "Yellow"
hand7Kindness = Instance.new("Model")
hand7Kindness.Name = "Green"
mouth = Instance.new("Part",suit2)
mouth.Size = Vector3.new(0.2,.7,0.4)
mouth.Transparency = 0
mouth.BrickColor = BrickColor.new("Really black")
mouth.CanCollide = false
mouthMesh = Instance.new("SpecialMesh",mouth)
mouthMesh.MeshType = "Sphere"
mouthMesh.Scale = Vector3.new(2.5,0.1,0.8)

weld(char.Head,mouth,CFrame.new(0,0,0),CFrame.new(0, .3, 0.45)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)


Crack2 = Instance.new("Part",suit2)
Crack2.Size = Vector3.new(0.2,.7,0.4)
Crack2.Transparency = 0
Crack2.BrickColor = BrickColor.new("Really black")
Crack2.CanCollide = false
Crack2Mesh = Instance.new("SpecialMesh",Crack2)
Crack2Mesh.MeshType = "Sphere"
Crack2Mesh.Scale = Vector3.new(0.3,0.7,0.8)

weld(char.Head,Crack2,CFrame.new(0,0,0),CFrame.new(.2, .15, 0.45)*CFrame.fromEulerAnglesXYZ(0, 0, -.2),char)


Crack1 = Instance.new("Part",suit2)
Crack1.Size = Vector3.new(0.2,.7,0.4)
Crack1.Transparency = 0
Crack1.BrickColor = BrickColor.new("Really black")
Crack1.CanCollide = false
Crack1Mesh = Instance.new("SpecialMesh",Crack1)
Crack1Mesh.MeshType = "Sphere"
Crack1Mesh.Scale = Vector3.new(0.3,0.7,0.65)

weld(char.Head,Crack1,CFrame.new(0,0,0),CFrame.new(-.2, -.3, 0.45)*CFrame.fromEulerAnglesXYZ(0, 0, .2),char)


Eye1 = Instance.new("Part",suit2)
Eye1.Size = Vector3.new(0.4,0.4,0.4)
Eye1.Transparency = 0
Eye1.BrickColor = BrickColor.new("Really black")
Eye1.CanCollide = false
Eye1Mesh = Instance.new("SpecialMesh",Eye1)
Eye1Mesh.MeshType = "Sphere"
Eye1Mesh.Scale = Vector3.new(1,1,0.6)

weld(char.Head,Eye1,CFrame.new(0,0,0),CFrame.new(-.2, -.1, 0.5)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)


Eye2 = Instance.new("Part",suit2)
Eye2.Size = Vector3.new(0.4,0.4,0.4)
Eye2.Transparency = 0
Eye2.CanCollide = false
Eye2.BrickColor = BrickColor.new("Really black")
Eye2Mesh = Instance.new("SpecialMesh",Eye2)
Eye2Mesh.MeshType = "Sphere"
Eye2Mesh.Scale = Vector3.new(1,1,0.6)

weld(char.Head,Eye2,CFrame.new(0,0,0),CFrame.new(.2, -.1, 0.5)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

MEye1 = Instance.new("Part",suit2)
MEye1.Size = Vector3.new(0.3,0.3,0.3)
MEye1.Transparency = 0
MEye1.Material= "Neon"
MEye1.BrickColor = BrickColor.new("Institutional white")
MEye1.CanCollide = false
MEye1Mesh = Instance.new("SpecialMesh",MEye1)
MEye1Mesh.MeshType = "Sphere"
MEye1Mesh.Scale = Vector3.new(.2,.5,.2)

weld(Eye1,MEye1,CFrame.new(0,0,0),CFrame.new(-.02,0,0.1)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

MEye2 = Instance.new("Part",suit2)
MEye2.Size = Vector3.new(0.3,0.3,0.3)
MEye2.Transparency = 0
MEye2.Material= "Neon"
MEye2.BrickColor = BrickColor.new("Institutional white")
MEye2.CanCollide = false
MEye2Mesh = Instance.new("SpecialMesh",MEye2)
MEye2Mesh.MeshType = "Sphere"
MEye2Mesh.Scale = Vector3.new(.2,.5,.2)

weld(Eye2,MEye2,CFrame.new(0,0,0),CFrame.new(.02,0,0.1)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)
hand1DeterminationPosition = Instance.new("Part",suit)
hand1DeterminationPosition.Size = Vector3.new(1,1,1)
hand1DeterminationPosition.Transparency = 1
hand1DeterminationPosition.CanCollide = false

weld(Torso,hand1DeterminationPosition,CFrame.new(0,0,0),CFrame.new(-2, -5, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand2PerseverancePosition = Instance.new("Part",suit)
hand2PerseverancePosition.Size = Vector3.new(1,1,1)
hand2PerseverancePosition.Transparency = 1
hand2PerseverancePosition.CanCollide = false

weld(Torso,hand2PerseverancePosition,CFrame.new(0,0,0),CFrame.new(2, -5, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand3PatiencePosition = Instance.new("Part",suit)
hand3PatiencePosition.Size = Vector3.new(1,1,1)
hand3PatiencePosition.Transparency = 1
hand3PatiencePosition.CanCollide = false

weld(Torso,hand3PatiencePosition,CFrame.new(0,0,0),CFrame.new(-4, -5, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand4IntegrityPosition = Instance.new("Part",suit)
hand4IntegrityPosition.Size = Vector3.new(1,1,1)
hand4IntegrityPosition.Transparency = 1
hand4IntegrityPosition.CanCollide = false

weld(Torso,hand4IntegrityPosition,CFrame.new(0,0,0),CFrame.new(4, -5, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand5BraveryPosition = Instance.new("Part",suit)
hand5BraveryPosition.Size = Vector3.new(1,1,1)
hand5BraveryPosition.Transparency = 1
hand5BraveryPosition.CanCollide = false

weld(Torso,hand5BraveryPosition,CFrame.new(0,0,0),CFrame.new(-6, -7, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand6JusticePosition = Instance.new("Part",suit)
hand6JusticePosition.Size = Vector3.new(1,1,1)
hand6JusticePosition.Transparency = 1
hand6JusticePosition.CanCollide = false

weld(Torso,hand6JusticePosition,CFrame.new(0,0,0),CFrame.new(6, -7, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hand7KindnessPosition = Instance.new("Part",suit)
hand7KindnessPosition.Size = Vector3.new(1,1,1)
hand7KindnessPosition.Transparency = 1
hand7KindnessPosition.CanCollide = false

weld(Torso,hand7KindnessPosition,CFrame.new(0,0,0),CFrame.new(0, -7, 0)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)


AttackPosition = Instance.new("Part",suit)
AttackPosition.Size = Vector3.new(1,1,1)
AttackPosition.Transparency = 1
AttackPosition.CanCollide = false

weld(Torso,AttackPosition,CFrame.new(0,0,0),CFrame.new(0, 0, 4)*CFrame.fromEulerAnglesXYZ(0, 0, 0),char)

hum.Animator:destroy()
char.Animate:destroy()

local soundd=Instance.new("Sound",char)
soundd.SoundId="rbxassetid://4578606688"
soundd.Volume=4
soundd.Looped=true
soundd:Play()

function shockwave(pos,par,col,div,size,bonus)
	if bonus==0 or bonus==nil then
		bonus=1
	end
	coroutine.resume(coroutine.create(function()
		local eff=Instance.new("Part",par)
		eff.Anchored=true
		eff.CanCollide=false
		eff.Size=size
		eff.BrickColor=col
		eff.Position=pos
		eff.Transparency=.1
		eff.Material=Enum.Material.Neon
		eff.CFrame=eff.CFrame*CFrame.Angles(0,math.rad(math.random(-360,360)),0)
		local mesh=Instance.new("SpecialMesh",eff)
		mesh.MeshId="rbxassetid://3097373378"
		for i=1,10 do
			wait()
			mesh.Scale=mesh.Scale:lerp(Vector3.new(1+(i/div*bonus),1+(i/div*bonus),1+(i/div*bonus)),.35)
			mesh.Offset=Vector3.new(0,0+mesh.Scale.Y/2,0)
			eff.Transparency=(i/10)
		end
		eff:destroy()
	end))	
end

function sphereEff(pos,par,col,div)
	coroutine.resume(coroutine.create(function()
		local eff=Instance.new("Part",par)
		eff.Anchored=true
		eff.CanCollide=false
		eff.Size=Vector3.new(1,1,1)
		eff.BrickColor=col
		eff.Position=pos
		eff.Material=Enum.Material.Neon
		local mesh=Instance.new("SpecialMesh",eff)
		mesh.MeshType=Enum.MeshType.Sphere
		for i=1,10 do
			wait()
			eff.Size=eff.Size:lerp(Vector3.new(i/div,i/div,i/div),.35)
			eff.Transparency=(i/10)
		end
		eff:destroy()
	end))
end
function sphereEff2(pos,par,col,div)
	coroutine.resume(coroutine.create(function()
		local eff=Instance.new("Part",par)
		eff.Anchored=true
		eff.CanCollide=false
		eff.Size=Vector3.new(1,1,1)
		eff.BrickColor=col
		eff.Position=pos
		eff.Material=Enum.Material.Neon
		local mesh=Instance.new("SpecialMesh",eff)
		mesh.MeshType=Enum.MeshType.Sphere
		for i=1,10 do
			wait()
			eff.Size=eff.Size:lerp(Vector3.new(i*div,i*div,i*div),.35)
			eff.Transparency=(i/10)
		end
		eff:destroy()
	end))
end

function clerp(a,b,t)
	return a:lerp(b,t)
end

function chatfunc(text)
	if char:FindFirstChild("TalkingBillBoard")~= nil then
		char:FindFirstChild("TalkingBillBoard").Parent = nil
	end
	local fx=sound(360802294,tors,10,1)
	local naeeym2 = Instance.new("BillboardGui",char)
	naeeym2.Size = UDim2.new(0,100,0,40)
	naeeym2.StudsOffset = Vector3.new(0,2,0)
	naeeym2.Adornee = char.Head
	naeeym2.Name = "TalkingBillBoard"
	naeeym2.AlwaysOnTop = true
	local tecks2 = Instance.new("TextLabel",naeeym2)
	tecks2.BackgroundTransparency = 1
	tecks2.BorderSizePixel = 0
	tecks2.Text = ""
	tecks2.Font = "Arcade"
	tecks2.TextSize = 30
	tecks2.TextStrokeTransparency = 0
	tecks2.TextColor3 = Color3.fromRGB(0,0,0)
	tecks2.TextStrokeColor3 = Color3.fromRGB(45,45,45)
	tecks2.Size = UDim2.new(1,0,0.5,0)
	fx:play()
	for i = 1,string.len(text),1 do
		tecks2.Text = string.sub(text,1,i)
		swait(3)
	end
	fx:stop()
	fx:destroy()
	wait(1)
	coroutine.resume(coroutine.create(function()
		for i = 1, 10 do
			tecks2.TextTransparency = (i/10)
			tecks2.TextStrokeTransparency = tecks2.TextTransparency
			tecks2.Rotation=tecks2.Rotation+.5
			swait()
		end
		naeeym2:Destroy()
	end))
end

function sound(ID, PARENT, VOLUME, PITCH)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = Instance.new("Sound", PARENT)
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		swait()
		NEWSOUND:play()
		game:GetService("Debris"):AddItem(NEWSOUND, 10)
	end))
	return NEWSOUND
end
wait(.5)
for i=1,20 do
	swait()	
	rs.C0=rs.C0:lerp(rightog*CFrame.Angles(math.rad(20),0,math.rad(135)),.4)
	ls.C0=ls.C0:lerp(leftog*CFrame.Angles(math.rad(20),0,math.rad(20)),.4)	
	neck.C0=neck.C0:lerp(nec,.4)
	rj.C0=rj.C0:lerp(rootCF,.4)
	lh.C0=lh.C0:lerp(lhCF,.4)
	rh.C0=rh.C0:lerp(rhCF,.4)	
end


function intro()
	wait(1)
	for i,v in pairs(suit:GetChildren())do
		if v:isA"Part"then
			local hand=Instance.new("Part", script)
			hand.Size = Vector3.new(0.8,1.25,1.5)
			hand.TopSurface = "Smooth"
			hand.BottomSurface = "Smooth"
			hand.Color = Color3.new(1,1,1)
			hand.Parent=v
			weld(v,hand,CFrame.new(0,0,0)*CFrame.Angles(-math.rad(90),math.rad(180)+math.rad(math.random(-15,15)),math.rad(90)),CFrame.new(),v)
			hand.Anchored=false
			sphereEff(v.Position,effects,BrickColor.new("Really black"),3)
		end
	end
	sound("367453005", head, 10, 1)
end

intro()

local a=false
local oof=false

local speed=0
function TheEnd()
	if not a then
		a=true
		speed=0
		for i=1,40 do
			wait()
			soundd.Volume=4-(i/10)
		end
		oof=true
		chatfunc("...")
		wait(2)
		chatfunc("After all this time...")
		wait(2)
		chatfunc("I still can't defeat you...")
		wait(2)
		chatfunc("I don't want to do this...")
		wait(2)
		chatfunc("It's time to show you TRUE power...")
		wait(.8)
		for i=1,2 do
			wait(1)
			sound("367453005", char, 10, 1)
			sphereEff2(tors.Position,effects,BrickColor.new("Really black"),6)	
		end
		wait(1)
		sound("2648563122", char, 10, 1)	
		sphereEff2(tors.Position,effects,BrickColor.new("Really black"),13)	
		shockwave(tors.Position-Vector3.new(0,.99,0),effects,BrickColor.new("Really black"),Vector3.new(0,0,0),12)
		speed=0
		soundd:Stop()
		soundd.SoundId="rbxassetid://632244280"
		soundd:Play()
		soundd.Volume=10
		oof=false
		ass_kicking_mode=true	
	end
end

plr.Chatted:connect(chatfunc)

local yeet=false
local ff=Instance.new("ForceField")
ff.Visible=false
function Kindness()
	sphereEff(AttackPosition.Position,effects,BrickColor.new("Lime green"),3)
	sphereEff(hand7KindnessPosition.Position,effects,BrickColor.new("Lime green"),3)	
	sound("367453005", char, 10, 1)	
	if not yeet then
		yeet=true
		ff.Parent=char
		local wall=Instance.new("Part",walls)
		wall.Size=Vector3.new(0,0,0)	
		wall.Shape="Ball"
		coroutine.resume(coroutine.create(function()
			for i=1,7 do	
				wait()	
				wall.Size=wall.Size:lerp(Vector3.new(20,20,20),.4)
			end
		end))
		wall.Anchored=true
		wall.Transparency=.3
		wall.CanCollide=false
		wall.BrickColor=BrickColor.new("Lime green")
		wall.Material=Enum.Material.ForceField
		wall.CFrame=tors.CFrame
		return
	else
		yeet=false
		ff.Parent=nil
		for i,wall in pairs(walls:GetChildren())do
			coroutine.resume(coroutine.create(function()
				for i=1,7 do	
					wait()	
					wall.Size=wall.Size:lerp(Vector3.new(0,0,0),.4)
				end
				wall:destroy()
			end))		
		end
	end
end

function Justice()
	if not ass_kicking_mode then
		sphereEff(AttackPosition.Position,effects,BrickColor.new("New Yeller"),3)
		sphereEff(hand6JusticePosition.Position,effects,BrickColor.new("New Yeller"),3)	
		local gunno=Instance.new("Part",effects)
		gunno.Anchored=true
		gunno.CanCollide=false
		gunno.BrickColor=BrickColor.new("New Yeller")
		gunno.Size=Vector3.new(0.2, 1.18, 1.35)
		gunno.CFrame=tors.CFrame
		local mesh=Instance.new("SpecialMesh",gunno)
		mesh.MeshId="http://www.roblox.com/asset/?id=79401392"
		mesh.Offset=Vector3.new(0,-.25,-.245)
		mesh.Scale=Vector3.new(1.5,1.5,1.5)	
		gunno.CFrame=CFrame.new(mouse.Hit.p)*CFrame.new(math.random(-10,10),3,-1)
		game:GetService("TweenService"):create(gunno,TweenInfo.new(.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{CFrame=CFrame.new(gunno.Position,mouse.Hit.p)*CFrame.Angles(-math.rad(90),0,0)}):play()

		wait(.5)
		sound(1590181673,char,10,1)
		local pew=Instance.new("Part",workspace)
		pew.CanCollide=false
		pew.Material="Neon"
		pew.Anchored=true
		pew.BrickColor=gunno.BrickColor
		pew.CFrame=mouse.Hit
		pew.Transparency=1
		local thing=Instance.new("Beam",gunno)
		thing.Texture="rbxassetid://26884682"
		thing.TextureLength=10
		thing.TextureSpeed=20
		thing.Color=ColorSequence.new(BrickColor.new("New Yeller").Color,BrickColor.new("New Yeller").Color)
		thing.Width0=.07
		thing.Width1=.3
		thing.LightEmission=1
		thing.FaceCamera=true
		if mouse.Target then
			mouse.Target:breakJoints()
			if mouse.Target.Name=="Head" or mouse.Target.Name=="Torso" and mouse.Target.className~="Workspace" then
				wait()
				print(mouse.Target.Parent.Name)
				pcall(function()
					ShowDamage(mouse.Target.Position+Vector3.new(0,2,0),9999,1,BrickColor.new("Really red").Color,mouse.Target.Parent)
				end)
			end
		end
		local AT1=Instance.new("Attachment",gunno)
		local AT2=Instance.new("Attachment",pew)
		thing.Attachment0=AT1
		thing.Attachment1=AT2
		wait(.5)
		gunno.CanCollide=true
		gunno.Anchored=false
		pew:Destroy()
		game.Debris:AddItem(gunno,2)
	else
		sphereEff(AttackPosition.Position,effects,BrickColor.new("New Yeller"),3)
		sphereEff(hand6JusticePosition.Position,effects,BrickColor.new("New Yeller"),3)			
		for i=1,3 do
			spawn(function()
				local gunno=Instance.new("Part",effects)
				gunno.Anchored=true
				gunno.CanCollide=false
				gunno.BrickColor=BrickColor.new("New Yeller")
				gunno.Size=Vector3.new(0.2, 1.18, 1.35)
				gunno.CFrame=tors.CFrame
				local mesh=Instance.new("SpecialMesh",gunno)
				mesh.MeshId="http://www.roblox.com/asset/?id=79401392"
				mesh.Offset=Vector3.new(0,-.25,-.245)
				mesh.Scale=Vector3.new(1.5,1.5,1.5)	
				gunno.CFrame=CFrame.new(mouse.Hit.p)*CFrame.new(math.random(-10,10),3,-1)
				game:GetService("TweenService"):create(gunno,TweenInfo.new(.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{CFrame=CFrame.new(gunno.Position,mouse.Hit.p)*CFrame.Angles(-math.rad(90),0,0)}):play()

				wait(.2)
				sound(1590181673,char,10,1)
				local pew=Instance.new("Part",workspace)
				pew.CanCollide=false
				pew.Material="Neon"
				pew.Anchored=true
				pew.BrickColor=gunno.BrickColor
				pew.CFrame=mouse.Hit
				pew.Transparency=1
				local thing=Instance.new("Beam",gunno)
				thing.Texture="rbxassetid://26884682"
				thing.TextureLength=10
				thing.TextureSpeed=20
				thing.Color=ColorSequence.new(BrickColor.new("New Yeller").Color,BrickColor.new("New Yeller").Color)
				thing.Width0=.07
				thing.Width1=.3
				thing.LightEmission=1
				thing.FaceCamera=true
				if mouse.Target then
					mouse.Target:breakJoints()
					if mouse.Target.Name=="Head" or mouse.Target.Name=="Torso" and mouse.Target.className~="Workspace" then
						wait()
						print(mouse.Target.Parent.Name)
						pcall(function()
							ShowDamage(mouse.Target.Position+Vector3.new(0,2,0),9999,1,BrickColor.new("Really red").Color,mouse.Target.Parent)
						end)
					end
				end
				local AT1=Instance.new("Attachment",gunno)
				local AT2=Instance.new("Attachment",pew)
				thing.Attachment0=AT1
				thing.Attachment1=AT2
				wait(.5)
				gunno.CanCollide=true
				gunno.Anchored=false
				pew:Destroy()
				game.Debris:AddItem(gunno,2)
			end)
		end
	end
end

function Tp()
	sound("367453005", char, 10, 1)		
	char:SetPrimaryPartCFrame(CFrame.new(mouse.Hit.p)*CFrame.new(0,2,0))
	sphereEff2(tors.Position,effects,BrickColor.new("Really black"),4)	
	--[[if findTorso(tors.Position,10)then
		findTorso(tors.Position,10).Parent:findFirstChildOfClass"Humanoid".Health=0
		wait()
		ShowDamage(findTorso(tors.Position,10).Position+Vector3.new(0,3,0),999999,1,BrickColor.new("Really red").Color,findTorso(tors.Position,10).Parent)
	end]]
end
local deb=false

function Brave()
	sphereEff(AttackPosition.Position,effects,BrickColor.new("Neon orange"),3)
	sphereEff(hand5BraveryPosition.Position,effects,BrickColor.new("Neon orange"),3)
	if not ass_kicking_mode then	
		local pew=Instance.new("Part",workspace)
		pew.Name="pew"
		pew.Anchored=true
		pew.CanCollide=false	
		pew.BrickColor=BrickColor.new("Neon orange")
		pew.Material=Enum.Material.Neon
		pew.Size=Vector3.new(0.28, 5.98, 1.12)
		pew.CFrame=root.CFrame
		pew.Touched:connect(function(hit)
			if not deb then
				if hit.Parent~=char then
					if hit.Parent:findFirstChildOfClass"Humanoid"then
						if hit.Parent:findFirstChildOfClass"Humanoid".Health>0 then
							local dmg=math.random(10,32)
							deb=true
							hit.Parent:findFirstChildOfClass"Humanoid":takeDamage(dmg)
							ShowDamage(hit.Position+Vector3.new(0,3,0),dmg,1,BrickColor.new("Really red").Color,hit.Parent)
							wait(.5)
							deb=false
						end
					end
				end
			end
		end)
		coroutine.resume(coroutine.create(function()
			local cf=root.CFrame
			for i=1,60*2 do
				swait()
				pew.CFrame=pew.CFrame:lerp(cf*CFrame.new(0,0,-2-(i)),.3)
			end
			for i=1,60*2 do
				swait()
				pew.CFrame=pew.CFrame:lerp(pew.CFrame*CFrame.new(0,0,2+(i/4)),.3)
			end		
			pew:Destroy()
		end))
	else
		for i=1,3 do
			wait(.5)
			local pew=Instance.new("Part",workspace)
			pew.Name="pew"
			pew.Anchored=true
			pew.CanCollide=false	
			pew.BrickColor=BrickColor.new("Neon orange")
			pew.Material=Enum.Material.Neon
			pew.Size=Vector3.new(0.28, 5.98, 1.12)
			pew.CFrame=root.CFrame
			pew.Touched:connect(function(hit)
				if not deb then
					if hit.Parent~=char then
						if hit.Parent:findFirstChildOfClass"Humanoid"then
							if hit.Parent:findFirstChildOfClass"Humanoid".Health>0 then
								local dmg=math.random(10,32)
								deb=true
								hit.Parent:findFirstChildOfClass"Humanoid":takeDamage(dmg)
								ShowDamage(hit.Position+Vector3.new(0,3,0),dmg,1,BrickColor.new("Really red").Color,hit.Parent)
								wait(.5)
								deb=false
							end
						end
					end
				end
			end)
			coroutine.resume(coroutine.create(function()
				local cf=root.CFrame
				for i=1,60*2 do
					swait()
					pew.CFrame=pew.CFrame:lerp(cf*CFrame.new(0,0,-2-(i)),.3)
				end
				for i=1,60*2 do
					swait()
					pew.CFrame=pew.CFrame:lerp(pew.CFrame*CFrame.new(0,0,2+(i/4)),.3)
				end		
				pew:Destroy()
			end))		
		end	
	end
end

mouse.KeyDown:connect(function(key)
	if key=="m"then
		sound("367453005", char, 10, 1)			
		TheEnd()
	end
	if key=="z"then
		Kindness()
	end
	if key=="x"then
		Justice()
	end
	if key=="c"then
		Tp()
	end
	if key=="v"then
		Brave()
	end
end)

function findTorso(pos,dist)
	local torso = nil
	local child = workspace:children()
	for i=1, #child do
		if child[i].className == "Model" then
			local h = child[i]:findFirstChild("Humanoid")
			if h ~= nil then
				local check = child[i]:findFirstChild("Torso")
				if check ~= nil then
					if (check.Position - pos).magnitude < dist then
						torso = check
						dist = (check.Position - pos).magnitude
					end
				end
			end
		end
	end
	return torso
end
function ShowDamage(Pos, dmg, Time, Color,target)
	
end

while true do
	swait()
	hum.Name="Soul"
	local hitfloor,posfloor = workspace:FindPartOnRay(Ray.new(root.CFrame.p,((CFrame.new(root.Position,root.Position - Vector3.new(0,1,0))).lookVector).unit * (4)),char)

	local walk = (math.abs(root.Velocity.x) > 1 or math.abs(root.Velocity.z) > 1)
	local state = (hum.PlatformStand and 'paralyzed' or hum.Sit and 'sit' or not hitfloor and root.Velocity.y < -1 and "fall" or not hitfloor and root.Velocity.y > 1 and "jump" or hitfloor and walk and "walk" or hitfloor and "idle")

	for i,v in pairs(suit:GetChildren())do
		if v:isA"Part"then
			v.Weld.C0=v.Weld.C0:lerp(CFrame.Angles(-math.rad(90)+math.rad(math.random(-12,12)),math.rad(180)+math.rad(math.random(-12,12)),math.rad(90)+math.rad(math.random(-12,12)))+Vector3.new(0,math.cos(tick()*3)/2,0),.3)
		end
	end	

	if ass_kicking_mode then
		Eye1.BrickColor=BrickColor.Random()
		Eye2.BrickColor=BrickColor.Random()
		Eye1.Material=Enum.Material.Neon
		Eye2.Material=Enum.Material.Neon
		if findTorso(tors.CFrame.p,12)then
			if  findTorso(tors.CFrame.p,12).Parent.Humanoid.Health>0 then
				findTorso(tors.CFrame.p,12).Parent.Humanoid.Health=0
				ShowDamage(findTorso(tors.CFrame.p,12).Position+Vector3.new(0,5,0),99999999,1,Color3.fromRGB(255,0,0),findTorso(tors.CFrame.p,12).Parent)
			end
		end
		neck.C0=neck.C0:lerp(nec*CFrame.Angles(math.rad(math.random(-17,17)),math.rad(math.random(-17,17)),math.rad(math.random(-17,17))),.35)
	end

	hum.MaxHealth=math.huge
	hum.Health=math.huge
	char:MakeJoints()
	pcall(function()
		walls.Part.CFrame=walls.Part.CFrame:lerp(tors.CFrame,.55)
	end)
	hum.WalkSpeed=14
	if not oof then
		if state=="idle"then
			rs.C0=rs.C0:lerp(rightogSin,.35)
			ls.C0=ls.C0:lerp(leftogSin,.35)	
			neck.C0=neck.C0:lerp(nec*CFrame.Angles(math.rad(10)+math.cos(tick()*2)/6,0,0),.35)
			rj.C0=rj.C0:lerp(rootCF*CFrame.Angles(math.cos(tick()*2)/12,0,0),.35)
			lh.C0=lh.C0:lerp(lhCF*CFrame.Angles(-math.rad(5),-math.rad(3),-math.rad(5)-math.cos(tick()*2)/12),.35)
			rh.C0=rh.C0:lerp(rhCF*CFrame.Angles(-math.rad(5),-math.rad(3),math.rad(5)+math.cos(tick()*2)/12),.35)	
		end
		if state=="walk"then
			rs.C0=rs.C0:lerp(rightogSin,.35)
			ls.C0=ls.C0:lerp(leftogSin,.35)	
			neck.C0=neck.C0:lerp(nec*CFrame.Angles(-math.rad(3)+math.cos(tick()*2)/6,0,0),.35)
			rj.C0=rj.C0:lerp(rootCF*CFrame.Angles(math.rad(10)+math.cos(tick()*4)/14,0,0)*CFrame.new(0,math.cos(tick()*6)/18,math.cos(tick()*6)/14),.35)
			lh.C0=lh.C0:lerp(lhCF*CFrame.Angles(-math.rad(2),-math.rad(1),-math.rad(1.5)+math.cos(tick()*5.5)/2),.35)
			rh.C0=rh.C0:lerp(rhCF*CFrame.Angles(-math.rad(2),-math.rad(1),-math.rad(1.5)+math.cos(tick()*5.5)/2),.35)			
		end
		if state=="jump"then
			local sine=tick()
			local necko=nec
			local angles=CFrame.Angles
			local cf=CFrame.new	
			local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
			local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)	
			rj.C0 = clerp(rj.C0,rootCF*cf(0,0,-0.1+0.1*math.cos(sine/20))* angles(math.rad(10),math.rad(0),math.rad(0)),.3)
			tors.Neck.C0 = clerp(tors.Neck.C0,necko *angles(math.rad(-10),math.rad(0),math.rad(0)),.3)
			rs.C0 = clerp(rs.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(30), math.rad(0), math.rad(20)), 0.3)
			ls.C0 = clerp(ls.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.3)
			lh.C0=clerp(lh.C0,cf(-1,-.9-0.1*math.cos(sine/20),-0.3)*LHCF*angles(math.rad(-5),math.rad(-0),math.rad(20)),0.15)
			rh.C0=clerp(rh.C0,cf(1,-1,0.3)*angles(math.rad(0),math.rad(90),math.rad(-20)),.3)
		end		
		if state=="fall"then
			local sine=tick()
			local necko=nec
			local angles=CFrame.Angles
			local cf=CFrame.new	
			local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
			local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)	

			rj.C0 = clerp(rj.C0,rootCF*cf(0,0,-0.1+0.1*math.cos(sine/20))* angles(math.rad(-5),math.rad(0),math.rad(0)),.3)
			tors.Neck.C0 = clerp(tors.Neck.C0,necko *angles(math.rad(-10),math.rad(0),math.rad(0)),.3)
			rs.C0 = clerp(rs.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(30), math.rad(0), math.rad(90)), 0.3)
			ls.C0 = clerp(ls.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-90)), 0.3)
			lh.C0=clerp(lh.C0,cf(-1,-.4-0.1*math.cos(sine/20),-.6)*LHCF*angles(math.rad(-5),math.rad(-0),math.rad(20)),0.15)
			rh.C0=clerp(rh.C0,cf(1,-.3-0.1*math.cos(sine/20),-.6)*angles(math.rad(0),math.rad(90),math.rad(-20)),.3)		
		end
	end
	if oof then
		local rad=math.rad
		local cos=math.cos
		local sine=tick()
		neck.C0=neck.C0:lerp(nec*CFrame.Angles(rad(38),0,0)*CFrame.Angles(math.rad(10)+math.cos(tick()*2)/6,0,0)+Vector3.new(0,cos(sine*3))/9,.35)
		rj.C0=rj.C0:lerp(rootCF*CFrame.new(0,0,-1.5)+Vector3.new(0,cos(sine*3))/6.2,.35)
		rs.C0=rs.C0:lerp(rightog*CFrame.Angles(0,rad(37),rad(37))+Vector3.new(0,cos(sine*3))/5.7,.35)
		ls.C0=ls.C0:lerp(leftog*CFrame.Angles(-rad(13),0,0)+Vector3.new(0,cos(sine*3))/5.7,.35)
		rh.C0=rh.C0:lerp(rhCF*CFrame.Angles(0,-rad(32/2),rad(90)),.35)
		lh.C0=lh.C0:lerp(lhCF*CFrame.Angles(0,rad(32/2),-rad(90)),.35)		
		root.Anchored=true
	else
		root.Anchored=false
	end
end