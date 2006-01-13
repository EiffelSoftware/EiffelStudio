indexing
	description: "[
		Manager of related preference values.
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

	known_preference (a_name: STRING): BOOLEAN is
			-- Is the preference with `a_name' in the system?
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := preferences.has_preference (namespace + "." + a_name)
		end

	known_resource (a_name: STRING): BOOLEAN is
		obsolete "use know_preference instead of know_resource"
		do
			Result := known_preference (a_name)
		end

feature {BASIC_PREFERENCE_FACTORY} -- Implementation

	preferences: PREFERENCES
			-- Preferences.

invariant
	has_preferences: preferences /= Void
	has_namespace: namespace /= Void
	namespace_valid: not namespace.is_empty

end -- class PREFERENCE_MANAGER
