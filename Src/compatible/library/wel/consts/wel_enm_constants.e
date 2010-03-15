note
	description: "Edit Notification mask (ENM) constants for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ENM_CONSTANTS

feature -- Access

	Enm_none: INTEGER = 0

	Enm_change: INTEGER = 1

	Enm_update: INTEGER = 2

	Enm_scroll: INTEGER = 4

	Enm_keyevents: INTEGER = 65536

	Enm_mouseevents: INTEGER = 131072

	Enm_requestresize: INTEGER = 262144

	Enm_selchange: INTEGER = 524288

	Enm_dropfiles: INTEGER = 1048576

	Enm_protected: INTEGER = 2097152

	Enm_correcttext: INTEGER = 4194304

	Enm_imechange: INTEGER = 8388608;

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




end -- class WEL_ENM_CONSTANTS

