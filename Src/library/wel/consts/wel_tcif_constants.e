indexing
	description: "Tab control item flag (TCIF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCIF_CONSTANTS

feature -- Access

	Tcif_text: INTEGER is 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as TCIF_TEXT

	Tcif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as TCIF_IMAGE

	Tcif_rtlreading: INTEGER is 4
			-- Windows 95 only: Displays the text of pszText
			-- using right-to-left reading order on Hebrew or
			-- Arabic systems.
			--
			-- Declared in Windows as TCIF_RTLREADING

	Tcif_param: INTEGER is 8
			-- The lParam member is valid.
			--
			-- Declared in Windows as TCIF_PARAM

	Tcif_state: INTEGER is 16;
			-- Declared in Windows as TCIF_STATE

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




end -- class WEL_TCIF_CONSTANTS

