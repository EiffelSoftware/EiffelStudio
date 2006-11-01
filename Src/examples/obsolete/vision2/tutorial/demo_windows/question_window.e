indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	QUESTION_WINDOW

inherit
	DEMO_WINDOW

	EV_BUTTON
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			make_with_text (par, " Show ")
			set_vertical_resize (False)
			set_horizontal_resize (False)
			create cmd.make (agent execute1)
			add_click_command (cmd, Void)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			question: EV_QUESTION_DIALOG
				-- The dialog
			cmd: EV_ROUTINE_COMMAND
			arg1: EV_ARGUMENT1 [STRING]
			arg2: EV_ARGUMENT1 [STRING]
		do
			create question.make_default (parent, "Question Dialog", "Are you alright ?")
				-- creation of the question dialog.

			create arg1.make ("Yes")
			create arg2.make ("No")
			create cmd.make (agent execute2)
			question.add_yes_command ( cmd, arg1)
			question.add_no_command ( cmd, arg2)
		end

	execute2 (arg: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Executed when the 'yes' or 'no' button is pressed.
		require else
			arg_ok: ((arg.first.is_equal ("Yes")) or (arg.first.is_equal ("No")))
		do
			io.new_line
			if (arg.first.is_equal ("Yes")) then
				io.put_string ("Yes, I am alright!")
			elseif (arg.first.is_equal ("No")) then
				io.put_string ("No, I am not alright")
			end
			io.new_line
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


end -- class FIXED_WINDOW

