function LoadLibrary(a)
	local t = {}

	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------JSON Functions Begin----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------

	--JSON Encoder and Parser for Lua 5.1
	--
	--Copyright 2007 Shaun Brown  (http://www.chipmunkav.com)
	--All Rights Reserved.

	--Permission is hereby granted, free of charge, to any person 
	--obtaining a copy of this software to deal in the Software without 
	--restriction, including without limitation the rights to use, 
	--copy, modify, merge, publish, distribute, sublicense, and/or 
	--sell copies of the Software, and to permit persons to whom the 
	--Software is furnished to do so, subject to the following conditions:

	--The above copyright notice and this permission notice shall be 
	--included in all copies or substantial portions of the Software.
	--If you find this software useful please give www.chipmunkav.com a mention.

	--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
	--EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	--OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	--IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
	--ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
	--CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
	--CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

	local string = string
	local math = math
	local table = table
	local error = error
	local tonumber = tonumber
	local tostring = tostring
	local type = type
	local setmetatable = setmetatable
	local pairs = pairs
	local ipairs = ipairs
	local assert = assert


	local StringBuilder = {
		buffer = {}
	}

	function StringBuilder:New()
		local o = {}
		setmetatable(o, self)
		self.__index = self
		o.buffer = {}
		return o
	end

	function StringBuilder:Append(s)
		self.buffer[#self.buffer+1] = s
	end

	function StringBuilder:ToString()
		return table.concat(self.buffer)
	end

	local JsonWriter = {
		backslashes = {
			['\b'] = "\\b",
			['\t'] = "\\t",	
			['\n'] = "\\n", 
			['\f'] = "\\f",
			['\r'] = "\\r", 
			['"']  = "\\\"", 
			['\\'] = "\\\\", 
			['/']  = "\\/"
		}
	}

	function JsonWriter:New()
		local o = {}
		o.writer = StringBuilder:New()
		setmetatable(o, self)
		self.__index = self
		return o
	end

	function JsonWriter:Append(s)
		self.writer:Append(s)
	end

	function JsonWriter:ToString()
		return self.writer:ToString()
	end

	function JsonWriter:Write(o)
		local t = type(o)
		if t == "nil" then
			self:WriteNil()
		elseif t == "boolean" then
			self:WriteString(o)
		elseif t == "number" then
			self:WriteString(o)
		elseif t == "string" then
			self:ParseString(o)
		elseif t == "table" then
			self:WriteTable(o)
		elseif t == "function" then
			self:WriteFunction(o)
		elseif t == "thread" then
			self:WriteError(o)
		elseif t == "userdata" then
			self:WriteError(o)
		end
	end

	function JsonWriter:WriteNil()
		self:Append("null")
	end

	function JsonWriter:WriteString(o)
		self:Append(tostring(o))
	end

	function JsonWriter:ParseString(s)
		self:Append('"')
		self:Append(string.gsub(s, "[%z%c\\\"/]", function(n)
			local c = self.backslashes[n]
			if c then return c end
			return string.format("\\u%.4X", string.byte(n))
		end))
		self:Append('"')
	end

	function JsonWriter:IsArray(t)
		local count = 0
		local isindex = function(k) 
			if type(k) == "number" and k > 0 then
				if math.floor(k) == k then
					return true
				end
			end
			return false
		end
		for k,v in pairs(t) do
			if not isindex(k) then
				return false, '{', '}'
			else
				count = math.max(count, k)
			end
		end
		return true, '[', ']', count
	end

	function JsonWriter:WriteTable(t)
		local ba, st, et, n = self:IsArray(t)
		self:Append(st)	
		if ba then		
			for i = 1, n do
				self:Write(t[i])
				if i < n then
					self:Append(',')
				end
			end
		else
			local first = true;
			for k, v in pairs(t) do
				if not first then
					self:Append(',')
				end
				first = false;			
				self:ParseString(k)
				self:Append(':')
				self:Write(v)			
			end
		end
		self:Append(et)
	end

	function JsonWriter:WriteError(o)
		error(string.format(
			"Encoding of %s unsupported", 
			tostring(o)))
	end

	function JsonWriter:WriteFunction(o)
		if o == nil then 
			self:WriteNil()
		else
			self:WriteError(o)
		end
	end

	local StringReader = {
		s = "",
		i = 0
	}

	function StringReader:New(s)
		local o = {}
		setmetatable(o, self)
		self.__index = self
		o.s = s or o.s
		return o	
	end

	function StringReader:Peek()
		local i = self.i + 1
		if i <= #self.s then
			return string.sub(self.s, i, i)
		end
		return nil
	end

	function StringReader:Next()
		self.i = self.i+1
		if self.i <= #self.s then
			return string.sub(self.s, self.i, self.i)
		end
		return nil
	end

	function StringReader:All()
		return self.s
	end

	local JsonReader = {
		escapes = {
			['t'] = '\t',
			['n'] = '\n',
			['f'] = '\f',
			['r'] = '\r',
			['b'] = '\b',
		}
	}

	function JsonReader:New(s)
		local o = {}
		o.reader = StringReader:New(s)
		setmetatable(o, self)
		self.__index = self
		return o;
	end

	function JsonReader:Read()
		self:SkipWhiteSpace()
		local peek = self:Peek()
		if peek == nil then
			error(string.format(
				"Nil string: '%s'", 
				self:All()))
		elseif peek == '{' then
			return self:ReadObject()
		elseif peek == '[' then
			return self:ReadArray()
		elseif peek == '"' then
			return self:ReadString()
		elseif string.find(peek, "[%+%-%d]") then
			return self:ReadNumber()
		elseif peek == 't' then
			return self:ReadTrue()
		elseif peek == 'f' then
			return self:ReadFalse()
		elseif peek == 'n' then
			return self:ReadNull()
		elseif peek == '/' then
			self:ReadComment()
			return self:Read()
		else
			return nil
		end
	end

	function JsonReader:ReadTrue()
		self:TestReservedWord{'t','r','u','e'}
		return true
	end

	function JsonReader:ReadFalse()
		self:TestReservedWord{'f','a','l','s','e'}
		return false
	end

	function JsonReader:ReadNull()
		self:TestReservedWord{'n','u','l','l'}
		return nil
	end

	function JsonReader:TestReservedWord(t)
		for i, v in ipairs(t) do
			if self:Next() ~= v then
				error(string.format(
					"Error reading '%s': %s", 
					table.concat(t), 
					self:All()))
			end
		end
	end

	function JsonReader:ReadNumber()
		local result = self:Next()
		local peek = self:Peek()
		while peek ~= nil and string.find(
			peek, 
			"[%+%-%d%.eE]") do
			result = result .. self:Next()
			peek = self:Peek()
		end
		result = tonumber(result)
		if result == nil then
			error(string.format(
				"Invalid number: '%s'", 
				result))
		else
			return result
		end
	end

	function JsonReader:ReadString()
		local result = ""
		assert(self:Next() == '"')
		while self:Peek() ~= '"' do
			local ch = self:Next()
			if ch == '\\' then
				ch = self:Next()
				if self.escapes[ch] then
					ch = self.escapes[ch]
				end
			end
			result = result .. ch
		end
		assert(self:Next() == '"')
		local fromunicode = function(m)
			return string.char(tonumber(m, 16))
		end
		return string.gsub(
			result, 
			"u%x%x(%x%x)", 
			fromunicode)
	end

	function JsonReader:ReadComment()
		assert(self:Next() == '/')
		local second = self:Next()
		if second == '/' then
			self:ReadSingleLineComment()
		elseif second == '*' then
			self:ReadBlockComment()
		else
			error(string.format(
				"Invalid comment: %s", 
				self:All()))
		end
	end

	function JsonReader:ReadBlockComment()
		local done = false
		while not done do
			local ch = self:Next()		
			if ch == '*' and self:Peek() == '/' then
				done = true
			end
			if not done and 
				ch == '/' and 
				self:Peek() == "*" then
				error(string.format(
					"Invalid comment: %s, '/*' illegal.",  
					self:All()))
			end
		end
		self:Next()
	end

	function JsonReader:ReadSingleLineComment()
		local ch = self:Next()
		while ch ~= '\r' and ch ~= '\n' do
			ch = self:Next()
		end
	end

	function JsonReader:ReadArray()
		local result = {}
		assert(self:Next() == '[')
		local done = false
		if self:Peek() == ']' then
			done = true;
		end
		while not done do
			local item = self:Read()
			result[#result+1] = item
			self:SkipWhiteSpace()
			if self:Peek() == ']' then
				done = true
			end
			if not done then
				local ch = self:Next()
				if ch ~= ',' then
					error(string.format(
						"Invalid array: '%s' due to: '%s'", 
						self:All(), ch))
				end
			end
		end
		assert(']' == self:Next())
		return result
	end

	function JsonReader:ReadObject()
		local result = {}
		assert(self:Next() == '{')
		local done = false
		if self:Peek() == '}' then
			done = true
		end
		while not done do
			local key = self:Read()
			if type(key) ~= "string" then
				error(string.format(
					"Invalid non-string object key: %s", 
					key))
			end
			self:SkipWhiteSpace()
			local ch = self:Next()
			if ch ~= ':' then
				error(string.format(
					"Invalid object: '%s' due to: '%s'", 
					self:All(), 
					ch))
			end
			self:SkipWhiteSpace()
			local val = self:Read()
			result[key] = val
			self:SkipWhiteSpace()
			if self:Peek() == '}' then
				done = true
			end
			if not done then
				ch = self:Next()
				if ch ~= ',' then
					error(string.format(
						"Invalid array: '%s' near: '%s'", 
						self:All(), 
						ch))
				end
			end
		end
		assert(self:Next() == "}")
		return result
	end

	function JsonReader:SkipWhiteSpace()
		local p = self:Peek()
		while p ~= nil and string.find(p, "[%s/]") do
			if p == '/' then
				self:ReadComment()
			else
				self:Next()
			end
			p = self:Peek()
		end
	end

	function JsonReader:Peek()
		return self.reader:Peek()
	end

	function JsonReader:Next()
		return self.reader:Next()
	end

	function JsonReader:All()
		return self.reader:All()
	end

	local function Encode(o)
		local writer = JsonWriter:New()
		writer:Write(o)
		return writer:ToString()
	end

	local function Decode(s)
		local reader = JsonReader:New(s)
		return reader:Read()
	end

	local function Null()
		return Null
	end
	-------------------- End JSON Parser ------------------------

	t.DecodeJSON = function(jsonString)
		pcall(function() warn("RbxUtility.DecodeJSON is deprecated, please use Game:GetService('HttpService'):JSONDecode() instead.") end)

		if type(jsonString) == "string" then
			return Decode(jsonString)
		end
		print("RbxUtil.DecodeJSON expects string argument!")
		return nil
	end

	t.EncodeJSON = function(jsonTable)
		pcall(function() warn("RbxUtility.EncodeJSON is deprecated, please use Game:GetService('HttpService'):JSONEncode() instead.") end)
		return Encode(jsonTable)
	end








	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------Terrain Utilities Begin-----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	--makes a wedge at location x, y, z
	--sets cell x, y, z to default material if parameter is provided, if not sets cell x, y, z to be whatever material it previously w
	--returns true if made a wedge, false if the cell remains a block
	t.MakeWedge = function(x, y, z, defaultmaterial)
		return game:GetService("Terrain"):AutoWedgeCell(x,y,z)
	end

	t.SelectTerrainRegion = function(regionToSelect, color, selectEmptyCells, selectionParent)
		local terrain = game:GetService("Workspace"):FindFirstChild("Terrain")
		if not terrain then return end

		assert(regionToSelect)
		assert(color)

		if type(color) ~= "Region3" then
			error("regionToSelect (first arg), should be of type Region3, but is type",type(regionToSelect))
		end
		if type(color) ~= "BrickColor" then
			error("color (second arg), should be of type BrickColor, but is type",type(color))
		end

		-- frequently used terrain calls (speeds up call, no lookup necessary)
		local GetCell = terrain.GetCell
		local WorldToCellPreferSolid = terrain.WorldToCellPreferSolid
		local CellCenterToWorld = terrain.CellCenterToWorld
		local emptyMaterial = Enum.CellMaterial.Empty

		-- container for all adornments, passed back to user
		local selectionContainer = Instance.new("Model")
		selectionContainer.Name = "SelectionContainer"
		selectionContainer.Archivable = false
		if selectionParent then
			selectionContainer.Parent = selectionParent
		else
			selectionContainer.Parent = game:GetService("Workspace")
		end

		local updateSelection = nil -- function we return to allow user to update selection
		local currentKeepAliveTag = nil -- a tag that determines whether adorns should be destroyed
		local aliveCounter = 0 -- helper for currentKeepAliveTag
		local lastRegion = nil -- used to stop updates that do nothing
		local adornments = {} -- contains all adornments
		local reusableAdorns = {}

		local selectionPart = Instance.new("Part")
		selectionPart.Name = "SelectionPart"
		selectionPart.Transparency = 1
		selectionPart.Anchored = true
		selectionPart.Locked = true
		selectionPart.CanCollide = false
		selectionPart.Size = Vector3.new(4.2,4.2,4.2)

		local selectionBox = Instance.new("SelectionBox")

		-- srs translation from region3 to region3int16
		local function Region3ToRegion3int16(region3)
			local theLowVec = region3.CFrame.p - (region3.Size/2) + Vector3.new(2,2,2)
			local lowCell = WorldToCellPreferSolid(terrain,theLowVec)

			local theHighVec = region3.CFrame.p + (region3.Size/2) - Vector3.new(2,2,2)
			local highCell = WorldToCellPreferSolid(terrain, theHighVec)

			local highIntVec = Vector3int16.new(highCell.x,highCell.y,highCell.z)
			local lowIntVec = Vector3int16.new(lowCell.x,lowCell.y,lowCell.z)

			return Region3int16.new(lowIntVec,highIntVec)
		end

		-- helper function that creates the basis for a selection box
		local function createAdornment(theColor)
			local selectionPartClone = nil
			local selectionBoxClone = nil

			if #reusableAdorns > 0 then
				selectionPartClone = reusableAdorns[1]["part"]
				selectionBoxClone = reusableAdorns[1]["box"]
				table.remove(reusableAdorns,1)

				selectionBoxClone.Visible = true
			else
				selectionPartClone = selectionPart:Clone()
				selectionPartClone.Archivable = false

				selectionBoxClone = selectionBox:Clone()
				selectionBoxClone.Archivable = false

				selectionBoxClone.Adornee = selectionPartClone
				selectionBoxClone.Parent = selectionContainer

				selectionBoxClone.Adornee = selectionPartClone

				selectionBoxClone.Parent = selectionContainer
			end

			if theColor then
				selectionBoxClone.Color = theColor
			end

			return selectionPartClone, selectionBoxClone
		end

		-- iterates through all current adornments and deletes any that don't have latest tag
		local function cleanUpAdornments()
			for cellPos, adornTable in pairs(adornments) do

				if adornTable.KeepAlive ~= currentKeepAliveTag then -- old news, we should get rid of this
					adornTable.SelectionBox.Visible = false
					table.insert(reusableAdorns,{part = adornTable.SelectionPart, box = adornTable.SelectionBox})
					adornments[cellPos] = nil
				end
			end
		end

		-- helper function to update tag
		local function incrementAliveCounter()
			aliveCounter = aliveCounter + 1
			if aliveCounter > 1000000 then
				aliveCounter = 0
			end
			return aliveCounter
		end

		-- finds full cells in region and adorns each cell with a box, with the argument color
		local function adornFullCellsInRegion(region, color)
			local regionBegin = region.CFrame.p - (region.Size/2) + Vector3.new(2,2,2)
			local regionEnd = region.CFrame.p + (region.Size/2) - Vector3.new(2,2,2)

			local cellPosBegin = WorldToCellPreferSolid(terrain, regionBegin)
			local cellPosEnd = WorldToCellPreferSolid(terrain, regionEnd)

			currentKeepAliveTag = incrementAliveCounter()
			for y = cellPosBegin.y, cellPosEnd.y do
				for z = cellPosBegin.z, cellPosEnd.z do
					for x = cellPosBegin.x, cellPosEnd.x do
						local cellMaterial = GetCell(terrain, x, y, z)

						if cellMaterial ~= emptyMaterial then
							local cframePos = CellCenterToWorld(terrain, x, y, z)
							local cellPos = Vector3int16.new(x,y,z)

							local updated = false
							for cellPosAdorn, adornTable in pairs(adornments) do
								if cellPosAdorn == cellPos then
									adornTable.KeepAlive = currentKeepAliveTag
									if color then
										adornTable.SelectionBox.Color = color
									end
									updated = true
									break
								end 
							end

							if not updated then
								local selectionPart, selectionBox = createAdornment(color)
								selectionPart.Size = Vector3.new(4,4,4)
								selectionPart.CFrame = CFrame.new(cframePos)
								local adornTable = {SelectionPart = selectionPart, SelectionBox = selectionBox, KeepAlive = currentKeepAliveTag}
								adornments[cellPos] = adornTable
							end
						end
					end
				end
			end
			cleanUpAdornments()
		end


		------------------------------------- setup code ------------------------------
		lastRegion = regionToSelect

		if selectEmptyCells then -- use one big selection to represent the area selected
			local selectionPart, selectionBox = createAdornment(color)

			selectionPart.Size = regionToSelect.Size
			selectionPart.CFrame = regionToSelect.CFrame

			adornments.SelectionPart = selectionPart
			adornments.SelectionBox = selectionBox

			updateSelection = 
				function (newRegion, color)
					if newRegion and newRegion ~= lastRegion then
					lastRegion = newRegion
					selectionPart.Size = newRegion.Size
					selectionPart.CFrame = newRegion.CFrame
				end
					if color then
					selectionBox.Color = color
				end
				end
		else -- use individual cell adorns to represent the area selected
			adornFullCellsInRegion(regionToSelect, color)
			updateSelection = 
				function (newRegion, color)
					if newRegion and newRegion ~= lastRegion then
					lastRegion = newRegion
					adornFullCellsInRegion(newRegion, color)
				end
				end

		end

		local destroyFunc = function()
			updateSelection = nil
			if selectionContainer then selectionContainer:Destroy() end
			adornments = nil
		end

		return updateSelection, destroyFunc
	end

	-----------------------------Terrain Utilities End-----------------------------







	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------Signal class begin------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
--[[
A 'Signal' object identical to the internal RBXScriptSignal object in it's public API and semantics. This function 
can be used to create "custom events" for user-made code.
API:
Method :connect( function handler )
	Arguments:   The function to connect to.
	Returns:     A new connection object which can be used to disconnect the connection
	Description: Connects this signal to the function specified by |handler|. That is, when |fire( ... )| is called for
	             the signal the |handler| will be called with the arguments given to |fire( ... )|. Note, the functions
	             connected to a signal are called in NO PARTICULAR ORDER, so connecting one function after another does
	             NOT mean that the first will be called before the second as a result of a call to |fire|.

Method :disconnect()
	Arguments:   None
	Returns:     None
	Description: Disconnects all of the functions connected to this signal.

Method :fire( ... )
	Arguments:   Any arguments are accepted
	Returns:     None
	Description: Calls all of the currently connected functions with the given arguments.

Method :wait()
	Arguments:   None
	Returns:     The arguments given to fire
	Description: This call blocks until 
]]

	function t.CreateSignal()
		local this = {}

		local mBindableEvent = Instance.new('BindableEvent')
		local mAllCns = {} --all connection objects returned by mBindableEvent::connect

		--main functions
		function this:connect(func)
			if self ~= this then error("connect must be called with `:`, not `.`", 2) end
			if type(func) ~= 'function' then
				error("Argument #1 of connect must be a function, got a "..type(func), 2)
			end
			local cn = mBindableEvent.Event:Connect(func)
			mAllCns[cn] = true
			local pubCn = {}
			function pubCn:disconnect()
				cn:Disconnect()
				mAllCns[cn] = nil
			end
			pubCn.Disconnect = pubCn.disconnect

			return pubCn
		end

		function this:disconnect()
			if self ~= this then error("disconnect must be called with `:`, not `.`", 2) end
			for cn, _ in pairs(mAllCns) do
				cn:Disconnect()
				mAllCns[cn] = nil
			end
		end

		function this:wait()
			if self ~= this then error("wait must be called with `:`, not `.`", 2) end
			return mBindableEvent.Event:Wait()
		end

		function this:fire(...)
			if self ~= this then error("fire must be called with `:`, not `.`", 2) end
			mBindableEvent:Fire(...)
		end

		this.Connect = this.connect
		this.Disconnect = this.disconnect
		this.Wait = this.wait
		this.Fire = this.fire

		return this
	end

	------------------------------------------------- Sigal class End ------------------------------------------------------




	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------Create Function Begins---------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
--[[
A "Create" function for easy creation of Roblox instances. The function accepts a string which is the classname of
the object to be created. The function then returns another function which either accepts accepts no arguments, in 
which case it simply creates an object of the given type, or a table argument that may contain several types of data, 
in which case it mutates the object in varying ways depending on the nature of the aggregate data. These are the
type of data and what operation each will perform:
1) A string key mapping to some value:
      Key-Value pairs in this form will be treated as properties of the object, and will be assigned in NO PARTICULAR
      ORDER. If the order in which properties is assigned matter, then they must be assigned somewhere else than the
      |Create| call's body.

2) An integral key mapping to another Instance:
      Normal numeric keys mapping to Instances will be treated as children if the object being created, and will be
      parented to it. This allows nice recursive calls to Create to create a whole hierarchy of objects without a
      need for temporary variables to store references to those objects.

3) A key which is a value returned from Create.Event( eventname ), and a value which is a function function
      The Create.E( string ) function provides a limited way to connect to signals inside of a Create hierarchy 
      for those who really want such a functionality. The name of the event whose name is passed to 
      Create.E( string )

4) A key which is the Create function itself, and a value which is a function
      The function will be run with the argument of the object itself after all other initialization of the object is 
      done by create. This provides a way to do arbitrary things involving the object from withing the create 
      hierarchy. 
      Note: This function is called SYNCHRONOUSLY, that means that you should only so initialization in
      it, not stuff which requires waiting, as the Create call will block until it returns. While waiting in the 
      constructor callback function is possible, it is probably not a good design choice.
      Note: Since the constructor function is called after all other initialization, a Create block cannot have two 
      constructor functions, as it would not be possible to call both of them last, also, this would be unnecessary.


Some example usages:

A simple example which uses the Create function to create a model object and assign two of it's properties.
local model = Create'Model'{
    Name = 'A New model',
    Parent = game.Workspace,
}


An example where a larger hierarchy of object is made. After the call the hierarchy will look like this:
Model_Container
 |-ObjectValue
 |  |
 |  `-BoolValueChild
 `-IntValue

local model = Create'Model'{
    Name = 'Model_Container',
    Create'ObjectValue'{
        Create'BoolValue'{
            Name = 'BoolValueChild',
        },
    },
    Create'IntValue'{},
}


An example using the event syntax:

local part = Create'Part'{
    [Create.E'Touched'] = function(part)
        print("I was touched by "..part.Name)
    end,	
}


An example using the general constructor syntax:

local model = Create'Part'{
    [Create] = function(this)
        print("Constructor running!")
        this.Name = GetGlobalFoosAndBars(this)
    end,
}


Note: It is also perfectly legal to save a reference to the function returned by a call Create, this will not cause
      any unexpected behavior. EG:
      local partCreatingFunction = Create'Part'
      local part = partCreatingFunction()
]]

	--the Create function need to be created as a functor, not a function, in order to support the Create.E syntax, so it
	--will be created in several steps rather than as a single function declaration.
	local function Create_PrivImpl(objectType)
		if type(objectType) ~= 'string' then
			error("Argument of Create must be a string", 2)
		end
		--return the proxy function that gives us the nice Create'string'{data} syntax
		--The first function call is a function call using Lua's single-string-argument syntax
		--The second function call is using Lua's single-table-argument syntax
		--Both can be chained together for the nice effect.
		return function(dat)
			--default to nothing, to handle the no argument given case
			dat = dat or {}

			--make the object to mutate
			local obj = Instance.new(objectType)
			local parent = nil

			--stored constructor function to be called after other initialization
			local ctor = nil

			for k, v in pairs(dat) do
				--add property
				if type(k) == 'string' then
					if k == 'Parent' then
						-- Parent should always be set last, setting the Parent of a new object
						-- immediately makes performance worse for all subsequent property updates.
						parent = v
					else
						obj[k] = v
					end


					--add child
				elseif type(k) == 'number' then
					if type(v) ~= 'userdata' then
						error("Bad entry in Create body: Numeric keys must be paired with children, got a: "..type(v), 2)
					end
					v.Parent = obj


					--event connect
				elseif type(k) == 'table' and k.__eventname then
					if type(v) ~= 'function' then
						error("Bad entry in Create body: Key `[Create.E\'"..k.__eventname.."\']` must have a function value\
					       got: "..tostring(v), 2)
					end
					obj[k.__eventname]:connect(v)


					--define constructor function
				elseif k == t.Create then
					if type(v) ~= 'function' then
						error("Bad entry in Create body: Key `[Create]` should be paired with a constructor function, \
					       got: "..tostring(v), 2)
					elseif ctor then
						--ctor already exists, only one allowed
						error("Bad entry in Create body: Only one constructor function is allowed", 2)
					end
					ctor = v


				else
					error("Bad entry ("..tostring(k).." => "..tostring(v)..") in Create body", 2)
				end
			end

			--apply constructor function if it exists
			if ctor then
				ctor(obj)
			end

			if parent then
				obj.Parent = parent
			end

			--return the completed object
			return obj
		end
	end

	--now, create the functor:
	t.Create = setmetatable({}, {__call = function(tb, ...) return Create_PrivImpl(...) end})

	--and create the "Event.E" syntax stub. Really it's just a stub to construct a table which our Create
	--function can recognize as special.
	t.Create.E = function(eventName)
		return {__eventname = eventName}
	end

	-------------------------------------------------Create function End----------------------------------------------------




	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------Documentation Begin-----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------

	t.Help = 
		function(funcNameOrFunc) 
			--input argument can be a string or a function.  Should return a description (of arguments and expected side effects)
			if funcNameOrFunc == "DecodeJSON" or funcNameOrFunc == t.DecodeJSON then
			return "Function DecodeJSON.  " ..
				"Arguments: (string).  " .. 
				"Side effect: returns a table with all parsed JSON values" 
		end
			if funcNameOrFunc == "EncodeJSON" or funcNameOrFunc == t.EncodeJSON then
			return "Function EncodeJSON.  " ..
				"Arguments: (table).  " .. 
				"Side effect: returns a string composed of argument table in JSON data format" 
		end  
			if funcNameOrFunc == "MakeWedge" or funcNameOrFunc == t.MakeWedge then
			return "Function MakeWedge. " ..
				"Arguments: (x, y, z, [default material]). " ..
				"Description: Makes a wedge at location x, y, z. Sets cell x, y, z to default material if "..
				"parameter is provided, if not sets cell x, y, z to be whatever material it previously was. "..
				"Returns true if made a wedge, false if the cell remains a block "
		end
			if funcNameOrFunc == "SelectTerrainRegion" or funcNameOrFunc == t.SelectTerrainRegion then
			return "Function SelectTerrainRegion. " ..
				"Arguments: (regionToSelect, color, selectEmptyCells, selectionParent). " ..
				"Description: Selects all terrain via a series of selection boxes within the regionToSelect " ..
				"(this should be a region3 value). The selection box color is detemined by the color argument " ..
				"(should be a brickcolor value). SelectionParent is the parent that the selection model gets placed to (optional)." ..
				"SelectEmptyCells is bool, when true will select all cells in the " ..
				"region, otherwise we only select non-empty cells. Returns a function that can update the selection," ..
				"arguments to said function are a new region3 to select, and the adornment color (color arg is optional). " ..
				"Also returns a second function that takes no arguments and destroys the selection"
		end
			if funcNameOrFunc == "CreateSignal" or funcNameOrFunc == t.CreateSignal then
			return "Function CreateSignal. "..
				"Arguments: None. "..
				"Returns: The newly created Signal object. This object is identical to the RBXScriptSignal class "..
				"used for events in Objects, but is a Lua-side object so it can be used to create custom events in"..
				"Lua code. "..
				"Methods of the Signal object: :connect, :wait, :fire, :disconnect. "..
				"For more info you can pass the method name to the Help function, or view the wiki page "..
				"for this library. EG: Help('Signal:connect')."
		end
			if funcNameOrFunc == "Signal:connect" then
			return "Method Signal:connect. "..
				"Arguments: (function handler). "..
				"Return: A connection object which can be used to disconnect the connection to this handler. "..
				"Description: Connectes a handler function to this Signal, so that when |fire| is called the "..
				"handler function will be called with the arguments passed to |fire|."
		end
			if funcNameOrFunc == "Signal:wait" then
			return "Method Signal:wait. "..
				"Arguments: None. "..
				"Returns: The arguments passed to the next call to |fire|. "..
				"Description: This call does not return until the next call to |fire| is made, at which point it "..
				"will return the values which were passed as arguments to that |fire| call."
		end
			if funcNameOrFunc == "Signal:fire" then
			return "Method Signal:fire. "..
				"Arguments: Any number of arguments of any type. "..
				"Returns: None. "..
				"Description: This call will invoke any connected handler functions, and notify any waiting code "..
				"attached to this Signal to continue, with the arguments passed to this function. Note: The calls "..
				"to handlers are made asynchronously, so this call will return immediately regardless of how long "..
				"it takes the connected handler functions to complete."
		end
			if funcNameOrFunc == "Signal:disconnect" then
			return "Method Signal:disconnect. "..
				"Arguments: None. "..
				"Returns: None. "..
				"Description: This call disconnects all handlers attacched to this function, note however, it "..
				"does NOT make waiting code continue, as is the behavior of normal Roblox events. This method "..
				"can also be called on the connection object which is returned from Signal:connect to only "..
				"disconnect a single handler, as opposed to this method, which will disconnect all handlers."
		end
			if funcNameOrFunc == "Create" then
			return "Function Create. "..
				"Arguments: A table containing information about how to construct a collection of objects. "..
				"Returns: The constructed objects. "..
				"Descrition: Create is a very powerfull function, whose description is too long to fit here, and "..
				"is best described via example, please see the wiki page for a description of how to use it."
		end
		end

	--------------------------------------------Documentation Ends----------------------------------------------------------

	return t
