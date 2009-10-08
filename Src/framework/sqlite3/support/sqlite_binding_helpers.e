note
	description: "[
		Helper functions for supporting statement argument binding.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BINDING_HELPERS

feature -- Status report

	is_valid_argument (a_value: detachable ANY): BOOLEAN
			-- Indicates if the value is of an accepted type.
			--
			-- `a_value': A value to check.
			-- `Result': True if the value type is marshallable; False otherwise.
		do
			Result := not attached a_value or else
				attached {READABLE_STRING_8} a_value or else
				attached {SQLITE_BIND_ARG [ANY]} a_value or else
				attached {MANAGED_POINTER}

			if not Result and attached a_value then
					-- Check scalar types
				Result := True
				inspect internal.dynamic_type (a_value)
				when
					{INTERNAL}.integer_8_type,
					{INTERNAL}.integer_16_type,
					{INTERNAL}.integer_32_type,
					{INTERNAL}.integer_64_type,
					{INTERNAL}.natural_8_type,
					{INTERNAL}.natural_16_type,
					{INTERNAL}.natural_32_type,
					{INTERNAL}.real_32_type,
					{INTERNAL}.real_64_type
				then
						-- Supported basic type
					check Result end
				else
						-- Unsupported type
					Result := False
				end
			end
		end

	is_valid_arguments (a_args: TUPLE): BOOLEAN
			-- Determines if an argument tuple is valid.
			--
			-- `a_args': A tuple of arguments to validate.
			-- `Result': True if the supplied tuple contains valid value for arguments; False otherwise.
		require
			a_args_attached: attached a_args
			not_a_args_is_empty: not a_args.is_empty
		local
			i_count, i: INTEGER
		do
			Result := a_args.count <= SQLITE_LIMIT_VARIABLE_NUMBER
			from
				i := 1
				i_count := a_args.count
			until
				i > i_count or not Result
			loop
				Result := is_valid_argument (a_args[i])
				i := i + 1
			end
		ensure
			a_args_small_enough: Result implies a_args.count <= SQLITE_LIMIT_VARIABLE_NUMBER
		end

	is_valid_variable_name (a_var: READABLE_STRING_8): BOOLEAN
			-- Determines if a SQLite variable name is valid.
			--
			-- `a_var': Name of the variable, including a qualifier.
			-- `Result': True if the variable is a valid SQLite variable; False otherwise
		require
			a_var_attached: attached a_var
			not_a_var_is_empty: not a_var.is_empty
		local
			l_qualifier, c: CHARACTER
			i_count, i: INTEGER
			l_index_str: READABLE_STRING_8
		do
			l_qualifier := a_var[1]

			if l_qualifier = '?' then
					-- Numeric index
				i_count := a_var.count
				Result := i_count = 1
				if not Result then
					l_index_str := a_var.substring (2, i_count)
					if l_index_str.is_integer_32 then
						i := l_index_str.to_integer_32
						Result := i > 0 and i <= SQLITE_LIMIT_VARIABLE_NUMBER
					end
				end
			elseif l_qualifier = ':' or l_qualifier = '@' or l_qualifier = '$' then
					-- Named variable
				i_count := a_var.count
				Result := i_count > 1
				if Result then
					from i := 2 until i > i_count or not Result loop
						c := a_var [i]
						Result := c.is_printable and not c.is_space
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- Helpers

	internal: INTERNAL
			-- Shared access to an instance of {INTERNAL}.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Externals

	SQLITE_LIMIT_VARIABLE_NUMBER: INTEGER
			-- Upper limit on a numerical id.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_LIMIT_VARIABLE_NUMBER"
		end

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
