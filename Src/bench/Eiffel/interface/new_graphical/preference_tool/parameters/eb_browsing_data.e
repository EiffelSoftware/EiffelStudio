indexing
	description: "All shared attributes for browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BROWSING_DATA

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
	
	class_completion: BOOLEAN is
			-- 
		do
			Result := class_completion_preference.value
		end		
	
	dock_tracking: BOOLEAN is
			-- 
		do
			Result := dock_tracking_preference.value
		end
	
	last_browsed_cluster_directory: STRING is
			-- 
		do
			Result := last_browsed_cluster_directory_preference.value
		end
	
feature {EB_SHARED_PREFERENCES} -- Preference
	
	class_completion_preference: BOOLEAN_PREFERENCE
	dock_tracking_preference: BOOLEAN_PREFERENCE
	last_browsed_cluster_directory_preference: STRING_PREFERENCE					
	
feature {NONE} -- Preference Strings

	class_completion_string: STRING is "browsing_tools.class_completion"
	dock_tracking_string: STRING is "browsing_tools.dock_tracking"
	last_browsed_cluster_directory_string: STRING is "browsing_tools.last_browsed_cluster_directory"

feature {NONE} -- Implementation
		
	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "browsing_tools")	
		
			class_completion_preference := l_manager.new_boolean_resource_value (l_manager, class_completion_string, True)
			dock_tracking_preference := l_manager.new_boolean_resource_value (l_manager, dock_tracking_string, True)
			last_browsed_cluster_directory_preference := l_manager.new_string_resource_value (l_manager, last_browsed_cluster_directory_string, "")
		end
	
	preferences: PREFERENCES
	
invariant
	preferences_not_void: preferences/= Void
	class_completion_preference_not_void: class_completion_preference /= Void
	dock_tracking_preference_not_void: dock_tracking_preference /= Void
	last_browsed_cluster_directory_preference_not_void:	last_browsed_cluster_directory_preference /= Void
	
end -- class EB_BROWSING_DATA
