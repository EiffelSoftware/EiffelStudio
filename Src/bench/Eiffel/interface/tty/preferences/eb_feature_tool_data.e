indexing
	description: "All shared attributes specific to the feature tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

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

	show_all_callers: BOOLEAN is
			-- Show all callers (as opposed to local callers) in `callers' form
		do
			Result := show_all_callers_preference.value
		end

	expand_feature_tree: BOOLEAN is
			-- Automatically expand the feature tree
		do
			Result := expand_feature_tree_preference.value
		end

feature {NONE} -- Preference

	show_all_callers_preference: BOOLEAN_PREFERENCE
		-- Show all callers (as opposed to local callers) in `callers' form

	expand_feature_tree_preference: BOOLEAN_PREFERENCE
		-- Automatically expand the feature tree

feature {NONE} -- Preference Strings

	expand_feature_tree_string: STRING is "feature_tool.expand_feature_tree"	
	show_all_callers_string: STRING is "feature_tool.show_all_callers"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "feature_tool")			
							
			show_all_callers_preference := l_manager.new_boolean_resource_value (l_manager, show_all_callers_string, False)		
			expand_feature_tree_preference := l_manager.new_boolean_resource_value (l_manager, expand_feature_tree_string, True)					
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	show_all_callers_preference_not_void: show_all_callers_preference /= Void
	expand_feature_tree_preference_not_void: expand_feature_tree_preference /= Void	

end -- class EB_FEATURE_TOOL_DATA
