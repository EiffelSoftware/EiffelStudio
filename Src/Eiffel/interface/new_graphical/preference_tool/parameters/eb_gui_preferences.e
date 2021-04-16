note
	description: "Preferences for graphical components of the Eiffel Compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GUI_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			create dialog_data.make (a_preferences)
			create context_tool_data.make (a_preferences)
			create debug_tool_data.make (a_preferences)
			create diagram_tool_data.make (a_preferences)
			create development_window_data.make (a_preferences)
			create recent_projects_data.make (a_preferences)
			create editor_data.make (a_preferences)
			create search_tool_data.make (a_preferences)
			create class_browser_data.make (a_preferences)
			create external_command_data.make (a_preferences)
			create metric_tool_data.make (a_preferences)
			create error_list_tool_data.make (a_preferences)
			create misc_shortcut_data.make (a_preferences)
			create property_data.make (a_preferences)
			create source_control_tool_data.make (a_preferences)
			is_gui_mode := True
		end

feature -- Access

	class_browser_data: EB_CLASS_BROWSER_DATA
			-- Preference data for class browser

	context_tool_data: EB_CONTEXT_TOOL_DATA
			-- Preference data for the context tool.		

	debug_tool_data: EB_DEBUG_TOOL_DATA
			-- Preference data for debugger tool.

	development_window_data: EB_DEVELOPMENT_WINDOW_PREFERENCES
			-- Preference data for the EiffelStudio main development window.

	diagram_tool_data: EIFFEL_DIAGRAM_PREFERENCES
			-- Preference data for the diagram tool.

	dialog_data: EB_DIALOGS_DATA
			-- Preference data for vision and custom dialogs.

	editor_data: EB_EDITOR_DATA
			-- Preference data for EiffelStudio editor

	external_command_data: EB_EXTERNAL_COMMAND_SHORTCUT_DATA
			-- Preference data for external commands

	recent_projects_data: EB_RECENT_PROJECTS
			-- Preference data for recently loaded EiffelStudio projects.	

	search_tool_data: EB_SEARCH_TOOL_DATA
			-- Preference data for EiffelStudio search tool

	metric_tool_data: EB_METRIC_TOOL_DATA
			-- Preference data for metric tool

	source_control_tool_data: EB_SOURCE_CONTROL_TOOL_DATA
			-- Preference data for source control tool

	error_list_tool_data: ES_ERROR_LIST_DATA
			-- Preference data for error list tool

	misc_shortcut_data: EB_MISC_SHORTCUT_DATA
			-- Shortcuts other than editor shortcuts and external command shortcuts.

	property_data: EB_PROPERTY_DATA
			-- Preference data for properties

	is_gui_mode: BOOLEAN
			-- Is current in gui mode?

invariant
	dialog_data_not_void: is_gui_mode implies dialog_data /= Void
	context_tool_data_not_void: is_gui_mode implies context_tool_data /= Void
	debug_tool_data_not_void: is_gui_mode implies debug_tool_data /= Void
	development_window_data_not_void: is_gui_mode implies development_window_data /= Void
	recent_projects_data_not_void: is_gui_mode implies recent_projects_data /= Void
	editor_data_not_void: is_gui_mode implies editor_data /= Void
	search_tool_data_not_void: is_gui_mode implies search_tool_data /= Void
	metric_tool_data_attached: is_gui_mode implies metric_tool_data /= Void
	error_list_tool_data_attached: is_gui_mode implies error_list_tool_data /= Void
	class_browser_data_attached: is_gui_mode implies class_browser_data /= Void
	property_data_attached: is_gui_mode implies attached property_data

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_GUI_PREFERENCES