end

---------------------------
--/                     \--
-- Script By: 123jl123	 --
--\                     /--
---------------------------
--local remote = NS ([=[

local TweenService = game:GetService("TweenService")
local Create = LoadLibrary("RbxUtility").Create



local Player = game.Players.LocalPlayer


ZTfade=false 
ZT=false

local agresive = false
Target = Vector3.new()
Character= Player.Character
Torso = Character.Torso
Head = Character.Head
Humanoid = Character.Humanoid
LeftArm = Character["Left Arm"]
LeftLeg = Character["Left Leg"]
RightArm = Character["Right Arm"]
RightLeg = Character["Right Leg"]
RootPart = Character["HumanoidRootPart"]
local Anim="Idle"
local inairvel=0
local WalkAnimStep = 0
local sine = 0
local change = 1
Animstep = 0
WalkAnimMove=0.05
Combo = 0
local attack=false
local RJ = Character.HumanoidRootPart:FindFirstChild("RootJoint")
local Neck = Character.Torso:FindFirstChild("Neck")
local MAINRUINCOLOR = BrickColor.new("Lily white")

local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14) 
local NeckCF = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)


local forWFB = 0
local forWRL = 0


Effects=Instance.new("Folder",Character)
Effects.Name="Effects"
it=Instance.new
vt=Vector3.new
cf=CFrame.new
euler=CFrame.fromEulerAnglesXYZ
angles=CFrame.Angles
local cn = CFrame.new
mr=math.rad
mememode=false
pantdown=false
pant=false
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

local lastid= "http://www.roblox.com/asset/?id=9046862941"
local s2=it("Sound",Character)
local CurId = 1
s2.EmitterSize = 30
local s2c=s2:Clone()

playsong = true

s2.SoundId = lastid
if playsong == true then
	s2:play()		
elseif playsong == false then
	s2:stop()			
end
lastsongpos= 0

--//=================================\\
--||          LOCAL IDS
--\\=================================//

local GROWL = 1544355717
local ROAR = 528589382
local ECHOBLAST = 376976397
local CAST = 459523898
local ALCHEMY = 424195979
local BUILDUP = 698824317
local BIGBUILDUP = 874376217
local IMPACT = 231917744
local LARGE_EXPLOSION = 168513088
local TURNUP = 299058146

if Character:FindFirstChild("Animate")then
	Character.Animate:Destroy()
end

function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end




CFuncs = {
	Part = {Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)

		local Part = Create("Part")({Parent = Parent, Reflectance = Reflectance, Transparency = Transparency, CanCollide = false, Locked = true, BrickColor = BrickColor.new(tostring(BColor)), Name = Name, Size = Size, Material = Material})
		RemoveOutlines(Part)
		return Part
	end
	}
	, 
	Mesh = {Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)

		local Msh = Create(Mesh)({Parent = Part, Offset = OffSet, Scale = Scale})
		if Mesh == "SpecialMesh" then
			Msh.MeshType = MeshType
			Msh.MeshId = MeshId
		end
		return Msh
	end
	}
	, 
	Weld = {Create = function(Parent, Part0, Part1, C0, C1)

		local Weld = Create("Weld")({Parent = Parent, Part0 = Part0, Part1 = Part1, C0 = C0, C1 = C1})
		return Weld
	end
	}
	, 
	Sound = {Create = function(id, par, vol, pit)

		coroutine.resume(coroutine.create(function()

			local S = Create("Sound")({Volume = vol, Pitch = pit or 1, SoundId  = "http://www.roblox.com/asset/?id="..id, Parent = par or workspace})
			wait()
			S:play()
			game:GetService("Debris"):AddItem(S, 6)
		end
		))
	end
	}
	, 
	ParticleEmitter = {Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)

		local fp = Create("ParticleEmitter")({Parent = Parent, Color = ColorSequence.new(Color1, Color2), LightEmission = LightEmission, Size = Size, Texture = Texture, Transparency = Transparency, ZOffset = ZOffset, Acceleration = Accel, Drag = Drag, LockedToPart = LockedToPart, VelocityInheritance = VelocityInheritance, EmissionDirection = EmissionDirection, Enabled = Enabled, Lifetime = LifeTime, Rate = Rate, Rotation = Rotation, RotSpeed = RotSpeed, Speed = Speed, VelocitySpread = VelocitySpread})
		return fp
	end
	}
}












