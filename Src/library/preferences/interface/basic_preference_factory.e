indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_PREFERENCE_FACTORY

feature -- Access

	new_boolean_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: BOOLEAN): BOOLEAN_PREFERENCE is
			-- Add a new boolean resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [BOOLEAN, BOOLEAN_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end		
		
	new_integer_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: INTEGER): INTEGER_PREFERENCE is
			-- Add a new integer resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [INTEGER, INTEGER_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_string_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: STRING): STRING_PREFERENCE is
			-- Add a new string resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [STRING, STRING_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_array_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: ARRAY [STRING]): ARRAY_PREFERENCE is
			-- Add a new array resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [ARRAY [STRING], ARRAY_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	

end
