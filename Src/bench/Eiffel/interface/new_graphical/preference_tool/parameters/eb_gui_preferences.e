indexing
	description: "Preferences for graphical components of the Eiffel Compiler."
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
			create formatter_data.make (a_preferences)
			create recent_projects_data.make (a_preferences)
			create editor_data.make (a_preferences)			
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
		
	development_window_data: EB_DEVELOPMENT_WINDOW_DATA
		-- Preference data for the EiffelStudio main development window.
		
	formatter_data: EB_FORMATTER_DATA
		-- Preference data for formatters.
		
	recent_projects_data: EB_RECENT_PROJECTS
		-- Preference data for recently loaded EiffelStudio projects.	

	editor_data: EB_EDITOR_DATA
		-- Preference data for EiffelStudio editor		

invariant
	dialog_data_not_void: dialog_data /= Void	
	context_tool_data_not_void: context_tool_data /= Void
	debug_tool_data_not_void: debug_tool_data /= Void
	debugger_data_not_void: debugger_data /= Void
	development_window_data_not_void: development_window_data /= Void	
	formatter_data_not_void: formatter_data /= Void
	recent_projects_data_not_void: recent_projects_data /= Void
	editor_data_not_void: editor_data /= Void
	
end -- class EB_GUI_PREFERENCES