--//=================================\\
--|| SAZERENOS ARTIFICIAL HEARTBEAT
--\\=================================//
Frame_Speed = 1 / 30
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

local hbcon = game:GetService("RunService").Heartbeat:connect(function(s, p)
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
game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()hbcon:Disconnect()end)
--//=================================\\
--\\=================================//

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

---------------
--[Functions]--
---------------
so = function(id, par, vol, pit)

	CFuncs.Sound.Create(id, par, vol, pit)


end

function weld(parent,part0,part1,c0)
	local weld=it("Weld") 
	weld.Parent=parent
	weld.Part0=part0 
	weld.Part1=part1 
	weld.C0=c0
	return weld
end

rayCast = function(Pos, Dir, Max, Ignore)

	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore)
end

function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
	local MoveStyle = Enum.EasingStyle[MoveStyle2]
	local outorin = Enum.EasingDirection[outorin2]


	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end

	if SPart.Name=="Bullet" then
		dahspeed=1	
	end

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

function GatherAllInstances(Parent,ig)
	local Instances = {}
	local Ignore=nil
	if	ig ~= nil then
		Ignore = ig	
	end

	local function GatherInstances(Parent,Ignore)
		for i, v in pairs(Parent:GetChildren()) do

			if v ~= Ignore then
				GatherInstances(v,Ignore)
				table.insert(Instances, v) end
		end
	end
	GatherInstances(Parent,Ignore)
	return Instances
end










function joint(parent,part0,part1,c0)
	local weld=it("Motor6D") 
	weld.Parent=parent
	weld.Part0=part0 
	weld.Part1=part1 
	weld.C0=c0
	return weld
end
ArmorParts = {}
--ArmorParts = {}
function WeldAllTo(Part1,Part2,scan,Extra)
	local EXCF = Part2.CFrame * Extra	
	for i, v3 in pairs(scan:GetDescendants()) do
		if v3:isA("BasePart") then	
			local STW=weld(v3,v3,Part1,EXCF:toObjectSpace(v3.CFrame):inverse() )
			v3.Anchored=false
			v3.Massless = true
			v3.CanCollide=false						
			v3.Parent = Part1			
			v3.Locked = true	
			if not v3:FindFirstChild("Destroy") then
				table.insert(ArmorParts,{Part = v3,Par = v3.Parent,Col = v3.Color,Mat=v3.Material.Name })	
			else
				v3:Destroy()	
			end				
		end
	end
	Part1.Transparency=1
	--Part2:Destroy()
end



function JointAllTo(Part1,Part2,scan,Extra)
	local EXCF = Part2.CFrame * Extra	
	for i, v3 in pairs(scan:GetDescendants()) do
		if v3:isA("BasePart") then	
			local STW=joint(v3,v3,Part1,EXCF:toObjectSpace(v3.CFrame):inverse() )
			v3.Anchored=false
			v3.Massless = true
			v3.CanCollide=false						
			v3.Parent = Part1			
			v3.Locked = true	
			if not v3:FindFirstChild("Destroy") then
				--	table.insert(ArmorParts,{Part = v3,Par = v3.Parent,Col = v3.Color,Mat=v3.Material.Name })	
			else
				v3:Destroy()	
			end				
		end
	end
	Part1.Transparency=1
	--Part2:Destroy()
end









local SToneTexture = Create("Texture")({


	Texture = "http://www.roblox.com/asset/?id=1693385655",
	Color3 = Color3.new(163/255, 162/255, 165/255),

})

function AddStoneTexture(part)
	coroutine.resume(coroutine.create(function()
		for i = 0,6,1 do
			local Tx = SToneTexture:Clone()
			Tx.Face = i
			Tx.Parent=part
		end
	end))
end

New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end



function Tran(Num)
	local GivenLeter = ""
	if Num == "1" then
		GivenLeter = "a"	
	elseif Num == "2" then
		GivenLeter = "b"
	elseif Num == "3" then
		GivenLeter = "c"
	elseif Num == "4" then
		GivenLeter = "d"
	elseif Num == "5" then
		GivenLeter = "e"
	elseif Num == "6" then
		GivenLeter = "f"
	elseif Num == "7" then
		GivenLeter = "g"
	elseif Num == "8" then
		GivenLeter = "h"
	elseif Num == "9" then
		GivenLeter = "i"
	elseif Num == "10" then
		GivenLeter = "j"
	elseif Num == "11" then
		GivenLeter = "k"
	elseif Num == "12" then
		GivenLeter = "l"
	elseif Num == "13" then
		GivenLeter = "m"
	elseif Num == "14" then
		GivenLeter = "n"
	elseif Num == "15" then
		GivenLeter = "o"
	elseif Num == "16" then
		GivenLeter = "p"
	elseif Num == "17" then
		GivenLeter = "q"
	elseif Num == "18" then
		GivenLeter = "r"
	elseif Num == "19" then
		GivenLeter = "s"
	elseif Num == "20" then
		GivenLeter = "t"
	elseif Num == "21" then
		GivenLeter = "u"
	elseif Num == "22" then
		GivenLeter = "v"
	elseif Num == "23" then
		GivenLeter = "w"
	elseif Num == "24" then
		GivenLeter = "x"
	elseif Num == "25" then
		GivenLeter = "y"
	elseif Num == "26" then
		GivenLeter = "z"
	elseif Num == "27" then
		GivenLeter = "_"
	elseif Num == "28" then
		GivenLeter = "0"
	elseif Num == "29" then
		GivenLeter = "1"
	elseif Num == "30" then
		GivenLeter = "2"	
	elseif Num == "31" then
		GivenLeter = "3"
	elseif Num == "32" then
		GivenLeter = "4"
	elseif Num == "33" then
		GivenLeter = "5"
	elseif Num == "34" then
		GivenLeter = "6"
	elseif Num == "35" then
		GivenLeter = "7"
	elseif Num == "36" then
		GivenLeter = "8"
	elseif Num == "37" then
		GivenLeter = "9"
	end
	return GivenLeter

end

function MaybeOk(Mode,Extra)
	local ReturningValue = ""
	if Mode == 1 then



		--	v.C0 = CFrame.new(1,1,1)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))

		--print(v.C0)
		local GivenText	= ""	
		local	msg = 	Extra
		local Txt = ""
		local FoundTime=0
		local LastFound = 0
		delay(wait(0),function()
			for v3 = 1, #msg do

				if string.sub(msg,0+v3,v3) == ","	then

					local TheN = string.sub(msg,LastFound,v3-1)


					local NumTranslate = Tran(string.sub(msg,LastFound,v3-1))



					FoundTime = FoundTime + 1


					GivenText = GivenText..NumTranslate

					LastFound=v3+1
					Txt=""
				end
				Txt=string.sub(msg,1,v3)		


				--    Gui.ExtentsOffset = Vector3.new(0,3,0)


				--  Gui.ExtentsOffset = Vector3.new(0,3,0)                    
				wait()
				-- Gui.ExtentsOffset = Vector3.new(0,3,0)   
			end;		

			ReturningValue=GivenText
			for v3 = 1, #Txt do
				Txt=string.sub(msg,-1,v3)







			end;
			--   Gui:remove()
		end)	


	elseif Mode == 2 then

		print("fat")
	end



	while ReturningValue == "" do wait() end
	return ReturningValue

end

function CreateMesh2(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
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

function CreatePart2(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
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

local S = IT("Sound")
function CreateSound2(ID, PARENT, VOLUME, PITCH, DOESLOOP)
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
		local EFFECT = CreatePart2(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound2(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Cylinder" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "Cylinder", "", "", SIZE, VT(0,0,0))	
		elseif TYPE == "Block" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)
		elseif TYPE == "Cube" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)	

		elseif TYPE == "Wave" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crown" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "173770780", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then

				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Quad","InOut",TIME/60)
			else

				SetTween(EFFECT,{CFrame = CFRAME},"Quad","InOut",0)

			end



			wait()

			SetTween(EFFECT,{Transparency = EFFECT.Transparency - TRANS},"Quad","InOut",TIME/60)

			if TYPE == "Block" then

				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Quad","InOut",0)
			else

				SetTween(EFFECT,{CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))},"Quad","InOut",0)

			end
			if MOVEDIRECTION ~= nil then
				local ORI = EFFECT.Orientation

				SetTween(EFFECT,{CFrame=CF(MOVEDIRECTION)},"Quad","InOut",TIME/60)
				SetTween(EFFECT,{Orientation=ORI},"Quad","InOut",TIME/60)


			end
			MSH.Scale = MSH.Scale - GROWTH/TIME
			SetTween(MSH,{Scale=ENDSIZE},"Quad","InOut",TIME/60)
			if TYPE == "Wave" then

				SetTween(MSH,{Offset=VT(0,0,-MSH.Scale.X/8)},"Quad","InOut",TIME/60)
			end
			for LOOP = 1, TIME+1 do
				wait(.05)

				--SetTween(EFFECT,{Transparency = EFFECT.Transparency - TRANS/TIME},"Quad","InOut",0)


				if TYPE == "Block" then

					--				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Quad","InOut",0)
				else

					--				SetTween(EFFECT,{CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))},"Quad","InOut",0)

				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation

					--					SetTween(EFFECT,{CFrame=CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)},"Quad","InOut",0)
					--						SetTween(EFFECT,{Orientation=ORI},"Quad","InOut",0)


				end
			end
			game:GetService("Debris"):AddItem(EFFECT, 15)
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
				repeat wait() until SOUND.Playing == false
				EFFECT:remove()
			end
		end
	end))
end	
----------------------
--[End Of Functions]--
----------------------






------------------
--[Gun]--
------------------












function CreatePart( Parent, Material, Reflectance, Transparency, BColor, Name, Size)
	local Part = Create("Part"){

		Parent = Parent,
		Reflectance = Reflectance,
		Transparency = Transparency,
		CanCollide = false,
		Locked = true,
		BrickColor = BrickColor.new(tostring(BColor)),
		Name = Name,
		Size = Size,
		Material = Material,
	}
	RemoveOutlines(Part)
	return Part
