note
	description: "[
			Interface to preference storage implementation which provides access to the underlying data store.
			If you wish to store preference values in a data store implement this class.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	PREFERENCES_STORAGE_I

inherit
	PREFERENCE_EXPORTER

	PREFERENCES_VERSIONS

feature {NONE} -- Initialization

	make_empty
			-- Create preferences storage.
			-- Location to store preferences will be generated based on name of application.
		deferred
		ensure
			has_location: location /= Void
			default_version: version.same_string (default_version)
		end

	frozen make_versioned (a_version: attached like version)
			-- Create preferences storage with `a_version' as `version'.
			-- Location to store preferences will be generated based on name of application.
			-- Redefine `make_empty' to change behavior.
		require
			a_version_not_void: a_version /= Void
			a_version_valid: valid_version (a_version)
		do
			make_empty
			internal_version := a_version
		ensure
			has_location: location /= Void
			version_set: version = a_version
		end

	make_with_location (a_location: READABLE_STRING_GENERAL)
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
	   	do
			create session_values.make (5)
			location := a_location
	   	ensure
	   		has_location: location /= Void
			location_set: location = a_location
			default_version: version.same_string (default_version)
		end

	frozen make_with_location_and_version (a_location: READABLE_STRING_GENERAL; a_version: attached like version)
			-- Create preference storage in the at location `a_location' with `a_version' as `version'.
			-- Try to read preference at `a_location' if it exists, if not create new one.

			-- Preferences will be stored in `a_location' between sessions, which is the
			-- path to either:
			--		* the root registry key where preferences are stored,
			--		* or the file where preferences are stored,
			-- depending on which storage is chosen (registry or xml ... ).
			-- Redefine `make_with_location' to change behavior.
		require
		    location_not_void: a_location /= Void
		    location_not_empty: not a_location.is_empty
			a_version_not_void: a_version /= Void
			a_version_valid: valid_version (a_version)
		do
			make_with_location (a_location)
			internal_version := a_version
	   	ensure
	   		has_location: location /= Void
			location_set: location = a_location
			version_set: version = a_version
		end

feature {PREFERENCES} -- Initialization

	initialize_with_preferences (a_preferences: PREFERENCES)
			-- Initialize current with `a_preferences'.
		require
			not_initialized: not initialized
			preferences_is_void: preferences = Void
			a_preferences_not_void: a_preferences /= Void
		do
			initialized := True
			preferences := a_preferences
		ensure
			preferences_assigned_and_not_void: preferences /= Void and then preferences = a_preferences
		end

	initialized: BOOLEAN
			-- is Current initialized with preferences ?

feature {PREFERENCES} -- Query

	has_preference (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does the underlying store contain a preference with `a_name'?
		require
			initialized: initialized
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			name_is_valid_string_8: a_name.is_valid_as_string_8
		deferred
		end

	get_preference_value (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Retrieve the preference string value from the underlying store.
		require
			initialized: initialized
		deferred
		end

	exists: BOOLEAN
			-- Does storage exists ?
		require
			initialized: initialized
		deferred
		end

feature -- Access

	version: IMMUTABLE_STRING_32
			-- Format version.
		do
			if attached internal_version as l_version then
				Result := l_version
			else
				Result := default_version
			end
		end

feature {PREFERENCES} -- Access

	location: READABLE_STRING_GENERAL
			-- The actual location of the underlying preference (filename, registry key, etc).

	session_values: STRING_TABLE [READABLE_STRING_32]
			-- Hash of user-defined values which have been loaded.

	preferences: detachable PREFERENCES
			-- Actual preferences


feature {PREFERENCES} -- Save

	save_preferences (a_preferences: ARRAYED_LIST [PREFERENCE]; a_save_modified_values_only: BOOLEAN)
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

	save_preference (a_preference: PREFERENCE)
			-- Save `a_preference' to underlying data store
		require
			initialized: initialized
			agument_preference_not_void: a_preference /= Void
		deferred
		ensure
			preference_saved: True
		end

	remove_preference (a_preference: PREFERENCE)
			-- Remove `preference' from storage device.
		require
			initialized: initialized
			argument_preference_not_void: a_preference /= Void
		deferred
		end

feature {NONE} -- Implementation

	internal_version: detachable like version
			-- Storage for `version' if specified.

invariant
	has_location: location /= Void

	preferences_not_void_when_initialized: initialized implies preferences /= Void

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
