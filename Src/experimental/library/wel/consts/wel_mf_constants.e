note
	description: "Menu Flags (MF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MF_CONSTANTS

feature -- Access

	Mf_insert: INTEGER = 0

	Mf_change: INTEGER = 128

	Mf_append: INTEGER = 256

	Mf_delete: INTEGER = 512

	Mf_remove: INTEGER = 4096

	Mf_bycommand: INTEGER = 0

	Mf_byposition: INTEGER = 1024

	Mf_separator: INTEGER = 2048

	Mf_enabled: INTEGER = 0

	Mf_grayed: INTEGER = 1

	Mf_disabled: INTEGER = 2

	Mf_unchecked: INTEGER = 0

	Mf_checked: INTEGER = 8

	Mf_usecheckbitmaps: INTEGER = 512

	Mf_string: INTEGER = 0

	Mf_bitmap: INTEGER = 4

	Mf_ownerdraw: INTEGER = 256

	Mf_popup: INTEGER = 16

	Mf_menubarbreak: INTEGER = 32

	Mf_menubreak: INTEGER = 64

	Mf_unhilite: INTEGER = 0

	Mf_hilite: INTEGER = 128

	Mf_sysmenu: INTEGER = 8192

	Mf_help: INTEGER = 16384

	Mf_mouseselect: INTEGER = 32768

	Mf_end: INTEGER = 128;

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




end -- class WEL_MF_CONSTANTS

