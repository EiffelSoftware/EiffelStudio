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
			make,
			set_parent
		end

	DEMO_WINDOW
	WIDGET_COMMANDS

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
			create event_window.make (Current)
			!! cmd.make (~execute1)
			add_click_command (cmd, Void)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	current_widget: EV_WINDOW
		-- The window

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
			item: DEMO_ITEM [WINDOW_WINDOW]
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
				current_widget.set_icon_name ("icon")

				-- We create the action window ansset the button
				-- sensitive again
				set_container_tabs
				tab_list.extend (window_tab)
				create action_window.make (current_widget, tab_list)
				create item.make_with_title (Void, "", "")
				item.action_button.set_insensitive (False)
				item.destroy
				add_widget_commands (current_widget, event_window, "window")
			end
			current_widget.show
		end

	hide_window  (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the window is closed
		do
			current_widget.hide
		end

feature {NONE} -- Implementation

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			{EV_BUTTON} Precursor (par)
			if current_widget /= Void then
				current_widget.hide
			end
		end

end -- class WINDOW_WINDOW

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

