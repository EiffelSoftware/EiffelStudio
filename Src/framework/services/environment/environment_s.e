note
	description: "[
		An environment service for access certain properties and variables held by the environment.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENVIRONMENT_S

inherit
	SERVICE_I

	USABLE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [ENVIRONMENT_OBSERVER, ENVIRONMENT_S]
		rename
			connection as environment_connection
		end

feature -- Access

	variables: LINEAR [READABLE_STRING_8]
			-- A complete list of registered environment variables.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = variables
		end

	variable (a_name: READABLE_STRING_GENERAL): detachable STRING assign set_variable
			-- Retrieves an associated values given a variable name.
			--
			-- `a_name': A variable name to retrieve an associated value for.
			-- `Result': An associated value or Void if the variable has not been set.
		require
			is_interface_usable: is_interface_usable
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		deferred
		end

feature -- Element change

	set_variable (a_value: detachable STRING; a_name: READABLE_STRING_GENERAL)
			-- Sets a variable in the Current environment.
			-- Note: This does not effect the environment variables themselves. To change the environment
			--       and any associated environment variable use `set_environment_variable'
			--
			-- `a_value': An associated value to bind to a given variable name.
			-- `a_name' : The name of the variable to set.
		require
			is_interface_usable: is_interface_usable
			not_a_value_is_empty: a_value /= Void and then not a_value.is_empty
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		deferred
		ensure
			a_name_is_set: (attached a_value) and then is_set (a_name)
			not_a_name_is_set: (not attached a_value) implies not is_set (a_name)
			a_name_set: is_set (a_name) and then ((attached variable (a_name) as l_value) and then l_value ~ a_value)
		end

	set_environment_variable (a_value: detachable STRING; a_name: READABLE_STRING_GENERAL)
			-- Like `set_variable' but will force the setting of an environment varable also.
			--
			-- `a_value': An associated value to bind to a given variable name.
			-- `a_name' : The name of the variable to set.
		require
			is_interface_usable: is_interface_usable
			not_a_value_is_empty: a_value /= Void and then not a_value.is_empty
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		deferred
		ensure
			a_name_is_set: (attached a_value) and then is_set (a_name)
			not_a_name_is_set: (not attached a_value) implies not is_set (a_name)
			a_name_set: is_set (a_name) and then ((attached variable (a_name) as l_value) and then l_value ~ a_value)
		end

feature -- Status report

	is_set (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a variable has been set.
			--
			-- `a_name': Name of the variable to check.
			-- `Result': True if the variable name as been set; False otherwise.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := attached variable (a_name)
		end

feature -- Query

	expand_string (a_string: READABLE_STRING_8; a_keep: BOOLEAN): STRING
			-- Expands a 8-bit string and replaces any variables with those found with a match value
			-- in `variable'.
			--
			-- `a_string': The string to expand.
			-- `a_keep'  : True to retain any unmatched variables in the result; False otherwise.
			-- `Result'  : An expanded string.
		require
			a_string_attached: a_string /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

--	expand_string_32 (a_string: READABLE_STRING_32; a_keep: BOOLEAN): STRING_32
--			-- Expands a 32-bit string and replaces any variables with those found with a match value
--			-- in `variable'.
--			--
--			-- `a_string': The string to expand.
--			-- `a_keep'  : True to retain any unmatched variables in the result; False otherwise.
--			-- `Result'  : An expanded string.
--		require
--			a_string_attached: a_string /= Void
--		deferred
--		ensure
--			result_attached: Result /= Void
--		end

feature -- Events

	value_changed_event: EVENT_TYPE_I [TUPLE [sender: ENVIRONMENT_S; name: detachable READABLE_STRING_GENERAL]]
			-- Event call when a value changes.
			--
			-- sender: The Current environment object publishing the event.
			-- name  : A variable name bound to the changed/removed value.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ value_changed_event
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
