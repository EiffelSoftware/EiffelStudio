indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND

inherit

	GB_TWO_STATE_COMMAND
	
	GB_SHARED_TOOLS
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_CONSTANTS
	
	WIZARD_SHARED
		rename
			pixmap as wizard_pixmap
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := display_window.is_show_requested
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			if display_window.is_show_requested then
				Result := "Hide display window"
			else
				Result := "Show display window"
			end
			
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		do
			if is_selected then
					-- If we are in wizard mode from Visual Studio,
					-- then we must show the window relative to the
					-- main window. This is because we are shown modally
					-- to Visual Studio, and otherwise, the windows
					-- become very annoying.
				if system_status.is_wizard_system then
					display_window.show_relative_to_window (first_window)
				else
					display_window.show
				end
					-- If the window is empty, then we give a default size.
				if display_window.is_empty then
					display_window.set_size (default_window_dimension, default_window_dimension)
						-- Ensure that the windows are not displayed directly on top of each other.
						-- This only seems to happen when they are shown relative.
					if builder_window.is_show_requested and display_window.x_position = builder_window.x_position
						and display_window.y_position = builder_window.y_position then
						display_window.set_position (display_window.x_position + 5, display_window.y_position + 5)
					end
				end
			else
				display_window.hide
				display_window.set_size (0, 0)
			end
			set_selected (not is_selected)
		end

end -- class GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND