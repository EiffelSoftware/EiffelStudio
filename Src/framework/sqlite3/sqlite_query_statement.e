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

create
	make

feature -- Meansurement

	column_count: NATURAL
			-- The number of columns found in the compiled statement
		require
			is_compiled: is_compiled
		do
			--Result := sqlite3_column_count (sqlite_api).as_natural_32
		end

feature -- Basic operations

	execute_with_callback (a_callback: PROCEDURE [ANY, TUPLE [row: SQLITE_RESULT_ROW]])
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
			db_is_accessible: db.is_accessible
			a_callback_attached: attached a_callback
		do
			execute_internal (a_callback, Void)
		ensure
			not_is_executing: not is_executing
		end

	execute_with_callback_and_arguments (a_callback: PROCEDURE [ANY, TUPLE [row: SQLITE_RESULT_ROW]]; a_bindings: ANY)
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
			db_is_accessible: db.is_accessible
			a_callback_attached: attached a_callback
			a_bindings_attached: attached a_bindings
			not_implemented: False
		do
			execute_internal (a_callback, a_bindings)
		ensure
			not_is_executing: not is_executing
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
