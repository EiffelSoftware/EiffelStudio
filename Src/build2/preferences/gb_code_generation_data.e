indexing
	description: "Preferences for code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATION_DATA
	
create
	make

feature {GB_PREFERENCES} -- Initialization

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

feature {GB_SHARED_PREFERENCES} -- Value

	generate_empty_directories: BOOLEAN is
			-- 
		do
			Result := generate_empty_directories_preference.value
		end		

feature -- Preference

	generate_empty_directories_preference: BOOLEAN_PREFERENCE

feature -- Preference Strings

	generate_empty_directories_string: STRING is "code_generation.generate_empty_directories"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: GB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "dialogs")			
							
			generate_empty_directories_preference := l_manager.new_boolean_resource_value (l_manager, generate_empty_directories_string, True)		
		end
	
	preferences: PREFERENCES
			-- Preferences
	
invariant
	preferences_not_void: preferences /= Void
	generate_empty_directories_preference_not_void: generate_empty_directories_preference /= Void

end
