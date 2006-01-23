indexing
	description	: "List View State Image List (TVSIL) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVSIL_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvsil_normal: INTEGER is 0
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the large icons.
			--
			-- Declared in Windows as LVSIL_NORMAL

	Lvsil_small: INTEGER is 1
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the small icons.
			--
			-- Declared in Windows as LVSIL_SMALL

	Lvsil_state: INTEGER is 2;
			-- Indicates the state image list. You can use state 
			-- images to indicate application-defined item states. 
			-- A state image is displayed to the left of an item's
			-- selected or nonselected image.
			--
			-- Declared in Windows as LVSIL_STATE

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




end -- class WEL_LVSIL_CONSTANTS

