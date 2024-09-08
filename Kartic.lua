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
		if o == Null then 
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

	function Encode(o)
		local writer = JsonWriter:New()
		writer:Write(o)
		return writer:ToString()
	end

	function Decode(s)
		local reader = JsonReader:New(s)
		return reader:Read()
	end

	function Null()
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

		if not type(regionToSelect) == "Region3" then
			error("regionToSelect (first arg), should be of type Region3, but is type",type(regionToSelect))
		end
		if not type(color) == "BrickColor" then
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
		function createAdornment(theColor)
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
		function cleanUpAdornments()
			for cellPos, adornTable in pairs(adornments) do

				if adornTable.KeepAlive ~= currentKeepAliveTag then -- old news, we should get rid of this
					adornTable.SelectionBox.Visible = false
					table.insert(reusableAdorns,{part = adornTable.SelectionPart, box = adornTable.SelectionBox})
					adornments[cellPos] = nil
				end
			end
		end

		-- helper function to update tag
		function incrementAliveCounter()
			aliveCounter = aliveCounter + 1
			if aliveCounter > 1000000 then
				aliveCounter = 0
			end
			return aliveCounter
		end

		-- finds full cells in region and adorns each cell with a box, with the argument color
		function adornFullCellsInRegion(region, color)
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

Player = game:GetService("Players").LocalPlayer
Character = Player.Character
PlayerGui = Player.PlayerGui
Backpack = Player.Backpack
Torso = Character.Torso
Head = Character.Head
Humanoid = Character.Humanoid
LeftArm = Character["Left Arm"]
LeftLeg = Character["Left Leg"]
RightArm = Character["Right Arm"]
RightLeg = Character["Right Leg"]
LS = Torso["Left Shoulder"]
LH = Torso["Left Hip"]
RS = Torso["Right Shoulder"]
RH = Torso["Right Hip"]
Face = Head.face
Neck = Torso.Neck
it = Instance.new
attacktype = 1
attacktype2 = 1
vt = Vector3.new
cf = CFrame.new
cn = CFrame.new
euler = CFrame.fromEulerAnglesXYZ
angles = CFrame.Angles
necko = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
necko2 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
LHC0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
LHC1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
RHC0 = cf(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
RHC1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
RootPart = Character.HumanoidRootPart
RootJoint = RootPart.RootJoint
RootCF = euler(-1.57, 0, 3.14)
attack = false
attackdebounce = false
trispeed = 0.2
attackmode = "none"
local idle = 0
local Anim = "Idle"
stance = false
local ff = 2
noleg = false
evadecooldown = false
Humanoid.Animator.Parent = nil
equip = false
Face.Texture = "http://www.roblox.com/asset/?id=0"
attackspeed = 0.14
df = false
Swing = 1
local sine = 0
local change = 1
local val = 0
magic = false
cam = workspace.CurrentCamera
deb = game:GetService("Debris")
RbxUtility = LoadLibrary("RbxUtility")
Create = RbxUtility.Create
local handee = Instance.new("Part")
handee.Parent = Character
handee.Size = Vector3.new(0.2, 0.2, 0.2)
handee.Archivable = true
handee.Transparency = 1
handee.CanCollide = false
handee.BrickColor = BrickColor.new("Cyan")
handee.Material = "Neon"
local handeeweld = Instance.new("Weld")
handeeweld.Parent = handee
handeeweld.Part0 = RightArm
handeeweld.Part1 = handee
handeeweld.C1 = CFrame.new(0, 0.96, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
handeeweld.Part0 = RightArm
function newWeld(wp0, wp1, wc0x, wc0y, wc0z)
	local wld = Instance.new("Weld", wp1)
	wld.Part0 = wp0
	wld.Part1 = wp1
	wld.C0 = CFrame.new(wc0x, wc0y, wc0z)
end
function weld(model)
	local parts, last = {}, nil
	local function scan(parent)
		for _, v in pairs(parent:GetChildren()) do
			if v:IsA("BasePart") then
				if last then
					local w = Instance.new("Weld")
					w.Name = ("%s_Weld"):format(v.Name)
					w.Part0, w.Part1 = last, v
					w.C0 = last.CFrame:inverse()
					w.C1 = v.CFrame:inverse()
					w.Parent = last
				end
				last = v
				table.insert(parts, v)
			end
			scan(v)
		end
	end
	scan(model)
	for _, v in pairs(parts) do
		v.Anchored = false
		v.Locked = true
		v.BackSurface = Enum.SurfaceType.SmoothNoOutlines
		v.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		v.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
		v.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
		v.RightSurface = Enum.SurfaceType.SmoothNoOutlines
		v.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
	end
end

music = Instance.new("Sound", Torso)
music.Volume = 1
music.TimePosition = 0
music.Pitch = 1
music.SoundId = "rbxassetid://1466277933"
music.Looped = true
music:Play()
function so(id, par, vol, pit)
	coroutine.resume(coroutine.create(function()
		local sou = Instance.new("Sound", par or workspace)
		sou.Volume = vol
		sou.Pitch = pit or 1
		sou.SoundId = id
		swait()
		sou:play()
		game:GetService("Debris"):AddItem(sou, 8)
	end))
end
RSH, LSH = nil, nil
RW, LW = Instance.new("Weld"), Instance.new("Weld")
RW.Name = "Right Shoulder"
LW.Name = "Left Shoulder"
LH = Torso["Left Hip"]
RH = Torso["Right Hip"]
TorsoColor = Torso.BrickColor
function NoOutline(Part)
	Part.TopSurface, Part.BottomSurface, Part.LeftSurface, Part.RightSurface, Part.FrontSurface, Part.BackSurface = 10, 10, 10, 10, 10, 10
end
player = Player
ch = Character
RSH = ch.Torso["Right Shoulder"]
LSH = ch.Torso["Left Shoulder"]
RSH.Parent = nil
LSH.Parent = nil
RW.Name = "Right Shoulder"
RW.Part0 = ch.Torso
RW.C0 = cf(1.5, 0.5, 0)
RW.C1 = cf(0, 0.5, 0)
RW.Part1 = ch["Right Arm"]
RW.Parent = ch.Torso
LW.Name = "Left Shoulder"
LW.Part0 = ch.Torso
LW.C0 = cf(-1.5, 0.5, 0)
LW.C1 = cf(0, 0.5, 0)
LW.Part1 = ch["Left Arm"]
LW.Parent = ch.Torso
function newWeld(wp0, wp1, wc0x, wc0y, wc0z)
	local wld = Instance.new("Weld", wp1)
	wld.Part0 = wp0
	wld.Part1 = wp1
	wld.C0 = CFrame.new(wc0x, wc0y, wc0z)
end
newWeld(RootPart, Torso, 0, -1, 0)
Torso.Weld.C1 = CFrame.new(0, -1, 0)
newWeld(Torso, LeftLeg, -0.5, -1, 0)
LeftLeg.Weld.C1 = CFrame.new(0, 1, 0)
newWeld(Torso, RightLeg, 0.5, -1, 0)
RightLeg.Weld.C1 = CFrame.new(0, 1, 0)
Player = game:GetService("Players").LocalPlayer
Character = Player.Character
mouse = Player:GetMouse()
m = Instance.new("Model", Character)
local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")
frame = 0.016666666666666666
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.Heartbeat:Fire()
game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.Heartbeat:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.Heartbeat:Fire()
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
function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end
CFuncs = {
	Part = {
		Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
			local Part = Create("Part")({
				Parent = Parent,
				Reflectance = Reflectance,
				Transparency = Transparency,
				CanCollide = false,
				Locked = true,
				BrickColor = BrickColor.new(tostring(BColor)),
				Name = Name,
				Size = Size,
				Material = Material
			})
			RemoveOutlines(Part)
			return Part
		end
	},
	Mesh = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh)({
				Parent = Part,
				Offset = OffSet,
				Scale = Scale
			})
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end
	},
	Mesh = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh)({
				Parent = Part,
				Offset = OffSet,
				Scale = Scale
			})
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end
	},
	Weld = {
		Create = function(Parent, Part0, Part1, C0, C1)
			local Weld = Create("Weld")({
				Parent = Parent,
				Part0 = Part0,
				Part1 = Part1,
				C0 = C0,
				C1 = C1
			})
			return Weld
		end
	},
	Sound = {
		Create = function(id, par, vol, pit)
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound")({
					Volume = vol,
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace
				})
				wait()
				S:play()
				game:GetService("Debris"):AddItem(S, 6)
			end))
		end
	},
	ParticleEmitter = {
		Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
			local fp = Create("ParticleEmitter")({
				Parent = Parent,
				Color = ColorSequence.new(Color1, Color2),
				LightEmission = LightEmission,
				Size = Size,
				Texture = Texture,
				Transparency = Transparency,
				ZOffset = ZOffset,
				Acceleration = Accel,
				Drag = Drag,
				LockedToPart = LockedToPart,
				VelocityInheritance = VelocityInheritance,
				EmissionDirection = EmissionDirection,
				Enabled = Enabled,
				Lifetime = LifeTime,
				Rate = Rate,
				Rotation = Rotation,
				RotSpeed = RotSpeed,
				Speed = Speed,
				VelocitySpread = VelocitySpread
			})
			return fp
		end
	},
	CreateTemplate = {}
}
EffectModel = Create("Model")({Parent = Character, Name = "Effects"})
Effects = {
	Block = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay, Type)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 2)
			if Type == 1 or Type == nil then
				table.insert(Effects, {
					prt,
					"Block1",
					delay,
					x3,
					y3,
					z3,
					msh
				})
			elseif Type == 2 then
				table.insert(Effects, {
					prt,
					"Block2",
					delay,
					x3,
					y3,
					z3,
					msh
				})
			end
		end
	},
	Cylinder = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("CylinderMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Cylinder",
				delay,
				x3,
				y3,
				z3,
				msh
			})
		end
	},
	Head = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Head", "nil", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Cylinder",
				delay,
				x3,
				y3,
				z3,
				msh
			})
		end
	},
	Sphere = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Cylinder",
				delay,
				x3,
				y3,
				z3,
				msh
			})
		end
	},
	Elect = {
		Create = function(cff, x, y, z)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, BrickColor.new("Lime green"), "Part", Vector3.new(1, 1, 1))
			prt.Anchored = true
			prt.CFrame = cff * CFrame.new(math.random(-x, x), math.random(-y, y), math.random(-z, z))
			prt.CFrame = CFrame.new(prt.Position)
			game:GetService("Debris"):AddItem(prt, 2)
			local xval = math.random() / 2
			local yval = math.random() / 2
			local zval = math.random() / 2
			local msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(xval, yval, zval))
			table.insert(Effects, {
				prt,
				"Elec",
				0.1,
				x,
				y,
				z,
				xval,
				yval,
				zval
			})
		end
	},
	Ring = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "FileMesh", "rbxassetid://3270017", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Cylinder",
				delay,
				x3,
				y3,
				z3,
				msh
			})
		end
	},
	Wave = {
		Create = function(brickcolor, cframe, x1, y1, z1, x3, y3, z3, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "FileMesh", "rbxassetid://20329976", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Cylinder",
				delay,
				x3,
				y3,
				z3,
				msh
			})
		end
	},
	Break = {
		Create = function(brickcolor, cframe, x1, y1, z1)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new(0.5, 0.5, 0.5))
			prt.Anchored = true
			prt.CFrame = cframe * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
			local msh = CFuncs.Mesh.Create("SpecialMesh", prt, "Sphere", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			local num = math.random(10, 50) / 1000
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Shatter",
				num,
				prt.CFrame,
				math.random() - math.random(),
				0,
				math.random(50, 100) / 100
			})
		end
	},
	Fire = {
		Create = function(brickcolor, cframe, x1, y1, z1, delay)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 0, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"Fire",
				delay,
				1,
				1,
				1,
				msh
			})
		end
	},
	FireWave = {
		Create = function(brickcolor, cframe, x1, y1, z1)
			local prt = CFuncs.Part.Create(EffectModel, "Neon", 0, 1, brickcolor, "Effect", Vector3.new())
			prt.Anchored = true
			prt.CFrame = cframe
			msh = CFuncs.Mesh.Create("BlockMesh", prt, "", "", Vector3.new(0, 0, 0), Vector3.new(x1, y1, z1))
			local d = Create("Decal")({
				Parent = prt,
				Texture = "rbxassetid://26356434",
				Face = "Top"
			})
			local d = Create("Decal")({
				Parent = prt,
				Texture = "rbxassetid://26356434",
				Face = "Bottom"
			})
			game:GetService("Debris"):AddItem(prt, 10)
			table.insert(Effects, {
				prt,
				"FireWave",
				1,
				30,
				math.random(400, 600) / 100,
				msh
			})
		end
	},
	Lightning = {
		Create = function(p0, p1, tym, ofs, col, th, tra, last)
			local magz = (p0 - p1).magnitude
			local curpos = p0
			local trz = {
				-ofs,
				ofs
			}
			for i = 1, tym do
				local li = CFuncs.Part.Create(EffectModel, "Neon", 0, tra or 0.4, col, "Ref", Vector3.new(th, th, magz / tym))
				local ofz = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
				local trolpos = CFrame.new(curpos, p1) * CFrame.new(0, 0, magz / tym).p + ofz
				li.Material = "Neon"
				if tym == i then
					local magz2 = (curpos - p1).magnitude
					li.Size = Vector3.new(th, th, magz2)
					li.CFrame = CFrame.new(curpos, p1) * CFrame.new(0, 0, -magz2 / 2)
					table.insert(Effects, {
						li,
						"Disappear",
						last
					})
				else
					li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / tym / 2)
					curpos = li.CFrame * CFrame.new(0, 0, magz / tym / 2).p
					game.Debris:AddItem(li, 10)
					table.insert(Effects, {
						li,
						"Disappear",
						last
					})
				end
			end
		end
	},
	EffectTemplate = {}
}
function New(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end
function clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
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
		if m00 < m11 then
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
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
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
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = math.acos(cosTheta)
			local invSinTheta = 1 / math.sin(theta)
			startInterp = math.sin((1 - t) * theta) * invSinTheta
			finishInterp = math.sin(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = math.acos(-cosTheta)
		local invSinTheta = 1 / math.sin(theta)
		startInterp = math.sin((t - 1) * theta) * invSinTheta
		finishInterp = math.sin(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function weld5(part0, part1, c0, c1)
	weeld = Instance.new("Weld", part0)
	weeld.Part0 = part0
	weeld.Part1 = part1
	weeld.C0 = c0
	weeld.C1 = c1
	return weeld
end
function rayCast(Pos, Dir, Max, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore)
end
function Damagefunc(hit, minim, maxim, knockback, Type, Property, Delay, KnockbackType, decreaseblock)
	if hit.Parent == nil then
		return
	end
	h = hit.Parent:FindFirstChild("Humanoid")
	for _, v in pairs(hit.Parent:children()) do
		if v:IsA("Humanoid") then
			h = v
		end
	end
	if hit.Parent.Parent:FindFirstChild("Torso") ~= nil then
		h = hit.Parent.Parent:FindFirstChild("Humanoid")
	end
	if hit.Parent.className == "Hat" then
		hit = hit.Parent.Parent:findFirstChild("Head")
	end
	if h ~= nil and hit.Parent.Name ~= Character.Name and hit.Parent:FindFirstChild("Torso") ~= nil then
		if hit.Parent:findFirstChild("DebounceHit") ~= nil and hit.Parent.DebounceHit.Value == true then
			return
		end
		c = Instance.new("ObjectValue")
		c.Name = "creator"
		c.Value = game:service("Players").LocalPlayer
		c.Parent = h
		game:GetService("Debris"):AddItem(c, 0.5)
		Damage = math.random(minim, maxim)
		blocked = false
		block = hit.Parent:findFirstChild("Block")
		if block ~= nil then
			print(block.className)
			if block.className == "NumberValue" and block.Value > 0 then
				blocked = true
				if decreaseblock == nil then
					block.Value = block.Value - 1
				end
			end
			if block.className == "IntValue" and block.Value > 0 then
				blocked = true
				if decreaseblock ~= nil then
					block.Value = block.Value - 1
				end
			end
		end
		if blocked == false then
			h.Health = h.Health - Damage
			showDamage(hit.Parent, Damage, 0.5, BrickColor.new("White"))
		else
			h.Health = h.Health - Damage / 2
			showDamage(hit.Parent, Damage / 2, 0.5, BrickColor.new("Bright blue"))
		end
		h.Health = h.Health - Damage
		if Type == "Knockdown" then
			hum = hit.Parent.Humanoid
			hum.PlatformStand = true
			coroutine.resume(coroutine.create(function(HHumanoid)
				swait(5)
				HHumanoid.PlatformStand = false
			end), hum)
			local angle = (hit.Position - (Property.Position + Vector3.new(0, 0, 0))).unit
			local bodvol = Instance.new("BodyVelocity")
			bodvol.velocity = angle * knockback
			bodvol.P = 5000
			bodvol.maxForce = Vector3.new(8000, 8000, 8000)
			bodvol.Parent = hit
			rl = Instance.new("BodyAngularVelocity")
			rl.P = 30000
			rl.maxTorque = Vector3.new(0, 10, 10) * 5000
			rl.angularvelocity = Vector3.new(math.random(-10, 10), math.random(2, 4), math.random(-10, 10))
			rl.Parent = hit
			game:GetService("Debris"):AddItem(bodvol, 0.5)
			game:GetService("Debris"):AddItem(rl, 0.5)
		elseif Type == "Normal" then
			vp = Instance.new("BodyVelocity")
			vp.P = 500
			vp.maxForce = Vector3.new(math.huge, 0, math.huge)
			if KnockbackType == 1 then
				vp.velocity = Property.CFrame.lookVector * knockback + Property.Velocity / 1.05
			elseif KnockbackType == 2 then
				vp.velocity = Property.CFrame.lookVector * knockback
			end
			if knockback > 0 then
				vp.Parent = hit.Parent.Torso
			end
			game:GetService("Debris"):AddItem(vp, 0.5)
		elseif Type == "Up" then
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.velocity = vt(0, 4, 0)
			bodyVelocity.P = 1000
			bodyVelocity.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
			bodyVelocity.Parent = hit
			game:GetService("Debris"):AddItem(bodyVelocity, 1)
			rl = Instance.new("BodyAngularVelocity")
			rl.P = 3000
			rl.maxTorque = Vector3.new(500000, 500000, 500000) * 50000000000000
			rl.angularvelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
			rl.Parent = hit
			game:GetService("Debris"):AddItem(rl, 0.5)
		elseif Type == "Slam" then
			local bodyVelocity2 = Instance.new("BodyVelocity")
			bodyVelocity2.velocity = vt(0, 4, 0)
			bodyVelocity2.P = 1000
			bodyVelocity2.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
			bodyVelocity2.Parent = hit
			game:GetService("Debris"):AddItem(bodyVelocity2, 1)
			rl2 = Instance.new("BodyAngularVelocity")
			rl2.P = 3000
			rl2.maxTorque = Vector3.new(500000, 500000, 500000) * 50000000000000
			rl2.angularvelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
			rl2.Parent = hit
			game:GetService("Debris"):AddItem(rl2, 0.5)
		elseif Type == "Snare" then
			bp = Instance.new("BodyPosition")
			bp.P = 2000
			bp.D = 100
			bp.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			bp.position = hit.Parent.Torso.Position
			bp.Parent = hit.Parent.Torso
			game:GetService("Debris"):AddItem(bp, 1)
		elseif Type == "Target" and Targetting == false then
			ZTarget = hit.Parent.Torso
			coroutine.resume(coroutine.create(function(Part)
				so("http://www.roblox.com/asset/?id=15666462", Part, 1, 1.5)
				swait(5)
				so("http://www.roblox.com/asset/?id=15666462", Part, 1, 1.5)
			end), ZTarget)
			TargHum = ZTarget.Parent:findFirstChild("Humanoid")
			targetgui = Instance.new("BillboardGui")
			targetgui.Parent = ZTarget
			targetgui.Size = UDim2.new(10, 100, 10, 100)
			targ = Instance.new("ImageLabel")
			targ.Parent = targetgui
			targ.BackgroundTransparency = 1
			targ.Image = "rbxassetid://4834067"
			targ.Size = UDim2.new(1, 0, 1, 0)
			cam.CameraType = "Scriptable"
			cam.CoordinateFrame = CFrame.new(Head.CFrame.p, ZTarget.Position)
			dir = Vector3.new(cam.CoordinateFrame.lookVector.x, 0, cam.CoordinateFrame.lookVector.z)
			workspace.CurrentCamera.CoordinateFrame = CFrame.new(Head.CFrame.p, ZTarget.Position)
			Targetting = true
			RocketTarget = ZTarget
			for i = 1, Property do
				if 0 < Humanoid.Health and Character.Parent ~= nil and 0 < TargHum.Health and TargHum.Parent ~= nil and Targetting == true then
					swait()
				end
				cam.CoordinateFrame = CFrame.new(Head.CFrame.p, ZTarget.Position)
				dir = Vector3.new(cam.CoordinateFrame.lookVector.x, 0, cam.CoordinateFrame.lookVector.z)
				cam.CoordinateFrame = CFrame.new(Head.CFrame.p, ZTarget.Position) * cf(0, 5, 10) * euler(-0.3, 0, 0)
			end
			Targetting = false
			RocketTarget = nil
			targetgui.Parent = nil
			cam.CameraType = "Custom"
		end
		debounce = Instance.new("BoolValue")
		debounce.Name = "DebounceHit"
		debounce.Parent = hit.Parent
		debounce.Value = true
		game:GetService("Debris"):AddItem(debounce, Delay)
		c = Instance.new("ObjectValue")
		c.Name = "creator"
		c.Value = Player
		c.Parent = h
		game:GetService("Debris"):AddItem(c, 0.5)
		CRIT = false
		hitDeb = true
		AttackPos = 6
	end
end
function showDamage(Char, Dealt, du, Color)
	m = Instance.new("Model")
	m.Name = tostring(Dealt)
	h = Instance.new("Humanoid")
	h.Health = 0
	h.MaxHealth = 0
	h.Parent = m
	c = Instance.new("Part")
	c.Transparency = 0
	c.BrickColor = Color
	c.Name = "Head"
	c.TopSurface = 0
	c.Material = "Neon"
	c.BrickColor = BrickColor.new("Toothpaste")
	c.BottomSurface = 0
	c.formFactor = "Plate"
	c.Size = Vector3.new(1, 0.4, 1)
	ms = Instance.new("CylinderMesh")
	ms.Scale = Vector3.new(0.8, 0.8, 0.8)
	if CRIT == true then
		ms.Scale = Vector3.new(1, 1.25, 1)
	end
	ms.Parent = c
	c.Reflectance = 0
	Instance.new("BodyGyro").Parent = c
	c.Parent = m
	if Char:findFirstChild("Head") ~= nil then
		c.CFrame = CFrame.new(Char.Head.CFrame.p + Vector3.new(0, 1.5, 0))
	elseif Char.Parent:findFirstChild("Head") ~= nil then
		c.CFrame = CFrame.new(Char.Parent.Head.CFrame.p + Vector3.new(0, 1.5, 0))
	end
	f = Instance.new("BodyPosition")
	f.P = 2000
	f.D = 100
	f.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	f.position = c.Position + Vector3.new(0, 3, 0)
	f.Parent = c
	game:GetService("Debris"):AddItem(m, 0.5 + du)
	c.CanCollide = false
	m.Parent = workspace
	c.CanCollide = false
end
function CreatePart(FormFactor, Parent, Material, Reflectance, Transparency, BColor, Name, Size)
	local Part = Create("Part")({
		formFactor = FormFactor,
		Parent = Parent,
		Reflectance = Reflectance,
		Transparency = Transparency,
		CanCollide = false,
		Locked = true,
		BrickColor = BrickColor.new(tostring(BColor)),
		Name = Name,
		Size = Size,
		Material = Material
	})
	RemoveOutlines(Part)
	return Part
end
function CreateMesh(Mesh, Part, MeshType, MeshId, OffSet, Scale)
	local Msh = Create(Mesh)({
		Parent = Part,
		Offset = OffSet,
		Scale = Scale
	})
	if Mesh == "SpecialMesh" then
		Msh.MeshType = MeshType
		Msh.MeshId = MeshId
	end
	return Msh
end
function CreateWeld(Parent, Part0, Part1, C0, C1)
	local Weld = Create("Weld")({
		Parent = Parent,
		Part0 = Part0,
		Part1 = Part1,
		C0 = C0,
		C1 = C1
	})
	return Weld
end
function attackone()
	attack = true
	for i = 0, 2, attackspeed + 0.16 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-30)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -0.3 * i) * angles(math.rad(60 * i), math.rad(0), math.rad(-20 * i)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(0)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-40), math.rad(4)), 0.2)
	end
	so("http://roblox.com/asset/?id=1022532343", LeftArm, 1, 1)
	RootPart.Velocity = RootPart.CFrame.lookVector * 34
	con5 = Humanoid.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
			attackdebounce = true
			Damagefunc(hit, 5, 8, math.random(5, 8), "Normal", RootPart, 0, 1)
			so("http://roblox.com/asset/?id=573395724", LeftArm, 1, 1)
			wait(0.2)
			attackdebounce = false
		end
	end)
	for i = 0, 1, attackspeed do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.4)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(60)), 0.4)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(30)), 0.4)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, -0.3) * angles(math.rad(20), math.rad(-40 * i), math.rad(-90)), 0.4)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(-4)), 0.3)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-3), math.rad(0)), 0.3)
	end
	attack = false
	con5:Disconnect()
