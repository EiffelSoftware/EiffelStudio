indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	DIALOG_WINDOW

inherit
	EV_BUTTON
		redefine
			make
		end
	DEMO_WINDOW

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
			set_parent (par)
		end

feature -- Access

	current_widget: EV_DIALOG
		-- The window
	
	temp_window: EV_WINDOW

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			if current_widget = Void then
				create temp_window.make_top_level
				create current_widget.make(temp_window)
				current_widget.set_title("Dialog Window")
				create cmd.make (~hide_dialog)
				current_widget.add_close_command (cmd, Void)
				set_container_tabs
				create action_window.make (current_widget, tab_list)
			end
			current_widget.show
		end


	hide_dialog (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the window is closed.
		do
			current_widget.hide
		end	

end -- class DIALOG_WINDOW

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