end

------------------
--[End of Gun]--
------------------

---------------
--[Particles]--
---------------


local Particle2_1 = Create("ParticleEmitter"){
	Color = ColorSequence.new(Color3.new (1,1,1),  Color3.new (170/255, 255/255, 255/255)),
	Transparency =  NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.75,.4),NumberSequenceKeypoint.new(1,1)}),
	Size = NumberSequence.new({NumberSequenceKeypoint.new(0,.5),NumberSequenceKeypoint.new(1,.0)}),
	Texture = "rbxassetid://241922778",
	Lifetime = NumberRange.new(0.55,0.95),
	Rate = 100,
	VelocitySpread = 180,
	Rotation = NumberRange.new(0),
	RotSpeed = NumberRange.new(-200,200),
	Speed = NumberRange.new(8.0),
	LightEmission = 1,
	LockedToPart = false,
	Acceleration = Vector3.new(0, 0, 0),
	EmissionDirection = "Top",
	Drag = 4,
	Enabled = false
}


local BEGONE_Particle = Create("ParticleEmitter"){
	Color = ColorSequence.new(Color3.new (1,1,1), Color3.new (1, 1, 1)),
	Transparency =  NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.1,0),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(0.5,.2),NumberSequenceKeypoint.new(1,1)}),
	Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.15,1.5),NumberSequenceKeypoint.new(.75,1.5),NumberSequenceKeypoint.new(1,0)}),
	Texture = "rbxassetid://936193661",
	Lifetime = NumberRange.new(1.5),
	Rate = 100,
	VelocitySpread = 0,
	Rotation = NumberRange.new(0),
	RotSpeed = NumberRange.new(-10,10),
	Speed = NumberRange.new(0),
	LightEmission = .25,
	LockedToPart = true,
	Acceleration = Vector3.new(0, -0, 0),
	EmissionDirection = "Top",
	Drag = 4,
	ZOffset = 1,
	Enabled = false
}


----------------------
--[End Of Particles]--
----------------------





-----------------



Damagefunc = function(Part, hit, minim, maxim, knockback, Type, Property, Delay, HitSound, HitPitch)

	if hit.Parent == nil then
		return 
	end
	local h = hit.Parent:FindFirstChildOfClass("Humanoid")
	for _,v in pairs(hit.Parent:children()) do
		if v:IsA("Humanoid") then
			if	h.Health > 0.0001 then
				h = v else   end
		end
	end

	if h == nil then
		return 
	elseif h ~= nil and h.Health < 0.001 then
		return 
	elseif  h ~= nil and h.Parent:FindFirstChild("Fly away") then
		return
	end


	--gg

	--local FoundTorso = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")	
	coroutine.resume(coroutine.create(function()	
		if h.Health >9999999 and minim <9999 and Type~= "IgnoreType" and(h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and not h.Parent:FindFirstChild("Fly away")then


			local FATag = Instance.new("Model",h.Parent)

			FATag.Name = "Fly away"
			game:GetService("Debris"):AddItem(FATag, 2.5)	


			for _,v in pairs(h.Parent:children()) do
				if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
					v.Anchored=true
				end
			end	

			wait(.25)

			if 	h.Parent:FindFirstChildOfClass("Body Colors")then
				h.Parent:FindFirstChildOfClass("Body Colors"):Destroy()
			end


			local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")

			coroutine.resume(coroutine.create(function()	


				local YourGone = Instance.new("Part")
				YourGone.Reflectance = 0
				YourGone.Transparency = 1
				YourGone.CanCollide = false
				YourGone.Locked = true
				YourGone.Anchored=true
				YourGone.BrickColor = BrickColor.new("Really blue")
				YourGone.Name = "YourGone"
				YourGone.Size = Vector3.new()
				YourGone.Material = "SmoothPlastic"
				YourGone:BreakJoints()
				YourGone.Parent = FoundTorso		
				YourGone.CFrame = FoundTorso.CFrame

				local NewParticle = Instance.new("ParticleEmitter")
				NewParticle.Parent = YourGone
				NewParticle.Acceleration =  Vector3.new(0,0,0)
				NewParticle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,10),NumberSequenceKeypoint.new(1,.0)})
				NewParticle.Color = ColorSequence.new(Color3.new (1,0,0), Color3.new (1, 0, 0))
				NewParticle.Lifetime = NumberRange.new(0.55,0.95)
				NewParticle.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.25,.0),NumberSequenceKeypoint.new(1,1)})
				NewParticle.Speed = NumberRange.new(0,0.0)
				NewParticle.ZOffset = 2
				NewParticle.Texture = "rbxassetid://243660364"
				NewParticle.RotSpeed = NumberRange.new(-0,0)
				NewParticle.Rotation = NumberRange.new(-180,180)
				NewParticle.Enabled = false
				game:GetService("Debris"):AddItem(YourGone, 3)	
				for i = 0,2,1 do
					NewParticle:Emit(1)
					so("1448044156", FoundTorso,2, 1)
					h.Parent:BreakJoints()
					YourGone.CFrame = FoundTorso.CFrame
					for _,v in pairs(h.Parent:children()) do
						if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
							v.Anchored=false
							--			v.Material = "Neon"
							--v.BrickColor = BrickColor.new("Really red")
							if v:FindFirstChildOfClass("SpecialMesh")then
								--v:Destroy()
							end	
							if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
								--	v:Destroy()
							end		
							local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

							vp.Parent = v		
							game:GetService("Debris"):AddItem(vp, math.random(50,100)/1000)				


						end



					end	



					wait(.2)	
				end
				wait(.1)	
				NewParticle:Emit(3)
				so("1448044156", FoundTorso,2, .8)
				h.Parent:BreakJoints()
				YourGone.CFrame = FoundTorso.CFrame
				for _,v in pairs(h.Parent:children()) do
					if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
						v.Anchored=false
						--			v.Material = "Neon"
						--v.BrickColor = BrickColor.new("Really red")
						if v:FindFirstChildOfClass("SpecialMesh")then
							--v:Destroy()
						end	
						if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
							--	v:Destroy()
						end		
						local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

						vp.Parent = v		
						game:GetService("Debris"):AddItem(vp, math.random(100,200)/1000)				


					end



				end	




			end))




			wait(.1)







		end


	end))
	if h ~= nil and hit.Parent ~= Character and hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso") ~= nil then
		if hit.Parent:findFirstChild("DebounceHit") ~= nil and hit.Parent.DebounceHit.Value == true then
			return 
		end
		local c = Create("ObjectValue")({Name = "creator", Value = game:service("Players").LocalPlayer, Parent = h})
		game:GetService("Debris"):AddItem(c, 0.5)
		if HitSound ~= nil and HitPitch ~= nil then
			so(HitSound, hit, 1, HitPitch)
		end
		local Damage = math.random(minim, maxim)
		local blocked = false
		local block = hit.Parent:findFirstChild("Block")
		if block ~= nil and block.className == "IntValue" and block.Value > 0 then
			blocked = true
			block.Value = block.Value - 1
			print(block.Value)
		end
		if blocked == false then
			--h.Health = h.Health - Damage
		else
			--h.Health = h.Health - Damage / 2

		end



			--[[local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
			local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit
			local bodvol = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(math.huge, 0, math.huge), velocity = CFrame.new(Part.Position,FoundTorso.Position).lookVector * knockback, Parent = hit})
			local rl = Create("BodyAngularVelocity")({P = 3000, maxTorque = Vector3.new(5000, 5000, 5000) * 5, angularvelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)), Parent = hit})
			game:GetService("Debris"):AddItem(bodvol, 2)
			game:GetService("Debris"):AddItem(rl, 0.125)]]



	elseif Type == "Knockdown2" then
		local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit

	elseif Type == "Normal" then
		local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
		local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit



	elseif Type== "Fire" 	then
		local HTorso = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")

		local tags = 0
		for _,v2 in next, HTorso:GetChildren() do 
			if v2:IsA("Folder") and v2.Name == "OnFire" then
				tags=tags+1
			end
		end	

		if tags < 2 then


			local tag = Instance.new("Folder",HTorso)
			tag.Name = "OnFire"					
			game:GetService("Debris"):AddItem(tag, 4.5) 
			for _,v in next, nil do if v:IsA("ParticleEmitter") or v:IsA("SpotLight")  then    game:GetService("Debris"):AddItem(v, 5) 	 v.Parent = HTorso
					coroutine.resume(coroutine.create(function()	
						for i = 1,35 do 
							coroutine.resume(coroutine.create(function()	
								v:Emit(2) end))
							coroutine.resume(coroutine.create(function()	
								Damagefunc(HTorso, HTorso, 4/2, 6/2, 0, "Normal", RootPart, 0.1, "1273118342", math.random(10,30)/10)
							end))
							if HTorso.Parent:FindFirstChildOfClass("Humanoid")  and HTorso.Parent:FindFirstChildOfClass("Humanoid").Health > .01 then
							else 	
								for _,v2 in next, HTorso.Parent:GetDescendants() do  
									if v2:isA("BasePart") then 
										--SetTween(v2,{Color=C3(0,0,0)},"Quad","Out",.5)
									end 
								end 
								break
							end
							wait(.1)
						end
					end))	

				end  end


		else-- print("Hit Max")		
		end			
	elseif Type== "Instakill" 	then
		coroutine.resume(coroutine.create(function()	
			if  (h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and not h.Parent:FindFirstChild("Fly away")then



				wait(.25)


				local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")

				coroutine.resume(coroutine.create(function()	


					local YourGone = Instance.new("Part")
					YourGone.Reflectance = 0
					YourGone.Transparency = 1
					YourGone.CanCollide = false
					YourGone.Locked = true
					YourGone.Anchored=true
					YourGone.BrickColor = BrickColor.new("Really blue")
					YourGone.Name = "YourGone"
					YourGone.Size = Vector3.new()
					YourGone.Material = "SmoothPlastic"
					YourGone:BreakJoints()
					YourGone.Parent = FoundTorso		
					YourGone.CFrame = FoundTorso.CFrame

					local NewParticle = Instance.new("ParticleEmitter")
					NewParticle.Parent = YourGone
					NewParticle.Acceleration =  Vector3.new(0,0,0)
					NewParticle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,10),NumberSequenceKeypoint.new(1,.0)})
					NewParticle.Color = ColorSequence.new(Color3.new (1,0,0), Color3.new (1, 0, 0))
					NewParticle.Lifetime = NumberRange.new(0.55,0.95)
					NewParticle.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.25,.0),NumberSequenceKeypoint.new(1,1)})
					NewParticle.Speed = NumberRange.new(0,0.0)
					NewParticle.ZOffset = 2
					NewParticle.Texture = "rbxassetid://243660364"
					NewParticle.RotSpeed = NumberRange.new(-0,0)
					NewParticle.Rotation = NumberRange.new(-180,180)
					NewParticle.Enabled = false
					game:GetService("Debris"):AddItem(YourGone, 3)	
					for i = 0,2,1 do
						NewParticle:Emit(1)
						so("1448044156", FoundTorso,2, 1)
						YourGone.CFrame = FoundTorso.CFrame
						for _,v in pairs(h.Parent:children()) do
							if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then			


							end



						end	



						wait(.2)	
					end
					wait(.1)	
					NewParticle:Emit(3)
					so("1448044156", FoundTorso,2, .8)
					YourGone.CFrame = FoundTorso.CFrame
					for _,v in pairs(h.Parent:children()) do
						if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
						end
					end	
				end))
				wait(.1)
			end
		end))
	elseif Type == "HPSteal" then


	elseif Type == "Impale" then









		wait(1)
	elseif Type == "IgnoreType" then





	elseif Type == "Up" then
	elseif Type == "Snare" then
	elseif Type == "Freeze2" then
	end
	local debounce = Create("BoolValue")({Name = "DebounceHit", Parent = hit.Parent, Value = true})
	game:GetService("Debris"):AddItem(debounce, Delay)
end



ShowDamage = function(Pos, Text, Time, Color)

	local Rate = 0.033333333333333
	if not Pos then
		local Pos = Vector3.new(0, 0, 0)
	end
	local Text = Text or ""
	local Time = Time or 2
	if not Color then
		local Color = Color3.new(1, 0.545098, 0.552941)
	end
	local EffectPart = CreatePart(workspace, "SmoothPlastic", 0, 1, BrickColor.new(Color), "Effect", Vector3.new(0, 0, 0))
	EffectPart.Anchored = true
	local BillboardGui = Create("BillboardGui")({Size = UDim2.new(2, 0, 2, 0), Adornee = EffectPart, Parent = EffectPart})
	local TextLabel = Create("TextLabel")({BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = ""..Text.."", TextColor3 = Color, TextScaled = true, Font = Enum.Font.SourceSansBold, Parent = BillboardGui})
	TextLabel.TextTransparency=1
	game.Debris:AddItem(EffectPart, Time + 0.1)
	EffectPart.Parent = game:GetService("Workspace")
	delay(0, function()

		local Frames = Time / Rate



		--print(Frames)

		EffectPart.CFrame=CFrame.new(Pos)
		wait()	TextLabel.TextTransparency=0
		SetTween(TextLabel,{TextTransparency=1},"Quad","In",Frames/60)
		SetTween(TextLabel,{Rotation=math.random(-25,25)},"Elastic","InOut",Frames/60)
		SetTween(TextLabel,{TextColor3=Color3.new(1,0,0)},"Elastic","InOut",Frames/60)

		SetTween(EffectPart,{CFrame = CFrame.new(Pos) + Vector3.new(math.random(-5,5), math.random(1,5), math.random(-5,5))},"Quad","InOut",Frames/60)


		wait(Frames/60)

		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end
	)
end

MagniDamage = function(Part, magni, mindam, maxdam, knock, Type2)




	local Type=""




	if  mememode == true then

		Type=	"Instakill"

	else
		Type=Type2
	end 
	if Type2 == "NormalKnockdown" then
		Type= "Knockdown"
	end

	for _,c in pairs(workspace:children()) do





		local hum = c:FindFirstChild("Humanoid")
		for _,v in pairs(c:children()) do
			if v:IsA("Humanoid") then
				hum = v
			end
		end	




		if hum ~= nil then
			local head = c:findFirstChild("Head")
			if head ~= nil then
				local targ = head.Position - Part.Position
				local mag = targ.magnitude
				if mag <= magni and c.Name ~= Player.Name then
					Damagefunc(Part, head, mindam, maxdam, knock, Type, RootPart, 0.1, "851453784", 1.2)
				end
			end
		end
	end
end


