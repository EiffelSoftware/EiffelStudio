indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND

	GB_SHARED_TOOLS
		export
			{NONE} all
		end

create
	default_create

feature {GB_COMMAND_HANDLER} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := component_viewer.is_show_requested
			drop_agent := agent component_dropped
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_hide_component_viewer_menu_text
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
		
feature {NONE} -- Implementation

	component_dropped (object_stone: GB_COMPONENT_OBJECT_STONE) is
			-- Respond to the dropping of `object_stone' on representations of `Current'.
		do
			if not is_selected then
					-- Show `component_viewer' if not already shown.
				execute
			end
			component_viewer.set_component (object_stone.component)
		end

end -- class GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND
