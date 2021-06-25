note
	description: "[
			This is a helper class used to initialize preferences.  To initialize a preference
			use the `new_*_preference_value' functions.  In doing so the following rules apply:
			
				1.  The preference name must be unique to the manager.  Note: it is possible to have a preference with
					the same name in a different manager.  For example you may have two preferences name `editor.width'
					and `application.width' in the same system, but not `editor.width' and `editor.width'.
			
				2.  If the preference is found in the underlying data store (registry or XML) from a previous session this
					saved value shall be used when the preference is initialized.  If there is no value in the underlying data store
					the value specified in a default file will be used.  If there is no default file or the preference does appear in the
					specified default file the value passed to the `new_*_preference_value' will be used.
			
			To add custom preferences inherit this class and implement a creation of custom preferences.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_PREFERENCE_FACTORY

feature -- Access: Basic type

	new_boolean_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: BOOLEAN): BOOLEAN_PREFERENCE
			-- Add a new boolean preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [BOOLEAN, BOOLEAN_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			instance_free: class
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_integer_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: INTEGER): INTEGER_PREFERENCE
			-- Add a new integer preference with name `a_name'.   If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [INTEGER, INTEGER_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

feature -- Access: Strings

	new_string_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: STRING): STRING_PREFERENCE
			-- Add a new string preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [STRING, STRING_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_string_32_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: READABLE_STRING_32): STRING_32_PREFERENCE
			-- Add a new string preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [STRING_32, STRING_32_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_path_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: PATH): PATH_PREFERENCE
			-- Add a new path preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [PATH, PATH_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

feature -- Access: Lists

	new_string_list_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ITERABLE [READABLE_STRING_GENERAL]): STRING_LIST_PREFERENCE
			-- Add a new `list of strings' preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		local
			lst: LIST [STRING_32]
		do
			if attached {LIST [STRING_32]} a_fallback_value as l_fb then
				lst := l_fb
			else
				create {ARRAYED_LIST [STRING_32]} lst.make (0)
				⟳ s: a_fallback_value ¦ lst.extend (s.to_string_32) ⟲
			end
			Result := (create {PREFERENCE_FACTORY [like {STRING_LIST_PREFERENCE}.value, STRING_LIST_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, lst)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_path_list_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ITERABLE [PATH]): PATH_LIST_PREFERENCE
			-- Add a new `list of paths' preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		local
			lst: LIST [PATH]
		do
			if attached {LIST [PATH]} a_fallback_value as l_fb then
				lst := l_fb
			else
				create {ARRAYED_LIST [PATH]} lst.make_from_iterable (a_fallback_value)
			end
			Result := (create {PREFERENCE_FACTORY [like {PATH_LIST_PREFERENCE}.value, PATH_LIST_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, lst)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

feature -- Access: Choices

	new_string_choice_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ITERABLE [READABLE_STRING_GENERAL]): STRING_CHOICE_PREFERENCE
			-- Add a new `list of strings' preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		local
			lst: LIST [STRING_32]
		do
			if attached {LIST [STRING_32]} a_fallback_value as l_fb then
				lst := l_fb
			else
				create {ARRAYED_LIST [STRING_32]} lst.make (0)
				⟳ s: a_fallback_value ¦ lst.extend (s.to_string_32) ⟲
			end
			Result := (create {PREFERENCE_FACTORY [like {STRING_CHOICE_PREFERENCE}.value, STRING_CHOICE_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, lst)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_path_choice_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ITERABLE [PATH]): PATH_CHOICE_PREFERENCE
			-- Add a new `list of paths' preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		local
			lst: LIST [PATH]
		do
			if attached {LIST [PATH]} a_fallback_value as l_fb then
				lst := l_fb
			else
				create {ARRAYED_LIST [PATH]} lst.make_from_iterable (a_fallback_value)
			end
			Result := (create {PREFERENCE_FACTORY [like {PATH_CHOICE_PREFERENCE}.value, PATH_CHOICE_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, lst)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

feature -- Access: Arrays

	new_array_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ARRAY [STRING]): ARRAY_PREFERENCE
			-- Add a new array preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [ARRAY [STRING], ARRAY_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

	new_array_32_preference_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: ARRAY [STRING_32]): ARRAY_32_PREFERENCE
			-- Add a new array preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
			not_has_preference: not a_manager.known_preference (a_name)
		do
			Result := (create {PREFERENCE_FACTORY [ARRAY [STRING_32], ARRAY_32_PREFERENCE]}).
				new_preference (a_manager.preferences, a_manager, a_name, a_fallback_value)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: a_manager.preferences.has_preference (a_name)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