end
function attacktwo()
	attack = true
	for i = 0, 2, 0.15 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(30)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -0.3 * i) * angles(math.rad(60 * i), math.rad(0), math.rad(20 * i)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(90 - 40 * i), math.rad(0), math.rad(-90 + 40 * i)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(40), math.rad(4)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-3), math.rad(0)), 0.2)
	end
	so("http://roblox.com/asset/?id=169259383", RightArm, 1, 1)
	RootPart.Velocity = RootPart.CFrame.lookVector * 45
	con5 = Humanoid.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
			attackdebounce = true
			Damagefunc(hit, 6, 17, math.random(5, 12), "Normal", RootPart, 0, 1)
			so("http://roblox.com/asset/?id=542443306", RightArm, 1, 1)
			wait(0.3)
			attackdebounce = false
		end
	end)
	for i = 0, 1, 0.07 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-40), math.rad(90 * i), math.rad(0)), 0.6)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(15), math.rad(-70)), 0.4)
		RW.C0 = clerp(RW.C0, CFrame.new(0.9, 0.5, -0.5) * angles(math.rad(80), math.rad(0), math.rad(-50)), 0.7)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-40), math.rad(0), math.rad(50)), 0.4)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-40), math.rad(20), math.rad(0)), 0.3)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(20), math.rad(-40), math.rad(20)), 0.3)
	end
	con5:Disconnect()
	attack = false
