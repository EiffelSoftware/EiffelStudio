indexing
	description: "Custom manager which can create custom preferences (in this case a DIRECTORY_RESOURCE)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	new_directory_preference_value (a_name: STRING; a_value: DIRECTORY_NAME): DIRECTORY_RESOURCE is
			-- Add a new directory path preference with name `a_name' and `a_value'.
		require
			name_valid: a_name /= Void and not a_name.is_empty
			value_not_void: a_value /= Void
			not_has_preference: not known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [DIRECTORY_NAME, DIRECTORY_RESOURCE]}).
				new_preference (preferences, Current, a_name, a_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_value_set: Result.value.is_equal (a_value)
			preference_added: preferences.has_preference (namespace + "." + a_name)
		end		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CUSTOM_MANAGER
