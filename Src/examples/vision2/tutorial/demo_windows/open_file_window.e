indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	OPEN_FILE_WINDOW

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

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_dialog_tabs
			tab_list.extend (selection_dialog_tab)
			tab_list.extend (file_dialog_tab)
			create tab_list.make
			tab_list.extend (file_open_dialog_tab)
			create action_window.make (dialog, tab_list)
		end

feature -- Access

	dialog: EV_FILE_OPEN_DIALOG
			-- The dialog
	w: EV_selection_dialog

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			if dialog /= Void then
				dialog.show
			else
				!! dialog.make (parent)
				dialog.show
			end
		end

end -- class OPEN_FILE_WINDOW

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
