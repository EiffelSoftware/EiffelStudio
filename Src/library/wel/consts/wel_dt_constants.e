indexing
	description: "DrawText (DT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DT_CONSTANTS

feature -- Access

	Dt_top: INTEGER is 0
			-- Declared in Windows as DT_TOP

	Dt_left: INTEGER is 0
			-- Declared in Windows as DT_LEFT

	Dt_center: INTEGER is 1
			-- Declared in Windows as DT_CENTER

	Dt_right: INTEGER is 2
			-- Declared in Windows as DT_RIGHT

	Dt_vcenter: INTEGER is 4
			-- Declared in Windows as DT_VCENTER

	Dt_bottom: INTEGER is 8
			-- Declared in Windows as DT_BOTTOM

	Dt_wordbreak: INTEGER is 16
			-- Declared in Windows as DT_WORDBREAK

	Dt_singleline: INTEGER is 32
			-- Declared in Windows as DT_SINGLELINE

	Dt_expandtabs: INTEGER is 64
			-- Declared in Windows as DT_EXPANDTABS

	Dt_tabstop: INTEGER is 128
			-- Declared in Windows as DT_TABSTOP

	Dt_noclip: INTEGER is 256
			-- Declared in Windows as DT_NOCLIP

	Dt_externalleading: INTEGER is 512
			-- Declared in Windows as DT_EXTERNALLEADING

	Dt_calcrect: INTEGER is 1024
			-- Declared in Windows as DT_CALCRECT

	Dt_noprefix: INTEGER is 2048
			-- Declared in Windows as DT_NOPREFIX

	Dt_internal: INTEGER is 4096
			-- Declared in Windows as DT_INTERNAL

	Dt_word_ellipsis: INTEGER is 262144
			-- Declared in Windows as DT_WORD_ELLIPSIS

	Dt_hideprefix: INTEGER is 1048576;
			-- Declared in Windows as DT_HIDEPREFIX

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




end -- class WEL_DT_CONSTANTS

