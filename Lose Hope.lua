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

lplr = game.Players.LocalPlayer
Player = lplr
Character = Player.Character
Mouse = lplr:GetMouse()

spawn(function()
Character.Parent = workspace

local TS = game:GetService("TweenService")
local PS = game:GetService("PhysicsService")
PlayerGui = Player.PlayerGui
Backpack = Player.Backpack
Humanoid = Character:FindFirstChildOfClass("Humanoid")
RootPart = Character["HumanoidRootPart"]



ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = 1/60
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
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


function Swait(num)
if num == 0 or num == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 1, num do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end


end)
--//CR//--
wait(0.2)









local Humanoid = Character.Humanoid
local LeftArm = Character["Left Arm"]
local RightArm = Character["Right Arm"]
local LeftLeg = Character["Left Leg"]
local RightLeg = Character["Right Leg"]
local Head = Character.Head
local Torso = Character.Torso
local Camera = game.Workspace.CurrentCamera
local RootPart = Character.HumanoidRootPart
local RootJoint = RootPart.RootJoint
local Neck = Torso["Neck"]
local RightShoulder = Torso["Right Shoulder"]
local LeftShoulder = Torso["Left Shoulder"]
local RightHip = Torso["Right Hip"]
local LeftHip = Torso["Left Hip"]
local attack = false
local Anim = 'Idle'
local attacktype = 1
local delays = false
local play = true
local targetted = nil
local Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude 
local velocity = RootPart.Velocity.y
local sine = 0
local change = 1
local doe = 0


local Create = LoadLibrary("RbxUtility").Create
local Effects = Instance.new("Folder", Character)
Effects.Name = "Effects"
local walkspeed = 36
Humanoid.WalkSpeed = walkspeed
local function FindHumanoid(Part)local humanoid=nil if Part.Parent then if Part.Parent~=Player.Character and Part.Parent:FindFirstChildOfClass("Humanoid")~=nil then humanoid=Part.Parent:FindFirstChildOfClass("Humanoid")else if Part.Parent.Parent then if Part.Parent.Parent:FindFirstChildOfClass("Humanoid")and Part.Parent.Parent~=Player.Character then humanoid=Part.Parent.Parent:FindFirstChildOfClass("Humanoid")end end end end if humanoid==Humanoid then humanoid=nil end return humanoid end
Humanoid.Animator.Parent = nil
Character.Animate.Parent = nil
local rc0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180))
local nc0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180))
local rscp = CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
local lscp = CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))

function QFCF(cf)
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
 
function QTCF(px, py, pz, x, y, z, w)
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
 
