note
	description: "[
		A null/void-value binding argument value for use with executing a SQLite statement.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_NULL_ARG

inherit
	SQLITE_BIND_ARG [ANY]
		rename
			make as make_arg
		redefine
			is_valid_value
		end

create
	make

feature {NONE} -- Initialization

	make (a_var: READABLE_STRING_8)
			-- Initializes an argument.
			--
			-- `a_var': Variable name or index string.
		require
			a_var_attached: attached a_var
			not_a_var_is_empty: not a_var.is_empty
			a_var_is_valid_variable_name: is_valid_variable_name (a_var)
		do
			make_arg (a_var, Void)
		ensure
			variable_set: variable.same_string (a_var)
		end

feature -- Status report

	is_valid_value (a_value: like value): BOOLEAN
			-- <Precursor>
		do
			Result := not attached a_value
		ensure then
			not_attached_a_value: Result implies not attached a_value
		end

feature {SQLITE_STATEMENT} -- Basic operations

	bind_to_statement (a_statement: SQLITE_STATEMENT; a_index: INTEGER)
			-- <Precursor>
		do
			sqlite_raise_on_failure ({SQLITE_EXTERNALS}.c_sqlite3_bind_null (a_statement.internal_stmt, a_index))
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
