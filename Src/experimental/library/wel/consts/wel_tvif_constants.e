note
	description: "Tree view item flag (TVIF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVIF_CONSTANTS

feature -- Access

	Tvif_children: INTEGER = 64
			-- The cChildren member is valid.
			--
			-- Declared in Windows as TVIF_CHILDREN

	Tvif_image: INTEGER = 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as TVIF_IMAGE

	Tvif_param: INTEGER = 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as TVIF_PARAM

	Tvif_selectedimage: INTEGER = 32
			-- The iSelectedImage member is valid.
			--
			-- Declared in Windows as TVIF_SELECTEDIMAGE

	Tvif_state: INTEGER = 8
			-- The state and stateMask members are valid.
			--
			-- Declared in Windows as TVIF_STATE

	Tvif_text: INTEGER = 1
			-- The pszText and cchTextMax members are valid.
			--
			-- Declared in Windows as TVIF_TEXT

	Tvif_handle: INTEGER = 16;
			-- The hitem member is valid.
			--
			-- Declared in Windows as TVIF_HANDLE

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TVIF_CONSTANTS

