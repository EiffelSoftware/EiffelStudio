indexing
	description: "Preference data for interaction with dialogs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end
