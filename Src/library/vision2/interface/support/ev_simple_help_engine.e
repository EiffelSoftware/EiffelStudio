indexing
	description	: "Display content of simple help context in a dialog."
	status		: "See notice at end of class."
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

end -- class EV_HELP_ENGINE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

