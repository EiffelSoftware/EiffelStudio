indexing
	description: "Menu Flags (MF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MF_CONSTANTS

feature -- Access

	Mf_insert: INTEGER is 0

	Mf_change: INTEGER is 128

	Mf_append: INTEGER is 256

	Mf_delete: INTEGER is 512

	Mf_remove: INTEGER is 4096

	Mf_bycommand: INTEGER is 0

	Mf_byposition: INTEGER is 1024

	Mf_separator: INTEGER is 2048

	Mf_enabled: INTEGER is 0

	Mf_grayed: INTEGER is 1

	Mf_disabled: INTEGER is 2

	Mf_unchecked: INTEGER is 0

	Mf_checked: INTEGER is 8

	Mf_usecheckbitmaps: INTEGER is 512

	Mf_string: INTEGER is 0

	Mf_bitmap: INTEGER is 4

	Mf_ownerdraw: INTEGER is 256

	Mf_popup: INTEGER is 16

	Mf_menubarbreak: INTEGER is 32

	Mf_menubreak: INTEGER is 64

	Mf_unhilite: INTEGER is 0

	Mf_hilite: INTEGER is 128

	Mf_sysmenu: INTEGER is 8192

	Mf_help: INTEGER is 16384

	Mf_mouseselect: INTEGER is 32768

	Mf_end: INTEGER is 128;

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




end -- class WEL_MF_CONSTANTS