end
function attackthree()
	attack = true
	noleg = true
	for i = 0, 2.3, 0.16 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1.15, 2.5) * CFrame.Angles(math.rad(-27), math.rad(0 - 50 * i), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-24), math.rad(-8), math.rad(43)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(60)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-0.9, 0.5, -0.3) * angles(math.rad(90), math.rad(0), math.rad(50)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -0.72, -0.4) * CFrame.Angles(math.rad(17), math.rad(0), math.rad(-16)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.34, -1.15, 0.3) * CFrame.Angles(math.rad(-77), math.rad(0), math.rad(0)), 0.2)
	end
	con5 = Humanoid.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
			attackdebounce = true
			Damagefunc(hit, 6, 12, math.random(5, 8), "Normal", RootPart, 0, 1)
			so("http://roblox.com/asset/?id=573395724", LeftLeg, 1, 1)
			wait(0.17)
			attackdebounce = false
		end
	end)
	so("http://roblox.com/asset/?id=1022532343", LeftLeg, 1, 1.34)
	so("http://roblox.com/asset/?id=1022532343", RightLeg, 1, 1.34)
	for i = 0, 3.17, 0.11 do
		swait()
		RootPart.Velocity = RootPart.CFrame.lookVector * 45
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -0.7, -0.9) * CFrame.Angles(math.rad(16 + 40 * i), math.rad(0 + 111 * i), math.rad(32 + 20 * i)), 0.1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(23), math.rad(0), math.rad(-10)), 0.16)
		RW.C0 = clerp(RW.C0, CFrame.new(0.3, 0.35, -0.5) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.16)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0.2) * angles(math.rad(-70), math.rad(0), math.rad(-40)), 0.16)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.79, -0.95, 0.34) * CFrame.Angles(math.rad(-32), math.rad(32), math.rad(-40)), 0.17)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.4, -0.75, -0.43) * CFrame.Angles(math.rad(76), math.rad(38), math.rad(0)), 0.1)
	end
	for i = 0, 1, attackspeed do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -0.4) * CFrame.Angles(math.rad(-8), math.rad(-30), math.rad(0)), 0.1)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(30)), 0.1)
		RW.C0 = clerp(RW.C0, CFrame.new(0.3, 0.35, -0.5) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.16)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(20), math.rad(0), math.rad(-30)), 0.1)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(3), math.rad(0)), 0.1)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1.03, 0.3) * CFrame.Angles(math.rad(-13), math.rad(0), math.rad(0)), 0.1)
	end
	noleg = false
	attack = false
	con5:Disconnect()
