indexing
	description	: "Display content of simple help context in a dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "help"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_SIMPLE_HELP_ENGINE

inherit
	EV_HELP_ENGINE
	
	EV_DIALOG_CONSTANTS

create
	default_create

feature -- Access

	Help_title: STRING is "Contextual Help"
			-- Help dialog title

feature -- Basic Operations

	show (a_help_context: EV_SIMPLE_HELP_CONTEXT) is
			-- Display content of `a_help_context' in a dialog.
		local
			help_dialog: EV_INFORMATION_DIALOG
		do
			create help_dialog.make_with_text (a_help_context)
			help_dialog.set_buttons (<<ev_ok>>)
			help_dialog.set_default_push_button (help_dialog.button (ev_ok))
			help_dialog.set_title (Help_title)
			help_dialog.disable_user_resize
			help_dialog.show
		end

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




end -- class EV_HELP_ENGINE

