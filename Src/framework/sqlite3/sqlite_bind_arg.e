note
	description: "[
		A abstract argument used for binding an argument to an SQLite statement.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SQLITE_BIND_ARG [G -> ANY]

inherit
	SQLITE_HELPERS
		export
			{NONE} all
		end

	SQLITE_BINDING_HELPERS
		export
			{NONE} all
		end

-- inherit {NONE}
	SQLITE_INTERNALS
		export
			{NONE} all
		end

	SQLITE_SHARED_API
		export
			{NONE} all
		end

	ANY

feature {NONE} -- Initialization

	make (a_var: READABLE_STRING_8; a_value: like value)
			-- Initializes an argument.
			--
			-- `a_var': Variable or index string.
			-- `a_value': Object to use with the SQL statement the argument is used in.
		require
			a_var_attached: attached a_var
			not_a_var_is_empty: not a_var.is_empty
			a_var_is_valid_variable_name: is_valid_variable_name (a_var)
			a_value_is_valid_value: is_valid_value (a_value)
		do
			create variable.make_from_string (a_var)
			value := a_value
		ensure
			variable_set: variable.same_string (a_var)
			value_set: value ~ a_value
		end

feature -- Access

	variable: IMMUTABLE_STRING_8
			-- Name/index of the argument to bind a value to.

	value: detachable G
			-- Value of bound argument.

feature -- Status report

	is_valid_value (a_value: like value): BOOLEAN
			-- Determines if an argument value is valid.
			--
			-- `a_value': The value to validate.
			-- `Result': True if the value is valid; False otherwise.
		do
			Result := True
		end

feature -- Measurement

	min_index_id: NATURAL_8 = 1
			-- Minumum allowable id index.

	max_index_id: NATURAL_8
			-- Maximum allowable id index.
		do
			Result := SQLITE_LIMIT_VARIABLE_NUMBER.as_natural_8
		end

feature {SQLITE_STATEMENT, SQLITE_STATEMENT_ITERATION_CURSOR} -- Basic operations

	bind_to_statement (a_statement: SQLITE_STATEMENT; a_index: INTEGER)
			-- Binds the argument to the statement, at a given index.
			--
			-- `a_statement': A prepared statement to bind the argument to.
			-- `a_index': The index to bind the value at.
		require
			a_statement_attached: attached a_statement
			a_statement_is_accessible: a_statement.is_accessible
			a_statement_is_compiled: a_statement.is_compiled
			not_a_statement_is_executing: not a_statement.is_executing
			a_index_positive: a_index > 0
			--a_index_small_enough: a_index <= variable_limit
		deferred
		end

invariant
	variable_attached: attached variable
	not_variable_is_empty: not variable.is_empty
	variable_is_valid_variable_name: is_valid_variable_name (variable)
	value_is_valid_value: is_valid_value (value)

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
