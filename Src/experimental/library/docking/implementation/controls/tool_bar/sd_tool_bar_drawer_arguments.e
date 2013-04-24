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

	tool_bar: detachable SD_TOOL_BAR
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

	item: detachable SD_TOOL_BAR_ITEM
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

	position: detachable EV_COORDINATE
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
			l_argument_valid: BOOLEAN
			l_tool_bar: like tool_bar
			l_item: like item
			l_position: like position
		do
			l_tool_bar := tool_bar
			l_item := item
			l_position := position
			if l_tool_bar /= Void and l_item /= Void and l_position /= Void then
				l_argument_valid := l_position.x >= 0 and l_position.y >= 0 and l_tool_bar.has (l_item)
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
