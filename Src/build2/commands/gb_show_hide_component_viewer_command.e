indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND
	
	GB_SHARED_COMPONENT_VIEWER
		export
			{NONE} all
		end

	GB_SHARED_TOOLS
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
			is_selected := component_viewer.is_show_requested
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			if component_viewer.is_show_requested then
				Result := "Hide component viewer"
			else
				Result := "Show component viewer"
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_component_viewer
		end
		
	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		do
			Result := component_viewer	
		end

end -- class GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND
