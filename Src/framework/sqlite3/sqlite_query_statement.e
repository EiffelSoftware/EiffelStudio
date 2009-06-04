note
	description: "[
		An SQLite statement specific for making queries to the database.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_QUERY_STATEMENT

inherit
	SQLITE_STATEMENT
		redefine
			reset
		end

create
	make

feature -- Meansurement

	column_count: NATURAL
			-- The number of columns found in the compiled statement.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			database_is_accessible: database.is_accessible
		do
			Result := sqlite3_column_count (sqlite_api, internal_stmt).as_natural_32
		end

feature -- Query

	column_name (a_column: NATURAL): IMMUTABLE_STRING_8
			-- Retrieve the name of a column in a statment.
			--
			-- `a_column': The column index to retrieve a name for.
			-- `Result': A column name, or an
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			database_is_accessible: database.is_accessible
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= column_count
		local
			p: POINTER
			l_names: like internal_column_names
			l_column: INTEGER
		do
			if attached internal_column_names as l_internal_names then
				l_names := l_internal_names
			else
				create l_names.make (1, column_count.as_integer_32)
				internal_column_names := l_names
			end

			l_column := a_column.as_integer_32

			if attached l_names[l_column] as l_result then
				Result := l_result
			else
				p := sqlite3_column_name (sqlite_api, internal_stmt, l_column - 1)
				if p = default_pointer then
					create Result.make_empty
				else
					create Result.make_from_c (p)
				end
				l_names[l_column] := Result
			end
		ensure
			result_attached: attached Result
			internal_column_names_attached: attached internal_column_names
			internal_column_names_big_enough: (attached internal_column_names as l_names2) implies
				l_names2.count.as_natural_32 = column_count
			internal_column_names_item_set: (attached internal_column_names as l_names2) implies
				attached l_names2[a_column.as_integer_32]
		end

feature -- Basic operations

	frozen execute_with_callback (a_callback: PROCEDURE [ANY, TUPLE [row: SQLITE_RESULT_ROW]])
			-- Executes the SQLite query statement and calls back a routine with a result row.
			--
			-- `a_callback': A callback routine accepting a result row as its argument.
			--               Note: The row does not change between calls and values must be queried
			--                     immediately.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
			a_callback_attached: attached a_callback
		do
			execute_internal (a_callback, Void)
		ensure
			not_is_executing: not is_executing
		end

	frozen execute_with_callback_and_arguments (a_callback: PROCEDURE [ANY, TUPLE [row: SQLITE_RESULT_ROW]]; a_bindings: ANY)
			-- Executes the SQLite query statement with arguments and calls back a routine with a result row.
			--
			-- `a_callback': A callback routine accepting a result row as its argument.
			--               Note: The row does not change between calls and values must be queried
			--                     immediately.
			-- `a_bindings': The bound arguments to call the SQLite query statement with.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
			a_callback_attached: attached a_callback
			a_bindings_attached: attached a_bindings
			not_implemented: False
		do
			execute_internal (a_callback, a_bindings)
		ensure
			not_is_executing: not is_executing
		end

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			internal_column_names := Void
			Precursor
		ensure then
			internal_column_names_detached: not attached internal_column_names
		end

feature {NONE} -- Implementation

	internal_column_names: detachable ARRAY [detachable IMMUTABLE_STRING_8]
			-- Cached column names for the query `column_name'.

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
