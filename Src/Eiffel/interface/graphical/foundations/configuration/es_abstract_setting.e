note
	description: "[
		Base interface for a configuration "setting". See more concrete examples using preferences
		{ES_PREFERENCE_SETTING} and sessions {ES_SESSION_SETTING}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_ABSTRACT_SETTING [G -> ANY]

inherit
	ES_RECYCLABLE

convert
	value: {G}

feature -- Access

	value: G assign set_value
			-- Setting value
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Access

	default_value: G
			-- Default value
		deferred
		end

feature -- Element change

	set_value (a_value: like value)
			-- Set new value.
			--
			-- `a_value': New value.
		require
			is_interface_usable: is_interface_usable
			not_is_read_only: not is_read_only
			a_value_is_valid_value: is_valid_value (a_value)
		deferred
		end

--	set_default_value (a_default: like default_value)
--			-- Sets a default value, if the setting has not been set.
--			--
--			-- `a_value': A default value.
--		require
--			is_interface_usable: is_interface_usable
--			not_is_read_only: not is_read_only
--			a_value_is_valid_value: is_valid_value (a_value)
--		deferred
--		end

feature -- Status report

	is_set: BOOLEAN
			-- Indicates if the setting has been set explicitly.
		deferred
		ensure
			value_is_default: not Result implies (value ~ default_value)
		end

	is_read_only: BOOLEAN
			-- Indicates if the setting is read-only
		do
			Result := False
		end

	is_valid_value (a_value: like value): BOOLEAN
			-- Indicates if the value is valid.
			--
			-- `a_value': A value to validate.
			-- `Result': True if the value is valid; False otherwise.
		do
			Result := True
		end

feature -- Basic operations

	commit
			-- Commits any change immediately to storage.
		deferred
		end

feature -- Actions

	value_change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called when the value is changed.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
		end

invariant
	value_is_valid_value: is_valid_value (value)
	default_value_is_valid_value: is_valid_value (default_value)

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