function CFMagniDamage(HTCF,magni, mindam, maxdam, knock, Type)
	local DGP = Instance.new("Part")

	DGP.Parent = Character
	DGP.Size = Vector3.new(0.05, 0.05, 0.05)
	DGP.Transparency = 1
	DGP.CanCollide = false
	DGP.Anchored = true
	RemoveOutlines(DGP)
	DGP.Position=DGP.Position + Vector3.new(0,-.1,0)
	DGP.CFrame = HTCF

	coroutine.resume(coroutine.create(function()
		MagniDamage(DGP, magni, mindam, maxdam, knock, Type)
	end))
	game:GetService("Debris"):AddItem(DGP, .05)


	DGP.Archivable = false
end



-----------------

function BulletHitEffectSpawn(EffectCF,EffectName)
	local MainEffectHolder=Instance.new("Part",Effects)	
	MainEffectHolder.Reflectance = 0
	MainEffectHolder.Transparency = 1
	MainEffectHolder.CanCollide = false
	MainEffectHolder.Locked = true
	MainEffectHolder.Anchored=true
	MainEffectHolder.BrickColor = BrickColor.new("Bright green")
	MainEffectHolder.Name = "Bullet"
	MainEffectHolder.Size = Vector3.new(.05,.05,.05)	
	MainEffectHolder.Material = "Neon"
	MainEffectHolder:BreakJoints()
	MainEffectHolder.CFrame = EffectCF
	local EffectAttach=Instance.new("Attachment",MainEffectHolder)	
	game:GetService("Debris"):AddItem(MainEffectHolder, 15)

	if EffectName == "Explode" then
		EffectAttach.Orientation = Vector3.new(90,0,0)





		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	






	if EffectName == "Spark" then

		EffectAttach.Orientation = Vector3.new(90,0,0)









		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	



	if EffectName == "ShockWave" then

		EffectAttach.Orientation = Vector3.new(90,0,0)








		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	




	if EffectName == "Nuke" then
		so(923073285,MainEffectHolder,8,2)
		EffectAttach.Orientation = Vector3.new(0,0,0)
		local EffectAttach2=Instance.new("Attachment",MainEffectHolder)	
		EffectAttach2.Orientation = Vector3.new(0,0,0)





		coroutine.resume(coroutine.create(function()

			for i = 0,2,.025/1.5 do


				Swait()		
			end

		end))



		game:GetService("Debris"):AddItem(EffectAttach, 10)				


	end	












end




--[[
		for i, v in pairs(C:GetChildren()) do
if v:IsA("Accessory")then
v:Destroy()	
end
if v:IsA("BasePart")then
v.Transparency =1
if v.Name == "Head" then
	v:FindFirstChildOfClass("Decal"):Destroy()
end
end
		end--]]
--[[













local tweeningInformation = TweenInfo.new(
	0.5,	
	Enum.EasingStyle.Back,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
--]]


local RJW=weld(RJ.Parent,RJ.Part0,RJ.Part1,RJ.C0)
RJW.C1 = RJ.C1
RJW.Name = RJ.Name

local NeckW=weld(Neck.Parent,Neck.Part0,Neck.Part1,Neck.C0)
NeckW.C1 = Neck.C1
NeckW.Name = Neck.Name


--print(WRJ.Parent.Name)

local RW=weld(Torso,Torso,RightArm,cf(0,0,0))

local LW=weld(Torso,Torso,LeftArm,cf(0,0,0))

local RH=weld(Torso,Torso,RightLeg,cf(0,0,0))

local LH=weld(Torso,Torso,LeftLeg,cf(0,0,0))



RW.C1 = cn(0, 0.5, 0)
LW.C1 = cn(0, 0.5, 0)
RH.C1 = cn(0, 1, 0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
LH.C1 = cn(0, 1, 0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))






--------
--(#Torso)
SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)},"Quad","InOut",0.1)
--------
--(#Head)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)},"Quad","InOut",0.1)
--------
--(#Right Arm)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)},"Quad","InOut",0.1)
--------
--(#Left Arm)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)},"Quad","InOut",0.1)
--------
--(#Right Leg)
SetTween(RH,{C0=CFrame.new(.5, -0.90, 0)},"Quad","InOut",0.1)
--------
--(#Left Leg)
SetTween(LH,{C0=CFrame.new(-.5, -0.90, 0)},"Quad","InOut",0.1)



--[[
SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
--]]


function AT1()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-40))},"Quad","InOut",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(40))},"Quad","InOut",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(30),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(30),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -.6, -.4)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(20),math.rad(0),math.rad(20))},"Quad","InOut",0.2)





	wait(.2/dahspeed)	

	--coroutine.resume(coroutine.create(function()	
	--	so("1428541279", RightArm,1.6, math.random(120,220)/100)


	CFMagniDamage(RootPart.CFrame*CF(0,-1,-1),7,10,20,20,"Normal")
	--end))

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,0)*angles(math.rad(-40),math.rad(0),math.rad(40))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-40))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-30),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-30),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(120),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-60),math.rad(0),math.rad(-20))},"Back","Out",0.2)





	wait(.2/dahspeed)	


	attack = false	
end




function AT2()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(60))},"Quad","InOut",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-60))},"Quad","InOut",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.4)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)

	CFMagniDamage(RootPart.CFrame*CF(0,-0,-1),9,10,15,0,"Normal")

	wait(.2/dahspeed)	

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,0)*angles(math.rad(0),math.rad(0),math.rad(-70))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(70))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(-20),math.rad(-90))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",0.2)


	wait(.2/dahspeed)	
	attack = false		
end

function AT3()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(120))},"Quad","In",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-80))},"Quad","InOut",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(90),math.rad(0),math.rad(20))},"Quad","InOut",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(20),math.rad(-0),math.rad(-0))},"Quad","InOut",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -.8, 0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)

	wait(.2/dahspeed)	
	CFMagniDamage(RootPart.CFrame*CF(-2,-.25,-1),9,20,30,10,"Knockdown")

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,0)*angles(math.rad(20),math.rad(0),math.rad(-0))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(90))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(20),math.rad(-0),math.rad(-0))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(-40),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	wait(.2/dahspeed)
	attack = false		
end



function AT4()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(-80))},"Quad","InOut",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(80))},"Quad","InOut",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-20),math.rad(-70),math.rad(-90))},"Quad","InOut",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -.0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -.5, -0.4)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)

	CFMagniDamage(RootPart.CFrame*CF(0,-0,-1),9,30,45,0,"Normal")
	so("3051417237", LeftArm,3, math.random(100,155)/100)
	wait(0.2/dahspeed)	

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,0)*angles(math.rad(20),math.rad(0),math.rad(45))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(-45))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(-0),math.rad(-90))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Back","Out",0.2)


	wait(.2/dahspeed)	
	attack = false		
end





function AT5()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(80))},"Quad","InOut",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-80))},"Quad","InOut",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-20),math.rad(70),math.rad(90))},"Quad","InOut",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-90))},"Quad","InOut",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -0.4)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, -0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.2)

	CFMagniDamage(RootPart.CFrame*CF(0,-0,-1),9,30,45,0,"Normal")
	so("3051417237", RightArm,3, math.random(100,155)/80)
	wait(0.2/dahspeed)	

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,0)*angles(math.rad(20),math.rad(0),math.rad(-45))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(45))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(90))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(-0),math.rad(0))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Back","Out",0.2)


	wait(.2/dahspeed)	
	attack = false		
end




function AT6()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed


	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1,-.3)*angles(math.rad(45),math.rad(0),math.rad(0))},"Quad","Out",0.3)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","Out",0.3)
	SetTween(RW,{C0=CFrame.new(1.1 , 0.5, -.3)*angles(math.rad(20),math.rad(115),math.rad(90))},"Quad","In",0.15)
	SetTween(LW,{C0=CFrame.new(-1.1, 0.5, -.3)*angles(math.rad(20),math.rad(-115),math.rad(-90))},"Quad","In",0.15)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(-60),math.rad(0),math.rad(0))},"Quad","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(60),math.rad(0),math.rad(0))},"Quad","Out",0.3)

	so("3051417237", Torso,3,  math.random(140,185)/80)
	CFMagniDamage(RootPart.CFrame*CF(-1.4,-0,-1),9,40,55,10,"Knockdown")
	CFMagniDamage(RootPart.CFrame*CF(1.4,-0,-1),9,40,55,10,"Knockdown")

	wait(0.175/dahspeed)	

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1.7,-.4)*angles(math.rad(45),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(90))},"Back","Out",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-90))},"Back","Out",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(65),math.rad(0),math.rad(0))},"Back","Out",0.2)



	wait(.2/dahspeed)	
	attack = false		
end


function AT7()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=5
	end --/dahspeed
	so("3051417237", Torso,3, .8)

	coroutine.resume(coroutine.create(function()	
		for i = 1,2 do Swait(3)
			so("3051417087", RightArm,3, math.random(100,155)/100) end
	end))
	for i =1,10,1 do 
		SetTween(RJW,{C0=RootCF*CFrame.new(0,-1.7+.17*i,-.4)*angles(math.rad(25-5*i),math.rad(0),math.rad(36*i))},"Quad","Out",0.1)
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.2)
		SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(180),math.rad(0),math.rad(90))},"Quad","Out",0.2)
		SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-90))},"Quad","Out",0.2)
		SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(-25),math.rad(0),math.rad(0))},"Quad","Out",0.2)
		SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(25),math.rad(0),math.rad(0))},"Quad","Out",0.2)
		CFMagniDamage(RootPart.CFrame*CF(1.4,-0,-1+.17*i),9,10,15,10,"Knockdown")
		Swait()
	end



	attack = false		
end
--[[
how to make an cat fly


	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-20))},"Quad","InOut",0.1)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(20))},"Quad","InOut",0.1)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.25)*angles(math.rad(0),math.rad(0),math.rad(40))},"Quad","Out",0.1)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
Swait(.1*30)
for i = 1,100,0.3 do	
	SetTween(RJW,{C0=RootCF*CFrame.new(-20.5*math.sin(i),20.5*math.cos(i),i/.5)*angles(math.rad(25-4.5*10*i),math.rad(0),math.rad(36*i*2))},"Quad","InOut",0.1)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-80))},"Quad","InOut",0.15)
SetTween(RW,{C0=CFrame.new(1.5 , 0.65, -.0)*angles(math.rad(160+2*i),math.rad(0),math.rad(30-3*i))},"Quad","Out",0.15)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.15)
SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0+6.5*i),math.rad(0),math.rad(0))},"Quad","InOut",0.15)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0-6.5*i),math.rad(0),math.rad(0))},"Quad","InOut",0.15)
Swait() end	

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,20)*angles(math.rad(-20),math.rad(0),math.rad(-20))},"Quad","InOut",0.1)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(20))},"Quad","InOut",0.1)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
Swait(1.1*30)


]]--


















