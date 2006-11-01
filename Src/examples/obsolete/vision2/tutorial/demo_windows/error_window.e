indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ERROR_WINDOW

inherit
	DEMO_WINDOW

	EV_BUTTON
		redefine
			make
		end

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
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		set_dialog_tabs
		create action_window.make (Current, tab_list)
		end
	

feature -- Access

	error: EV_ERROR_DIALOG
			-- The dialog

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			if error /= Void then
				error.show
			else
				create error.make_default (parent, "Error Dialog", "There is an error !")
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


end -- class FIXED_WINDOW

