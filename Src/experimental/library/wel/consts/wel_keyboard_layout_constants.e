note
	description: "Keyboard layout constants."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_KEYBOARD_LAYOUT_CONSTANTS

feature -- Constants

	Hkl_prev: INTEGER = 0
			--Previous locale identifier

	Hkl_next: INTEGER = 1
			--Next locale identifier

	Klf_activate: INTEGER = 1

	Klf_substitute_ok: INTEGER = 2

	Klf_unload_previous: INTEGER = 4

	Klf_reorder: INTEGER = 8
			--Reorder locale identifiers starting with current as first

	Kl_namelength: INTEGER = 9

feature -- Constants for Windows 2000 or later

	Klf_replace_lang: INTEGER = 16

	Klf_notellshell: INTEGER = 128

	Klf_set_for_process: INTEGER = 256;

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

end