function Attack1()
	attack = true

	Humanoid.JumpPower = 0	
	Humanoid.WalkSpeed=0.1	
	so("299058146", RightArm,2,2.5)
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-20))},"Back","Out",0.6)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(20))},"Back","Out",0.6)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-10),math.rad(0),math.rad(20))},"Back","Out",0.6)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-20))},"Back","Out",0.6)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",0.6)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Back","Out",0.6)
	Swait(.2*30)

	coroutine.resume(coroutine.create(function()
		local EffectAttach=Instance.new("Attachment",RightArm)				
		EffectAttach.Orientation = Vector3.new(0,0,0)
		EffectAttach.Position =  Vector3.new(0,-1,0)

		game:GetService("Debris"):AddItem(EffectAttach, 2)				
	end))



	local TheGunHandle = Instance.new("Part")
	TheGunHandle.Reflectance = 0
	TheGunHandle.Transparency = 1
	TheGunHandle.CanCollide = false
	TheGunHandle.Locked = true
	TheGunHandle.Anchored=false
	TheGunHandle.BrickColor = BrickColor.new("Really blue")
	TheGunHandle.Name = "BHandle"
	TheGunHandle.Size = Vector3.new(2.5,1,2.5)
	TheGunHandle.Material = "SmoothPlastic"
	TheGunHandle:BreakJoints()
	TheGunHandle.Parent = Effects		
	TheGunHandle.CFrame = RootPart.CFrame	
	TheGunHandle.Massless = false

	local SWeld=weld(TheGunHandle,RootPart,TheGunHandle,cf(0,0,-3)*angles(math.rad(0),math.rad(0),math.rad(0)))
	local IsHit = false
	local function onTouch(HitPa)
		if IsHit == false then
			local c = HitPa.Parent
			local h = HitPa.Parent:FindFirstChild("Humanoid")
			for _,v in pairs(HitPa.Parent:children()) do
				if v:IsA("Humanoid") then

					h = v end

			end 
			local head = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
			local realhead = c:FindFirstChild("Head")
			if h ~= nil and head ~= nil and realhead ~= nil then

				IsHit = true
				--head.Anchored=true
				coroutine.resume(coroutine.create(function()
					TheGunHandle:Destroy()
				end))
				----------------------------------------------------------------------------------------------------------------------------------	

				local TheFlyHandle = Instance.new("Part")
				TheFlyHandle.Reflectance = 0
				TheFlyHandle.Transparency = 1
				TheFlyHandle.CanCollide = false
				TheFlyHandle.Locked = true
				TheFlyHandle.Anchored=true
				TheFlyHandle.BrickColor = BrickColor.new("Really blue")
				TheFlyHandle.Name = "FHandle"
				TheFlyHandle.Size = Vector3.new(1,1,1)
				TheFlyHandle.Material = "SmoothPlastic"
				TheFlyHandle:BreakJoints()
				TheFlyHandle.Parent = Effects		
				TheFlyHandle.CFrame = RootPart.CFrame	
				TheFlyHandle.Massless = false

				local thejoint =joint(TheFlyHandle,RootPart,TheFlyHandle,cf())


				local risingnum=(25-4.5*1)



				local EffectAttach=Instance.new("Attachment",RightArm)				
				EffectAttach.Orientation = Vector3.new(0,0,0)
				EffectAttach.Position =  Vector3.new(0,-1,0)

				game:GetService("Debris"):AddItem(EffectAttach, 5)				


				so("231917750", Torso,2,0.9)
				for i = 1,10,0.4 do	
					SetTween(RJW,{C0=RootCF*CFrame.new(-0.5*math.sin(i),0.5*math.cos(i),0)*angles(math.rad(25-4.5*i),math.rad(0),math.rad(36*i*2))},"Quad","InOut",0.05)
					SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(-80))},"Quad","InOut",0.15)
					SetTween(RW,{C0=CFrame.new(1.5 , 0.65, -.0)*angles(math.rad(160+2*i),math.rad(0),math.rad(30-3*i))},"Quad","Out",0.15)
					SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.15)
					SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0+6.5*i),math.rad(0),math.rad(0))},"Quad","InOut",0.15)
					SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0-6.5*i),math.rad(0),math.rad(0))},"Quad","InOut",0.15)

					--SetTween(head,{CFrame=RootPart.CFrame*CF(0,  0,-1)*angles(math.rad(math.random(-180,180)),math.rad(math.random(-180,180)),math.rad(math.random(-180,180)))},"Quad","InOut",0.05)	



					SetTween(thejoint,{C0=CFrame.new(0,-i*2,i/2)},"Quad","InOut",0.05)

					risingnum = risingnum+75
					if risingnum > 180 then risingnum = -180 print(1) end
					if risingnum > -45 and  risingnum < 45 then
						BulletHitEffectSpawn(head.CFrame,"ShockWave")
						so("471882019", head,3,2.5)
					end
					Swait()



				end	

				coroutine.resume(coroutine.create(function()
					local EffectAttach=Instance.new("Attachment",RightArm)				
					EffectAttach.Orientation = Vector3.new(0,0,0)
					EffectAttach.Position =  Vector3.new(0,-1,0)


					game:GetService("Debris"):AddItem(EffectAttach, 2)				
				end))
				coroutine.resume(coroutine.create(function()
					local EffectAttach=Instance.new("Attachment",LeftArm)				
					EffectAttach.Orientation = Vector3.new(0,0,0)
					EffectAttach.Position =  Vector3.new(0,-1,0)

					game:GetService("Debris"):AddItem(EffectAttach, 2)				
				end))
				so("782353117", Torso,2,0.9)
				so("588738949", RightArm,3,math.random(90,110)/100)
				so("588738949", LeftArm,3,math.random(90,110)/100)
				SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-65),math.rad(0),math.rad(-0))},"Back","Out",0.3)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(65),math.rad(0),math.rad(0))},"Back","Out",0.3)
				SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(90),math.rad(0),math.rad(90))},"Back","Out",0.3)
				SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(90),math.rad(0),math.rad(-90))},"Back","Out",0.3)
				SetTween(RH,{C0=CFrame.new(.5, -.7, -.2)*angles(math.rad(-40),math.rad(0),math.rad(0))},"Back","Out",0.3)
				SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-30),math.rad(0),math.rad(0))},"Back","Out",0.3)

				SetTween(thejoint,{C0=CFrame.new(0,-30,5)},"Back","Out",0.6)

				for i = 1,3 do 
					--SetTween(head,{CFrame=RootPart.CFrame*CF(0,  0,-6)*angles(mr(0),mr(180),mr(0))},"Quad","Out",0.1)	

					Swait(0.1*30)
				end






				for i = 1,2.5,.225 do	
					SetTween(RJW,{C0=RootCF*CFrame.new(0,2+(-0.75*i),20-1.8*i)*angles(math.rad(15+30*i*2),math.rad(0),math.rad(-0))},"Quad","Out",0.2)
					SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-25),math.rad(0),math.rad(0))},"Quad","Out",0.3)
					SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(170),math.rad(0),math.rad(90-(90/2.0)*i))},"Quad","Out",0.2)
					SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(170),math.rad(0),math.rad(-90+(90/2.0)*i))},"Quad","Out",0.2)
					SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(40),math.rad(0),math.rad(0))},"Quad","Out",0.3)
					SetTween(LH,{C0=CFrame.new(-.5, -1, -0)*angles(math.rad(40),math.rad(0),math.rad(0))},"Quad","Out",0.3)
					Swait()

					SetTween(thejoint,{C0=CFrame.new(0,-(20-1.8*i),13-1.2*i)},"Quad","Out",0.2)

				end
				so("231917750", Torso,5,0.9)
				local EffectAttach2=Instance.new("Attachment",Torso)				
				EffectAttach2.Orientation = Vector3.new(0,0,0)
				EffectAttach2.Position =  Vector3.new(0,0,0)

				game:GetService("Debris"):AddItem(EffectAttach2, 7)				




				coroutine.resume(coroutine.create(function()	
					local parsave = c.Parent
					c.Parent = Effects
					local  hitground,hitgp,dir = rayCast(Torso.Position, CFrame.new(Torso.Position,(RootPart.CFrame*CF(0,  -4,-10)).p).lookVector, 54, Character)
					c.Parent = parsave
					SetTween(head,{CFrame=cf(hitgp-VT(0,0,0),Torso.Position)*angles(mr(0),mr(180),mr(-45))},"Quad","In",0.3) Swait(.3*30)	so("231917744", head,4,1.25) BulletHitEffectSpawn(CF(hitgp,hitgp+dir),"Explode") end))	
				coroutine.resume(coroutine.create(function()	
					Swait(0.3*30)
					--[[]]
				end))				

				SetTween(thejoint,{C0=CFrame.new(0,0,27)},"Quad","In",0.3)
				SetTween(RJW,{C0=RootCF*CFrame.new(0,-0,-.5)*angles(math.rad(85),math.rad(0),math.rad(-0))},"Quad","Out",0.2)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-65),math.rad(0),math.rad(0))},"Back","Out",0.2)
				SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(130),math.rad(0),math.rad(0))},"Back","Out",0.2)
				SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(130),math.rad(0),math.rad(-0))},"Back","Out",0.2)
				SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(-25),math.rad(0),math.rad(0))},"Back","Out",0.2)
				SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-25),math.rad(0),math.rad(0))},"Back","Out",0.2)
				Swait(0.3*30)

				SetTween(RJW,{C0=RootCF*CFrame.new(0,-0,0)*angles(math.rad(-0),math.rad(0),math.rad(-0))},"Quad","Out",0.25)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(35),math.rad(0),math.rad(0))},"Back","Out",0.25)
				SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(30),math.rad(0),math.rad(30))},"Back","Out",0.25)
				SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(30),math.rad(0),math.rad(-30))},"Back","Out",0.25)
				SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(10),math.rad(0),math.rad(0))},"Back","Out",0.25)
				SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Back","Out",0.25)
				Swait(0.25*30)
				TheFlyHandle:Destroy()		


				attack = false	
				----------------------------------------------------------------------------------------------------------------------------------







			end

		end	
	end		
	local combothingy = TheGunHandle.Touched:connect(onTouch)	
	Swait(.5*30)
	if TheGunHandle.Parent == Effects then	
		combothingy:disconnect()
		TheGunHandle:Destroy()
		attack = false
	end
	while true do Swait()

		if attack == false then 
			break
		end	

	end	
	print("aaaaaaaaaaaaaaaaaa")
	combothingy:disconnect()	
	Humanoid.JumpPower = 60	
	Humanoid.WalkSpeed=16	




end

function Attack6()

	for i, v in pairs(GatherAllInstances(Effects)) do
		if v.Name == "Zombie" then
			v.Parent:Destroy()
		end
	end
end

local NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance,parent)
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

