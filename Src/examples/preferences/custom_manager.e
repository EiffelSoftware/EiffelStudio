indexing
	description: "Custom manager which can create custom preferences (in this case a DIRECTORY_RESOURCE)."
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_MANAGER

inherit
	PREFERENCE_MANAGER
	
	GRAPHICAL_PREFERENCE_FACTORY

create
	make

feature -- Access

	new_directory_resource_value (a_name: STRING; a_value: DIRECTORY_NAME): DIRECTORY_RESOURCE is
			-- Add a new directory path resource with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void and not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_resource: not known_resource (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [DIRECTORY_NAME, DIRECTORY_RESOURCE]}).
				new_resource (preferences, Current, a_name, a_value)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_value_set: Result.value.is_equal (a_value)
			resource_added: preferences.has_resource (namespace + "." + a_name)
		end		

end -- class CUSTOM_MANAGER
