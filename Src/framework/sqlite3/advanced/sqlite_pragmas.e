note
	description: "[
		Not yet ready for use!
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_PRAGMAS

inherit
	SQLITE_SHARED_API

create
	make

feature {NONE} -- Initialization

	make (a_db: like database)
			-- Initializes the database pragma helper function for a database.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			a_db_attached: attached a_db
			a_db_is_accessible: a_db.is_accessible
		do
			database := a_db
		ensure
			database_set: database = a_db
		end

feature -- Access

	database: SQLITE_DATABASE
			-- Database to perform pragma queries and function on.

feature -- Status report

	auto_vacuum: BOOLEAN assign set_auto_vacuum
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
		do
			Result := boolean_pragma_value (auto_vacuum_name)
		end

feature -- Element change

	set_auto_vacuum (a_enable: BOOLEAN)
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
		do
			set_boolean_pragma_value (auto_vacuum_name, a_enable)
		ensure
			auto_vacuum_set: auto_vacuum = a_enable
		end

feature {NONE} -- Factory

	boolean_pragma_value (a_name: READABLE_STRING_8): BOOLEAN
			--
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_result: CELL [BOOLEAN]
			l_sql: STRING
			l_statement: SQLITE_QUERY_STATEMENT
		do
			create l_result.put (False)

			create l_sql.make (20)
			l_sql.append ("PRAGMA ")
			l_sql.append (a_name)
			l_sql.append_character (';')

			create l_statement.make (l_sql, database)
			check is_compiled: l_statement.is_compiled end
			l_statement.execute_with_callback (agent (ia_row: SQLITE_RESULT_ROW; ia_result: CELL [BOOLEAN]): BOOLEAN
				do
					if ia_row.count > 0 and not ia_row.is_null (1) then
						ia_result.put (ia_row.integer_value (1) /= 0)
					end
				end (?, l_result))

			Result := l_result.item
		end

	set_boolean_pragma_value (a_name: READABLE_STRING_8; a_value: BOOLEAN)
			--
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			database_is_accessible: database.is_accessible
			database_is_readable: database.is_readable
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_sql: STRING
			l_statement: SQLITE_MODIFY_STATEMENT
		do
			create l_sql.make (20)
			l_sql.append ("PRAGMA ")
			l_sql.append (a_name)
			l_sql.append_character ('=')
			if a_value then
				l_sql.append_integer (1)
			else
				l_sql.append_integer (0)
			end
			l_sql.append_character (';')

			create l_statement.make (l_sql, database)
			check is_compiled: l_statement.is_compiled end
			l_statement.execute
		ensure
			value_set: boolean_pragma_value (a_name) = a_value
		end

feature {NONE} -- Constants: Pragmas

	auto_vacuum_name: STRING = "auto_vacuum"
	cache_size_name: STRING = "cache_size"
	count_changes_name: STRING = "count_changes"
	default_cache_size_name: STRING = "default_cache_size"
	empty_result_callbacks_name: STRING = "empty_result_callbacks"
	encoding_name: STRING = "encoding"
	full_column_names_name: STRING = "full_column_names"
	fullfsync_name: STRING = "fullfsync "
	incremental_vacuum_name: STRING = "incremental_vacuum"
	journal_mode_name: STRING = "journal_mode"
	journal_size_limit_name: STRING = "journal_size_limit"
	legacy_file_format_name: STRING = "legacy_file_format"
	locking_mode_name: STRING = "locking_mode"
--	_name: STRING = ""
--	_name: STRING = ""
--	_name: STRING = ""
--	_name: STRING = ""

invariant
	database_attached: attached database

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
