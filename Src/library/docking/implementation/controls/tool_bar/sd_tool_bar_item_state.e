indexing
	description: "Tool bar item state."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ITEM_STATE

feature -- Enumeration

	Normal: INTEGER is 1
			-- Normal	

	Hot: INTEGER is 2
			-- Hot

	Pressed: INTEGER is 3
			-- Pressed

	Disabled: INTEGER is 4
			-- Disabled

	Checked: INTEGER is 5
			-- Checked

	Hot_checked: INTEGER is 6
			-- Hot checked

feature -- Query

	is_valid (a_state: INTEGER): BOOLEAN is

		do
			Result := a_state = checked or a_state = disabled or a_state = hot or
						a_state = hot_checked or a_state = normal or a_state = pressed
		end

indexing
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
