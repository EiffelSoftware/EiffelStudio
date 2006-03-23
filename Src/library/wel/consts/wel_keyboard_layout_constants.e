indexing
	description: "Keyboard layout constants."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_KEYBOARD_LAYOUT_CONSTANTS

feature -- Constants

	Hkl_prev: INTEGER is 0
			--Previous locale identifier

	Hkl_next: INTEGER is 1
			--Next locale identifier

	Klf_activate: INTEGER is 1

	Klf_substitute_ok: INTEGER is 2

	Klf_unload_previous: INTEGER is 4

	Klf_reorder: INTEGER is 8
			--Reorder locale identifiers starting with current as first

	Kl_namelength: INTEGER is 9

feature -- Constants for Windows 2000 or later

	Klf_replace_lang: INTEGER is 16

	Klf_notellshell: INTEGER is 128

	Klf_set_for_process: INTEGER is 256;

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

end
