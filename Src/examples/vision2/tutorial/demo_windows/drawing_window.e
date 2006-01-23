indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DRAWING_WINDOW

inherit
	DEMO_WINDOW

	EV_DRAWING_AREA
		redefine
			make
		end
	WIDGET_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor {EV_DRAWING_AREA} (par)
			set_minimum_size (200, 200)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "drawing area")
			create cmd.make (agent resize_command)
			add_resize_command (cmd, Void)
			create cmd.make (agent paint_command)
			add_paint_command (cmd, Void)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend (pixmapable_tab)
			tab_list.extend (drawable_tab)
			tab_list.extend (drawing_area_tab)
			create action_window.make (Current, tab_list)
		end

feature -- Access


feature -- Execution Features

	resize_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When the drawing area is resized, inform the user in `event window'.
		do
			event_window.display ("Drawing area resized.")
		end

	paint_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When the drawing area is redrawn, inform the user in `event window'.	
		do
			event_window.display ("Drawing area redrawn.")
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


end -- class DRAWING_WINDOW

