indexing
	description: "Enumerations used by client programmers and internals."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ENUMERATION

feature -- Direction

	top: INTEGER is 1
			-- Top

	bottom: INTEGER is 2
			-- Bottom

	left: INTEGER is 3
			-- Left

	right: INTEGER is 4
			-- Right

feature -- Content Type

	tool: INTEGER is 1
			-- Tool

	editor: INTEGER is 2
			-- Editor

feature -- {SD_STATE, SD_HOT_ZONE}

	place_holder: INTEGER is 3
			-- Place holder for eidtor.

feature -- Contract support

	 is_direction_valid (a_direction: INTEGER): BOOLEAN is
	 		-- If `a_direction' valid?
	 	do
			Result := a_direction = top or a_direction = bottom or a_direction = left or a_direction = right
	 	end


	is_type_valid (a_type: INTEGER): BOOLEAN is
			-- If `a_type' valid?
		do
			Result := a_type = editor or a_type = tool or a_type = place_holder
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
