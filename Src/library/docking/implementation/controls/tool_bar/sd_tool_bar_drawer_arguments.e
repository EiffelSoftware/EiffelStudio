indexing
	description: "Arguments for SD_TOOL_BAR_DRAWER."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_ARGUMENTS

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method
		do
		end

feature -- Properties

	tool_bar: SD_TOOL_BAR
			-- SD_TOOL_BAR

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Set `tool_bar'
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar
		ensure
			set: tool_bar = a_tool_bar
		end

	item: SD_TOOL_BAR_ITEM
			-- Item on `tool_bar'

	set_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Set `item'.
		require
			not_void: a_item /= Void
		do
			item := a_item
		ensure
			set: item = a_item
		end

	position: EV_COORDINATE
			-- Position to draw `item' on `tool_bar'

	set_position (a_position: EV_COORDINATE) is
			-- Set `position'
		require
			not_void: a_position /= Void
		do
			position := a_position
		ensure
			set: position = a_position
		end

feature -- Query

	is_valid: BOOLEAN is
			-- If Current valid?
		local
			l_not_void: BOOLEAN
			l_argument_valid: BOOLEAN
		do
			l_not_void := tool_bar /= Void and item /= Void and position /= Void
			if l_not_void then
				l_argument_valid := position.x >= 0 and position.y >= 0 and tool_bar.has (item)
				Result := l_argument_valid
			end
		end


end
