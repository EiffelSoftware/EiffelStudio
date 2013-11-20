note
	description: "ScrollBar (SB) messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SB_CONSTANTS

feature -- Access

	Sb_lineup: INTEGER = 0
			-- Declared in Windows as SB_LINEUP

	Sb_lineleft: INTEGER = 0
			-- Declared in Windows as SB_LINELEFT

	Sb_linedown: INTEGER = 1
			-- Declared in Windows as SB_LINEDOWN

	Sb_lineright: INTEGER = 1
			-- Declared in Windows as SB_LINERIGHT

	Sb_pageup: INTEGER = 2
			-- Declared in Windows as SB_PAGEUP

	Sb_pageleft: INTEGER = 2
			-- Declared in Windows as SB_PAGELEFT

	Sb_pagedown: INTEGER = 3
			-- Declared in Windows as SB_PAGEDOWN

	Sb_pageright: INTEGER = 3
			-- Declared in Windows as SB_PAGERIGHT

	Sb_thumbposition: INTEGER = 4
			-- Declared in Windows as SB_THUMBPOSITION

	Sb_thumbtrack: INTEGER = 5
			-- Declared in Windows as SB_THUMBTRACK

	Sb_top: INTEGER = 6
			-- Declared in Windows as SB_TOP

	Sb_left: INTEGER = 6
			-- Declared in Windows as SB_LEFT

	Sb_bottom: INTEGER = 7
			-- Declared in Windows as SB_BOTTOM

	Sb_right: INTEGER = 7
			-- Declared in Windows as SB_RIGHT

	Sb_endscroll: INTEGER = 8
			-- Declared in Windows as SB_ENDSCROLL

	Sb_horz: INTEGER = 0
			-- Declared in Windows as SB_HORZ

	Sb_vert: INTEGER = 1
			-- Declared in Windows as SB_VERT

	Sb_ctl: INTEGER = 2
			-- Declared in Windows as SB_CTL

	Sb_both: INTEGER = 3;
			-- Declared in Windows as SB_BOTH

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




end -- class WEL_SB_CONSTANTS

