indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	COLOR_SELECTION_WINDOW

inherit
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
			-- Set the tabs for the action window
		do
		
		end


feature -- Access

	dialog: EV_COLOR_DIALOG
			-- The dialog

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		local
			cmd: EV_ROUTINE_COMMAND
		do
			if dialog /= Void then
				dialog.show
			else
				create dialog.make (parent)
--				!! cmd.make (~execute2)
--				dialog.add_ok_command (cmd, Void)
--				!! cmd.make (~execute3)
--				dialog.add_cancel_command (cmd, Void)
				dialog.show
			end
		end

	execute2 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
		end

	execute3 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
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


end -- class COLOR_SELECTION_WINDOW

