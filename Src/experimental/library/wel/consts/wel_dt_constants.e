note
	description: "DrawText (DT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DT_CONSTANTS

feature -- Access

	Dt_top: INTEGER = 0
			-- Declared in Windows as DT_TOP

	Dt_left: INTEGER = 0
			-- Declared in Windows as DT_LEFT

	Dt_center: INTEGER = 1
			-- Declared in Windows as DT_CENTER

	Dt_right: INTEGER = 2
			-- Declared in Windows as DT_RIGHT

	Dt_vcenter: INTEGER = 4
			-- Declared in Windows as DT_VCENTER

	Dt_bottom: INTEGER = 8
			-- Declared in Windows as DT_BOTTOM

	Dt_wordbreak: INTEGER = 16
			-- Declared in Windows as DT_WORDBREAK

	Dt_singleline: INTEGER = 32
			-- Declared in Windows as DT_SINGLELINE

	Dt_expandtabs: INTEGER = 64
			-- Declared in Windows as DT_EXPANDTABS

	Dt_tabstop: INTEGER = 128
			-- Declared in Windows as DT_TABSTOP

	Dt_noclip: INTEGER = 256
			-- Declared in Windows as DT_NOCLIP

	Dt_externalleading: INTEGER = 512
			-- Declared in Windows as DT_EXTERNALLEADING

	Dt_calcrect: INTEGER = 1024
			-- Declared in Windows as DT_CALCRECT

	Dt_noprefix: INTEGER = 2048
			-- Declared in Windows as DT_NOPREFIX

	Dt_internal: INTEGER = 4096
			-- Declared in Windows as DT_INTERNAL

	Dt_word_ellipsis: INTEGER = 262144
			-- Declared in Windows as DT_WORD_ELLIPSIS

	Dt_hideprefix: INTEGER = 1048576;
			-- Declared in Windows as DT_HIDEPREFIX

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




end -- class WEL_DT_CONSTANTS

