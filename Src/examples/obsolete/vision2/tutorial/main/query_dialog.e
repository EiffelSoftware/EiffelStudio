indexing
	description: 
		"Query dialog used in the tutorial."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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
			create label.make_with_text (display_area, question)
			create cmd.make (agent ok_execute)
			create field.make_with_text (display_area, "0")
			field.add_activate_command (cmd, Void)
			create button.make_with_text (action_area, "OK")
			button.add_click_command (cmd, Void)
			create button.make_with_text (action_area, "Cancel")
			create cmd.make (agent cancel_execute)
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
				create error.make_default (parent, "Error", "Enter an interger value !")
			end
		end

	cancel_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when Cancel button is pressed
		do
			hide
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


end -- class QUERY_DIALOG