end
function Fdash()
	evadecooldown = true
	attack = true
	so("http://www.roblox.com/asset/?id=558640653", Character, 2.5, 1)
	Effects.Block.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 33.6, 33.6, 33.6, 0.05)
	Effects.Block.Create(BrickColor.new("White"), RootPart.CFrame, 2, 2, 2, 33.4, 33.4, 33.4, 0.04)
	Effects.Block.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 36.6, 36.6, 36.6, 0.05)
	Effects.Block.Create(BrickColor.new("Deep blue"), RootPart.CFrame, 2, 2, 2, 36.4, 36.4, 36.4, 0.05)
	Effects.Ring.Create(BrickColor.new("New Yeller"), Torso.CFrame, 2, 2, 2, 7.6, 7.6, 7.6, 0.025)
	Effects.Ring.Create(BrickColor.new("Deep blue"), Torso.CFrame, 2, 2, 2, 8.6, 8.6, 8.6, 0.03)
	Effects.Ring.Create(BrickColor.new("White"), Torso.CFrame, 2, 2, 2, 9.6, 9.6, 9.6, 0.04)
	Effects.Ring.Create(BrickColor.new("Navy blue"), Torso.CFrame, 2, 2, 2, 10.6, 10.6, 10.6, 0.05)
	for i = 0, 2, 0.064 do
		swait()
		RootPart.Velocity = RootPart.CFrame.lookVector * 145
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -4.8) * CFrame.Angles(math.rad(-90), math.rad(0 + 213.8 * i), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-90), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
	end
	attack = false
	wait(0.13)
	evadecooldown = false
end
function Adash()
	evadecooldown = true
	attack = true
	so("http://www.roblox.com/asset/?id=558640653", Character, 2.5, 1)
	Effects.Block.Create(BrickColor.new("Navy blue"), LeftLeg.CFrame, 2, 2, 2, 33.6, 33.6, 33.6, 0.05)
	Effects.Block.Create(BrickColor.new("White"), RightLeg.CFrame, 2, 2, 2, 33.4, 33.4, 33.4, 0.04)
	Effects.Block.Create(BrickColor.new("Navy blue"), LeftLeg.CFrame, 2, 2, 2, 36.6, 36.6, 36.6, 0.05)
	Effects.Block.Create(BrickColor.new("Deep blue"), RightLeg.CFrame, 2, 2, 2, 36.4, 36.4, 36.4, 0.05)
	Torso.Velocity = RootPart.Velocity + vt(0, 19.4, 0)
	for i = 0, 2, 0.064 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(0), math.rad(0 + 213.8 * i), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-90), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
	end
	attack = false
	wait(0.13)
	evadecooldown = false
end
function Ldash()
	evadecooldown = true
	attack = true
	so("http://www.roblox.com/asset/?id=707957812", Torso, 2.5, 1)
	for i = 0, 2, 0.064 do
		swait()
		RootPart.Velocity = RootPart.CFrame.rightVector * -75
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(32)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(-9), math.rad(-14)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(77), math.rad(0), math.rad(70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.55) * angles(math.rad(30), math.rad(0), math.rad(70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(12)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(8)), 0.2)
	end
	attack = false
	wait(0.13)
	evadecooldown = false
