indexing
	description: "Preference data for interaction with dialogs."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DIALOG_DATA

create
	make

feature {GB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Initialize with `a_preferences'.
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end		

feature {GB_SHARED_PREFERENCES} -- Value

	show_deleting_keyboard_warning: BOOLEAN is
			-- 
		do
			Result := show_deleting_keyboard_warning_preference.value
		end	
		
	show_deleting_directories_warning: BOOLEAN is
			-- 
		do
			Result := show_deleting_directories_warning_preference.value
		end	
		
	show_deleting_final_directory_warning: BOOLEAN is
			-- 
		do
			Result := show_deleting_final_directory_warning_preference.value
		end	
		
	show_changing_client_type_warning: BOOLEAN is
			-- 
		do
			Result := show_changing_client_type_warning_preference.value
		end	

feature -- Preference

	show_deleting_keyboard_warning_preference: BOOLEAN_PREFERENCE
	
	show_deleting_directories_warning_preference: BOOLEAN_PREFERENCE
	
	show_deleting_final_directory_warning_preference: BOOLEAN_PREFERENCE
	
	show_changing_client_type_warning_preference: BOOLEAN_PREFERENCE

feature -- Preference Strings

	show_deleting_keyboard_warning_string: STRING is "graphical_elements.dialogs.show_deleting_keyboard_warning"
	
	show_deleting_directories_warning_string: STRING is "graphical_elements.dialogs.show_deleting_directories_warning"
	
	show_deleting_final_directory_warning_string: STRING is "graphical_elements.dialogs.show_deleting_final_directory_warning"
	
	show_changing_client_type_warning_string: STRING is "graphical_elements.dialogs.show_changing_client_type_warning"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: GB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "graphical_elements.dialogs")
			
			show_deleting_keyboard_warning_preference := l_manager.new_boolean_resource_value (l_manager, show_deleting_keyboard_warning_string, True)		
			show_deleting_directories_warning_preference := l_manager.new_boolean_resource_value (l_manager, show_deleting_directories_warning_string, True)		
			show_deleting_final_directory_warning_preference := l_manager.new_boolean_resource_value (l_manager, show_deleting_final_directory_warning_string, True)		
			show_changing_client_type_warning_preference := l_manager.new_boolean_resource_value (l_manager, show_changing_client_type_warning_string, True)	
		end
	
	preferences: PREFERENCES
			-- Preferences
	
invariant
	preferences_not_void: preferences /= Void

end
