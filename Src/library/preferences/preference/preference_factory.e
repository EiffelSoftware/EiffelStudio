note
	description: "[
			Helper factory to create new TYPED_PREFERENCE's.  This class is used by PREFERENCE_MANAGER to
			create new preferences and values.  Use PREFERENCE_MANAGER to manipulate PREFERENCE objects in your
			code.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_FACTORY [G, H -> TYPED_PREFERENCE [G] create make, make_from_string_value end]

feature -- Commands

	new_preference (preferences: PREFERENCES; a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: G): H
			-- Create a new preference with name `a_name'.  If preference cannot be found in
			-- underlying datastore or in a default values then `a_fallback_value' is used for the value.
		require
			preferences_not_void: preferences /= Void
			manager_not_void: a_manager /= Void
			not_has_preference: not a_manager.known_preference (a_name)
			name_valid: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_fallback_value /= Void
		local
			l_fullname: STRING
			l_value, l_desc: detachable STRING
		do
			l_fullname := a_name
			l_value := preferences.session_values.item (l_fullname)
			if l_value /= Void then
					-- Retrieve from saved values.
				create Result.make_from_string_value (a_manager, a_name, l_value)
				if attached preferences.default_values.item (l_fullname) as l_dft_value then
					Result.set_hidden (l_dft_value.hidden)
					Result.set_restart_required (l_dft_value.restart)
				end
			elseif attached preferences.default_values.item (l_fullname) as l_dft_value then
					-- Retrieve from default values.
				l_value := l_dft_value.value
				if l_value = Void then
					l_value := ""
				end
				create Result.make_from_string_value (a_manager, a_name, l_value)
				Result.set_hidden (l_dft_value.hidden)
				Result.set_restart_required (l_dft_value.restart)
			else
					-- Create with `a_value'.
				create Result.make (a_manager, a_name, a_fallback_value)
			end

					-- Set the default value for future resetting by user.
			if attached preferences.default_values.item (l_fullname) as l_dft_value then
				l_desc := l_dft_value.description
				l_value := l_dft_value.value
				if l_desc /= Void and then not l_desc.is_empty then
					Result.set_description (l_desc)
				end
				if l_value = Void then
					l_value := ""
				end
				Result.set_default_value (l_value)
			end

					-- Add to list of know preferences.
			preferences.preferences.put (Result, l_fullname)
		ensure
			has_result: Result /= Void
			preference_name_set: Result.name.is_equal (a_name)
			preference_added: preferences.has_preference (a_name)
		end

	new_resource (preferences: PREFERENCES; a_manager: PREFERENCE_MANAGER; a_name: STRING; a_fallback_value: G): H
		obsolete "[2006-01-13] use new_preference instead of new_resource."
		do
			Result := new_preference (preferences, a_manager, a_name, a_fallback_value)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class PREFERENCE_FACTORY
