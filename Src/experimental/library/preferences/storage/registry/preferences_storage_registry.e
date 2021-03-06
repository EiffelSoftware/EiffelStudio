note
	description: "Windows Registry preferences storage implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	PREFERENCES_STORAGE_REGISTRY

inherit
	PREFERENCES_STORAGE_I
		redefine
			initialize_with_preferences
		end

	WEL_REGISTRY

create
	make_empty,
	make_versioned,
	make_with_location,
	make_with_location_and_version

feature {PREFERENCES} -- Initialization

	make_empty
			-- Create preferences storage in the registry.  Registry key created base on name of application
			-- in `HKEY_CURRENT_USER\Software\'.  So location will be `HKEY_CURRENT_USER\Software\APPLICATION_NAME_HERE'
		local
			l_loc: STRING_32
			l_exec: EXECUTION_ENVIRONMENT
			l_path: PATH
		do
			create l_exec
			create l_loc.make_from_string_general ("HKEY_CURRENT_USER\Software\")
			create l_path.make_from_string (l_exec.arguments.command_name)
			if attached l_path.entry as l_entry then
				l_loc.append_string (l_entry.name)
				l_loc.append_string_general ("\")
			else
					-- Very unlikely there will be no name, but who knows.
				l_loc.append_string_general ("EiffelDefaultApplication\")
			end
			make_with_location (l_loc)
		end

feature {PREFERENCES} -- Initialization

	initialize_with_preferences (a_preferences: PREFERENCES)
	   	local
			l_keyp: POINTER
			l_name: STRING_32
			l_value: detachable STRING_32
			l_key_values: LINKED_LIST [STRING_32]
			l_is_new_format: BOOLEAN
		do
			Precursor (a_preferences)

			l_keyp := open_key_with_access (location, key_read)
			if l_keyp /= default_pointer then
				l_key_values := enumerate_values (l_keyp)
				if not l_key_values.is_empty then
					from
						l_is_new_format := not is_format_version_1_0
						l_key_values.start
					until
						l_key_values.after
					loop
						l_name := l_key_values.item
						if attached key_value (l_keyp, l_name) as l_key_value then
							l_value := l_key_value.string_value
							if not l_is_new_format then
								if l_name.has ('_') then
									l_name := l_name.substring (l_name.index_of ('_', 1) + 1, l_name.count)
								end
							end
							session_values.put (l_value, l_name)
						else
							check key_value_exists: False end
						end
						l_key_values.forth
					end
				end
				close_key (l_keyp)
			end
		end

feature {PREFERENCES} -- Resource Management

	exists: BOOLEAN
			-- Does storage exists ?
		do
			Result := True
				--| Registry exists by default on Windows
				--| If the related key did not exists,
				--|   `initialize_with_preferences' created it anyway
		end

	has_preference (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does the underlying store contain a preference with `a_name'?
		do
			Result := get_preference_value (a_name) /= Void
		end

	get_preference_value (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Retrieve the preference string value from the underlying store.
		local
			l_handle: POINTER
		do
			l_handle := open_key_with_access (location, Key_read)

			if valid_value_for_hkey (l_handle) then
				if attached key_value (l_handle, a_name) as l_key_value then
					Result := l_key_value.string_value
				end
				close_key (l_handle)
			end
		end

	save_preference (a_preference: PREFERENCE)
			-- Save `a_preference' to registry.
		local
			l_parent_key: POINTER
			l_new_value: WEL_REGISTRY_KEY_VALUE
			l_registry_preference_name: STRING
		do
			l_parent_key := open_key_with_access (location, key_write)
			if not  valid_value_for_hkey (l_parent_key) then
				create_new_key (location)
				l_parent_key := open_key_with_access (location, key_write)
			end
			if valid_value_for_hkey (l_parent_key) then
				if is_format_version_1_0 then
					l_registry_preference_name := a_preference.string_type + "_" + a_preference.name
				else
					l_registry_preference_name := a_preference.name
				end
				create l_new_value.make ({WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz, a_preference.text_value)
				set_key_value (l_parent_key, l_registry_preference_name, l_new_value)
				close_key (l_parent_key)
			end
		end

	remove_preference (a_preference: PREFERENCE)
			-- Remove `preference' from storage device.
		local
			l_parent_key: POINTER
			l_registry_preference_name: STRING
		do
			l_parent_key := open_key_with_access (location, key_write)
			if not  valid_value_for_hkey (l_parent_key) then
				create_new_key (location)
				l_parent_key := open_key_with_access (location, key_write)
			end
			if valid_value_for_hkey (l_parent_key) then
				if is_format_version_1_0 then
					l_registry_preference_name := a_preference.string_type + "_" + a_preference.name
				else
					l_registry_preference_name := a_preference.name
				end
				delete_value (l_parent_key, l_registry_preference_name)
				close_key (l_parent_key)
			end
		end

feature {NONE} -- Implementation

	is_format_version_1_0: BOOLEAN
			-- Is storage using the old format which does store the type along the name of the preferences?
		do
			Result := version.same_string (version_1_0)
		end

invariant
	has_session_values: session_values /= Void

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
