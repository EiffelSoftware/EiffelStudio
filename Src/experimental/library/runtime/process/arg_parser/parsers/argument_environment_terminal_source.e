note
	description: "[
		An extended version of {ARGUMENT_TERMINAL_SOURCE} that aguments the terminal command line
		arguments with a value take from an environment variable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_ENVIRONMENT_TERMINAL_SOURCE

inherit
	ARGUMENT_TERMINAL_SOURCE
		undefine
			arguments,
			terminal_arguments
		redefine
			is_empty
		end

	ENVIRONMENT_ARGUMENTS
		rename
			environment_arguments as arguments,
			base_arguments as terminal_arguments
		end

create
	make

feature {NONE} -- Initialization

	make (a_var_name: READABLE_STRING_32)
			-- Initializes an argument source with an environment variable.
			--
			-- `a_var_name': Name of the environment variable, see `variable_name'.
		require
			a_var_name_attached: attached a_var_name
			not_a_var_name_is_empty: not a_var_name.is_empty
		do
			create arguments_environment_name.make_from_string (a_var_name)
		ensure
			arguments_environment_name_set: arguments_environment_name.same_string (a_var_name)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := argument_count > 0
		ensure then
			argument_count_positive: Result implies argument_count > 0
		end

feature {NONE} -- Implementation

	arguments_environment_name: IMMUTABLE_STRING_32
			-- <Precursor>

invariant
	arguments_environment_name_attached: attached arguments_environment_name
	not_arguments_environment_name_is_empty: not arguments_environment_name.is_empty

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
