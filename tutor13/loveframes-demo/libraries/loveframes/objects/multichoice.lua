--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012 Kenny Shields --
--]]------------------------------------------------

-- multichoice class
local newobject = loveframes.NewObject("multichoice", "loveframes_object_multichoice", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type                   = "multichoice"
	self.choice                 = ""
	self.text                   = "Select an option"
	self.width                  = 200
	self.height                 = 25
	self.listpadding            = 0
	self.listspacing            = 0
	self.buttonscrollamount     = 0.10
	self.mousewheelscrollamount = 5
	self.haslist                = false
	self.internal               = false
	self.choices                = {}
	self.listheight             = nil
	
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:update(dt)

	local visible      = self.visible
	local alwaysupdate = self.alwaysupdate
	
	if not visible then
		if not alwaysupdate then
			return
		end
	end
	
	local parent = self.parent
	local base   = loveframes.base
	local update = self.Update
	
	self:CheckHover()
	
	-- move to parent if there is a parent
	if parent ~= base then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end
	
	if update then
		update(self, dt)
	end
	
end

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws the object
--]]---------------------------------------------------------
function newobject:draw()
	
	local visible = self.visible
	
	if not visible then
		return
	end
	
	local skins         = loveframes.skins.available
	local skinindex     = loveframes.config["ACTIVESKIN"]
	local defaultskin   = loveframes.config["DEFAULTSKIN"]
	local selfskin      = self.skin
	local skin          = skins[selfskin] or skins[skinindex]
	local drawfunc      = skin.DrawMultiChoice or skins[defaultskin].DrawMultiChoice
	local draw          = self.Draw
	local drawcount     = loveframes.drawcount
	
	-- set the object's draw order
	self:SetDrawOrder()
		
	if draw then
		draw(self)
	else
		drawfunc(self)
	end
	
end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)
	
	local visible = self.visible
	
	if not visible then
		return
	end
	
	local hover   = self.hover
	local haslist = self.haslist
	
	if hover and not haslist and button == "l" then
	
		local baseparent = self:GetBaseParent()
	
		if baseparent and baseparent.type == "frame" then
			baseparent:MakeTop()
		end
		
		self.haslist = true
		self.list = loveframes.objects["multichoicelist"]:new(self)
		loveframes.hoverobject = self
		
	end

end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)
	
	local visible = self.visible
	
	if not visible then
		return
	end

end

--[[---------------------------------------------------------
	- func: AddChoice(choice)
	- desc: adds a choice to the current list of choices
--]]---------------------------------------------------------
function newobject:AddChoice(choice)

	local choices = self.choices
	table.insert(choices, choice)
	
end

--[[---------------------------------------------------------
	- func: SetChoice(choice)
	- desc: sets the current choice
--]]---------------------------------------------------------
function newobject:SetChoice(choice)

	self.choice = choice
	
end

--[[---------------------------------------------------------
	- func: SelectChoice(choice)
	- desc: selects a choice
--]]---------------------------------------------------------
function newobject:SelectChoice(choice)

	local onchoiceselected = self.OnChoiceSelected
	
	self.choice = choice
	self.list:Close()
	
	if onchoiceselected then
		onchoiceselected(self, choice)
	end
	
end

--[[---------------------------------------------------------
	- func: SetListHeight(height)
	- desc: sets the height of the list of choices
--]]---------------------------------------------------------
function newobject:SetListHeight(height)

	self.listheight = height
	
end

--[[---------------------------------------------------------
	- func: SetPadding(padding)
	- desc: sets the padding of the list of choices
--]]---------------------------------------------------------
function newobject:SetPadding(padding)

	self.listpadding = padding
	
end

--[[---------------------------------------------------------
	- func: SetSpacing(spacing)
	- desc: sets the spacing of the list of choices
--]]---------------------------------------------------------
function newobject:SetSpacing(spacing)

	self.listspacing = spacing
	
end

--[[---------------------------------------------------------
	- func: GetValue()
	- desc: gets the value (choice) of the object
--]]---------------------------------------------------------
function newobject:GetValue()

	return self.choice
	
end

--[[---------------------------------------------------------
	- func: GetChoice()
	- desc: gets the current choice (same as get value)
--]]---------------------------------------------------------
function newobject:GetChoice()

	return self.choice
	
end

--[[---------------------------------------------------------
	- func: SetText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:SetText(text)

	self.text = text
	
end

--[[---------------------------------------------------------
	- func: GetText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:GetText()

	return self.text
	
end

--[[---------------------------------------------------------
	- func: SetButtonScrollAmount(speed)
	- desc: sets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:SetButtonScrollAmount(amount)

	self.buttonscrollamount = amount
	
end

--[[---------------------------------------------------------
	- func: GetButtonScrollAmount()
	- desc: gets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:GetButtonScrollAmount()

	return self.buttonscrollamount
	
end

--[[---------------------------------------------------------
	- func: SetMouseWheelScrollAmount(amount)
	- desc: sets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:SetMouseWheelScrollAmount(amount)

	self.mousewheelscrollamount = amount
	
end

--[[---------------------------------------------------------
	- func: GetMouseWheelScrollAmount()
	- desc: gets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:GetButtonScrollAmount()

	return self.mousewheelscrollamount
	
end