end
function Rdash()
	evadecooldown = true
	attack = true
	so("http://www.roblox.com/asset/?id=707957812", Torso, 2.5, 1)
	for i = 0, 2, 0.064 do
		swait()
		RootPart.Velocity = RootPart.CFrame.rightVector * 75
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-32)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(9), math.rad(14)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, -0.55) * angles(math.rad(30), math.rad(0), math.rad(-70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(77), math.rad(0), math.rad(-70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-8)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-12)), 0.2)
	end
	attack = false
	wait(0.13)
	evadecooldown = false
end
function Bdash()
	evadecooldown = true
	attack = true
	for i = 0, 8.4, 0.21 do
		swait()
		RootPart.Velocity = RootPart.CFrame.lookVector * -90
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -0.79, 2.5) * CFrame.Angles(math.rad(0 + 100 * i), math.rad(0), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(20), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(180), math.rad(-60), math.rad(40)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(180), math.rad(60), math.rad(-40)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2)
	end
	attack = false
	wait(0.9)
	evadecooldown = false
end
function bullets()
	local X = Instance.new("Part", Workspace)
	local O = Instance.new("ObjectValue", X)
	O.Name = "creator"
	X.Locked = true
	X.Name = "Shell"
	X.Anchored = false
	X.CanCollide = false
	X.Transparency = 0.24
	X.Reflectance = 0
	X.BottomSurface = 0
	X.TopSurface = 0
	X.Shape = 0
	local V = Instance.new("ObjectValue", X)
	V.Value = Character
	V.Name = "creator"
	X.BrickColor = BrickColor.new("Cyan")
	X.Size = Vector3.new(2, 2, 2)
	X.Material = "Neon"
	local Z = Instance.new("SpecialMesh", X)
	Z.MeshType = "Sphere"
	Z.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
	X.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
	local bv = Instance.new("BodyVelocity", X)
	bv.maxForce = Vector3.new(99999, 99999, 99999)
	X.CFrame = CFrame.new(X.Position, mouse.Hit.p)
	bv.velocity = X.CFrame.lookVector * 445
	so("http://roblox.com/asset/?id=200633327", X, 1, 1)
	local X2 = Instance.new("Part", Workspace)
	local O2 = Instance.new("ObjectValue", X2)
	O2.Name = "creator"
	X2.Locked = true
	X2.Name = "Shell"
	X2.Anchored = false
	X2.CanCollide = false
	X2.Transparency = 0.24
	X2.Reflectance = 0
	X2.BottomSurface = 0
	X2.TopSurface = 0
	X2.Shape = 0
	local V2 = Instance.new("ObjectValue", X2)
	V2.Value = Character
	V2.Name = "creator"
	X2.BrickColor = BrickColor.new("New Yeller")
	X2.Size = Vector3.new(2, 2, 2)
	X2.Material = "Neon"
	local Z2 = Instance.new("SpecialMesh", X2)
	Z2.MeshType = "Sphere"
	Z2.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
	X2.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
	local bv2 = Instance.new("BodyVelocity", X2)
	bv2.maxForce = Vector3.new(99999, 99999, 99999)
	X2.CFrame = CFrame.new(X2.Position, mouse.Hit.p)
	bv2.velocity = X2.CFrame.lookVector * 345
	so("http://roblox.com/asset/?id=200633327", X2, 1, 1)
	local X3 = Instance.new("Part", Workspace)
	local O3 = Instance.new("ObjectValue", X3)
	O3.Name = "creator"
	X3.Locked = true
	X3.Name = "Shell"
	X3.Anchored = false
	X3.CanCollide = false
	X3.Transparency = 0.24
	X3.Reflectance = 0
	X3.BottomSurface = 0
	X3.TopSurface = 0
	X3.Shape = 0
	local V3 = Instance.new("ObjectValue", X3)
	V3.Value = Character
	V3.Name = "creator"
	X3.BrickColor = BrickColor.new("White")
	X3.Size = Vector3.new(2, 2, 2)
	X3.Material = "Neon"
	local Z3 = Instance.new("SpecialMesh", X3)
	Z3.MeshType = "Sphere"
	Z3.Scale = Vector3.new(0.2, 0.2, 0.7) + Vector3.new(math.random(0, 0.7), math.random(0, 0.7), math.random(0, 0.7))
	X3.CFrame = handee.CFrame * CFrame.new(0, -5, -1) + Vector3.new(math.random(-76, 76), math.random(5, 10), math.random(-44, 44))
	local bv3 = Instance.new("BodyVelocity", X3)
	bv3.maxForce = Vector3.new(99999, 99999, 99999)
	X3.CFrame = CFrame.new(X3.Position, mouse.Hit.p)
	bv3.velocity = X3.CFrame.lookVector * 545
	so("http://roblox.com/asset/?id=200633327", X3, 1, 1)
	local con5 = X.Touched:connect(function(hit)
		Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
		X:Destroy()
		so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X2" or hit.Name ~= "X3" then
			Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
			Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
			so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
			X:Destroy()
		end
	end)
	local con5 = X2.Touched:connect(function(hit)
		Effects.Sphere.Create(BrickColor.new("New Yeller"), X2.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
		X2:Destroy()
		so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X" or hit.Name ~= "X3" then
			Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
			Effects.Sphere.Create(BrickColor.new("New Yeller"), X2.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
			so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
			X2:Destroy()
		end
	end)
	local con5 = X3.Touched:connect(function(hit)
		Effects.Sphere.Create(BrickColor.new("White"), X3.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
		X3:Destroy()
		so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Name ~= "X2" or hit.Name ~= "X" then
			Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
			Effects.Sphere.Create(BrickColor.new("White"), X3.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
			so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
			X3:Destroy()
		end
	end)
end
function Fkickcombo()
	attack = true
	for i = 0, 2.3, 0.16 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1.15, 2.5) * CFrame.Angles(math.rad(-27), math.rad(0 - 50 * i), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-24), math.rad(-8), math.rad(43)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(60)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-0.9, 0.5, -0.3) * angles(math.rad(90), math.rad(0), math.rad(50)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -0.72, -0.4) * CFrame.Angles(math.rad(17), math.rad(0), math.rad(-16)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.34, -1.15, 0.3) * CFrame.Angles(math.rad(-77), math.rad(0), math.rad(0)), 0.2)
	end
	con5 = Humanoid.Touched:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
			attackdebounce = true
			Damagefunc(hit, 17, 26, math.random(2, 3), "Normal", RootPart, 0, 1)
			so("http://roblox.com/asset/?id=260429995", RightLeg, 2, 1)
			wait(0.14)
			attackdebounce = false
		end
	end)
	so("http://roblox.com/asset/?id=158475221", Torso, 1, 1.9)
	noleg = true
	for i = 0, 3.3, 0.11 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, 2.4, -0.8) * CFrame.Angles(math.rad(13 - 22 * i), math.rad(0 + 130 * i), math.rad(80 - 15 * i)), 0.15)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(13), math.rad(-17), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(0.7, 0.5, -0.7) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.15)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-90), math.rad(0), math.rad(-30)), 0.15)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.03, 0.4) * CFrame.Angles(math.rad(-54 - 3 * i), math.rad(0), math.rad(0)), 0.15)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, -0.7) * CFrame.Angles(math.rad(60 + 3 * i), math.rad(10), math.rad(-4)), 0.15)
	end
	attack = false
	noleg = false
	con5:disconnect()
end
function Magicform()
	df = true
	attack = true
	music.TimePosition = 0
	music.SoundId = "rbxassetid://1228696343"
	swait(1)
	for i = 0, 4, 0.1 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(24), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(-4), math.rad(3)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(4), math.rad(-3)), 0.2)
	end
	so("http://roblox.com/asset/?id=1286168545", Head, 6, 1)
	Effects.Sphere.Create(BrickColor.new("Toothpaste"), Torso.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
	for i = 0, 4, 0.1 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-54), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(-70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(4), math.rad(-3)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(-4), math.rad(3)), 0.2)
	end
	attack = false
