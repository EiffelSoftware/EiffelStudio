indexing
	description: "Access to underlying data store for preferences."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_STRUCTURE

create
	make_empty,
	make_with_location

feature {PREFERENCES} -- Initialization	
	
	make_empty (a_resources: PREFERENCES) is
			-- Make a new underlying data store based upon the name of the application.
		require
			resources_not_void: a_resources /= Void
		local
			imp: PREFERENCE_STRUCTURE_IMP
		do
			default_create
			resources := a_resources
			create imp.make_empty (a_resources)
			implementation := imp	
		ensure
			has_implementation: implementation /= Void
		end

	make_with_location (a_resources: PREFERENCES; a_location: STRING) is
			-- Access underlying data store at `a_location'.
		require
			resources_not_void: a_resources /= Void
			location_not_empty: not a_location.is_empty
		local
			imp: PREFERENCE_STRUCTURE_IMP
		do
			default_create
			resources := a_resources
			create imp.make_with_location (a_resources, a_location)
			implementation := imp	
		ensure
			has_implementation: implementation /= Void
		end

feature {PREFERENCES} -- Access

	session_values: HASH_TABLE [STRING, STRING] is
			-- Session values.  Contains name and value of user-defined  
			-- resources which are loaded from the underlying data store.
		do
			Result := implementation.session_values
		ensure
			session_values_not_void: Result /= Void
		end

feature {PREFERENCES} -- Resource Management

	has_resource (a_name: STRING): BOOLEAN is
			-- Does a resource with `a_name' exist in the data store?
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := implementation.has_resource (a_name)
		end		
		
	get_resource_value (a_name: STRING): STRING is
			-- Get resource with name of `a_name' string value direct from underlying datastore.		
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := implementation.get_resource_value (a_name)
		end

	save_resource (a_resource: PREFERENCE) is
			-- Save `resource' to storage device.
		require		
			resource_not_void: a_resource /= Void
		do
			implementation.save_resource (a_resource)		
		end
		
	save_resources (a_resources: ARRAYED_LIST [PREFERENCE]) is
			-- Save all resources in `a_resources' to storage device.
		require
			resources_not_void: a_resources /= Void
		do
			implementation.save_resources (a_resources)
		end

	remove_resource (a_resource: PREFERENCE) is
			-- Remove `resource' from storage device.
		require		
			resource_not_void: a_resource /= Void
		do
			implementation.remove_resource (a_resource)		
		end	

feature {NONE} -- Implementation

	implementation: PREFERENCE_STRUCTURE_I
			-- Structure interface.

	resources: PREFERENCES
			-- Actual Preferences

invariant
	has_implementation: implementation /= Void

end -- class PREFERENCE_STRUCTURE
