indexing
	description:
		"The demo that goes with the button demo";
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

creation
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
			create cmd.make (~execute1)
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
			!! question.make_default (parent, "Question Dialog", "Are you alright ?")
				-- creation of the question dialog.

			create arg1.make ("Yes")
			create arg2.make ("No")
			create cmd.make (~execute2)
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

end -- class FIXED_WINDOW

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

