indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	POPUP_WINDOW

inherit
	DEMO_WINDOW

	EV_FIXED
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
			sep: EV_MENU_SEPARATOR
		do
			Precursor {EV_FIXED} (par)
	
			create cmd.make (agent popup_cmd)
			add_button_press_command (3, cmd, Void)

			create button.make_with_text (Current, "I move")
			button.set_x_y (10, 10)

			create popup.make (Current)
			create item.make_with_text (popup, "GO")
			create cmd.make (agent plus_command)
			item.add_select_command (cmd, Void)
			create sep.make (popup)
			create item.make_with_text (popup, "BACK")
			create cmd.make (agent less_command)
			item.add_select_command (cmd, Void)
		end
	
	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	button: EV_BUTTON
		-- A moving button

	popup: EV_POPUP_MENU
		-- A popup for the demo

	item: EV_MENU_ITEM
		-- An item in the popup

feature -- Execute command

	popup_cmd (arg: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
		do
			popup.show
--			popup.show_at_position (data.absolute_x, data.absolute_y)
		end

	plus_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			button.set_x_y (button.x + 10, button.y + 10)
		end

	less_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			button.set_x_y (button.x - 10, button.y - 10)
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


end -- class MENU_WINDOW

