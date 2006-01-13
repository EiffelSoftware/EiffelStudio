indexing
	description: "[
			Interface to preference storage implementation which provides access to the underlying data store.
			If you wish to store preference values in a data store implement this class.
		]"

deferred class
	PREFERENCES_STORAGE_I

feature {NONE} -- Initialization

	make_empty is
			-- Create preferences storage.
			-- Location to store preferences will be generated based on name of application.
		deferred
		ensure
			has_location: location /= Void
		end

	make_with_location (a_location: STRING) is
			-- Create preference storage in the at location `a_location'.
			-- Try to read preference at `a_location' if it exists, if not create new one.

			-- Preferences will be stored in `a_location' between sessions, which is the
			-- path to either:
			--		* the root registry key where preferences are stored,
			--		* or the file where preferences are stored,
			-- depending on which storage is chosen (registry or xml ... ).
		require
		    location_not_void: a_location /= Void
		    location_not_empty: not a_location.is_empty
	   	deferred
	   	ensure
	   		has_location: location /= Void
		end

feature {PREFERENCES} -- Initialization

	initialize_with_preferences (a_preferences: PREFERENCES) is
			-- Initialize current with `a_preferences'.
		require
			not_initialized: not initialized
			preferences_is_void: preferences = Void
		do
			initialized := True
			preferences := a_preferences
		ensure
			preferences_assigned_and_not_void: preferences /= Void and then preferences = a_preferences
		end

	initialized: BOOLEAN
			-- is Current initialized with preferences ?

feature {PREFERENCES} -- Query

	has_preference (a_name: STRING): BOOLEAN is
			-- Does the underlying store contain a preference with `a_name'?
		require
			initialized: initialized
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		deferred
		end

	get_preference_value (a_name: STRING): STRING is
			-- Retrieve the preference string value from the underlying store.
		require
			initialized: initialized
		deferred
		end

feature {PREFERENCES} -- Access

	location: STRING
			-- The actual location of the underlying preference (filename, registry key, etc).

	session_values: HASH_TABLE [STRING, STRING]
			-- Hash of user-defined values which have been loaded.

	preferences: PREFERENCES
			-- Actual preferences

feature {PREFERENCES} -- Save

	save_preferences (a_preferences: ARRAYED_LIST [PREFERENCE]; a_save_modified_values_only: BOOLEAN) is
			-- Save all preferences in `a_preferences' to storage device.
			-- If `a_save_modified_values_only' then only preferences whose value is different
			-- from the default one are saved, otherwise all preferences are saved.
		require
			initialized: initialized
			argument_preferences_not_void: a_preferences /= Void
		do
			from
				a_preferences.start
			until
				a_preferences.after
			loop
				if not a_save_modified_values_only or else not a_preferences.item.is_default_value then
					save_preference (a_preferences.item)
				else
					remove_preference (a_preferences.item)
				end
				a_preferences.forth
			end
		end

	save_preference (a_preference: PREFERENCE) is
			-- Save `a_preference' to underlying data store
		require
			initialized: initialized
			agument_preference_not_void: a_preference /= Void
		deferred
		ensure
			preference_saved: True
		end

	remove_preference (a_preference: PREFERENCE) is
			-- Remove `preference' from storage device.
		require
			initialized: initialized
			argument_preference_not_void: a_preference /= Void
		deferred
		end

invariant
	has_location: location /= Void

	preferences_not_void_when_initialized: initialized implies preferences /= Void

end
