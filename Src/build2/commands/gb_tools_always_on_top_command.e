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
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			enable_sensitive
				-- Enable/disable the setting, based on the current preferences.
			if Preferences.boolean_resource_value (Preferences.Tools_on_top, True) then
				enable_selected
				System_status.enable_tools_always_on_top
			else
				disable_selected
				System_status.disable_tools_always_on_top
			end
			
				-- Now add an accelerator
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_t)
			create acc.make_with_key_combination (key, True, False, False)
			acc.actions.extend (agent execute)
			Main_window.accelerators.extend (acc)
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
			counter: INTEGER
		do
			reverse_is_selected
			if is_selected then
				system_status.enable_tools_always_on_top
			else
				system_status.disable_tools_always_on_top
			end
				-- Firstly update all items in `All_floating_tools'.
			from
				counter := 1
			until
				counter > All_floating_tools.count
			loop
				update_tool (All_floating_tools @ counter)
				counter := counter + 1
			end
				-- Now update all floating object editors as
				-- they are not included in `All_floating_tools'.
			from
				counter := 1
			until
				counter > floating_object_editors.count
			loop
				update_tool (parent_dialog (floating_object_editors @ counter))
				counter := counter + 1
			end
			preferences.set_boolean_resource (Preferences.Tools_on_top, is_selected)
			preferences.save_resources
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

			if tool_window.is_show_requested and not tool_window.is_relative then
				tool_window.show_relative_to_window (main_window)
			elseif tool_window.is_show_requested and tool_window.is_relative then
				tool_window.show
			end
		end

end -- class GB_TOOLS_ALWAYS_ON_TOP_COMMAND
