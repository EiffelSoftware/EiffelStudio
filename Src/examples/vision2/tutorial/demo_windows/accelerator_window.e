indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	ACCELERATOR_WINDOW

inherit
	DEMO_WINDOW

	EV_DYNAMIC_TABLE
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
			color: EV_BASIC_COLORS
			acc: EV_ACCELERATOR
			code: EV_KEY_CODE
			vbox: EV_VERTICAL_BOX
			but: EV_BUTTON
		do
			{EV_DYNAMIC_TABLE} Precursor (Void)
			set_finite_dimension (2)
			set_row_spacing (10)
			set_column_spacing (10)
			create color
			create code.make

			create frame.make_with_text (Current, "Press [Ctrl+S]")
			frame.set_foreground_color (color.red)
			create lab1.make (frame)
			lab1.set_editable (False)
			create acc.make (code.key_s, False, False, True)
			create cmd.make (~execute1)
			frame.add_accelerator_command (acc, cmd, Void)

			create frame.make_with_text (Current, "Press [F2]")
			frame.set_foreground_color (color.red)
			create lab2.make (frame)
			lab2.set_editable (False)
			create acc.make (code.key_f2, False, False, False)
			create cmd.make (~execute2)
			frame.add_accelerator_command (acc, cmd, Void)

			create frame.make_with_text (Current, "Press [F2]")
			frame.set_foreground_color (color.red)
			create lab3.make (frame)
			lab3.set_editable (False)
			create acc.make (code.key_f2, False, False, False)
			create cmd.make (~execute3)
			frame.add_accelerator_command (acc, cmd, Void)

			create frame.make_with_text (Current, "Choose your accelerator - None")
			frame.set_foreground_color (color.red)
			create vbox.make (frame)
			vbox.set_spacing (5)
			create lab4.make (vbox)
			lab4.set_editable (False)
			create but.make_with_text (vbox, "Choose")
			vbox.set_child_expandable (but, False)
			create cmd.make (~execute_button)
			but.add_click_command (cmd, Void)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


feature -- Access

	lab1, lab2, lab3, lab4: EV_TEXT
			-- Labels to show the action

	frame: EV_FRAME
			-- A frame for the accelerator

	dialog: EV_ACCELERATOR_DIALOG
			-- A dialog to choose an accelerator

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab2.set_text ("")
			lab3.set_text ("")
			lab4.set_text ("")
			lab1.set_text ("[Ctrl+S] pressed")
		end

	execute2 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab1.set_text ("")
			lab3.set_text ("")
			lab4.set_text ("")
			lab2.set_text ("[F2] pressed")
		end

	execute3 (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab1.set_text ("")
			lab2.set_text ("")
			lab4.set_text ("")
			lab3.set_text ("[F2] pressed")
		end

	execute4 (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab1.set_text ("")
			lab2.set_text ("")
			lab3.set_text ("")
			lab4.set_text ("You did it !")
		end

	execute5 (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the ok button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			create cmd.make (~execute4)
			if accelerator /= Void then
				frame.remove_accelerator_commands (accelerator)
			end
			if dialog.accelerators.first /= Void then
				accelerator := dialog.accelerators.first
				frame.add_accelerator_command (accelerator, cmd, arg)
				frame.set_text ("Accelerator chosen")
			else
				frame.set_text ("Choose your accelerator - None")
				lab4.set_text ("")
			end
		end

	execute_button (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the first button
		local
			action: LINKED_LIST [STRING]
			cmd: EV_ROUTINE_COMMAND
		do
			create action.make
			action.extend ("Your accelerator")
			create dialog.make_with_actions (parent, action)
			create cmd.make (~execute5)
			dialog.add_ok_command (cmd, Void)
			dialog.show
		end

	accelerator: EV_ACCELERATOR
			-- The current accelerator choosen by the user.

end -- class DIRECTORY_WINDOW

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