end
function Magicrevert()
	df = false
	attack = true
	music.TimePosition = 0
	music.SoundId = "rbxassetid://1343241846"
	swait(1)
	for i = 0, 4, 0.1 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(0), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(24), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(-70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.2, 0.5, -0.35) * angles(math.rad(90), math.rad(0), math.rad(70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(-4), math.rad(3)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(30), math.rad(4), math.rad(-3)), 0.2)
	end
	so("http://roblox.com/asset/?id=1286168545", Head, 6, 1)
	Effects.Sphere.Create(BrickColor.new("New Yeller"), Torso.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
	for i = 0, 4, 0.1 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-54), math.rad(0), math.rad(0)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-60), math.rad(0), math.rad(-70)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(4), math.rad(-3)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(-30), math.rad(-4), math.rad(3)), 0.2)
	end
	attack = false
end
function Sphere1()
	magic = true
	while magic == true do
		do
			local thing = Instance.new("BodyGyro", RootPart)
			thing.D = 30
			thing.P = 3000
			thing.MaxTorque = vt(math.huge, math.huge, 0)
			thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
			attack = true
			Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
			for i = 0, 1.6, 0.22 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-14), math.rad(-60), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(70)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(60), math.rad(0), math.rad(-90)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.06, 0) * CFrame.Angles(math.rad(-8), math.rad(27), math.rad(-12)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(2), math.rad(-24), math.rad(7)), 0.2)
			end
			local X = Instance.new("Part", Workspace)
			local O = Instance.new("ObjectValue", X)
			O.Name = "creator"
			X.Locked = true
			X.Name = "Shell"
			X.Anchored = false
			X.CanCollide = false
			X.Transparency = 0.24
			X.Reflectance = 0
			X.BottomSurface = 0
			X.TopSurface = 0
			X.Shape = 0
			local V = Instance.new("ObjectValue", X)
			V.Value = char
			V.Name = "creator"
			X.BrickColor = BrickColor.new("Cyan")
			X.Size = Vector3.new(2, 2, 2)
			X.Material = "Neon"
			local Z = Instance.new("SpecialMesh", X)
			Z.MeshType = "Sphere"
			Z.Scale = Vector3.new(1.5, 1.5, 2)
			X.CFrame = handee.CFrame * CFrame.new(0, -5, -1)
			local bv = Instance.new("BodyVelocity", X)
			bv.maxForce = Vector3.new(99999, 99999, 99999)
			X.CFrame = CFrame.new(X.Position, mouse.Hit.p)
			bv.velocity = X.CFrame.lookVector * 245
			RootPart.Velocity = RootPart.CFrame.lookVector * -43
			Torso.Velocity = RootPart.Velocity + vt(0, 3.4, 0)
			game:service("Debris"):AddItem(X, 9)
			local con5 = X.Touched:connect(function(hit)
				Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
				X:Destroy()
				so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
				if hit.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
					attackdebounce = true
					Damagefunc(hit, 9, 16, math.random(4, 6), "Knockdown", RootPart, 0.2, 1)
					Effects.Sphere.Create(BrickColor.new("Toothpaste"), X.CFrame, 2, 2, 2, 37.6, 37.6, 37.6, 0.07)
					so("http://roblox.com/asset/?id=265581252", Workspace, 0.5, 1)
					X:Destroy()
					wait()
					attackdebounce = false
				end
			end)
			Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
			for i = 0, 2.86, 0.22 do
				swait()
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(10), math.rad(40), math.rad(0)), 0.2)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(6), math.rad(0), math.rad(-50)), 0.2)
				RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.65) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.2)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-40)), 0.2)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-16), math.rad(4), math.rad(11)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(16), math.rad(-4), math.rad(13)), 0.2)
			end
			thing:Destroy()
			attack = false
		end
	end
end
function Sphere2()
	attack = true
	local thing = Instance.new("BodyGyro", RootPart)
	thing.D = 30
	thing.P = 3000
	thing.MaxTorque = vt(math.huge, math.huge, 0)
	Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.07)
	for i = 0, 2.86, 0.22 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(10), math.rad(40), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(6), math.rad(0), math.rad(-50)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.2, 0.5, -0.65) * angles(math.rad(80), math.rad(0), math.rad(-70)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30), math.rad(0), math.rad(-40)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-16), math.rad(4), math.rad(11)), 0.2)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1, 0) * CFrame.Angles(math.rad(16), math.rad(-4), math.rad(13)), 0.2)
	end
	for i = 1, 215 do
		thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
		bullets()
		swait()
		bullets()
		bullets()
		wait(0.2)
		bullets()
		bullets()
		RootPart.Velocity = RootPart.CFrame.lookVector * -23
	end
	thing:Destroy()
	attack = false
end
function laser()
	local thing = Instance.new("BodyGyro", RootPart)
	thing.D = 0
	thing.P = 7000
	thing.MaxTorque = vt(math.huge, math.huge, 0)
	thing.CFrame = CFrame.new(RootPart.Position, mouse.Hit.p)
	attack = true
	so("http://roblox.com/asset/?id=1048497321", RightArm, 1, 1)
	for i = 0, 1, 0.1 do
		swait()
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(0), math.rad(90)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
	end
	local ray = Ray.new(handee.CFrame.p, (mouse.Hit.p - handee.CFrame.p).unit * 700)
	local part, position = workspace:FindPartOnRay(ray, player.Character, false, true)
	local beam = Instance.new("Part", workspace)
	beam.BrickColor = BrickColor.new("Navy blue")
	beam.FormFactor = "Custom"
	beam.Material = "Neon"
	beam.Transparency = 0
	beam.Anchored = true
	beam.Locked = true
	beam.CanCollide = false
	local beam1 = Instance.new("Part", workspace)
	beam1.BrickColor = BrickColor.new("Navy blue")
	beam1.FormFactor = "Custom"
	beam1.Material = "Neon"
	beam1.Transparency = 0
	beam1.Anchored = false
	beam1.Locked = true
	beam1.CanCollide = false
	local distance = (handee.CFrame.p - position).magnitude
	beam.Size = Vector3.new(1.71, 1.71, distance)
	beam1.Size = Vector3.new(2.71, 2.71, distance)
	beam.CFrame = CFrame.new(handee.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
	beam1.CFrame = CFrame.new(handee.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
	local Z = Instance.new("SpecialMesh", beam)
	Z.MeshType = "Sphere"
	local Z1 = Instance.new("SpecialMesh", beam1)
	Z1.MeshType = "Sphere"
	local bv = Instance.new("BodyVelocity", beam1)
	bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	beam1.CFrame = CFrame.new(beam1.Position, mouse.Hit.p)
	bv.velocity = beam1.CFrame.lookVector * 350
	so("http://roblox.com/asset/?id=215270668", RightArm, 6, 1)
	Torso.Anchored = true
	Effects.Ring.Create(BrickColor.new("Navy blue"), RootPart.CFrame, 2, 2, 2, 18.6, 18.6, 18.6, 0.02)
	Effects.Block.Create(BrickColor.new("Navy blue"), handee.CFrame, 2, 2, 2, 3.6, 3.6, 3.6, 0.03)
	if part then
		local humanoid = part.Parent:FindFirstChild("Humanoid")
		humanoid = humanoid or part.Parent.Parent:FindFirstChild("Humanoid")
		if humanoid and part.Parent:FindFirstChild("Humanoid") ~= nil and attackdebounce == false then
			attackdebounce = true
			Damagefunc(part, 1, 9, math.random(1, 2), "Knockdown", RootPart, 0.2, 1)
			swait()
			attackdebounce = false
		end
	end
	for i = 0, 3.8, 0.1 do
		swait()
		beam.Size = beam.Size + Vector3.new(3.71, 3.71, 0)
		beam1.Size = beam1.Size + Vector3.new(7.71, 7.71, 0)
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90 + 7 * math.cos(sine / 1.6) / 2), math.rad(0), math.rad(90)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
	end
	for i = 0, 3.8, 0.1 do
		swait()
		beam.Size = beam.Size - Vector3.new(6.71, 6.71, 0)
		beam1.Size = beam1.Size - Vector3.new(9.71, 9.71, 0)
		Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.2)
		Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0), math.rad(0), math.rad(-80)), 0.2)
		RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90 + 7 * math.cos(sine / 1.6) / 2), math.rad(0), math.rad(90)), 0.2)
		LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-20), math.rad(0), math.rad(-30)), 0.2)
		LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.73, -1, 0) * CFrame.Angles(math.rad(-25), math.rad(-66), math.rad(-25)), 0.1)
		RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.6, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-83), math.rad(0)), 0.1)
	end
	Torso.Anchored = false
	game:GetService("Debris"):AddItem(beam, 0.1)
	game:GetService("Debris"):AddItem(beam1, 0.1)
	attack = false
	thing:Destroy()