function chatfunc(text)
	coroutine.wrap(function()
		if(Character:FindFirstChild'ChatGUI')then Character.ChatGUI:destroy() end
		local BBG = NewInstance("BillboardGui",Character,{Name='ChatGUI',Size=UDim2.new(0,100,0,40),StudsOffset=Vector3.new(0,2.753,0),Adornee=Head})
		local Txt = NewInstance("TextLabel",BBG,{Text = "",BackgroundTransparency=1,TextColor3=MAINRUINCOLOR.Color,TextStrokeColor3=Color3.new(0,0,0),BorderSizePixel=0,Font=Enum.Font.SourceSansBold,TextSize=28,TextStrokeTransparency=0,Size=UDim2.new(1,0,.5,0)})
		coroutine.resume(coroutine.create(function()
			repeat Swait()
				--lol
			until Txt.Transparency > 1
		end))
		for i = 1, #text do
			delay(i/25, function()
				so("131238032", Head,5, math.random(20,32)/35)
				Txt.Text = text:sub(1,i)
			end)
		end
		delay((#text/25)+2.6, function()
			wait(0.2)
			for i = 1, 15 do
				Swait()
				Txt.TextTransparency = Txt.TextTransparency + 1/15
				Txt.TextStrokeTransparency = Txt.TextStrokeTransparency + 1/15
			end
		end)
		delay((#text/25)+3, function()
			BBG:destroy()
		end)
	end)()
end

function ClickCombo()
	if Anim == "Fall" or Anim == "Jump" then
		if Combo == 0 then		
			--DownAT()	
		end
	else
		if agresive == false then				
			if Combo == 0 then
				AT1()	
				Combo = 1
			elseif Combo == 1 then
				AT2()	
				Combo = 2	
			elseif Combo == 2 then
				AT3()
				Combo = 0	
			elseif Combo == 3 then
				Combo = 0	
				ClickCombo()	
			end

		else
			if Combo == 0 then
				AT4()	
				Combo = 1
			elseif Combo == 1 then
				AT5()	
				Combo = 2	
			elseif Combo == 2 then
				AT6()
				Combo = 3	
			elseif Combo == 3 then
				AT7()
				Combo = 0	
			end

		end
	end
end
chatfunc("Neko V6 :3")

function onChatted(msg)
	chatfunc(msg)
end

Player.Chatted:connect(onChatted)

local Hold = false


Button1DownF=function()

	Hold= true
	while Hold == true do
		if attack == false then
			ClickCombo()
		else

		end Swait()
	end








end





Button1UpF=function()

	if Hold==true then

		Hold = false

	end	

end



KeyUpF=function(key)



end

KeyDownF=function(key)
	key = key:lower()
	if  key == "f"   and attack == false then
		--Attack1()
		if agresive == false then 
			agresive= true
			so("3051417649", RightArm,1.5, .8)
			so("3051417649", LeftArm,1.5, .8)
			so("418252437", Head,5, math.random(20,32)/35)
			chatfunc("Claws: ON")
		else
			agresive= false
			so("3051417791", RightArm,1.5, .8)
			so("3051417791", LeftArm,1.5, .8)
			chatfunc("Claws: OFF")
		end

	end
	
	if  key == "y"   and attack == false and agresive == false then
		attack = true
		RootPart.Anchored = true

		SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)*CFrame.new(0,0,-0.1)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.3)
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-10),math.rad(-5),math.rad(0))},"Back","Out",0.3)
		SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(math.rad(-6),0,math.rad(10))},"Quad","InOut",0.3)
		SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(math.rad(20),0,math.rad(5))},"Quad","InOut",0.3)
		SetTween(LW,{C0=CFrame.new(-1.1, 0.3, -.0)*angles(-0.4,0,math.rad(40))},"Quad","InOut",0.3)
		Swait()	


		for i = 0.1,2,1 do 



			SetTween(RW,{C0=CFrame.new(1.3 , 0.5, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 80 )),math.rad(60-25* math.cos(sine / 80 )))},"Linear","Out",.2)
			wait(0.2)

			SetTween(RW,{C0=CFrame.new(1.3 , 0.5, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 80 )),math.rad(60+25* math.cos(sine / 80 )))},"Linear","Out",.2)
			wait(0.2)

			SetTween(RW,{C0=CFrame.new(1.3 , 0.5, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 80 )),math.rad(60+25* math.cos(sine / 80 )))},"Linear","Out",.2)
			wait(0.2)

			SetTween(RW,{C0=CFrame.new(1.3 , 0.5, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 80 )),math.rad(60-25* math.cos(sine / 80 )))},"Linear","Out",.2)
			wait(0.2)

		end
		attack = false
		RootPart.Anchored = false
	end
	
	if  key == "l"   and attack == false then

		attack = true 
		local laying = true----RELAJARSE
		while laying == true do

			SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, -6.3)*CFrame.new(0,0,-2.5)*angles(math.rad(85),math.rad(0),math.rad(-180))},"Quad","InOut",0.15)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(50),math.rad(0),math.rad(0))},"Back","Out",0.15)
			SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(math.rad(5),0,math.rad(-15))},"Quad","InOut",0.15)
			SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(math.rad(5),0,math.rad(15))},"Quad","InOut",0.15)
			SetTween(LW,{C0=CFrame.new(-1.3, 1.3, -0)*angles(math.rad(-190),0,math.rad(40))},"Quad","InOut",0.15)
			SetTween(RW,{C0=CFrame.new(1.3, 1.3, -0)*angles(math.rad(-190),0,math.rad(-40))},"Quad","InOut",0.15)	


			Swait()
			if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
				laying = false	
			end

		end
		attack = false
	end
	         
	if  key == "q"   and attack == false and agresive == false then
		attack = true
		RootPart.Anchored = true

		SetTween(LW,{C0=CFrame.new(-1.3, 0.4, -0)*angles(-30,0,math.rad(40))},"Quad","InOut",0.3)
		SetTween(RW,{C0=CFrame.new(1.3, 0.4, -.0)*angles(-30,0,math.rad(-40))},"Quad","InOut",0.3)
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(30))},"Back","Out",0.5)
		Swait()	
		wait(0.4)

		for i = 0.1,2,1 do 
			wait(0.4)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(-30))},"Back","Out",0.5)
			SetTween(LW,{C0=CFrame.new(-1.3, 0.4, -.0)*angles(-30,0,math.rad(1))},"Quad","InOut",0.3)
			SetTween(RW,{C0=CFrame.new(1.3, 0.4, -.0)*angles(-30,0,math.rad(-1))},"Quad","InOut",0.3)
			wait(0.4)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(30))},"Back","Out",0.5)
			SetTween(LW,{C0=CFrame.new(-1.3, 0.4, -.0)*angles(-30,0,math.rad(40))},"Quad","InOut",0.3)
			SetTween(RW,{C0=CFrame.new(1.3, 0.4, -.0)*angles(-30,0,math.rad(-40))},"Quad","InOut",0.3)
			wait(0.4)
		end
		attack = false
		RootPart.Anchored = false
	end
	if  key == "e"   and attack == false and agresive == false then
		attack = true
		RootPart.Anchored = true
		SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)*CFrame.new(0,0,-0.1)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.3)
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(5),math.rad(0),math.rad(0))},"Back","Out",0.3)
		SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(math.rad(-6),0,math.rad(10))},"Quad","InOut",0.3)
		SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(math.rad(20),0,math.rad(5))},"Quad","InOut",0.3)
		SetTween(LW,{C0=CFrame.new(-1.1, 0.3, -.0)*angles(-0.4,0,math.rad(40))},"Quad","InOut",0.3)
		Swait()	
		wait(0.4)

		for i = 0.1,2,1 do 
			wait(0.4)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Back","Out",0.5)

			wait(0.4)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(5),math.rad(0),math.rad(0))},"Back","Out",0.5)

			wait(0.4)
		end
		attack = false
		RootPart.Anchored = false
	end

	if  key == "u" and attack == false then
		attack = true
		while attack == true do
			SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)*CFrame.new(0,0,-2)*angles(math.rad(85),math.rad(0),math.rad(-90))},"Quad","InOut",0.3)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(40),math.rad(0),math.rad(0))},"Back","Out",0.3)
			SetTween(LH,{C0=CFrame.new(-.6, -.95+.05,0)*angles(math.rad(30),0,math.rad(-6))},"Quad","InOut",0.3)
			SetTween(RH,{C0=CFrame.new(.6, -.95+.05,0)*angles(math.rad(40),0,math.rad(-25))},"Quad","InOut",0.3)
			SetTween(LW,{C0=CFrame.new(-1, 1.3, -0.2)*angles(math.rad(160),0,math.rad(10))},"Quad","InOut",0.3)
			SetTween(RW,{C0=CFrame.new(0.5, 0.1, -0.7)*angles(math.rad(90),0,math.rad(-66))},"Quad","InOut",0.3)

			Swait()
			if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
				attack = false
			end
		end
	end
	
	if key == "c" and pant == false and attack == false and pantdown == false then
		attack = true
		RootPart.Anchored = true
		pant = true
		pantdown = true
		for i = 0,0.3,0.1 do
			SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)},"Quad","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(0,0,math.rad(-5))},"Quad","InOut",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(0,0,math.rad(5))},"Quad","InOut",0.1)
			SetTween(LW,{C0=CFrame.new(-1.5, 0.4, -.0)*angles(0,0,math.rad(10))},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.5, 0.4, -.0)*angles(0,0,math.rad(-10))},"Quad","InOut",0.1)
			Swait()
		end
		for i = 0,0.3,0.1 do
			SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)*CFrame.new(0,0,-0.1)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(math.rad(20),0,math.rad(-5))},"Quad","InOut",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(math.rad(20),0,math.rad(5))},"Quad","InOut",0.1)
			SetTween(LW,{C0=CFrame.new(-1.5, 0.4, -.0)*angles(0,0,math.rad(10))},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.5, 0.4, -.0)*angles(0,0,math.rad(-10))},"Quad","InOut",0.1)
			Swait()
		end
		local first = true
		for i = 0,0.6,0.1 do
			SetTween(RJW,{C0=CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)*CFrame.new(0,0,-0.3)*angles(math.rad(40),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -.95+.05,0)*angles(math.rad(40),0,math.rad(-5))},"Quad","InOut",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -.95+.05,0)*angles(math.rad(40),0,math.rad(5))},"Quad","InOut",0.1)
			SetTween(LW,{C0=CFrame.new(-1.5, 0.4, 0.2)*angles(math.rad(30),0,math.rad(10))},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.5, 0.4, 0.2)*angles(math.rad(30),0,math.rad(-10))},"Quad","InOut",0.1)
			if first == true then
				first = false
			end
			Swait()
		end
		for i = 0,1,0.1 do
			SetTween(LW,{C0=CFrame.new(-1.5, 0, 0)*angles(math.rad(30),0,math.rad(10))},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.5, 0, 0)*angles(math.rad(30),0,math.rad(-10))},"Quad","InOut",0.1)
			Swait()
		end
		local ParticleEmitter0 = Instance.new("ParticleEmitter")
		ParticleEmitter0.Parent = LeftLeg
		ParticleEmitter0.Speed = NumberRange.new(0.5, 0.5)
		ParticleEmitter0.Rotation = NumberRange.new(0, 360)
		ParticleEmitter0.Enabled = true
		ParticleEmitter0.Texture = "rbxassetid://244221440"
		ParticleEmitter0.Transparency = NumberSequence.new(0.89999997615814,0.89999997615814)
		ParticleEmitter0.ZOffset = 5
		ParticleEmitter0.Acceleration = Vector3.new(0, 1, 0)
		ParticleEmitter0.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
		ParticleEmitter0.Rate = 20000
		ParticleEmitter0.RotSpeed = NumberRange.new(-30, 30)
		ParticleEmitter0.SpreadAngle = Vector2.new(360, 360)
		ParticleEmitter0.VelocitySpread = 360
		local ParticleEmitter1 = Instance.new("ParticleEmitter")
		ParticleEmitter1.Parent = RightLeg
		ParticleEmitter1.Speed = NumberRange.new(0.5, 0.5)
		ParticleEmitter1.Rotation = NumberRange.new(0, 360)
		ParticleEmitter1.Enabled = true
		ParticleEmitter1.Texture = "rbxassetid://244221440"
		ParticleEmitter1.Transparency = NumberSequence.new(0.89999997615814,0.89999997615814)
		ParticleEmitter1.ZOffset = 5
		ParticleEmitter1.Acceleration = Vector3.new(0, 1, 0)
		ParticleEmitter1.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
		ParticleEmitter1.Rate = 20000
		ParticleEmitter1.RotSpeed = NumberRange.new(-30, 30)
		ParticleEmitter1.SpreadAngle = Vector2.new(360, 360)
		ParticleEmitter1.VelocitySpread = 360
		RootPart.Anchored = false
		attack = false
		pant = false
		wait(0.2)
		ParticleEmitter0.Enabled = false
		ParticleEmitter1.Enabled = false
	elseif key == "c" and attack == false and pantdown == true then
		pant = true
		pantdown = false
		local ParticleEmitter0 = Instance.new("ParticleEmitter")
		ParticleEmitter0.Parent = LeftLeg
		ParticleEmitter0.Speed = NumberRange.new(0.5, 0.5)
		ParticleEmitter0.Rotation = NumberRange.new(0, 360)
		ParticleEmitter0.Enabled = true
		ParticleEmitter0.Texture = "rbxassetid://244221440"
		ParticleEmitter0.Transparency = NumberSequence.new(0.89999997615814,0.89999997615814)
		ParticleEmitter0.ZOffset = 5
		ParticleEmitter0.Acceleration = Vector3.new(0, 1, 0)
		ParticleEmitter0.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
		ParticleEmitter0.Rate = 20000
		ParticleEmitter0.RotSpeed = NumberRange.new(-30, 30)
		ParticleEmitter0.SpreadAngle = Vector2.new(360, 360)
		ParticleEmitter0.VelocitySpread = 360
		local ParticleEmitter1 = Instance.new("ParticleEmitter")
		ParticleEmitter1.Parent = RightLeg
		ParticleEmitter1.Speed = NumberRange.new(0.5, 0.5)
		ParticleEmitter1.Rotation = NumberRange.new(0, 360)
		ParticleEmitter1.Enabled = true
		ParticleEmitter1.Texture = "rbxassetid://244221440"
		ParticleEmitter1.Transparency = NumberSequence.new(0.89999997615814,0.89999997615814)
		ParticleEmitter1.ZOffset = 5
		ParticleEmitter1.Acceleration = Vector3.new(0, 1, 0)
		ParticleEmitter1.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
		ParticleEmitter1.Rate = 20000
		ParticleEmitter1.RotSpeed = NumberRange.new(-30, 30)
		ParticleEmitter1.SpreadAngle = Vector2.new(360, 360)
		ParticleEmitter1.VelocitySpread = 360
		for i,v in pairs(Player.Character:GetChildren()) do
			if v.Name == "pantdownl" or v.Name == "pantdownr" then
				local ParticleEmitter3 = Instance.new("ParticleEmitter")
				ParticleEmitter3.Parent = v
				ParticleEmitter3.Speed = NumberRange.new(0.5, 0.5)
				ParticleEmitter3.Rotation = NumberRange.new(0, 360)
				ParticleEmitter3.Enabled = true
				ParticleEmitter3.Texture = "rbxassetid://244221440"
				ParticleEmitter3.Transparency = NumberSequence.new(0.89999997615814,0.89999997615814)
				ParticleEmitter3.ZOffset = 5
				ParticleEmitter3.Acceleration = Vector3.new(0, 1, 0)
				ParticleEmitter3.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
				ParticleEmitter3.Rate = 20000
				ParticleEmitter3.RotSpeed = NumberRange.new(-30, 30)
				ParticleEmitter3.SpreadAngle = Vector2.new(360, 360)
				ParticleEmitter3.VelocitySpread = 360
				v.Transparency = 1
				v.Anchored = true
				v.CanCollide = false
				coroutine.resume(coroutine.create(function()
					wait(0.2)
					ParticleEmitter3.Enabled = false
					game:GetService("Debris"):AddItem(v,2)
				end))
			end
		end
		wait(0.2)
		ParticleEmitter0.Enabled = false
		ParticleEmitter1.Enabled = false
		pant=false
	end
	
	if  key == "p" and attack == false then
		attack = true
		while attack == true do
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0), math.rad(0),math.rad(0))},"Back","Out",.1)
			SetTween(RJW,{C0=CFrame.new(0, -2, 0)*angles(math.rad(90),15.7,math.rad(0))},"Quad","InOut",.1)
			SetTween(LH,{C0=CFrame.new(-0.5, -1.0, 0)*angles(math.rad(90), 0, -0.5)},"Quad","InOut",0.1)
			SetTween(RH,{C0=CFrame.new(0.5, -1.0,0)*angles(math.rad(90), 0, 0.5)},"Quad","InOut",0.1)
			SetTween(LW,{C0=CFrame.new(-1.05, 0.2, 0)*angles(math.rad(50),0, 0.45)},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.05,  0.2, 0)*angles(math.rad(50),0, -0.45)},"Quad","InOut",0.1)			

			Swait()
			if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
				attack = false
			end
		end
	end

	if  key == "r"   and attack == false and pantdown == false then


		attack = true 
		local laying = true
		while laying == true do




			SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-2.20)*angles(math.rad(75),math.rad(5* math.cos(sine / 8 )),math.rad(5* math.cos(sine / 8 )))},"Linear","InOut",0.1)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-40),math.rad(15* math.sin(sine / 8 )),math.rad(0))},"Linear","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.0 , 0.5, -.4)*angles(math.rad(160),math.rad(5* math.cos(sine / 8 )),math.rad(-50+5* math.cos(sine / 8 )))},"Linear","Out",0.1)
			SetTween(LW,{C0=CFrame.new(-1.0, 0.5, -.4)*angles(math.rad(160),math.rad(5* math.cos(sine / 8 )),math.rad(40+5* math.cos(sine / 8 )))},"Linear","Out",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -.9-.1* math.cos(sine / 8 ), -.4+.4* math.cos(sine / 8 ))*angles(math.rad(-50+35* math.cos(sine / 8 )),math.rad(5* math.cos(sine / 8 )),math.rad(-15* math.cos(sine / 8 )))},"Linear","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -.9+.1* math.cos(sine / 8 ), -.4-.4* math.cos(sine / 8 ))*angles(math.rad(-50-35* math.cos(sine / 8 )),math.rad(5* math.cos(sine / 8 )),math.rad(-15* math.cos(sine / 8 )))},"Linear","InOut",0.1)

			Swait()
			if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
				laying = false	
			end
		end

		attack = false

	end

	if key == "r"   and attack == false and pantdown == true then


		attack = true 
		local laying = true
		while laying == true do


			SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-1.8)*angles(math.rad(140),math.rad(5* math.cos(sine / 8 )),math.rad(5* math.cos(sine / 8 )))},"Linear","InOut",0.1)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-100),math.rad(15* math.sin(sine / 8 )),math.rad(0))},"Linear","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.0 , 1, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 8 )),math.rad(40+5* math.cos(sine / 8 )))},"Linear","Out",0.1)
			SetTween(LW,{C0=CFrame.new(-1.0, 1, 0)*angles(math.rad(210),math.rad(5* math.cos(sine / 8 )),math.rad(-40+5* math.cos(sine / 8 )))},"Linear","Out",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -0.7, 0)*angles(math.rad(130+5* math.cos(sine / 8 )),math.rad(15* math.sin(sine / 8 )),math.rad(-15* math.cos(sine / 8 )))},"Linear","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -0.7, 0)*angles(math.rad(130-5* math.cos(sine / 8 )),math.rad(-15* math.sin(sine / 8 )),math.rad(-15* math.cos(sine / 8 )))},"Linear","InOut",0.1)

			Swait()
			if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
				laying = false	
			end
		end
		attack = false

	end
	if  key == "z"   and attack == false then
		Attack1()
	end

	if  key == "t"   and attack == false then
		attack = true

		SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(30))},"Back","Out",0.3)
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Back","Out",0.3)
		SetTween(RW,{C0=CFrame.new(1.3 , 0.5, -.0)*angles(math.rad(120),math.rad(0),math.rad(-40))},"Back","Out",0.3)
		SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.3)
		SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.3)
		SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",0.3)	
		Swait(.3*30)	

		chatfunc("^v^")
		so("3051419970", Character,4, .9)
		change = 4.3
		for i = 1,4,0.1 do 

			SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.1-.05* math.cos(sine / 8))*angles(math.rad(1+1* math.cos(sine / 8)),math.rad(0),math.rad(30+1* math.cos(sine / 8)))},"Quad","InOut",0.1)
			SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-30+1* math.cos(sine / 8)))},"Quad","InOut",0.1)
			SetTween(RW,{C0=CFrame.new(1.3 , 0.5, -.0)*angles(math.rad(120),math.rad(0),math.rad(-40))},"Quad","InOut",0.1)
			SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
			SetTween(RH,{C0=CFrame.new(.5, -.95+.05* math.cos(sine / 8), -.2+.05* math.cos(sine / 8))*angles(math.rad(-10+1* math.cos(sine / 8)),math.rad(25* math.cos(sine / 16)),math.rad(0))},"Quad","InOut",0.1)
			SetTween(LH,{C0=CFrame.new(-.5, -.95+.05* math.cos(sine / 8), 0)*angles(math.rad(1+1* math.cos(sine / 8)),math.rad(0),math.rad(0))},"Quad","InOut",0.1)	
			Swait()	
		end
		attack = false
	end
	if  key == "x"   and attack == false then
		if mememode == false then
			mememode=true











			lastsongpos = 0
			s2.TimePosition = lastsongpos


		else
			mememode=false
			CurId=CurId-1
			KeyDownF("n")

		end
	end






	if key == "m" then	

		if playsong == true then
			playsong = false	
			s2:stop()	
		elseif playsong == false then
			playsong = true	


			s2:play()				
		end

	end



	if key == "n" and mememode == false then	






		CurId = CurId + 1

		if CurId > 5 then
			CurId = 1	

		end
		chatfunc("now playing song Nr"..CurId)
		if CurId == 1 then
			lastid= "http://www.roblox.com/asset/?id=9046862941"
		elseif CurId == 2 then
			lastid= "http://www.roblox.com/asset/?id=9043887091"
		elseif CurId == 3 then
			lastid= "http://www.roblox.com/asset/?id=1848354536"
		elseif CurId == 4 then
			lastid= "http://www.roblox.com/asset/?id=1846458016"
		elseif CurId == 5 then
			lastid= "http://www.roblox.com/asset/?id=1836393153"
		elseif CurId == 6 then
			lastid= "http://www.roblox.com/asset/?id=16662832662"



		end 


		lastsongpos = 0
		s2.TimePosition = lastsongpos


	end


end

