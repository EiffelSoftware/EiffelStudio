indexing
	description: "Objects that modify the display settings for windows%
		%containing tools, either `modeless' or `show'"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TOOLS_ALWAYS_ON_TOP_COMMAND

inherit

	GB_TWO_STATE_COMMAND
		redefine
			make, execute
		end

	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_TOOLS
	
	GB_CONSTANTS
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_HISTORY
	
	GB_SHARED_COMPONENT_VIEWER

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			enable_sensitive
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_tool_windows_modeless_text
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_builder_window
		end


feature -- Execution

	execute is
			-- Execute command.
		local
			root_object: GB_OBJECT
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			reverse_is_selected
			if is_selected then
				system_status.enable_tools_always_on_top
			else
				system_status.disable_tools_always_on_top
			end
			update_tool (display_window)
			update_tool (builder_window)
			update_tool (history.dialog)
			update_tool (component_viewer)
		end		
				
	update_tool (tool_window: EV_DIALOG) is
			-- Toggle display status of `tool_window' between
			-- regular and display relative to `main_window'.
		do
			if tool_window.is_show_requested and not tool_window.is_relative then
				tool_window.show_relative_to_window (main_window)
			elseif tool_window.is_show_requested and tool_window.is_relative then
				tool_window.show
			end
		end

end -- class GB_TOOLS_ALWAYS_ON_TOP_COMMAND
