indexing
	description: "Common control Track Bar Style (TBS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBS_CONSTANTS

feature -- Access

	Tbs_autoticks: INTEGER is 1
			-- Declared in Windows as TBS_AUTOTICKS

	Tbs_vert: INTEGER is 2
			-- Declared in Windows as TBS_VERT

	Tbs_horz: INTEGER is 0
			-- Declared in Windows as TBS_HORZ

	Tbs_top: INTEGER is 4
			-- Declared in Windows as TBS_TOP

	Tbs_bottom: INTEGER is 0
			-- Declared in Windows as TBS_BOTTOM

	Tbs_left: INTEGER is 4
			-- Declared in Windows as TBS_LEFT

	Tbs_right: INTEGER is 0
			-- Declared in Windows as TBS_RIGHT

	Tbs_both: INTEGER is 8
			-- Declared in Windows as TBS_BOTH

	Tbs_noticks: INTEGER is 16
			-- Declared in Windows as TBS_NOTICKS

	Tbs_enableselrange: INTEGER is 32
			-- Declared in Windows as TBS_ENABLESELRANGE

	Tbs_fixedlength: INTEGER is 64
			-- Declared in Windows as TBS_FIXEDLENGTH

	Tbs_nothumb: INTEGER is 128
			-- Declared in Windows as TBS_NOTHUMB

	Tbs_tooltips: INTEGER is 256;
			-- Declared in Windows as TBS_TOOLTIPS

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




end -- class WEL_TBS_CONSTANTS

