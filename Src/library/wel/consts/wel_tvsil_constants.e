indexing
	description	: "Tree View State Image List (TVSIL) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TVSIL_CONSTANTS

feature -- Access

	Tvsil_normal: INTEGER is 0
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a tree view control. 
			--
			-- Declared in Windows as TVSIL_NORMAL

	Tvsil_state: INTEGER is 2;
			-- Indicates the state image list. You can use state 
			-- images to indicate application-defined item states. 
			-- A state image is displayed to the left of an item's
			-- selected or nonselected image.
			--
			-- Declared in Windows as TVSIL_STATE

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TVSIL_CONSTANTS