end
mouse.Button1Down:connect(function()
	if attack == false and attacktype == 1 and df == false then
		attacktype = 2
		attackone()
	elseif attack == false and attacktype == 2 and df == false then
		attacktype = 3
		attacktwo()
	elseif attack == false and attacktype == 3 and df == false then
		attacktype = 1
		attackthree()
	elseif attack == false and attacktype == 4 and df == false then
		attacktype = 1
		attackfour()
	elseif attack == false and attacktype2 == 1 and df == true then
		attacktype = 1
		Sphere1()
	end
end)
mouse.Button1Up:connect(function()
	if attack == true and df == true then
		magic = false
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "f" and attack == false and evadecooldown == false then
		Fdash()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "g" and attack == false and evadecooldown == false then
		Adash()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "e" and attack == false and evadecooldown == false then
		Ldash()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "r" and attack == false and evadecooldown == false then
		Rdash()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "q" and attack == false and df == false then
		Fkickcombo()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "t" and attack == false then
		Bdash()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "y" and attack == false and df == false then
		Magicform()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "u" and attack == false and df == true then
		Magicrevert()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "l" and attack == false and df == true then
		laser()
	end
end)
mouse.KeyDown:connect(function(key)
	if key == "h" and attack == false and df == true then
		Sphere2()
	end
end)
mouse.KeyDown:connect(function(key)
	if string.byte(key) == 32 then
		local ray = Ray.new(Torso.CFrame.p, Torso.CFrame.lookVector * 2)
		local hit, position, normal = workspace:FindPartOnRay(ray, character)
		if hit and hit ~= lastwall then
			print("walljump")
			local velo = Instance.new("BodyVelocity", Torso)
			velo.MaxForce = Vector3.new(400000, 400000, 400000)
			velo.Velocity = -Torso.CFrame.lookVector * 20 + Vector3.new(0, 16, 0)
			game.Debris:AddItem(velo, 0.1)
			lastwall = hit
			wait(0.4)
			lastwall = nil
		end
	end
end)
for _, v in next, game:service("Players").localPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") then
		local BF = Instance.new("BodyForce", v)
		BF.force = Vector3.new(0, workspace.Gravity * v:GetMass() / 1.121, 0)
	end
