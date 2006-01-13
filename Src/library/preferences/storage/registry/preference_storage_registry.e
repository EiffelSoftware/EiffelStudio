indexing
	description: "Windows Registry preferences storage implementation."

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
	make_with_location

feature {PREFERENCES} -- Initialization

	make_empty is
			-- Create preferences storage in the registry.  Registry key created base on name of application
			-- in `HKEY_CURRENT_USER\Software\'.  So location will be `HKEY_CURRENT_USER\Software\APPLICATION_NAME_HERE'
		local
			l_loc, l_prog: STRING
			l_exec: EXECUTION_ENVIRONMENT
		do
			create l_exec
			l_loc := "HKEY_CURRENT_USER\Software\"
			l_prog := l_exec.command_line.argument (0)
			if l_prog /= Void then
				l_prog := l_prog.substring (l_prog.last_index_of ('\', l_prog.count) + 1, l_prog.count) + "\"
			else
				l_prog := "\"
			end
			l_loc.append (l_prog)
			make_with_location (l_loc)
		end

	make_with_location (a_location: STRING) is
			-- Create preferences storage in the registry at location `a_location'.
			-- Try to read key at `a_location' if it exists, if not create new one.
		do
			create session_values.make (5)
			location := a_location
		end

feature {PREFERENCES} -- Initialization

	initialize_with_preferences (a_preferences: PREFERENCES) is
	   	local
			l_keyp: POINTER
			l_name,
			l_value: STRING
			l_key_values: LINKED_LIST [STRING]
		do
			Precursor (a_preferences)
			
			l_keyp := open_key_with_access (location, key_read)
			if l_keyp = default_pointer then
				create_new_key (location)
			else
				l_key_values := enumerate_values (l_keyp)
				if not l_key_values.is_empty then
					from
						l_key_values.start
					until
						l_key_values.after
					loop
						l_name := l_key_values.item
						l_value := key_value (l_keyp, l_name).string_value
						if l_name.has ('_') then
							l_name := l_name.substring (l_name.index_of ('_', 1) + 1, l_name.count)
						end
						if not session_values.has (l_name) then
							session_values.put (l_value, l_name)
						end
						l_key_values.forth
					end
				end
			end
		end

feature {PREFERENCES} -- Resource Management

	has_preference (a_name: STRING): BOOLEAN is
			-- Does the underlying store contain a preference with `a_name'?
		do
			Result := get_preference_value (a_name) /= Void
		end

	get_preference_value (a_name: STRING): STRING is
			-- Retrieve the preference string value from the underlying store.
		local
			l_handle: POINTER
			l_key_value: WEL_REGISTRY_KEY_VALUE
		do
			l_handle := open_key_with_access (location, Key_read)

			if valid_value_for_hkey (l_handle) then
				l_key_value := key_value (l_handle, a_name)
				if l_key_value /= Void then
					Result := l_key_value.string_value
				end
				close_key (l_handle)
			end
		end

	save_preference (a_preference: PREFERENCE) is
			-- Save `a_preference' to registry.
		local
			l_parent_key: POINTER
			l_new_value: WEL_REGISTRY_KEY_VALUE
			l_registry_preference_name: STRING
		do
			l_registry_preference_name := a_preference.string_type + "_" + a_preference.name
			l_parent_key := open_key_with_access (location, key_write)
			create l_new_value.make ({WEL_REGISTRY_KEY_VALUE_TYPE}.reg_sz, a_preference.string_value)

			if valid_value_for_hkey (l_parent_key) then
				set_key_value (l_parent_key, l_registry_preference_name, l_new_value)
				close_key (l_parent_key)
			end
		end

	remove_preference (a_preference: PREFERENCE) is
			-- Remove `preference' from storage device.
		local
			l_parent_key: POINTER
			l_registry_preference_name: STRING
		do
			l_registry_preference_name := a_preference.string_type + "_" + a_preference.name
			l_parent_key := open_key_with_access (location, key_write)
			if valid_value_for_hkey (l_parent_key) then
				delete_value (l_parent_key, l_registry_preference_name)
				close_key (l_parent_key)
			end
		end

invariant
	has_session_values: session_values /= Void

end
