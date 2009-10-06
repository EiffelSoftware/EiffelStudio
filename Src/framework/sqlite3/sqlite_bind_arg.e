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

	make (a_id: READABLE_STRING_8; a_value: like value)
			-- Initializes an argument.
			--
			-- `a_id': Variable name or index string.
			-- `a_value': Object to use with the SQL statement the argument is used in.
		require
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_value_is_valid_value: is_valid_value (a_value)
		do
			create id.make_from_string (a_id)
			value := a_value
		ensure
			id_set: id.same_string (a_id)
			value_set: value ~ a_value
		end

feature -- Access

	id: IMMUTABLE_STRING_8
			-- Name/index of the argument to bind a value to.

	value: detachable G
			-- Value of bound argument.

feature -- Status report

	is_valid_id (a_id: READABLE_STRING_8): BOOLEAN
			-- Determines if the identifier is valid.
			--
			-- `a_id': THe identifier to validate.
			-- `Result': True if the identifier is valid; False otherwise.
		require
			a_id_attached: attached a_id
		local
			i: NATURAL_8
		do
			Result := not a_id.is_empty
			if Result then
					-- First determine it is a number.
				if a_id.is_natural_64 or else a_id.is_integer_64 then
						-- Valid only if the id is a lower enough index (1-999)
					Result := a_id.is_natural_8
					if Result then
						i := a_id.to_natural_8
						Result := i >= min_index_id and i <= max_index_id
					end
				end
			end
		end

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

feature {SQLITE_STATEMENT} -- Basic operations

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

feature {NONE} -- Externals

	SQLITE_LIMIT_VARIABLE_NUMBER: INTEGER
			-- Upper limit on a numerical id.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_LIMIT_VARIABLE_NUMBER"
		end

invariant
	id_attached: attached id
	not_id_is_empty: not id.is_empty
	id_is_valid_id: is_valid_id (id)
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
