indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND

inherit

	GB_TWO_STATE_COMMAND
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{none} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	WIZARD_SHARED
		rename
			pixmap as wizard_pixmap
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := builder_window.is_show_requested
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			if builder_window.is_show_requested then
				Result := "Hide builder window"
			else
				Result := "Show builder window"
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_builder_window
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
					builder_window.show_relative_to_window (first_window)
				else
					builder_window.show
				end
					-- If the window is empty, then we give a default size.
				if builder_window.is_empty then
					builder_window.set_size (default_window_dimension, default_window_dimension)
						-- Ensure that the windows are not displayed directly on top of each other.
						-- This only seems to happen when they are shown relative.
					if display_window.is_show_requested and display_window.x_position = builder_window.x_position and
						display_window.y_position = builder_window.y_position then
						builder_window.set_position (builder_window.x_position + 5, builder_window.y_position + 5)
					end
				end
			else
				builder_window.hide
				builder_window.set_size (0, 0)
			end
			set_selected (not is_selected)
		end

end -- class GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND
