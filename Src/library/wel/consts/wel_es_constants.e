note
	description: "Edit control style (ES) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ES_CONSTANTS

feature -- Access

	Es_left: INTEGER = 0

	Es_center: INTEGER = 1

	Es_right: INTEGER = 2

	Es_multiline: INTEGER = 4

	Es_uppercase: INTEGER = 8

	Es_lowercase: INTEGER = 16

	Es_password: INTEGER = 32

	Es_autovscroll: INTEGER = 64

	Es_autohscroll: INTEGER = 128

	Es_nohidesel: INTEGER = 256

	Es_oemconvert: INTEGER = 1024

	Es_readonly: INTEGER = 2048

	Es_wantreturn: INTEGER = 4096;

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




end -- class WEL_ES_CONSTANTS

