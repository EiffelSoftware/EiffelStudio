indexing
	description: "All shared attributes specific to the context tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_TOOL_DATA

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
	
	default_class_formatter_index: INTEGER is
			-- Default class formatter that should be popped up automatically.
		do
			Result := default_class_formatter_index_preference.value
		end

	default_feature_formatter_index: INTEGER is
			-- Default feature formatter that should be popped up automatically.
		do
			Result := default_feature_formatter_index_preference.value
		end		
		
	editor_history_size: INTEGER is
			-- Number of memorized formatted text in formatters.
		do
			Result := editor_history_size_preference.value
		end	
		
feature {EB_SHARED_PREFERENCES} -- Preference

	editor_history_size_preference: INTEGER_PREFERENCE
	default_class_formatter_index_preference: INTEGER_PREFERENCE
	default_feature_formatter_index_preference: INTEGER_PREFERENCE	

feature {NONE} -- Preference Strings

	editor_history_size_string: STRING is "tools.context_tool.formatters_history_size"
	default_class_formatter_index_string: STRING is "tools.context_tool.default_class_formatter_index"
	default_feature_formatter_index_string: STRING is "tools.context_tool.default_feature_formatter_index"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "context_tool")								
			editor_history_size_preference := l_manager.new_integer_resource_value (l_manager, editor_history_size_string, 60)
			default_class_formatter_index_preference := l_manager.new_integer_resource_value (l_manager, default_class_formatter_index_string, 5)
			default_feature_formatter_index_preference := l_manager.new_integer_resource_value (l_manager, default_feature_formatter_index_string, 2)
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void

end -- class EB_CONTEXT_TOOL_DATA

