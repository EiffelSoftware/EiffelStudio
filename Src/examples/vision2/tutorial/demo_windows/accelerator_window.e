indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	ACCELERATOR_WINDOW

inherit
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
			frame: EV_FRAME
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
			!! color
			!! code.make

			!! frame.make_with_text (Current, "Press [Ctrl+S]")
			frame.set_foreground_color (color.red)
			!! lab1.make (frame)
			lab1.set_editable (False)
			!! acc.make (code.key_s, False, False, True)
			!! cmd.make (~execute1)
			frame.add_accelerator_command (acc, cmd, Void)

			!! frame.make_with_text (Current, "Press [F2]")
			frame.set_foreground_color (color.red)
			!! lab2.make (frame)
			lab2.set_editable (False)
			!! acc.make (code.key_f2, False, False, False)
			!! cmd.make (~execute2)
			frame.add_accelerator_command (acc, cmd, Void)

			!! frame.make_with_text (Current, "Press [F2]")
			frame.set_foreground_color (color.red)
			!! lab3.make (frame)
			lab3.set_editable (False)
			!! acc.make (code.key_f2, False, False, False)
			!! cmd.make (~execute3)
			frame.add_accelerator_command (acc, cmd, Void)

			!! frame.make_with_text (Current, "Choose your accelerator")
			frame.set_foreground_color (color.red)
			!! vbox.make (frame)
			vbox.set_spacing (5)
			!! lab4.make_with_text (vbox, "Doesn't work yet.")
			lab4.set_editable (False)
			!! but.make_with_text (vbox, "Choose")
			but.set_expand (False)
			!! cmd.make (~execute_button)
			but.add_click_command (cmd, Void)

			set_parent (par)
		end

feature -- Access

	lab1, lab2, lab3, lab4: EV_TEXT
			-- Labels to show the action

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab2.set_text ("")
			lab3.set_text ("")
--			lab4.set_text ("")
			lab1.set_text ("[Ctrl+S] pressed")
		end

	execute2 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab1.set_text ("")
			lab3.set_text ("")
--			lab4.set_text ("")
			lab2.set_text ("[F2] pressed")
		end

	execute3 (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the first button
		do
			lab1.set_text ("")
			lab2.set_text ("")
--			lab4.set_text ("")
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

	execute_button (arg: EV_ARGUMENT; data: EV_KEY_EVENT_DATA) is
			-- Executed when we press the first button
		local
			dialog: EV_ACCELERATOR_DIALOG
			action: LINKED_LIST [STRING]
			cmd: EV_ROUTINE_COMMAND
		do
			!! action.make
			action.extend ("Your accelerator")
			!! dialog.make_with_actions (parent, action)
			dialog.show
--			dialog.add_ok_command (cmd, Void)
--			!! cmd.make (~execute4)
--			lab4.remove_accelerator_commands (accelerator)
--			accelerator := dialog.accelerators.first
--			lab4.add_accelerator_command (accelerator, cmd, arg)
		end

	accelerator: EV_ACCELERATOR
			-- The current accelerator choosen by the user.

end -- class DIRECTORY_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
