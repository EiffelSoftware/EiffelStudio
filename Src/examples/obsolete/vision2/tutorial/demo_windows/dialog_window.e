indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DIALOG_WINDOW

inherit
	EV_BUTTON
		redefine
			make,
			set_parent
		end

	DEMO_WINDOW

create
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
			create cmd.make (agent execute1)
			add_click_command (cmd, Void)
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


feature -- Access

	current_widget: EV_DIALOG
		-- The window

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
			temp_window: EV_WINDOW
			label: EV_LABEL
			button: EV_BUTTON
			item: DEMO_ITEM [WINDOW_WINDOW]
		do
			if current_widget = Void then
				create temp_window.make_top_level
				create current_widget.make (temp_window)
				current_widget.set_title ("Dialog Window")
				create cmd.make (agent hide_dialog)
				current_widget.add_close_command (cmd, Void)

				-- We customize the dialog
				create label.make_with_text (current_widget.display_area, "A customized dialog.")
				create button.make_with_text (current_widget.action_area, "OK")
				create button.make_with_text (current_widget.action_area, "Cancel")
				create button.make_with_text (current_widget.action_area, "Help")

				-- We create the action_window
				set_container_tabs
				tab_list.extend (window_tab)
				create action_window.make (current_widget, tab_list)
				create item.make_with_title (Void, "", "")
				item.action_button.set_insensitive (False)
				item.destroy
			end
			current_widget.show
		end


	hide_dialog (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the window is closed.
		do
			current_widget.hide
		end	

feature {NONE} -- Implementation

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			Precursor {EV_BUTTON} (par)
			if current_widget /= Void then
				current_widget.hide
			end
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


end -- class DIALOG_WINDOW

