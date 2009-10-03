note
	description: "[
		A SQLite statement used to perform modification to the database.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_MODIFY_STATEMENT

inherit
	SQLITE_STATEMENT
		export
			{ANY} changes_count
		end

create
	make

feature -- Basic operations

	frozen execute
			-- Executes the SQLite modification statement.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			not_is_executing: not is_executing
			is_accessible: is_accessible
			database_is_readable: database.is_readable
		do
			execute_internal (Void, Void)
		ensure
			not_is_executing: not is_executing
		end

	frozen execute_with_arguments (a_bindings: ARRAY [SQLITE_BIND_ARG [ANY]])
			-- Executes the SQLite modification statement with bound set of arguments.
			--
			-- `a_bindings': The bound arguments to call the SQLite query statement with.
		require
			is_compiled: is_compiled
			is_connected: is_connected
			not_is_executing: not is_executing
			is_accessible: is_accessible
			database_is_readable: database.is_readable
			has_arguments: has_arguments
			a_bindings_attached: attached a_bindings
			a_bindings_count_big_enough: a_bindings.count.as_natural_32 = arguments_count
		do
			execute_internal (Void, a_bindings)
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
