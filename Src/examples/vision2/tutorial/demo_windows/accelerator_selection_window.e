indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	ACCELERATOR_SELECTION_WINDOW

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
			!! cmd.make (~execute1)
			add_click_command (cmd, Void)
		end

feature -- Access

	dialog: EV_ACCELERATOR_DIALOG
			-- The dialog

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
			list: LINKED_LIST [STRING]
		do
			if dialog /= Void then
				dialog.show
			else
				!! list.make
				list.extend ("Melt")
				list.extend ("Quick Melt")
				list.extend ("Freeze")
				!! dialog.make_with_actions (parent, list)
--				!! cmd.make (~execute2)
--				dialog.add_ok_command (cmd, Void)
--				!! cmd.make (~execute3)
--				dialog.add_cancel_command (cmd, Void)
				dialog.show
			end
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end

	execute2 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
		end

	execute3 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
		end

end -- class ACCELERATOR_SELECTION_WINDOW

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

