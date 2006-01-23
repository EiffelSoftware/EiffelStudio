indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	BUTTON_WINDOW

inherit
	DEMO_WINDOW

	EV_BUTTON
		redefine
			make
		end

	WIDGET_COMMANDS
	BUTTON_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first hidden because it
			-- is faster.
		local
			color: EV_COLOR
			set_col: EV_COLOR
		do
			Precursor {EV_BUTTON} (par)
			hide
			make_with_text (par, "Button")
			create color.make_rgb (100,0,0)
			set_background_color (color)
			set_col := background_color
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "button")
			add_button_commands (Current, event_window, "Button")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
			set_primitive_tabs
			create action_window.make (Current,tab_list)
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


end -- class BUTTON_WINDOW