function QS(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = math.acos(cosTheta)
			local invSinTheta = 1 / math.sin(theta)
			startInterp = math.sin((1 - t) * theta) * invSinTheta
			finishInterp = math.sin(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = math.acos(-cosTheta)
			local invSinTheta = 1 / math.sin(theta)
			startInterp = math.sin((t - 1) * theta) * invSinTheta
			finishInterp = math.sin(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QFCF(a)}
	local qb = {QFCF(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QTCF(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QS(qa, qb, t))
end

ArtificialHB = Create("BindableEvent", script){
	Parent = script,
	Name = "Heartbeat",
}

script:WaitForChild("Heartbeat")

frame = 1 / 30
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

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = Instance.new(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end	

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = Instance.new(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or Vector3.new(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = Instance.new("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BrickColor.new(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

local S = Instance.new("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "rbxassetid://"..ID
		NEWSOUND.PlayOnRemove = true
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
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

for i = 1, 20 do
	local FACE = CreatePart(3, Head, "Fabric", 0, 0+(i-5)/10.2, "Dark stone grey", "FaceGradient", Vector3.new(1.01,0.65,1.01),false)
	FACE.Color = Color3.new(0,0,0)
	Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FACE
	CreateWeldOrSnapOrMotor("Weld", Head, Head, FACE, CFrame.new(0,0.25-(i-0.55)/40,0), CFrame.new(0, 0, 0))
end

local GUN = Instance.new("Part", workspace)
GUN.Size = Vector3.new(1.897, 2.038, 6.71)
GUN.BrickColor = BrickColor.new('Cocoa')
GUN.Parent = Character
GUN.CanCollide = false
local GUNMESH = Instance.new("SpecialMesh", GUN)
GUNMESH.MeshId = "rbxassetid://1485890441"
GUNMESH.Scale = Vector3.new(0.01, 0.01, 0.01)
GUNMESH.Offset = Vector3.new(0, 0.6, -1.25)
for _, c in pairs(GUN:GetChildren()) do
	if c:IsA("BasePart") then
		c.Anchored = false
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		if c ~= GUN then
			weldBetween(GUN,c)
		end
		c.Locked = true
	end
end
local GunJoint = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, GUN, CFrame.new(0,-1,0), CFrame.new(0, 0, 0))
local Hole = GUN

function rayCast(Position, Direction, Range, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Position, Direction.unit * (Range or 999.999)), Ignore) 
end 

function dmg(dude)

end

function mdmg(Part,Magnitude)

end

function Effect(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or Vector3.new(1,1,1))
	local ENDSIZE = (Table.Size2 or Vector3.new(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or Color3.new(1,1,1))
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
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BrickColor.new("Pearl"), "Effect", Vector3.new(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, Vector3.new(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = Instance.new("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, Vector3.new(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", Vector3.new(SIZE.X,SIZE.X,0.1), Vector3.new(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", Vector3.new(SIZE.X/10,0,SIZE.X/10), Vector3.new(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", Vector3.new(SIZE.X/10,0,SIZE.X/10), Vector3.new(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, Vector3.new(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, Vector3.new(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, Vector3.new(0,0,0))
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
				EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					swait()
					MSH.Scale = MSH.Scale - (Vector3.new((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vector3.new(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*CFrame.Angles(math.rad(ROTATION1),math.rad(ROTATION2),math.rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CFrame.new(EFFECT.Position,MOVEDIRECTION)*CFrame.new(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.Orientation = ORI
					end
				end
			else
				for LOOP = 1, TIME+1 do
					swait()
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vector3.new(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*CFrame.Angles(math.rad(ROTATION1),math.rad(ROTATION2),math.rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CFrame.new(EFFECT.Position,MOVEDIRECTION)*CFrame.new(0,0,-MOVESPEED)
						EFFECT.Orientation = ORI
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

function Lightning(Part0, Part1, Times, Offset, Color, Timer, sSize, eSize, Trans, Boomer, sBoomer)
  local magz = (Part0 - Part1).magnitude
  local curpos = Part0
  local trz = {
    -Offset,
    Offset
  }
  for i = 1, Times do
    local li = Instance.new("Part", Effects)
    li.Name = "Lightning"
    li.TopSurface = 0
    li.Material = "Neon"
    li.BottomSurface = 0
    li.Anchored = true
    li.Locked = true
    li.Transparency = 0
    li.BrickColor = Color
    li.formFactor = "Custom"
    li.CanCollide = false
    li.Size = Vector3.new(0.1, 0.1, magz / Times)
    local Offzet = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
    local trolpos = CFrame.new(curpos, Part1) * CFrame.new(0, 0, magz / Times).p + Offzet
    if Times == i then
      local magz2 = (curpos - Part1).magnitude
      li.Size = Vector3.new(0.1, 0.1, magz2)
      li.CFrame = CFrame.new(curpos, Part1) * CFrame.new(0, 0, -magz2 / 2)
    else
      li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / Times / 2)
    end
    curpos = li.CFrame * CFrame.new(0, 0, magz / Times / 2).p
    li:Destroy()
	Effect({Time = Timer, EffectType = "Box", Size = Vector3.new(sSize,sSize,li.Size.Z), Size2 = Vector3.new(eSize,eSize,li.Size.Z), Transparency = Trans, Transparency2 = 1, CFrame = li.CFrame, MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = li.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = Boomer, Boomerang = 0, SizeBoomerang = sBoomer})
  end
end

function SHAKECAM(POSITION,RANGE,INTENSITY,TIME)

end

function FireArc(Part,ToLocation,AmountOfTime,Height,DoesCourontine)
    if DoesCourontine == false then
        local Direction = CFrame.new(Part.Position,ToLocation)
        local Distance = (Part.Position - ToLocation).magnitude
        for i = 1, AmountOfTime do
            swait()
            Part.CFrame = Direction*CFrame.new(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
            Direction = Part.CFrame
        end
    elseif DoesCourontine == true then
        coroutine.resume(coroutine.create(function()
            local Direction = CFrame.new(Part.Position,ToLocation)
            local Distance = (Part.Position - ToLocation).magnitude
            for i = 1, AmountOfTime do
                swait()
                Part.CFrame = Direction*CFrame.new(0,(AmountOfTime/200)+((AmountOfTime/Height)-((i*2)/Height)),-Distance/AmountOfTime)
                Direction = Part.CFrame
            end
        end))
    end
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = Instance.new("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = Instance.new("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = Instance.new("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function AttackGyro()
	local GYRO = Instance.new("BodyGyro",RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = Vector3.new(0,4000000,0)
	GYRO.CFrame = CFrame.new(RootPart.Position,Mouse.Hit.p)
	coroutine.resume(coroutine.create(function()
		repeat
			swait()
			GYRO.CFrame = CFrame.new(RootPart.Position,Mouse.Hit.p)
		until attack == false
		GYRO:Remove()
	end))
end

function chatfunc(text)
local chat = coroutine.wrap(function()
if Character:FindFirstChild("TalkingBillBoard")~= nil then
Character:FindFirstChild("TalkingBillBoard"):destroy()
end
local naeeym2 = Instance.new("BillboardGui",Character)
naeeym2.Size = UDim2.new(0,100,0,40)
naeeym2.StudsOffset = Vector3.new(0,3,0)
naeeym2.Adornee = Character.Head
naeeym2.Name = "TalkingBillBoard"
local tecks2 = Instance.new("TextLabel",naeeym2)
tecks2.BackgroundTransparency = 1
tecks2.BorderSizePixel = 0
tecks2.Text = ""
tecks2.Font = "Code"
tecks2.TextSize = 40
tecks2.TextStrokeTransparency = 0
tecks2.TextColor3 = Color3.new(.50,.30,.10)
tecks2.TextStrokeColor3 = Color3.new(0,0,0)
tecks2.Size = UDim2.new(1,0,0.5,0)
local tecks3 = Instance.new("TextLabel",naeeym2)
tecks3.BackgroundTransparency = 1
tecks3.BorderSizePixel = 0
tecks3.Text = ""
tecks3.Font = "Code"
tecks3.TextSize = 40
tecks3.TextStrokeTransparency = 0
tecks3.TextColor3 = Color3.new(.70,.50,.30)
tecks3.TextStrokeColor3 = Color3.new(0,0,0)
tecks3.Size = UDim2.new(1,0,0.5,0)
coroutine.resume(coroutine.create(function()
while naeeym2 ~= nil do
swait()
tecks2.Position = UDim2.new(math.random(-.5,.5),math.random(-5,5),.02,math.random(-5,5)) 
tecks3.Position = UDim2.new(math.random(-.5,.5),math.random(-5,5),.02,math.random(-5,5)) 
tecks2.Rotation = tecks2.Rotation + math.random(-0.5,0.5)
tecks3.Rotation = tecks3.Rotation + math.random(-0.5,0.5)
end
end))
for i = 1,string.len(text),1 do
CreateSound(565939471, Head, 5, 0.65)
tecks2.Text = string.sub(text,1,i)
tecks3.Text = string.sub(text,1,i)
wait(0.015)
end
wait(2)
for i = 1, 50 do
swait()
tecks2.Position = tecks2.Position - UDim2.new(math.random(-.5,.5),math.random(-5,5),.05,math.random(-5,5))
tecks3.Position = tecks2.Position - UDim2.new(math.random(-.5,.5),math.random(-5,5),.05,math.random(-5,5))
tecks2.Rotation = tecks2.Rotation + math.random(-2,2)
tecks3.Rotation = tecks3.Rotation + math.random(-2,2)
tecks2.TextStrokeTransparency = tecks2.TextStrokeTransparency +.02
tecks2.TextTransparency = tecks2.TextStrokeTransparency +.02
tecks3.TextStrokeTransparency = tecks3.TextStrokeTransparency +.02
tecks3.TextTransparency = tecks3.TextStrokeTransparency +.02
end
naeeym2:Destroy()
end)
chat()
end
function onChatted(msg)
chatfunc(msg)
end
Player.Chatted:connect(onChatted)

abss = Instance.new("BillboardGui",Character)
abss.Size = UDim2.new(10,0,10,0)
abss.Enabled = false
imgl = Instance.new("ImageLabel",abss)
imgl.Position = UDim2.new(0,0,0,0)
imgl.Size = UDim2.new(1,0,1,0)
imgl.Image = "rbxassetid://1490455495"
imgl.BackgroundTransparency = 1
imgl.ImageColor3 = Color3.new(.9,0,0)
img2 = Instance.new("ImageLabel",abss)
img2.Position = UDim2.new(0,0,0,0)
img2.Size = UDim2.new(1,0,1,0)
img2.Image = "rbxassetid://1490455495"
img2.BackgroundTransparency = 1
img2.ImageColor3 = Color3.new(.9,0,0)


function attackone()
	attack = true
	walkspeed = 24
	if targetted then
	local GYRO = Instance.new("BodyGyro",RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = Vector3.new(0,4000000,0)
	GYRO.CFrame = CFrame.new(RootPart.Position,targetted.Head.Position)
	for i = 0, 0.5, 0.05 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-30)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	local Torsy = targetted:FindFirstChild("Torso") or targetted:FindFirstChild("UpperTorso")
	if Torsy then
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 642890855, SoundPitch = 0.45, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Lightning(Hole.Position,Torsy.Position,15,3.5,BrickColor.new("Really black"),math.random(15,35),1,3,0,true,55) Lightning(Hole.Position,Torsy.Position,15,3.5,BrickColor.new("Really red"),math.random(5,35),1,3,0,true,55)
	for i = 0, 2 do
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Torsy.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 192410089, SoundPitch = .55, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Torsy.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	for i = 0, 2 do
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Torsy.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Torsy.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	end
	dmg(targetted)
	SHAKECAM(Hole.Position,43,23,23)
	SHAKECAM(Torsy.Position,31,15,15)
	end
	for i = 0, 0.5, 0.075 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(60)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-60)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(160), math.rad(-20), math.rad(60)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	GYRO:Remove()
	else
	AttackGyro()
	for i = 0, 0.5, 0.05 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-30)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 642890855, SoundPitch = 0.45, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Lightning(Hole.Position,Mouse.Hit.p,15,3.5,BrickColor.new("Really black"),math.random(15,35),1,3,0,true,55) Lightning(Hole.Position,Mouse.Hit.p,15,3.5,BrickColor.new("Really red"),math.random(15,35),1,3,0,true,55)
	for i = 0, 2 do
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Mouse.Hit, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 192410089, SoundPitch = .55, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Mouse.Hit, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	for i = 0, 2 do
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Mouse.Hit*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
    end
	mdmg(Mouse.Hit.p,9)
	SHAKECAM(Hole.Position,43,23,23)
	SHAKECAM(Mouse.Hit.p,31,15,15)
	for i = 0, 0.5, 0.075 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(60)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(-60)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(160), math.rad(-20), math.rad(60)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	end
	walkspeed = 36
	attack = false
end

function attacktwo()
	attack = true
	walkspeed = 12
	AttackGyro()
    local gBullet = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "BullyFuck", Vector3.new(0,0,0))
    MakeForm(gBullet,"Ball")
    gBullet.CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0)
	CreateSound(2785493,gBullet,2,0.8)
	for i = 0, 1.25, 0.025 do
		swait()
		SHAKECAM(gBullet.Position,23,17,17)
		Effect({Time = math.random(35,55), EffectType = "Sphere", Size = Vector3.new(0.5,0.5,0.5), Size2 = Vector3.new(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0), MoveToPos = LeftArm.CFrame*CFrame.new(0,-1.5,0)*CFrame.new(math.random(-10,10),math.random(-10,10),math.random(-10,10)).p, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 50, SizeBoomerang = 50})
		gBullet.Size = gBullet.Size * 1.085
        gBullet.CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0)
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5), math.rad(0), math.rad(-30)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(30)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(30)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(85 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(-30 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	local bullets = {}
	for i = 1, math.random(27,41) do
		swait()
		local Bullet = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "BulletFuck", Vector3.new(0.6,0.6,0.6))
    	MakeForm(Bullet,"Ball")
		Bullet.CFrame = gBullet.CFrame
		Effect({Time = math.random(5,20), EffectType = "Sphere", Size = Vector3.new(3,3,3)*math.random(-3,2), Size2 = Vector3.new(6,6,6)*math.random(-3,2), Transparency = 0.4, Transparency2 = 1, CFrame = Bullet.CFrame, MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 25})
		SHAKECAM(Bullet.Position,11,5,5)
		table.insert(bullets, Bullet)
	end
	for b = 1, #bullets do
		swait(.25)
		local part, pos = rayCast(LeftArm.CFrame*CFrame.new(0,-1.5,0).p,((Mouse.Hit.p+Vector3.new(math.random(-15,15),math.random(-7,7),math.random(-15,15))) - LeftArm.CFrame*CFrame.new(0,-1.5,0).p),500,Character)
		coroutine.resume(coroutine.create(function()
		FireArc(bullets[b],pos,math.random(17,31),math.random(9,15),false)
		Effect({Time = math.random(25,35), EffectType = "Sphere", Size = Vector3.new(0.6,0.6,0.6), Size2 = Vector3.new(1.6,1.6,1.6), Transparency = 0, Transparency2 = 1, CFrame = bullets[b].CFrame, MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 25})
		swait(math.random(55,65))
		for i = 1, 3 do
			Effect({Time = math.random(45,65), EffectType = "Sphere", Size = Vector3.new(0.6,6,0.6)*math.random(-1.05,1.25), Size2 = Vector3.new(1.6,10,1.6)*math.random(-1.05,1.25), Transparency = 0, Transparency2 = 1, CFrame = bullets[b].CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 20, SizeBoomerang = 35})
		end
		for i = 0, 10 do
		swait()
		bullets[b].Transparency = bullets[b].Transparency + 0.1
		end
		mdmg(bullets[b].Position,5)
		SHAKECAM(bullets[b].Position,29,11,11)
		CreateSound(168513088,bullets[b],3.5,1.1,false)
		bullets[b]:Destroy()
		end))
	end
	for i = 0, 10 do
	swait()
	gBullet.Transparency = gBullet.Transparency + 0.1
	end
	gBullet:Destroy()
	walkspeed = 36
	attack = false
end

local Grabbed = false
function hedshoot()
	attack = true
	walkspeed = 26
	CreateSound(235097614, RootPart, 6, 1.5, false)
	for i = 0, 0.5, 0.05 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-60)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(60)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-60)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 642890855, SoundPitch = 0.45, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(25,45), EffectType = "Sphere", Size = Vector3.new(2,100,2), Size2 = Vector3.new(6,100,6), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CFrame.new(math.random(-1,1),math.random(-1,1),-50)*CFrame.Angles(math.rad(math.random(89,91)),math.rad(math.random(-1,1)),math.rad(math.random(-1,1))), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 45})
	Effect({Time = math.random(25,45), EffectType = "Sphere", Size = Vector3.new(3,100,3), Size2 = Vector3.new(9,100,9), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CFrame.new(math.random(-1,1),math.random(-1,1),-50)*CFrame.Angles(math.rad(math.random(89,91)),math.rad(math.random(-1,1)),math.rad(math.random(-1,1))), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 45})
	mdmg(RootPart.Position,14)
	SHAKECAM(RootPart.Position,14,11,18)
	for i = 1, 4 do
		RootPart.CFrame = RootPart.CFrame * CFrame.new(0,0,-25)
		mdmg(RootPart.Position,14)
		SHAKECAM(RootPart.Position,14,11,18)
		Lightning(RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).p,RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).p,6,25,BrickColor.new("Really black"),math.random(30,45),0.5,1.5,0,true,60) Lightning(RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).p,RootPart.CFrame*CFrame.new(math.random(-2.5,2.5),math.random(-5,5),math.random(-15,15)).p,6,25,BrickColor.new("Really red"),math.random(30,45),0.5,1.5,0,true,60)
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	for i = 0, 0.5, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-90)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(75), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-65), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	attack = false
	walkspeed = 36
end

function moarblood()
	attack = true
	walkspeed = 22
	if targetted then
	local h=targetted:FindFirstChild("Humanoid")
	if h then
	local torsy = h.Parent:FindFirstChild("Head")or h.Parent:FindFirstChild("HumanoidRootPart")or h.Parent:FindFirstChild("Torso")or h.Parent:FindFirstChild("UpperToso")
	if torsy then
	local GYRO = Instance.new("BodyGyro",RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = Vector3.new(0,4000000,0)
	GYRO.CFrame = CFrame.new(RootPart.Position,targetted.Head.Position)
	for i = 0, 0.75, 0.075 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5), math.rad(0), math.rad(-30)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(30)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(30)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(85 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(-30 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 199978087, SoundPitch = 0.65, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Lightning(LeftArm.CFrame*CFrame.new(0,-1.5,0).p,targetted.Head.Position,7,1.75,BrickColor.new("Really black"),math.random(15,35),0.5,1.5,0,true,55) Lightning(LeftArm.CFrame*CFrame.new(0,-1.5,0).p,targetted.Head.Position,7,1.75,BrickColor.new("Really red"),math.random(15,35),0.5,1.5,0,true,55)
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = targetted.Head.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = targetted.Head.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	SHAKECAM(LeftArm.Position,35,19,25)
	SHAKECAM(torsy.Position,27,23,14)
	dmg(targetted)
	for i = 0, 0.75, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5), math.rad(0), math.rad(-20)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(20)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(20)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(115 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(-20 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	GYRO:Remove()
	end
	end
	else
	if Mouse.Target ~= nil then
	local h=FindHumanoid(Mouse.Target)
	if h then
	local torsy = h.Parent:FindFirstChild("Head")or h.Parent:FindFirstChild("HumanoidRootPart")or h.Parent:FindFirstChild("Torso")or h.Parent:FindFirstChild("UpperToso")
	if torsy and 100 >= (torsy.Position - RootPart.Position).Magnitude then
	local GYRO = Instance.new("BodyGyro",RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = Vector3.new(0,4000000,0)
	GYRO.CFrame = CFrame.new(RootPart.Position,h.Parent.Head.Position)
	for i = 0, 0.75, 0.075 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5), math.rad(0), math.rad(-30)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(30)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(30)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(85 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(-30 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 199978087, SoundPitch = 0.65, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = LeftArm.CFrame*CFrame.new(0,-1.5,0), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Lightning(LeftArm.CFrame*CFrame.new(0,-1.5,0).p,h.Parent.Head.Position,7,1.75,BrickColor.new("Really black"),math.random(15,35),0.5,1.5,0,true,55) Lightning(LeftArm.CFrame*CFrame.new(0,-1.5,0).p,h.Parent.Head.Position,7,1.75,BrickColor.new("Really red"),math.random(15,35),0.5,1.5,0,true,55)
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = h.Parent.Head.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = h.Parent.Head.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	SHAKECAM(LeftArm.Position,35,19,25)
	SHAKECAM(torsy.Position,27,23,14)
	dmg(h.Parent)
	for i = 0, 0.75, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(5), math.rad(0), math.rad(-20)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-5 - 3 * math.cos(sine / 12)), math.rad(0), math.rad(20)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-62.5), math.rad(0 - 5 * math.cos(sine / 12)), math.rad(20)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(115 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(-20 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.075 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	GYRO:Remove()
	end
	end
	end
	end
	attack = false
	walkspeed = 36
end

function painlessrain()
attack = true
    walkspeed = 18
	coroutine.wrap(function()
	for i = 0, 2 do
	wait(.2)
	CreateSound(199145095, GUN, 6, 1)
	end
	end)()
	for i = 0, 2, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-10)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(25), math.rad(0), math.rad(-20)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(35), math.rad(-35), math.rad(20)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-20), math.rad(-5), math.rad(-10)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(doe * 22), math.rad(0), math.rad(0)), 1 / 2)
	end
	for i = 0, 1.5, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(175), math.rad(-10), math.rad(10)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-10), math.rad(-10), math.rad(-5)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	local Hole2 = Hole.CFrame*CFrame.new(-600,0,0)
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = 642890855, SoundPitch = 0.45, SoundVolume = 6, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame, MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
	Lightning(Hole.Position,Hole2.p,15,3.5,BrickColor.new("Really black"),math.random(15,35),1,3,0,true,55) Lightning(Hole.Position,Hole2.p,15,3.5,BrickColor.new("Really red"),math.random(15,35),1,3,0,true,55)
	for i = 0, 2 do
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.4,0,0.4), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
	end
	SHAKECAM(Hole.Position,43,23,23)
	for i = 0, .5, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(225), math.rad(-20), math.rad(20)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-5), math.rad(-5), math.rad(0)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	for i = 0, .5, 0.1 do
		swait()
		RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)), 1 / 3)
		Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-5)), 1 / 3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(175), math.rad(-10), math.rad(10)) * rscp, 1 / 3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(-5), math.rad(-5), math.rad(0)) * lscp, 1 / 3)
		RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(-5), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
		LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
		GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
	end
	attack = false
	walkspeed = 36
	wait(.6)
	for i = 1, 75 do
		local Sky = RootPart.CFrame*CFrame.new(0,600,0)
		local MoPos = Mouse.Hit*CFrame.new(math.random(-18,18),0,math.random(-18,18)).p
		local DISTANCE = (Sky.p - MoPos).Magnitude
		Lightning(Sky.p,MoPos,35,7,BrickColor.new("Bright violet"),math.random(15,35),2,4,0,true,55)
		Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(1,1,DISTANCE), Size2 = Vector3.new(2,2,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CFrame.new(Sky.p, MoPos) * CFrame.new(0, 0, -DISTANCE / 2), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
		Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = CFrame.new(MoPos), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = BrickColor.new("Bright violet").Color, SoundID = 192410089, SoundPitch = .55, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
		Effect({Time = math.random(15,35), EffectType = "Box", Size = Vector3.new(2,2,2), Size2 = Vector3.new(5,5,5), Transparency = 0, Transparency2 = 1, CFrame = CFrame.new(MoPos), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 50})
		local a = math.random(1,2)
		if a == 1 then
		Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.3,0,0.3), Transparency = 0, Transparency2 = 1, CFrame = CFrame.new(MoPos)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = BrickColor.new("Bright violet").Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
		else
		Effect({Time = math.random(25,50), EffectType = "Round Slash", Size = Vector3.new(0.1,0.1,0.1), Size2 = Vector3.new(0.3,0,0.3), Transparency = 0, Transparency2 = 1, CFrame = CFrame.new(MoPos)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 15})
		end
		mdmg(MoPos,12)
		SHAKECAM(MoPos,27,11,11)
		swait(5)
	end
end

function TargetSelect(person)
local dd=coroutine.wrap(function()
if targetted ~= person then
targetted = person
img2.Size = UDim2.new(1,0,1,0)
img2.ImageTransparency = 0
img2.Position = UDim2.new(0,0,0,0)
for i = 0, 7, 0.35 do
swait()
img2.Size = img2.Size + UDim2.new(.075,0,.075,0)
img2.Position = img2.Position + UDim2.new(-.0375,0,-.0375,0)
img2.ImageTransparency = img2.ImageTransparency + 0.05
end
end
end)
dd()
end

function LockOn()
if Mouse.Target ~= nil then
local h=FindHumanoid(Mouse.Target)
if h then
local torsy = h.Parent:FindFirstChild("Head")or h.Parent:FindFirstChild("HumanoidRootPart")or h.Parent:FindFirstChild("Torso")or h.Parent:FindFirstChild("UpperToso")
if torsy then
TargetSelect(h.Parent)
CreateSound(743521450, Head, 4, .65, false)
Effect({Time = math.random(10,20), EffectType = "Sphere", Size = Vector3.new(1,1,1), Size2 = Vector3.new(0,5,0), Transparency = 0.15, Transparency2 = 1, CFrame = Head.CFrame*CFrame.new(0.2,0.2,-0.55), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0.8,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
Effect({Time = math.random(10,20), EffectType = "Sphere", Size = Vector3.new(1,1,1), Size2 = Vector3.new(0,5,0), Transparency = 0.15, Transparency2 = 1, CFrame = Head.CFrame*CFrame.new(0.2,0.2,-0.55)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(90)), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0.8,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
Effect({Time = math.random(20,40), EffectType = "Sphere", Size = Vector3.new(1,1,1), Size2 = Vector3.new(0,10,0), Transparency = 0.05, Transparency2 = 1, CFrame = Head.CFrame*CFrame.new(0.2,0.2,-0.55)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(-45)), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0.8,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
Effect({Time = math.random(20,40), EffectType = "Sphere", Size = Vector3.new(1,1,1), Size2 = Vector3.new(0,10,0), Transparency = 0.05, Transparency2 = 1, CFrame = Head.CFrame*CFrame.new(0.2,0.2,-0.55)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(45)), MoveToPos = nil, RotationX = math.random(-1,1), RotationY = math.random(-1,1), RotationZ = math.random(-1,1), Material = "Neon", Color = Color3.new(0.8,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
end
end
end
end

function ofmoosic() -- 2 lazi hoh
delays = true
while wait() and kkk and kkk.Volume >= 0.02 do
	kkk.Volume = kkk.Volume - 0.05
end
wait(0.1)
kkk.Pitch = 0
kkk.PlaybackSpeed = 0
kkk.Volume = 0
play = false
delays = false
end
function onmoosic()
delays = true
kkk.Pitch = .6
kkk.PlaybackSpeed = .6
while wait() and kkk and kkk.Volume <= 1.5 do
	kkk.Volume = kkk.Volume + 0.05
end
wait(0.1)
kkk.Volume = 3
play = true
delays = false
end
Mouse.Button1Down:connect(function()
	if attack == false then
		attackone()
	end
end)

Mouse.KeyDown:connect(function(k)
	k = k:lower()
	if attack == false and k == 'q' then
		if targetted == nil then
			LockOn()
		else
			targetted = nil
		end
	end
	if k == 'z' and attack == false then	
	hedshoot()
	elseif k == 'x' and attack == false then
	moarblood()
	elseif k == 'c' and attack == false then
	painlessrain()
	elseif k == 'v' and attack == false then
	attacktwo()
    elseif k == 'm' and play == true then
	ofmoosic()
	elseif k == 'm' and play == false then
	onmoosic()
	end
end)




local ActualVelocity = Vector3.new(0,0,0)

spawn(function()
local bb=Instance.new("BillboardGui", Head )bb.AlwaysOnTop=true bb.Size=UDim2.new(1,0,1,0)bb.StudsOffset=Vector3.new(0,4.5,0)
local t2=Instance.new("TextLabel",bb)t2.Size=UDim2.new(1,0,1,0)t2.Text="Lose Hope"t2.TextColor3=Color3.new(.50,.30,.10)t2.TextStrokeTransparency=0
t2.BackgroundTransparency=1 t2.TextSize=40 t2.Font="Code"t2.Rotation = -6
local t=Instance.new("TextLabel",bb)t.Size=UDim2.new(1,0,1,0)t.Text="Lose Hope"t.TextColor3=Color3.new(.70,.50,.30)t.TextStrokeTransparency=0
t.BackgroundTransparency=1 t.TextSize=40 t.Font="Code"t.Rotation = -6
while wait() do
    bb.StudsOffset=Vector3.new(math.random(-30,30)/15,4.5+math.random(-30,30)/15,math.random(-30,30)/15)
	t.Rotation = t.Rotation + math.random(-1,1)
	t2.Rotation = t2.Rotation + math.random(-1.5,1.5)
end
end)

local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
	if c:IsA("BasePart") and c.Name ~= "Handle" then
		if c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and c ~= LeftLeg then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(BODY,{c,c.Parent,c.Material,c.Color,c.Transparency,c.Size,c.Name})
	elseif c:IsA("JointInstance") then
		table.insert(BODY,{c,c.Parent,nil,nil,nil,nil,nil})
	end
end
for e = 1, #BODY do
	if BODY[e] ~= nil then
		do
			local STUFF = BODY[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			if PART.ClassName == "Part" and PART ~= RootPart then
				PART.Material = MATERIAL
				PART.Transparency = TRANSPARENCY
			end
			PART.AncestryChanged:Connect(function()
				PART.Parent = PARENT
			end)
		end
	end
end
function refit()

end

function Parents()

end

Humanoid.Died:connect(function()
  	refit()
	Parents()
	Humanoid.MaxHealth = 500
	Humanoid.Health = 500
	for i,v in pairs(Humanoid:GetChildren()) do
    	for i,p in pairs(v:GetChildren()) do
    		if p.ClassName == "BodyVelocity" or p.ClassName == "BodyGyro" then
    			p:destroy()
            end
        end
    end
end)

local kkktime = 0
local fix = false
coroutine.wrap(function()
while 1 do
swait()
if doe <= 360 then
	doe = doe + 2
else
	doe = 0
end
end
end)()
while true do
	swait()
	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("Part") then
		elseif v:IsA("Accessory") then
		end
	end
while true do
swait()
coroutine.resume(coroutine.create(function()
if math.random(1,13) == 1 then
swait(0.1)
Lightning(Hole.Position,GUN.Position,3,15,BrickColor.new("Really black"),math.random(15,35),0.15,0.25,0,true,55) Lightning(Hole.Position,GUN.Position,3,15,BrickColor.new("Really red"),math.random(15,35),0.15,0.25,0,true,55)
end
end))
script.Disabled = false
if Character:FindFirstChild("Shield") == nil then
Shield = Instance.new ("MeshPart", Character) Shield.Name = "Shield" Shield.CanCollide = false Shield.Transparency = 1 Shield.Material = "Neon" Shield.BrickColor = BrickColor.new("Really red") Shield.Size = Vector3.new(7,7,7) Shield.Massless = true Shield.CFrame = Torso.CFrame
local Wed = Instance.new("Weld", Shield) Wed.Part0 = Shield Wed.Part1 = Torso
end
if Character:FindFirstChild("Shield2") == nil then
Shield2 = Instance.new ("MeshPart", Character) Shield2.Name = "Shield2" Shield2.CanCollide = false Shield2.Transparency = 1 Shield2.Material = "Neon" Shield2.BrickColor = BrickColor.new("Really red") Shield2.Size = Vector3.new(6,6,6) Shield2.Massless = true Shield2.CFrame = Torso.CFrame
local Wed = Instance.new("Weld", Shield2) Wed.Part0 = Shield2 Wed.Part1 = Torso
end
Humanoid:SetStateEnabled("Dead",false)Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)Humanoid:SetStateEnabled("GettingUp",true)Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)Humanoid:SetStateEnabled("Ragdoll",false) Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
for _, c in pairs(Character:GetChildren()) do if c:IsA("BasePart") and c ~= RootPart then c.Anchored = false end end
Humanoid.Name="nil" Humanoid.PlatformStand=false Humanoid.MaxHealth = 500 Humanoid.Health = 500 refit() Parents()
if Character:FindFirstChildOfClass("ForceField")then Character:FindFirstChildOfClass("ForceField").Visible=false else Instance.new("ForceField",Character).Name=""end 
if Player == nil or Humanoid == nil or Character == nil or RootPart == nil or Torso == nil or Head == nil or RightArm == nil or LeftArm == nil or GUN == nil then Humanoid.MaxHealth = 500 
Humanoid.Health = 500 for i,v in pairs(Humanoid:GetChildren()) do for i,p in pairs(v:GetChildren()) do if p.ClassName == "BodyVelocity" or p.ClassName == "BodyGyro" then p:destroy() end end end end
imgl.Rotation = imgl.Rotation + 12
img2.Rotation = img2.Rotation + 32
if targetted ~= nil then
abss.Adornee = targetted:FindFirstChild("Torso") or targetted:FindFirstChild("UpperTorso") or targetted:FindFirstChild("HumanoidRootPart")
abss.Enabled = true
elseif targetted == nil then
abss.Adornee = nil
abss.Enabled = false
end

while true and imgl.Rotation >= 360 do
imgl.Rotation = 0	
img2.Rotation = 0
end







	
	Torsovelocity = (ActualVelocity * Vector3.new(1, 0, 1)).magnitude
	if lplr == Player then
	Torsovelocity = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
	end 
	velocity = RootPart.Velocity.y
	sine = sine + change
	Humanoid.WalkSpeed = walkspeed
	local hit, pos = rayCast(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0))).lookVector, 4, Character)
	if Anim == "Walk" and Torsovelocity > 1 then
		RootJoint.C1 = Clerp(RootJoint.C1, rc0 * CFrame.new(0, 0, 0.1 + 0.05 * math.cos(sine / (8/2))) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 2 * (Humanoid.WalkSpeed / 16) / 3)
		Neck.C1 = Clerp(Neck.C1, CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / 3)
		RightHip.C1 = Clerp(RightHip.C1, CFrame.new(0.5, 1 - 0.125 * math.sin(sine / 8) - 0.15 * math.cos(sine / 8*2), 0.25 * math.sin(sine / 8)) * CFrame.Angles(math.rad(-5), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0+25 * math.cos(sine / 8))), 0.6 / 3)
		LeftHip.C1 = Clerp(LeftHip.C1, CFrame.new(-0.5, 1 + 0.125 * math.sin(sine / 8) - 0.15 * math.cos(sine / 8*2), -0.25 * math.sin(sine / 8)) * CFrame.Angles(math.rad(-5), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0+25 * math.cos(sine / 8))), 0.6 / 3)
	elseif (Anim ~= "Walk") or (Torsovelocity < 1) then
		RootJoint.C1 = Clerp(RootJoint.C1, rc0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2 / 3)
		Neck.C1 = Clerp(Neck.C1, CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.2 / 3)
		RightHip.C1 = Clerp(RightHip.C1, CFrame.new(0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.7 / 3)
		LeftHip.C1 = Clerp(LeftHip.C1, CFrame.new(-0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.7 / 3)
	end
		if RootPart.Velocity.y > 1 and hit == nil then 
			Anim = "Jump"
			if attack == false then
				RootJoint.C0 = Clerp(RootJoint.C0, rc0 * CFrame.new(0, 0, 0 ) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
				Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0 , 0 + ((1) - 1)) * CFrame.Angles(math.rad(-25), math.rad(0), math.rad(10)), 1 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-50), math.rad(0), math.rad(0 + 10 * math.cos(sine / 12))) * rscp, 1 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(50), math.rad(0), math.rad(-25 - 10 * math.cos(sine / 12))) * lscp, 1 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.4, -0.6) * CFrame.Angles(math.rad(1), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)), 1 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-85), math.rad(0)) * CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)), 1 / 3)
				GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
			end
		elseif RootPart.Velocity.y < -1 and hit == nil then 
			Anim = "Fall"
			if attack == false then
				RootJoint.C0 = Clerp(RootJoint.C0, rc0 * CFrame.new(0, 0, 0 ) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0)), 1 / 3)
				Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0 , 0 + ((1) - 1)) * CFrame.Angles(math.rad(-15), math.rad(2.5), math.rad(5+5 * math.cos(sine / 12))), 1 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-90 - 4 * math.cos(sine / 6)), math.rad(0), math.rad(0 + 10 * math.cos(sine / 12))) * rscp, 1 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(math.rad(35 - 4 * math.cos(sine / 6)), math.rad(0), math.rad(-45 - 10 * math.cos(sine / 12))) * lscp, 1 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.3, -0.7) * CFrame.Angles(math.rad(-25 + 5 * math.sin(sine / 12)), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)), 1 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -0.8, -0.3) * CFrame.Angles(math.rad(-10), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(-1 * math.sin(sine / 6)), math.rad(0), math.rad(0)), 1 / 3)
				GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
			end
		elseif Torsovelocity < 1 and hit ~= nil then
			Anim = "Idle"
			if attack == false then
				change = 1
				RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(0)), 1 / 3)
				Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-15 - 3 * math.cos(sine / 12)), math.rad(5), math.rad(0)), 1 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5+0.1 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(-53.75+1.75 * math.cos(sine / 12)), math.rad(0), math.rad(5)) * rscp, 1 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(sine / 12), -0) * CFrame.Angles(math.rad(15 - 1.5 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12)), math.rad(0 - 6 * math.cos(sine / 12))) * lscp, 1 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1.1 - 0.05 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(15), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 1 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.1 - 0.05 * math.cos(sine / 12), 0) * CFrame.Angles(math.rad(10), math.rad(-70), math.rad(0)) * CFrame.Angles(math.rad(-5), math.rad(0), math.rad(0)), 1 / 3)
				GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
			end
		elseif Torsovelocity > 2 and hit ~= nil then
			Anim = "Walk"
			if attack == false then
				RootJoint.C0 = Clerp(RootJoint.C0,rc0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(sine / 12)) * CFrame.Angles(math.rad(20), math.rad(0 + 2.5 * math.cos(sine / 12)), math.rad(0 - 2.5 * math.cos(sine / 12))), 1 / 3)
				Neck.C0 = Clerp(Neck.C0, nc0 * CFrame.new(0, 0, 0 + ((1) - 1)) * CFrame.Angles(math.rad(-20 - 3 * math.cos(sine / 12)), math.rad(0 - 2.5 * math.cos(sine / 12)), math.rad(0 - 2.5 * math.cos(sine / 12))), 1 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-70 - 5 * math.cos(sine / 12)), math.rad(0 - 2.5 * math.cos(sine / 12)), math.rad(5 + 2.5 * math.cos(sine / 12))) * rscp, 1 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0 - 0.2 * math.cos(sine / 12)) * CFrame.Angles(math.rad(20 + 45 * math.cos(sine / 12)), math.rad(0 - 10 * math.cos(sine / 12)), math.rad(0 + 2.5 * math.cos(sine / 12))) * lscp, 1 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1 , -1, 0) * CFrame.Angles(math.rad(0), math.rad(85), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 1 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-85), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 1 / 3)
				GunJoint.C0 = Clerp(GunJoint.C0,CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1 / 2)
			end
		end
	end
end