local event = Instance.new("BindableEvent")
coroutine.resume(coroutine.create(function()
	while true do 
		event.Event:Connect(function()return;end)
		sine = sine + change
		local hitfloor = rayCast(RootPart.Position, CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0)).lookVector, 4, Character)
		if Character:FindFirstChild("Sound") then
			Character:FindFirstChild("Sound"):Destroy()	
		end
		local torvel = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude
		local velderp = RootPart.Velocity.y
		if RootPart.Velocity.y > 1 and hitfloor == nil then
			Anim = "Jump"

		elseif RootPart.Velocity.y < -1 and hitfloor == nil then
			Anim = "Fall"
		elseif Humanoid.Sit == true then
			Anim = "Sit"	
		elseif torvel < .5 and hitfloor ~= nil  then
			Anim = "Idle"
		elseif torvel > .5 and  hitfloor ~= nil  then

			Anim = "Walk"




		else
			Anim = ""

		end 


		local Ccf=RootPart.CFrame
		--warn(Humanoid.MoveDirection*RootPart.CFrame.lookVector)
		local Walktest1 = Humanoid.MoveDirection*Ccf.LookVector
		local Walktest2 = Humanoid.MoveDirection*Ccf.RightVector
		--warn(Walktest1.Z.."/"..Walktest1.X)
		--warn(Walktest2.Z.."/"..Walktest2.X)
		forWFB = Walktest1.X+Walktest1.Z
		forWRL = Walktest2.X+Walktest2.Z





		--print(Humanoid.MoveDirection)
		--warn(Torso.CFrame.lookVector)



		coroutine.resume(coroutine.create(function()


			if s2.Parent == nil or s2 == nil  then

				s2 = s2c:Clone()
				s2.Parent = Torso
				s2.Name = "BGMusic"
				--	s2.SoundId = lastid
				s2.Pitch = 1
				s2.Volume = 1.5
				s2.Looped = true
				s2.archivable = false
				s2.TimePosition = lastsongpos
				if playsong == true then
					s2:play()		
				elseif playsong == false then
					s2:stop()			
				end


			else
				lastsongpos=s2.TimePosition		
				s2.Pitch = 1

				s2.Volume = 1.5

				s2.Looped = true
				s2.SoundId = lastid
				s2.EmitterSize = 30
			end



		end))




		inairvel=torvel*1

		--forWRL
		if inairvel > 30 then
			inairvel=30	
		end
		inairvel=inairvel/50*2



		if attack == false then
			if Anim == "Jump" then
				change = 0.60*2
				SetTween(RJW,{C0=RootCF* cn(0, 0 + (0.0395/2) * math.cos(sine / 8), -0.1 + 0.0395 * math.cos(sine / 8)) * angles(math.rad(-6.5 - 1.5 * math.cos(sine / 8))+(inairvel*forWFB)/2, math.rad(0)-(inairvel*forWRL)/2, math.rad(0))},"Quad","Out",0.25)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-26.5 + 2.5 * math.cos(sine / 8)), math.rad(0), math.rad(-0))},"Quad","Out",0.25)
				SetTween(RW,{C0=cf(1.4 + .05 * math.cos(sine / 8) , 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(140 - 2 * math.cos(sine / 8 )), math.rad(-5), math.rad(8 + 4 * math.cos(sine / 8)))},"Quad","Out",0.2)
				SetTween(LW,{C0=cf(-1.4 + .05 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(140 - 2 * math.cos(sine / 8 )), math.rad(5), math.rad(-8 - 4 * math.cos(sine / 8 )))},"Quad","Out",0.2)
				SetTween(RH,{C0=CFrame.new(.5, -0.85+ .05 * math.cos(sine / 15), -.2) * CFrame.Angles(math.rad(-15 -1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.075)
				SetTween(LH,{C0=CFrame.new(-.5, -0.35+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-25 +1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.075)



			elseif Anim == "Fall" then 
				change = 0.60*2
				SetTween(RJW,{C0=RootCF*cn(0, 0 + (0.0395/2) * math.cos(sine / 8), -0.5 + 0.0395 * math.cos(sine / 8)) * angles(math.rad(5.5 - 1.5 * math.cos(sine / 8))-(inairvel*forWFB)/2, math.rad(0)+(inairvel*forWRL)/2, math.rad(0))},"Quad","Out",0.35)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(26.5 + 2.5 * math.cos(sine / 8)), math.rad(0), math.rad(-0))},"Quad","Out",0.25)
				SetTween(RW,{C0=cf(1.4 + .05 * math.cos(sine / 8) , 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(105 - 2 * math.cos(sine / 8 )), math.rad(-15), math.rad(80 + 4 * math.cos(sine / 8)))},"Quad","Out",0.2)
				SetTween(LW,{C0=cf(-1.4 + .05 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(105 - 2 * math.cos(sine / 8 )), math.rad(15), math.rad(-80 - 4 * math.cos(sine / 8 )))},"Quad","Out",0.2)
				SetTween(RH,{C0=CFrame.new(.5, -0.15+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-15 -1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(LH,{C0=CFrame.new(-.5, -0.55+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-0 +1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.1)



			elseif Anim == "Idle" then


				local dahspeed=1
				if attack == true and mememode == true then
					dahspeed=5
				end



				if agresive == false then

					change = (0.60*1.75)*dahspeed
					Humanoid.JumpPower = 60	
					Humanoid.WalkSpeed=16	



					local ADNum = 0	
					SetTween(RJW,{C0=RootCF*cn(0, 0, -0.1 + 0.0395 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))) * angles(math.rad(1.5 - 1 * math.cos(sine / 8)), math.rad((0 + 0* math.cos(sine / 8)/20)), math.rad(-20))},"Quad","InOut",0.1)
					SetTween(NeckW,{C0=NeckCF*angles(math.rad(0.5 - 3.5 * math.sin(sine / 8 +ADNum* math.cos(sine / 8*2))), math.rad(12.5-1.5 * math.cos(sine / 16)), math.rad(6 - 2.5 * math.cos(sine / 15 +.4* math.cos(sine / 10))))},"Quad","InOut",0.1)
					SetTween(RW,{C0=cf(.85 + .0 * math.cos(sine / 8), 0.3 + .05 * math.cos(sine / 8), .0) * angles(math.rad(14 + 2 * math.sin(sine / 8 )), math.rad(-24), math.rad(-29 + 2 * math.cos(sine / 8)))},"Quad","Out",0.2)
					SetTween(LW,{C0=cf(-.85 + .0 * math.cos(sine / 8), 0.3 + .05 * math.cos(sine / 8), .0) * angles(math.rad(14 + 2 * math.sin(sine / 8 )), math.rad(24), math.rad(29 - 2 * math.cos(sine / 8 )))},"Quad","Out",0.2)
					SetTween(RH,{C0=CFrame.new(.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(1.5 - 1 * math.cos(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.1)
					SetTween(LH,{C0=CFrame.new(-.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(1.5 - 1 * math.cos(sine / 8)),math.rad(20),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.1)
				else


					change = (0.60*1.75)*dahspeed
					Humanoid.JumpPower = 60	
					Humanoid.WalkSpeed=16	



					local ADNum = 0	
					SetTween(RJW,{C0=RootCF*cn(0, 0, -0.1 + 0.0395 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))) * angles(math.rad(10.5 - 1 * math.cos(sine / 8)), math.rad((0 + 0* math.cos(sine / 8)/20)), math.rad(-5))},"Quad","InOut",0.1)
					SetTween(NeckW,{C0=NeckCF*angles(math.rad(-6.5 - 3.5 * math.sin(sine / 8 +ADNum* math.cos(sine / 8*2))), math.rad(2.5-5.5 * math.cos(sine / 16)), math.rad(5 - 6.5 * math.cos(sine / 15 +.4* math.cos(sine / 10))))},"Quad","InOut",0.1)
					SetTween(RW,{C0=cf(1.45 + .0 * math.cos(sine / 8) , 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(10 + 3 * math.sin(sine / 8 )), math.rad(25), math.rad(40 + 4 * math.cos(sine / 8)))},"Quad","Out",0.2)
					SetTween(LW,{C0=cf(-1.45 + .0 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(10 + 3 * math.sin(sine / 8 )), math.rad(-25), math.rad(-40 - 4 * math.cos(sine / 8 )))},"Quad","Out",0.2)
					SetTween(RH,{C0=CFrame.new(.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(20.5 - 1 * math.cos(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.1)
					SetTween(LH,{C0=CFrame.new(-.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(1.5 - 1 * math.cos(sine / 8)),math.rad(20),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.1)

				end







			elseif Anim == "Walk" then

				if agresive == false then

					local speed=1.0
					if mememode == true then
						speed=4
					end


					change = 2.4*speed
					Humanoid.JumpPower = 60*speed
					Humanoid.WalkSpeed=16*speed


					local RH2 = cf(-forWRL/7 * math.cos(sine / 8 ),0,forWFB/7 * math.cos(sine / 8 ))*angles(math.rad(-forWFB*30) * math.cos(sine / 8 ),0,math.rad(-forWRL*30) * math.cos(sine / 8 ))
					local LH2 = cf(forWRL/7 * math.cos(sine / 8 ),0,-forWFB/7 * math.cos(sine / 8 ))*angles(math.rad(forWFB*30) * math.cos(sine / 8 ),0,math.rad(forWRL*30) * math.cos(sine / 8 ))

					SetTween(RJW,{C0=RootCF*CFrame.new(0, 0 , -0.05 + 0.055 * math.cos(sine / 4) + -math.sin(sine / 4) / 8) * angles(math.rad((forWFB*2 - forWFB  * math.cos(sine / 4))*7), math.rad((-forWRL*2 - -forWRL  * math.cos(sine / 4))*5) , math.rad(8 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/speed)
					SetTween(NeckW,{C0=NeckCF*CFrame.new(0, 0, 0 + 0.025 * math.cos(sine / 4)) * angles(math.rad((-forWFB*1 - -forWFB  * math.cos(sine / 4))*7), math.rad((forWRL*2 - forWRL  * math.cos(sine / 4))*3.5), math.rad(-forWRL*45+-8 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/speed)
					SetTween(RW,{C0=cf(1.45 + .0 * math.cos(sine / 8) , 0.5 + forWRL/50* math.cos(sine / 8), 0)   * angles(math.rad(0 + forWFB*15 * math.cos(sine / 8 )), math.rad(0), math.rad(8 + forWRL*5 * math.cos(sine / 8)))},"Quad","Out",WalkAnimMove/speed)
					SetTween(LW,{C0=cf(-1.45 + .0 * math.cos(sine / 8), 0.5 + forWRL/50  * math.cos(sine / 8), 0)  * angles(math.rad(0 - forWFB*15 * math.cos(sine / 8 )), math.rad(0), math.rad(-8 - forWRL*5 * math.cos(sine / 8 )))},"Quad","Out",WalkAnimMove/speed)
					SetTween(RH,{C0=CFrame.new(.5, -0.85+ .15 * math.sin(sine / 8 ), -.15+.15* math.cos(sine / 8 ))*RH2 * CFrame.Angles(math.rad(0 - 5 * math.cos(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/speed)
					SetTween(LH,{C0=CFrame.new(-.5, -0.85- .15 * math.sin(sine / 8 ), -.15-.15* math.cos(sine / 8 ))*LH2 * CFrame.Angles(math.rad(0 + 5 * math.cos(sine / 8)),math.rad(0),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/speed)


				else



					local speed=1.6
					if mememode == true then
						speed=4
					end


					change = 2.5*speed
					Humanoid.JumpPower = 60*speed
					Humanoid.WalkSpeed=22*speed


					local RH2 = cf(-forWRL/9 * math.cos(sine / 8 ),0,forWFB/7 * math.cos(sine / 8 ))*angles(math.rad(-forWFB*60) * math.cos(sine / 8 ),0,math.rad(-forWRL*25) * math.cos(sine / 8 ))
					local LH2 = cf(forWRL/9 * math.cos(sine / 8 ),0,-forWFB/7 * math.cos(sine / 8 ))*angles(math.rad(forWFB*60) * math.cos(sine / 8 ),0,math.rad(forWRL*25) * math.cos(sine / 8 ))

					SetTween(RJW,{C0=RootCF*CFrame.new(forWRL*1 * math.sin(sine / 8),  forWFB*1 * math.sin(sine / 8) , -0.5 - 0.255 * math.cos(sine / 8) + -math.sin(sine / 8) / 8) * angles(math.rad(85+( forWFB  * math.cos(sine / 8))*20), math.rad(( -forWRL  * math.cos(sine / 4))*1) , math.rad((-forWRL  * math.cos(sine / 8))*10))},"Linear","InOut",WalkAnimMove/speed)
					SetTween(NeckW,{C0=NeckCF*CFrame.new(0, 0, 0 + 0.025 * math.cos(sine / 4)) * angles(math.rad(-20+(-forWFB*1 - -forWFB  * math.cos(sine / 4))*5), math.rad((forWRL*2 - forWRL  * math.cos(sine / 4))*3.5), math.rad(-forWRL*45+-8 * math.cos(sine / 8)))},"Linear","InOut",WalkAnimMove/speed)
					SetTween(RW,{C0=cf(1.0 + .0 * math.cos(sine / 8) , .5-forWFB*0.5* math.sin(sine / 8), -.4)   * angles(math.rad(95 - forWFB*75 * math.sin(sine / 8 )), math.rad(0), math.rad(-8+(-forWRL*55* math.sin(sine / 8 )) + 10 * math.cos(sine / 8)))},"Linear","Out",WalkAnimMove/speed)
					SetTween(LW,{C0=cf(-1.0 + .0 * math.cos(sine / 8), .5-forWFB*0.5* math.sin(sine / 8), -.4)  * angles(math.rad(95 - forWFB*75 * math.sin(sine / 8 )), math.rad(0), math.rad(8+(forWRL*55* math.cos(sine / 8 )) - 10 * math.cos(sine / 8 )))},"Linear","Out",WalkAnimMove/speed)
					SetTween(RH,{C0=CFrame.new(.5, -0.85- .25 * math.sin(sine / 8 ), -.15-.25* math.sin(sine / 8 ))*RH2 * CFrame.Angles(math.rad(60 - 5 * math.cos(sine / 8)),math.rad(0),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Linear","InOut",WalkAnimMove/speed)
					SetTween(LH,{C0=CFrame.new(-.5, -0.85- .25 * math.sin(sine / 8 ), -.15-.25* math.sin(sine / 8 ))*LH2 * CFrame.Angles(math.rad(60 - 5 * math.sin(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.sin(sine / 8)))},"Linear","InOut",WalkAnimMove/speed)


				end


			elseif Anim == "Sit" then	
				SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
				SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
				SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.1)

			end
		end
		if   attack == false and not (agresive==true and Anim == "Walk") then


		end
		Swait(Animstep*30)
	end
end))

local mouse = Player:GetMouse()

local a = mouse.KeyDown:Connect(KeyDownF)
local b = mouse.KeyUp:Connect(KeyUpF)
local c = mouse.Button1Down:Connect(Button1DownF)

local d = mouse.Button1Up:Connect(Button1UpF)

local e = mouse.Move:Connect(function()
	if mouse.Target then
		Target = mouse.Target
	end
end)
game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()event:Fire()for _,v in ipairs({a,b,c,d,e}) do v:Disconnect() end end)
--[[game.Players.LocalPlayer.Character.Humanoid.Ragdoll:Connect(function(state)
    if state == true then game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false) end
end)]]