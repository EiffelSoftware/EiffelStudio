note
	description: "[
		SQLite C macros used to determine the action code values signify what kind of operation is to be
		authorized.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_ACTION_CODES

feature -- Constants: Authorizer Action Codes

	SQLITE_CREATE_INDEX: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_INDEX"
		end

	SQLITE_CREATE_TABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TABLE"
		end

	SQLITE_CREATE_TEMP_INDEX: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TEMP_INDEX"
		end

	SQLITE_CREATE_TEMP_TABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TEMP_TABLE"
		end

	SQLITE_CREATE_TEMP_TRIGGER: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TEMP_TRIGGER"
		end

	SQLITE_CREATE_TEMP_VIEW: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TEMP_VIEW"
		end

	SQLITE_CREATE_TRIGGER: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_TRIGGER"
		end

	SQLITE_CREATE_VIEW: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_VIEW"
		end

	SQLITE_DELETE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DELETE"
		end

	SQLITE_DROP_INDEX: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_INDEX"
		end

	SQLITE_DROP_TABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TABLE"
		end

	SQLITE_DROP_TEMP_INDEX: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TEMP_INDEX"
		end

	SQLITE_DROP_TEMP_TABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TEMP_TABLE"
		end

	SQLITE_DROP_TEMP_TRIGGER: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TEMP_TRIGGER"
		end

	SQLITE_DROP_TEMP_VIEW: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TEMP_VIEW"
		end

	SQLITE_DROP_TRIGGER: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_TRIGGER"
		end

	SQLITE_DROP_VIEW: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_VIEW"
		end

	SQLITE_INSERT: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INSERT"
		end

	SQLITE_PRAGMA: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PRAGMA"
		end

	SQLITE_SELECT: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_SELECT"
		end

	SQLITE_TRANSACTION: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_TRANSACTION"
		end

	SQLITE_UPDATE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_UPDATE"
		end

	SQLITE_ATTACH: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ATTACH"
		end

	SQLITE_DETACH: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DETACH"
		end

	SQLITE_ALTER_TABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ALTER_TABLE"
		end

	SQLITE_REINDEX: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_REINDEX"
		end

	SQLITE_ANALYZE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ANALYZE"
		end

	SQLITE_CREATE_VTABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CREATE_VTABLE"
		end

	SQLITE_DROP_VTABLE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DROP_VTABLE"
		end

	SQLITE_FUNCTION: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FUNCTION"
		end

	SQLITE_SAVEPOINT: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_SAVEPOINT"
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
