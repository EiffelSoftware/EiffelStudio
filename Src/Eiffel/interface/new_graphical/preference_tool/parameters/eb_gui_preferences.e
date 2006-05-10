indexing
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

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			create dialog_data.make (a_preferences)
			create context_tool_data.make (a_preferences)
			create debug_tool_data.make (a_preferences)
			create diagram_tool_data.make (a_preferences)
			create debugger_data.make (a_preferences)
			create development_window_data.make (a_preferences)
			create recent_projects_data.make (a_preferences)
			create editor_data.make (a_preferences)
			create search_tool_data.make (a_preferences)
			create class_browser_data.make (a_preferences)
		end

feature -- Access

	dialog_data: EB_DIALOGS_DATA
		-- Preference data for vision and custom dialogs.

	context_tool_data: EB_CONTEXT_TOOL_DATA
		-- Preference data for the context tool.		

	debug_tool_data: EB_DEBUG_TOOL_DATA
		-- Preference data for debugger tool.

	diagram_tool_data: EIFFEL_DIAGRAM_PREFERENCES
		-- Preference data for the diagram tool.

	debugger_data: EB_DEBUGGER_DATA
		-- Preference data for debugger.		

	development_window_data: EB_DEVELOPMENT_WINDOW_PREFERENCES
		-- Preference data for the EiffelStudio main development window.

	recent_projects_data: EB_RECENT_PROJECTS
		-- Preference data for recently loaded EiffelStudio projects.	

	editor_data: EB_EDITOR_DATA
		-- Preference data for EiffelStudio editor

	search_tool_data: EB_SEARCH_TOOL_DATA
		-- Preference data for EiffelStudio search tool

	class_browser_data: EB_CLASS_BROWSER_DATA
		-- Preference data for class browser

invariant
	dialog_data_not_void: dialog_data /= Void
	context_tool_data_not_void: context_tool_data /= Void
	debug_tool_data_not_void: debug_tool_data /= Void
	debugger_data_not_void: debugger_data /= Void
	development_window_data_not_void: development_window_data /= Void
	recent_projects_data_not_void: recent_projects_data /= Void
	editor_data_not_void: editor_data /= Void
	search_tool_data_not_void: search_tool_data /= Void

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

end -- class EB_GUI_PREFERENCES
