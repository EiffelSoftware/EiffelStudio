note
	description: "Arguments for SD_TOOL_BAR_DRAWER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_ARGUMENTS

create
	make

feature {NONE}  -- Initlization

	make
			-- Creation method
		do
		end

feature -- Properties

	tool_bar: SD_TOOL_BAR
			-- SD_TOOL_BAR

	set_tool_bar (a_tool_bar: SD_TOOL_BAR)
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

	set_item (a_item: SD_TOOL_BAR_ITEM)
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

	set_position (a_position: EV_COORDINATE)
			-- Set `position'
		require
			not_void: a_position /= Void
		do
			position := a_position
		ensure
			set: position = a_position
		end

feature -- Query

	is_valid: BOOLEAN
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


note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
