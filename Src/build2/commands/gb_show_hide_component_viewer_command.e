indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND

inherit

	GB_TWO_STATE_COMMAND
	
	GB_SHARED_COMPONENT_VIEWER

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

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		do
			if is_selected then
				component_viewer.show
			else
				component_viewer.hide
			end
			set_selected (not is_selected)
		end

end -- class GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND
