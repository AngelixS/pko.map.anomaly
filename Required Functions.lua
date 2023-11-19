file_exists = file_exists or function(name)
    local f = io.open(name, 'r')
    if(f ~= nil)then
        io.close(f)
        return true
    else
        return false
    end
end
AdjustTextSpace = function(Text, Spaces, End, Align)
	local Message = ''
	if not Align or Align == 'Center' then
		local Count = math.floor((Spaces - string.len(Text)) * 0.5)
		for C = 1, Count, 1 do
			Message = Message.." "
		end
		Message = Message..Text
		Count = math.floor(Spaces - string.len(Message))
		for C = 1, Count, 1 do
			Message = Message.." "
		end
	end
	if Align and Align == 'Left' then
		local Count = math.floor(Spaces - string.len(Text))
		Message = Text
		for C = 1, Count, 1 do
			Message = Message..' '
		end
	end
	if Align and Align == 'Right' then
		local Count = math.floor(Spaces - string.len(Text))
		for C = 1, Count, 1 do
			Message = Message..' '
		end
		Message = Message..Text
	end
	if End then
		Message = Message..End
	end
	return Message
end
AdjustTextLeft = function(Text, Spaces, Ending)
	return AdjustTextSpace(Text, Spaces, Ending, 'Left')
end
AdjustTextCenter = function(Text, Spaces, Ending)
	return AdjustTextSpace(Text, Spaces, Ending, 'Center')
end
AdjustTextRight = function(Text, Spaces, Ending)
	return AdjustTextSpace(Text, Spaces, Ending, 'Right')
end