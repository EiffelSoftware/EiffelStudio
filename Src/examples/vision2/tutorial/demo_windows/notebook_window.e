indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	NOTEBOOK_WINDOW

inherit
	EV_NOTEBOOK
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the notebook 
			-- without parent.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_NOTEBOOK} Precursor (Void)
			!! button1.make (Current)
			!! box.make (Current)
			!! button_box.make_with_text (box, "button 1")
			!! button_box.make_with_text (box, "button 2")
			!! button_box.make_with_text (box, "button 3")
			!! button_box.make_with_text (box, "button 4")
			button1.set_text ("Button")			
			append_page (button1, "Button")
			append_page (box, "Pixmap 2")
			set_current_page (2)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "notebook")
			create cmd.make (~switch_command)
			add_switch_command (cmd, Void)
			set_parent (par)			
		end
	
	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend(notebook_tab)
			create action_window.make(Current,tab_list)
		end

feature -- Access

	button1, button_box: EV_BUTTON
		-- Buttons for the demo

	box: EV_VERTICAL_BOX
		-- Box for the demo

feature -- Execution

	switch_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When selected tab changes, inform user in `event_window'
		do
			event_window.display ("Switch command in notebook.")
		end

end -- class NOTEBOOK_WINDOW

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

