indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the notebook 
			-- without parent.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor {EV_NOTEBOOK} (Void)
			create button1.make (Current)
			create box.make (Current)
			create button_box.make_with_text (box, "button 1")
			create button_box.make_with_text (box, "button 2")
			create button_box.make_with_text (box, "button 3")
			create button_box.make_with_text (box, "button 4")
			button1.set_text ("Button")			
			append_page (button1, "Button")
			append_page (box, "Pixmap 2")
			set_current_page (2)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "notebook")
			create cmd.make (agent switch_command)
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


end -- class NOTEBOOK_WINDOW

