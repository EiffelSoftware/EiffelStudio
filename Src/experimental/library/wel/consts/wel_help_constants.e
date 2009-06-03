note
	description: "Help constants.  See MSDN for more details discussion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HELP_CONSTANTS

feature -- Access

	Help_context: INTEGER = 1
			-- Display topic identified by specified context identifier
			-- defined in [MAP] section of .hpj file

	Help_quit: INTEGER = 2

	Help_index: INTEGER = 3

	Help_contents: INTEGER = 3

	Help_helponhelp: INTEGER = 4

	Help_setindex: INTEGER = 5

	Help_setcontents: INTEGER = 5

	Help_contextpopup: INTEGER = 8

	Help_forcefile: INTEGER = 9

	Help_key: INTEGER = 257

	Help_command: INTEGER = 258

	Help_contextmenu: INTEGER = 10

	Help_partialkey: INTEGER = 261

	Help_multikey: INTEGER = 513

	Help_setwinpos: INTEGER = 515

	Help_finder: INTEGER = 11

	Help_setpopup_pos: INTEGER = 13

	Help_tcard: INTEGER = 32768

	Help_wm_help: INTEGER = 12;

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




end -- class WEL_HELP_CONSTANTS

