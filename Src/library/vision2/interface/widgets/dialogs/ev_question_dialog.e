indexing
	description: "EiffelVision warning dialog. This dialog%
			% displays a window with a question bitmap,%
			% a text inside and a title."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_QUESTION_DIALOG

inherit

	EV_MESSAGE_DIALOG
		redefine
			implementation
		end

creation
	make, make_default

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make (par)
		end

	make_default (par: EV_CONTAINER; txt, title: STRING) is
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make_default (par, txt, title)
		end

feature -- status settings

	add_yesno_buttons is
			-- Add two buttons `yes' and `no'
		do
			implementation.add_yesno_buttons
		end

	add_yesnocancel_buttons is
			-- Add three buttons : `yes', `no' and `cancel'.
		do
			implementation.add_yesnocancel_buttons
		end

feature -- Event - command association

	add_yes_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `ok' button
			-- is pressed. If there is no `ok' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			Implementation.add_yes_command (a_command, arguments)
		end

	add_no_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `cancel' button
			-- is pressed. If there is no `cancel' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			Implementation.add_no_command (a_command, arguments)
		end

feature {NONE} -- Implementation

	implementation: EV_QUESTION_DIALOG_I

end -- class EV_QUESTION_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
