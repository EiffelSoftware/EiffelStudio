indexing
	description:
		"The demo that goes with the button demo";
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

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_DRAWING_AREA} Precursor (par)
			set_minimum_size (200, 200)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "drawing area")
			create cmd.make (~resize_command)
			add_resize_command (cmd, Void)
			create cmd.make (~paint_command)
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
end -- class DRAWING_WINDOW

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

