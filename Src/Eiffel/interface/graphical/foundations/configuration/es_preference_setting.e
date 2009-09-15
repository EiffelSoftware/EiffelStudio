note
	description: "[
		Base implementation for all preference-based configuration settings.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_PREFERENCE_SETTING [G -> ANY]

inherit
	ES_ABSTRACT_SETTING [G]
		redefine
			is_interface_usable,
			internal_recycle
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

convert
	value: {G}

feature {NONE} -- Initialization

	make (a_preference: like preference; a_default: like default_value)
			-- Creates a new setting based on a preference.
			--
			-- `a_preference': Preference object used to query and store the setting.
			-- `a_default': A default value, used if there was not session value set.
		require
			a_preference_attached: attached a_preference
			a_default_is_valid_value: is_valid_value (a_default)
		do
			preference := a_preference
			default_value := a_default
		ensure
			preference_set: preference = a_preference
			default_value_set: default_value = a_default
		end

	make_from_name (a_preference_name: READABLE_STRING_8; a_default: like default_value)
			-- Creates a new setting based on a preference, using a preference name.
			--
			-- `a_preference_name': Name of the preference.
			-- `a_default': A default value, used if there was not session value set.
		require
			a_preference_name_attached: attached a_preference_name
			not_a_preference_name_is_empty: not a_preference_name.is_empty
			has_a_preference_name: preferences.preferences.has_preference (a_preference_name)
			a_default_is_valid_value: is_valid_value (a_default)
		do
			if attached {like preference} preferences.preferences.get_preference (a_preference_name) as l_preference then
				make (l_preference, a_default)
			else
				default_value := a_default
			end
		ensure
			default_value_set: default_value = a_default
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if attached internal_value_change_actions as l_actions then
				l_actions.wipe_out
				if attached preference as l_preference then
					l_preference.change_actions.prune (agent on_preference_value_changed)
				end
			end
		end

feature -- Access

	value: G assign set_value
			-- <Precursor>
		local
			l_preference: like preference
		do
			l_preference := preference
			if attached l_preference and then l_preference.has_value and then attached {G} l_preference.value as l_result then
				Result := l_result
			else
				Result := default_value
			end
		end

	preference: detachable TYPED_PREFERENCE [G]
			-- Preference object to query value from.
		note
			options: stable
		attribute
		end

feature {NONE} -- Access

	default_value: G
			-- <Precursor>

feature -- Element change

	set_value (a_value: like value)
			-- <Precursor>.
		do
			if attached preference as l_preference then
				l_preference.set_value (a_value)
			end
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then attached preference
		ensure then
			preference_attached: Result implies attached preference
		end

	is_set: BOOLEAN
			-- <Precursor>
		do
			Result := preference.is_default_value
		end

feature -- Basic operations

	commit
			-- <Precursor>
		do
			if attached preference as l_preference then
				preferences.preferences.save_preference (l_preference)
			end
		end

feature -- Actions

	value_change_actions: ACTION_SEQUENCE [TUPLE]
			-- <Precursor>
		do
			if attached internal_value_change_actions as l_result then
				Result := l_result
			else
				create Result
				if attached preference as l_preference then
					l_preference.change_actions.extend (agent on_preference_value_changed)
				end
			end
		end

feature {NONE} -- Event handler

	on_preference_value_changed
			-- Called when a preference value changes
		require
			is_interface_usable: is_interface_usable
			internal_value_change_actions_attached: attached internal_value_change_actions
		do
			if attached internal_value_change_actions as l_result then
				l_result.call (Void)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_value_change_actions: detachable like value_change_actions
			-- Cached version of `value_change_actions'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
