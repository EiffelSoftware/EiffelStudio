indexing
	description: "[
			Interface to resource structure implementation which provides access to the underlying data store.
			If you wish to store preference values in a data store implement this class.
		]"

deferred class
	PREFERENCE_STRUCTURE_I

feature -- Initialization

	make_empty (a_resources: PREFERENCES) is
			-- Create resource structure.  Location to store preferencec will be generated based on name of application.
		require
			resources_not_void: a_resources /= Void
		deferred
		ensure
			has_location: location /= Void
		end

	make_with_location (a_resources: PREFERENCES; a_location: STRING) is
			-- Create resource structure in the at location `a_location'.
			-- Try to read resource at `a_location' if it exists, if not create new one.
		require
		    location_not_void: a_location /= Void 
		    location_not_empty: not a_location.is_empty
			resources_not_void: a_resources /= Void
	   	deferred
	   	ensure
	   		has_location: location /= Void
		end

feature -- Query

	has_resource (a_name: STRING): BOOLEAN is
			-- Does the underlying store contain a resource with `a_name'?
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		deferred
		end
		
	get_resource_value (a_name: STRING): STRING is
			-- Retrieve the resource string value from the underlying store.
		require
			has_resource: has_resource (a_name)
		deferred
		ensure
			has_result: Result /= Void
		end	

feature -- Access

	location: STRING
			-- The actual location of the underlying resource (filename, registry key, etc).
			
	session_values: HASH_TABLE [STRING, STRING]
			-- Hash of user-defined values which have been loaded.

	resources: PREFERENCES
			-- Actual preferences

feature -- Save

	save (a_resources: ARRAYED_LIST [PREFERENCE]) is
			-- Save contents of structure.
		require
			resources_not_void: a_resources /= Void
		deferred
		end

	save_resource (a_resource: PREFERENCE) is
			-- Save `a_resource' to underlying data store
		require
			resource_not_void: a_resource /= Void		
		deferred
		ensure
			resource_saved: True
		end	

	remove_resource (a_resource: PREFERENCE) is
			-- Remove `resource' from storage device.
		require		
			resource_not_void: a_resource /= Void
		deferred
		end	

invariant
	has_location: location /= Void

end -- class PREFERENCE_STRUCTURE_I
