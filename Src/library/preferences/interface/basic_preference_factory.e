indexing
	description: "[
		This is a helper class used to initialize preferences.  To initialize a resource
		use the `new_*_resource_value' functions.  In doing so the following rules apply:
		
			1.  The resource name must be unique to the manager.  Note: it is possible to have a resource with
				the same name in a different manager.  For example you may have two resources name `editor.width' 
				and `application.width' in the same system, but not `editor.width' and `editor.width'.
				
			2.  If the resource is found in the underlying data store (registry or XML) from a previous session this
				saved value shall be used when the resource is initialized.  If there is no value in the underlying data store
				the value specified in a default file will be used.  If there is no default file or the resource does appear in the
				specified default file the value passed to the `new_*_resource_value' will be used.					
				
		To add custom resources inherit this class and implement a creation of custom resources.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_PREFERENCE_FACTORY

feature -- Access

	new_boolean_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: BOOLEAN): BOOLEAN_PREFERENCE is
			-- Add a new boolean resource with name `a_name'.  If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [BOOLEAN, BOOLEAN_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end		
		
	new_integer_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: INTEGER): INTEGER_PREFERENCE is
			-- Add a new integer resource with name `a_name'.   If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [INTEGER, INTEGER_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_string_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: STRING): STRING_PREFERENCE is
			-- Add a new string resource with name `a_name'.  If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [STRING, STRING_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	
		
	new_array_resource_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ARRAY [STRING]): ARRAY_PREFERENCE is
			-- Add a new array resource with name `a_name'.  If preference cannot be found in 
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_resource: not a_manager.known_resource (a_name)
		do		
			Result := (create {PREFERENCE_FACTORY [ARRAY [STRING], ARRAY_PREFERENCE]}).
				new_resource (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: a_manager.preferences.has_resource (a_name)
		end	

end
