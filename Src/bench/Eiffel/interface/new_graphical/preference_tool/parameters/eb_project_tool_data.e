indexing
	description: "All shared attributes specific to the project tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_TOOL_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature {EB_SHARED_PREFERENCES} -- Value

	raise_on_error: BOOLEAN is
		do
			Result := raise_on_error_preference.value
		end

	context_unified_stone: BOOLEAN is
		do
			Result := context_unified_stone_preference.value
		end

	graphical_output_disabled: BOOLEAN is
		do
			Result := graphical_output_disabled_preference.value
		end

feature {NONE} -- Preference

	raise_on_error_preference: BOOLEAN_PREFERENCE
	context_unified_stone_preference: BOOLEAN_PREFERENCE
	graphical_output_disabled_preference: BOOLEAN_PREFERENCE			
		
feature {NONE} -- Preference Strings

	raise_on_error_string: STRING is "tools.project_tool.raise_on_error"
	context_unified_stone_string: STRING is "tools.project_tool.unified_stone"
	graphical_output_disabled_string: STRING is "tools.project_tool.graphical_output_disabled"			

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "project_tool")	
		
			raise_on_error_preference := l_manager.new_boolean_resource_value (l_manager, raise_on_error_string, True)
			context_unified_stone_preference := l_manager.new_boolean_resource_value (l_manager, context_unified_stone_string, False)
			graphical_output_disabled_preference := l_manager.new_boolean_resource_value (l_manager, graphical_output_disabled_string, False)			
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	raise_on_error_preference_not_void: raise_on_error_preference /= Void
	context_unified_stone_preference_not_void: context_unified_stone_preference /= Void
	graphical_output_disabled_preference_not_void: graphical_output_disabled_preference /= Void	

end -- class EB_PROJECT_TOOL_DATA
