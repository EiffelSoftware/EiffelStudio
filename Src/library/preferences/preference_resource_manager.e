indexing
	description: "[
		Manager of related preference values.  This is a helper class used to initialize preferences.
		The namespace indicates the top-level organizational identifier for this manager.  To initialize a resource
		use the `new_*_resource_value' functions.  In doing so the following rules apply:
		
			1.  The resource name must be unique to this manager.  Note: it is possible to have a resource with
				the same name in a different manager.  For example you may have two resources name `editor.width' 
				and `application.width' in the same system, but not `editor.width' and `editor.width'.
				
			2.  If the resource is found in the underlying data store (registry or XML) from a previous session this
				saved value shall be used when the resource is initialized.  If there is no value in the underlying data store
				the value specified in a default file will be used.  If there is no default file or the resource does appear in the
				specified default file the value passed to the `new_*_resource_value' will be used.					
				
		To add custom resources inherit PREFERENCE_MANAGER and implement a custom manager with a feature like 'new_custom_resource_value'.
				
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_MANAGER

create {PREFERENCES}
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES; a_namespace: STRING) is
			-- New manager.
		require
			preferences_not_void: a_preferences /= Void
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
		do
			preferences := a_preferences
			namespace := a_namespace
			preferences.add_manager (Current)			
		ensure
			has_preferences: preferences /= Void
			inserted_in_preferences: preferences.has_manager (namespace)
			has_namespace: namespace /= Void
			namesapce_valid: not a_namespace.is_empty
		end		

feature -- Access

	namespace: STRING
			-- Name for this manager.

feature -- Query

	known_resource (a_name: STRING): BOOLEAN is
			-- Is the resource with `a_name' in the system?
		require
			name_not_void: a_name /= Void 
			name_not_empty: not a_name.is_empty
		do
			Result := preferences.has_resource (namespace + "." + a_name)	
		end		
		
feature {BASIC_PREFERENCE_FACTORY} -- Implementation

	preferences: PREFERENCES
			-- Preferences.

invariant	
	has_preferences: preferences /= Void
	has_namespace: namespace /= Void
	namespace_valid: not namespace.is_empty

end -- class PREFERENCE_MANAGER
