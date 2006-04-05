indexing
	description: "Objects that modify the display settings for windows%
		%containing tools, either `modeless' or `show'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TOOLS_ALWAYS_ON_TOP_COMMAND

inherit

	GB_TWO_STATE_COMMAND
		redefine
			execute
		end

	GB_CONSTANTS
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
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			enable_sensitive
				-- Enable/disable the setting, based on the current preferences.
			if preferences.global_data.tools_on_top then
				enable_selected
				components.System_status.enable_tools_always_on_top
			else
				disable_selected
				components.System_status.disable_tools_always_on_top
			end

				-- Now add an accelerator
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_t)
			create acc.make_with_key_combination (key, True, False, False)
			acc.actions.extend (agent execute)
-- IMPORTANT
--			components.tools.main_window.accelerators.extend (acc)
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
		end

feature -- Execution

	execute is
			-- Execute command.
		local
			counter: INTEGER
			l_all_floating_tools: ARRAYED_LIST [EV_DIALOG]
		do
			reverse_is_selected
			if is_selected then
				components.system_status.enable_tools_always_on_top
			else
				components.system_status.disable_tools_always_on_top
			end
				-- Firstly update all items in `All_floating_tools'.
			l_all_floating_tools := components.tools.all_floating_tools
			from
				counter := 1
			until
				counter > l_all_floating_tools.count
			loop
				update_tool (l_all_floating_tools @ counter)
				counter := counter + 1
			end
				-- Now update all floating object editors as
				-- they are not included in `All_floating_tools'.
			from
				counter := 1
			until
				counter > components.object_editors.floating_object_editors.count
			loop
				update_tool (parent_dialog (components.object_editors.floating_object_editors @ counter))
				counter := counter + 1
			end
			preferences.global_data.tools_on_top_preference.set_value (is_selected)
			preferences.preferences.save_resource (preferences.global_data.tools_on_top_preference)
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
				tool_window.show_relative_to_window (components.tools.main_window)
			elseif tool_window.is_show_requested and tool_window.is_relative then
				tool_window.show
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_TOOLS_ALWAYS_ON_TOP_COMMAND
