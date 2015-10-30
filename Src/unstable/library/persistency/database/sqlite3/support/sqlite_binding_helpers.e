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

inherit
	SQLITE_SHARED_API

feature -- Status report

	is_valid_argument (a_value: detachable ANY): BOOLEAN
			-- Indicates if the value is of an accepted type.
			--
			-- `a_value': A value to check.
			-- `Result': True if the value type is marshallable; False otherwise.
		local
			l_type_id: INTEGER
		do
			Result := not attached a_value or else
				attached {READABLE_STRING_8} a_value or else
				attached {SQLITE_BIND_ARG [ANY]} a_value or else
				attached {MANAGED_POINTER} a_value or else
				(attached {READABLE_STRING_32} a_value as s32 and then s32.is_valid_as_string_8)
			if not Result and attached a_value then
					-- Check scalar types
				Result := True
				l_type_id := a_value.generating_type.type_id
				if		-- Minor: optimisation, most common types are checked first
					l_type_id = ({INTEGER_32}).type_id
					or l_type_id = ({BOOLEAN}).type_id -- Converted to INTEGER in binding
					or l_type_id = ({NATURAL_32}).type_id
					or l_type_id = ({REAL_32}).type_id
					or l_type_id = ({INTEGER_8}).type_id
					or l_type_id = ({INTEGER_16}).type_id
					or l_type_id = ({INTEGER_64}).type_id
					or l_type_id = ({NATURAL_8}).type_id
					or l_type_id = ({NATURAL_16}).type_id
					or l_type_id = ({REAL_64}).type_id
				then
						-- Supported basic type
					check Result end
				elseif attached {NATURAL_64_REF} a_value as nat64 then
							-- Natural 64 will be stored as INTEGER_64
							-- sqlite does not support unit64 !
							-- this will be handled via {SQLITE_INTEGER_ARG} built by
							--  `{SQLITE_BIND_ARG_MARSHALLER}.new_binding_argument'
						Result := nat64 <= {INTEGER_64}.Max_value.as_natural_64
				else
						-- Unsupported type, or unsupported value for type
					Result := False
				end
			end
		end

	is_valid_arguments (a_args: ITERABLE [detachable ANY]): BOOLEAN
			-- Determines if an argument tuple is valid.
			--
			-- `a_args': A tuple of arguments to validate.
			-- `Result': True if the supplied tuple contains valid value for arguments; False otherwise.
		require
			a_args_attached: attached a_args
			not_a_args_is_empty: across a_args as ic some True end
		local
			n: INTEGER
			l_sqlite_limit_variable_number: like maximum_variable_index_number
		do
			l_sqlite_limit_variable_number := maximum_variable_index_number
			Result := True
			across
				a_args as ic
			until
				not Result
			loop
				n := n + 1
				Result := n <= l_sqlite_limit_variable_number and is_valid_argument (ic.item)
			end
		ensure
			a_args_small_enough: Result implies not is_over_sqlite_limit_variable_number (a_args)
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
						Result := i > 0 and i <= maximum_variable_index_number
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

	is_over_sqlite_limit_variable_number (lst: ITERABLE [detachable separate ANY]): BOOLEAN
			-- Container `lst' exceeds the number of accepted variables?
		local
			i,n: INTEGER
		do
			n := maximum_variable_index_number
			across
				lst as ic
			until
				i > n
			loop
				i := i + 1
			end
		end

	iterable_min_count_or_value (lst: ITERABLE [detachable separate ANY]; a_nb: INTEGER): INTEGER
			-- Minimum between count of `lst' and `a_nb'
		do
			if attached {FINITE [detachable separate ANY]} lst as l_finite then
				Result := l_finite.count.min (a_nb)
			else
				across
					lst as ic
				until
					Result >= a_nb
				loop
					Result := Result + 1
				end
			end
		end

	iterable_has_count (lst: ITERABLE [detachable separate ANY]; n: INTEGER): BOOLEAN
			-- Is count of `lst' the same as `nb' ?
		local
			i: INTEGER
		do
			if attached {FINITE [detachable separate ANY]} lst as l_finite then
				Result := l_finite.count = n
			else
				across
					lst as ic
				until
					i > n
				loop
					i := i + 1
				end
				Result := i = n
			end
		end

feature {NONE} -- Externals

	maximum_variable_index_number: INTEGER
			-- Maximum index number of any parameter in an SQL statement.
			-- See {SQLITE_DATABASE}.maximum_variable_index_number
		do
			Result := sqlite_api.maximum_variable_index_number
		end

;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