end
mouse.KeyDown:connect(function(key)
	if string.byte(key) == 48 then
		Swing = 2
		if df == true then
			Character.Humanoid.WalkSpeed = 38.82
		end
		if df == false then
			Character.Humanoid.WalkSpeed = 28.82
		end
	end
end)
mouse.KeyUp:connect(function(key)
	if string.byte(key) == 48 then
		Swing = 1
		Character.Humanoid.WalkSpeed = 8
	end
end)
Humanoid.JumpPower = 43.3
Character.Humanoid.WalkSpeed = 8
while true do
	swait()
	sine = sine + change
	local torvel = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
	local velderp = RootPart.Velocity.y
	hitfloor, posfloor = rayCast(RootPart.Position, CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0)).lookVector, 4, Character)
	if attack == true or attack == false then
		if attack == false then
			idle = idle + 1
		else
			idle = 0
		end
		if not (idle >= 500) or attack == false then
		end
		if RootPart.Velocity.y > 1 and hitfloor == nil then
			Anim = "Jump"
			if attack == false then
				change = 1
				Humanoid.CameraOffset = Vector3.new(0, 0, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, -0.15) * CFrame.Angles(math.rad(-13), math.rad(0), math.rad(0)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(0)), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(50 - 2.05 * math.cos(sine / 5))), 0.1)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(-30 + 2.05 * math.cos(sine / 5)), math.rad(0), math.rad(-50 + 2.05 * math.cos(sine / 5))), 0.1)
			end
			if attack == false then
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-25 + 3.05 * math.cos(sine / 5)), math.rad(0), math.rad(0)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -0.47, -0.7) * CFrame.Angles(math.rad(-12 + 3.05 * math.cos(sine / 5)), math.rad(-3), math.rad(0)), 0.1)
			end
		elseif RootPart.Velocity.y < -1 and hitfloor == nil then
			Anim = "Fall"
			change = 1
			if attack == false then
				Humanoid.CameraOffset = Vector3.new(0, 0, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1, 0.2) * CFrame.Angles(math.rad(-10), math.rad(0), math.rad(0)), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(90), math.rad(20), math.rad(90)), 0.1)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0) * angles(math.rad(90), math.rad(-20), math.rad(-90)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(40), math.rad(0), math.rad(0)), 0.1)
			end
			if attack == false or attack == true then
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1, 0) * CFrame.Angles(math.rad(-8), math.rad(3), math.rad(0)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -0.67, -0.4) * CFrame.Angles(math.rad(25), math.rad(0), math.rad(0)), 0.1)
			end
		elseif torvel < 1 and hitfloor ~= nil then
			Anim = "Idle"
			change = 1.54
			if attack == false and equip == false then
				Humanoid.CameraOffset = Vector3.new(0, 0, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 - 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(0), math.rad(-43), math.rad(0)), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(7 + 5 * math.sin(sine / 40)), math.rad(-4), math.rad(43)), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5 + 0.07 * math.sin(sine / 40), 0) * angles(math.rad(-13), math.rad(0 + 7 * math.cos(sine / 40)), math.rad(14 + 3.2 * math.cos(sine / 40))), 0.1)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5 + 0.07 * math.sin(sine / 40), 0) * angles(math.rad(-3), math.rad(0 - 7 * math.cos(sine / 40)), math.rad(-14 - 3.2 * math.cos(sine / 40))), 0.1)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1.03 + 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(0), math.rad(25), math.rad(-4)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.1 * math.cos(sine / 40), 0) * CFrame.Angles(math.rad(-14), math.rad(-9), math.rad(7)), 0.1)
			end
		elseif torvel > 2 and torvel < 25 and hitfloor ~= nil then
			Anim = "Walk"
			change = 0.76
			if attack == false and equip == false then
				Humanoid.CameraOffset = Vector3.new(0, 0, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 + 0.23 * math.cos(sine / 3.5), -0.3) * angles(math.rad(-7 + 3 * math.cos(sine / 3.5)), math.rad(0 + 4 * math.cos(sine / 7)), math.rad(0) + RootPart.RotVelocity.Y / 46), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(0 - 6 * math.cos(sine / 3.5)), math.rad(0), math.rad(0) + RootPart.RotVelocity.Y / 13), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0 + 0.34 * math.sin(sine / 7)) * angles(math.rad(0 - 44 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / -34, math.rad(0), math.rad(5 + 14 * math.sin(sine / 7)) - RootPart.RotVelocity.Y / 34), 0.1)
				LW.C0 = clerp(LW.C0, CFrame.new(-1.5, 0.5, 0 - 0.34 * math.sin(sine / 7)) * angles(math.rad(0 + 44 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / 34, math.rad(0), math.rad(-5 + 14 * math.sin(sine / 7)) + RootPart.RotVelocity.Y / -34), 0.1)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.22 * math.cos(sine / 7), 0 + 0.22 * math.sin(sine / 7)) * CFrame.Angles(math.rad(0 - 65 * math.sin(sine / 7)), math.rad(3), math.rad(0)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.22 * math.cos(sine / 7), 0 - 0.22 * math.sin(sine / 7)) * CFrame.Angles(math.rad(0 + 65 * math.sin(sine / 7)), math.rad(-3), math.rad(0)), 0.1)
			end
			if attack == true and noleg == false then
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.12 * math.cos(sine / 18), 0 + 0.22 * math.sin(sine / 18)) * CFrame.Angles(math.rad(0 - 30 * math.sin(sine / 18)), math.rad(3), math.rad(0)), 0.1)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.12 * math.cos(sine / 18), 0 - 0.22 * math.sin(sine / 18)) * CFrame.Angles(math.rad(0 + 30 * math.sin(sine / 18)), math.rad(-3), math.rad(0)), 0.1)
			end
		elseif torvel >= 25 and hitfloor ~= nil then
			Anim = "Run"
			if df == false then
				change = 1
			end
			if df == true then
				change = 1.35
			end
			if attack == false and equip == false then
				Humanoid.CameraOffset = Vector3.new(0, 0, 0)
				Torso.Weld.C0 = clerp(Torso.Weld.C0, CFrame.new(0, -1 - 0.42 * math.cos(sine / 2.5), -0.8) * angles(math.rad(-27), math.rad(0), math.rad(0) + RootPart.RotVelocity.Y / 26), 0.1)
				Torso.Neck.C0 = clerp(Torso.Neck.C0, necko * angles(math.rad(-13 + 20 * math.sin(sine / 2.5)), math.rad(0), math.rad(0 + 5 * math.sin(sine / 5)) + RootPart.RotVelocity.Y / 13), 0.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0 + 0.34 * math.sin(sine / 5)) * angles(math.rad(0 - 80 * math.sin(sine / 5)), math.rad(0), math.rad(10 + 18 * math.sin(sine / 5))), 0.15)
				LW.C0 = clerp(LW.C0, cf(-1.5, 0.5, 0 - 0.34 * math.sin(sine / 5)) * angles(math.rad(0 + 80 * math.sin(sine / 5)), math.rad(0), math.rad(-10 + 18 * math.sin(sine / 5))), 0.15)
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.24 * math.cos(sine / 5), 0 + 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 - 85 * math.sin(sine / 5)), math.rad(3), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.24 * math.cos(sine / 5), 0 - 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 + 85 * math.sin(sine / 5)), math.rad(-3), math.rad(0)), 0.2)
			end
			if attack == true and noleg == false then
				LeftLeg.Weld.C0 = clerp(LeftLeg.Weld.C0, CFrame.new(-0.5, -1 - 0.24 * math.cos(sine / 5), 0 + 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 - 65 * math.sin(sine / 5)), math.rad(3), math.rad(0)), 0.2)
				RightLeg.Weld.C0 = clerp(RightLeg.Weld.C0, CFrame.new(0.5, -1 + 0.24 * math.cos(sine / 5), 0 - 0.32 * math.sin(sine / 5)) * CFrame.Angles(math.rad(0 + 65 * math.sin(sine / 5)), math.rad(-3), math.rad(0)), 0.2)
			end
		end
	end
	if 0 < #Effects then
		for e = 1, #Effects do
			if Effects[e] ~= nil then
				local Thing = Effects[e]
				if Thing ~= nil then
					local Part = Thing[1]
					local Mode = Thing[2]
					local Delay = Thing[3]
					local IncX = Thing[4]
					local IncY = Thing[5]
					local IncZ = Thing[6]
					if Thing[2] == "Shoot" then
						local Look = Thing[1]
						local move = 30
						if Thing[8] == 3 then
							move = 10
						end
						local hit, pos = rayCast(Thing[4], Thing[1], move, m)
						if Thing[10] ~= nil then
							da = pos
							cf2 = CFrame.new(Thing[4], Thing[10].Position)
							cfa = CFrame.new(Thing[4], pos)
							tehCF = cfa:lerp(cf2, 0.2)
							Thing[1] = tehCF.lookVector
						end
						local mag = (Thing[4] - pos).magnitude
						Effects.Head.Create(Torso.BrickColor, CFrame.new((Thing[4] + pos) / 2, pos) * CFrame.Angles(1.57, 0, 0), 1, mag * 5, 1, 0.5, 0, 0.5, 0.2)
						if Thing[8] == 2 then
							Effects.Ring.Create(Torso.BrickColor, CFrame.new((Thing[4] + pos) / 2, pos) * CFrame.Angles(1.57, 0, 0) * CFrame.fromEulerAnglesXYZ(1.57, 0, 0), 1, 1, 0.1, 0.5, 0.5, 0.1, 0.1, 1)
						end
						Thing[4] = Thing[4] + Look * move
						Thing[3] = Thing[3] - 1
						if 2 < Thing[5] then
							Thing[5] = Thing[5] - 0.3
							Thing[6] = Thing[6] - 0.3
						end
						if hit ~= nil then
							Thing[3] = 0
							if Thing[8] == 1 or Thing[8] == 3 then
								Damage(hit, hit, Thing[5], Thing[6], Thing[7], "Normal", RootPart, 0, "", 1)
							elseif Thing[8] == 2 then
								Damage(hit, hit, Thing[5], Thing[6], Thing[7], "Normal", RootPart, 0, "", 1)
								if hit.Parent:findFirstChild("Humanoid") ~= nil or hit.Parent.Parent:findFirstChild("Humanoid") ~= nil then
									ref = CFuncs.Part.Create(workspace, "Neon", 0, 1, BrickColor.new("Really red"), "Reference", Vector3.new())
									ref.Anchored = true
									ref.CFrame = CFrame.new(pos)
									CFuncs.Sound.Create("161006093", ref, 1, 1.2)
									game:GetService("Debris"):AddItem(ref, 0.2)
									Effects.Block.Create(Torso.BrickColor, CFrame.new(ref.Position) * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 1, 1, 10, 10, 10, 0.1, 2)
									Effects.Ring.Create(BrickColor.new("Bright yellow"), CFrame.new(ref.Position) * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)), 1, 1, 0.1, 4, 4, 0.1, 0.1)
									MagnitudeDamage(ref, 15, Thing[5] / 1.5, Thing[6] / 1.5, 0, "Normal", "", 1)
								end
							end
							ref = CFuncs.Part.Create(workspace, "Neon", 0, 1, BrickColor.new("Really red"), "Reference", Vector3.new())
							ref.Anchored = true
							ref.CFrame = CFrame.new(pos)
							Effects.Sphere.Create(Torso.BrickColor, CFrame.new(pos), 5, 5, 5, 1, 1, 1, 0.07)
							game:GetService("Debris"):AddItem(ref, 1)
						end
						if Thing[3] <= 0 then
							table.remove(Effects, e)
						end
					end
					if Thing[2] == "FireWave" then
						if Thing[3] <= Thing[4] then
							Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(0, 1, 0)
							Thing[3] = Thing[3] + 1
							Thing[6].Scale = Thing[6].Scale + Vector3.new(Thing[5], 0, Thing[5])
						else
							Part.Parent = nil
							table.remove(Effects, e)
						end
					end
					if Thing[2] ~= "Shoot" and Thing[2] ~= "Wave" and Thing[2] ~= "FireWave" then
						if Thing[1].Transparency <= 1 then
							if Thing[2] == "Block1" then
								Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
								Mesh = Thing[7]
								Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Block2" then
								Thing[1].CFrame = Thing[1].CFrame
								Mesh = Thing[7]
								Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Fire" then
								Thing[1].CFrame = CFrame.new(Thing[1].Position) + Vector3.new(0, 0.2, 0)
								Thing[1].CFrame = Thing[1].CFrame * CFrame.fromEulerAnglesXYZ(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Cylinder" then
								Mesh = Thing[7]
								Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Blood" then
								Mesh = Thing[7]
								Thing[1].CFrame = Thing[1].CFrame * CFrame.new(0, 0.5, 0)
								Mesh.Scale = Mesh.Scale + Vector3.new(Thing[4], Thing[5], Thing[6])
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Elec" then
								Mesh = Thing[10]
								Mesh.Scale = Mesh.Scale + Vector3.new(Thing[7], Thing[8], Thing[9])
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Disappear" then
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
							elseif Thing[2] == "Shatter" then
								Thing[1].Transparency = Thing[1].Transparency + Thing[3]
								Thing[4] = Thing[4] * CFrame.new(0, Thing[7], 0)
								Thing[1].CFrame = Thing[4] * CFrame.fromEulerAnglesXYZ(Thing[6], 0, 0)
								Thing[6] = Thing[6] + Thing[5]
							end
						else
							Part.Parent = nil
							table.remove(Effects, e)
						end
					end
				end
			end
		end
	end
end