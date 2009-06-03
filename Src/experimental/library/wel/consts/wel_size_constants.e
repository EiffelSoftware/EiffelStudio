note
	description	: "Size (SIZE) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_SIZE_CONSTANTS

feature -- Access

	Size_maximized: INTEGER = 2
			-- Declared in Windows as SIZE_MAXIMIZED

	Size_minimized: INTEGER = 1
			-- Declared in Windows as SIZE_MINIMIZED

	Size_restored: INTEGER = 0
			-- Declared in Windows as SIZE_RESTORED

	Size_maxhide: INTEGER = 4
			-- Declared in Windows as SIZE_MAXHIDE

	Size_maxshow: INTEGER = 3;
			-- Declared in Windows as SIZE_MAXSHOW

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




end -- class WEL_SIZE_CONSTANTS

