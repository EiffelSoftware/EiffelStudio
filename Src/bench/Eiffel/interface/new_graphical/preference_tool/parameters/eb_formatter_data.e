indexing
	description: "All shared attributes of formatters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMATTER_DATA

inherit
	FEATURE_CLAUSE_NAMES

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

	editor_history_size: INTEGER is
			-- Number of memorized formatted text in formatters.
		do
			Result := editor_history_size_preference.value
		end

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

	show_syntactical_suppliers: BOOLEAN is
			-- Should the supplier formatter display syntactical suppliers
			-- (those whose name appear in the class) or
			-- actual ones (those of which a feature is called)?
--|FIXME XR: Not implemented.
		do
			Result := show_syntactical_suppliers_preference.value
		end

feature {NONE} -- Preference

	editor_history_size_preference: INTEGER_PREFERENCE
	default_class_formatter_index_preference: INTEGER_PREFERENCE
	default_feature_formatter_index_preference: INTEGER_PREFERENCE	
	show_syntactical_suppliers_preference: BOOLEAN_PREFERENCE
		
feature {NONE} -- Preference Strings

	editor_history_size_string: STRING is "formatter.formatters_history_size"
	default_class_formatter_index_string: STRING is "formatter.default_class_formatter_index"
	default_feature_formatter_index_string: STRING is "formatter.default_feature_formatter_index"
	
	show_syntactical_suppliers_string: STRING is "formatter.show_syntactical_suppliers"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "formatter")	
		
			editor_history_size_preference := l_manager.new_integer_resource_value (l_manager, editor_history_size_string, 60)
			default_class_formatter_index_preference := l_manager.new_integer_resource_value (l_manager, default_class_formatter_index_string, 5)
			default_feature_formatter_index_preference := l_manager.new_integer_resource_value (l_manager, default_feature_formatter_index_string, 2)
			show_syntactical_suppliers_preference := l_manager.new_boolean_resource_value (l_manager, show_syntactical_suppliers_string, False)		
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	editor_history_size_preference_not_void: editor_history_size_preference /= Void
	default_class_formatter_index_preference_not_void: default_class_formatter_index_preference /= Void
	default_feature_formatter_index_preference_not_void: default_feature_formatter_index_preference /= Void
	show_syntactical_suppliers_preference_not_void: show_syntactical_suppliers_preference /= Void

end -- class EB_FORMATTER_DATA
