indexing
	description: 
		"Query dialog used in the tutorial."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	QUERY_DIALOG

inherit
	EV_DIALOG
		rename
			make as ev_make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW; a_title, question: STRING) is
			-- Create an empty menu.
		local
			label: EV_LABEL
			button: EV_BUTTON
			cmd: EV_ROUTINE_COMMAND
		do
			ev_make (par)
			value := 0
			set_title (a_title)
			!! label.make_with_text (display_area, question)
			!! cmd.make (~ok_execute)
			!! field.make_with_text (display_area, "0")
			field.add_activate_command (cmd, Void)
			!! button.make_with_text (action_area, "OK")
			button.add_click_command (cmd, Void)
			!! button.make_with_text (action_area, "Cancel")
			!! cmd.make (~cancel_execute)
			button.add_click_command (cmd, Void)
			show
		end

feature -- Access

	field: EV_TEXT_FIELD
			-- The text field

	value: INTEGER

feature -- Command execute

	ok_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when OK button is pressed
		local
			error: EV_ERROR_DIALOG
		do
			if field.text.is_integer then
				value := field.text.to_integer
				hide
			else
				!! error.make_default (parent, "Error", "Enter an interger value !")
			end
		end

	cancel_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when Cancel button is pressed
		do
			hide
		end

end -- class QUERY_DIALOG

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

