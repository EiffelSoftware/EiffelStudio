indexing
	description	: "List view item flag (LVIF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVIF_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvif_text: INTEGER is 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVIF_TEXT

	Lvif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as LVIF_IMAGE

	Lvif_param: INTEGER is 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as LVIF_PARAM

	Lvif_state: INTEGER is 8;
			-- The state member is valid
			--
			-- Declared in Windows as LVIF_STATE

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




end -- class WEL_LVIF_CONSTANTS

