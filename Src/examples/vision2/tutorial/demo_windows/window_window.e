indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	WINDOW_WINDOW

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

	current_widget: EV_WINDOW
		-- The window

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			if current_widget = Void then
				!! current_widget.make_top_level
				current_widget.set_title ("Window")	
				!!cmd.make (~hide_window)
				current_widget.add_close_command (cmd, Void)
				current_widget.set_width(640)
				current_widget.set_height(480)
				current_widget.set_minimum_width(400)
				current_widget.set_minimum_height(320)
				set_container_tabs
				tab_list.extend (window_tab)
				create action_window.make (current_widget, tab_list)
			end
			current_widget.show
		end

	hide_window  (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the window is closed
		do
			current_widget.hide
		end

end -- class WINDOW_WINDOW

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
