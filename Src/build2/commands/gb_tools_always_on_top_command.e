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
		local
			iconable_tool: GB_ICONABLE_TOOL
		do
			iconable_tool ?= tool_window
				-- All iconable tools must be windows.
			check
				iconable_tool /= Void
			end

				-- Note that we must also update the icons on the windows,
				-- dependent on whether they are relative of not.
				-- This is because on Windows, if we have multiple windows
				-- show relative, they all share the same icon. Therefore,
				-- we need to set it to an appropriate one.
			if tool_window.is_show_requested and not tool_window.is_relative then
				tool_window.show_relative_to_window (main_window)
				iconable_tool.set_default_icon
			elseif tool_window.is_show_requested and tool_window.is_relative then
				tool_window.show
				iconable_tool.restore_icon
			end
		end

end -- class GB_TOOLS_ALWAYS_ON_TOP_COMMAND
