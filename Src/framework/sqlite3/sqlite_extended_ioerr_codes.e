note
	description: "[
		Extended SQLite C macros used to determine the success/failure of an SQLite API operation,
		related to IO operations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_EXTENDED_IOERR_CODES

feature -- Access

	mask: INTEGER = 0xFFFFFF00
			-- Mask for extended IO error codes.

feature -- Constants

	SQLITE_IOERR_READ: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_READ"
		end

	SQLITE_IOERR_SHORT_READ: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_SHORT_READ"
		end

	SQLITE_IOERR_WRITE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_WRITE"
		end

	SQLITE_IOERR_FSYNC: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_FSYNC"
		end

	SQLITE_IOERR_DIR_FSYNC: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_DIR_FSYNC"
		end

	SQLITE_IOERR_TRUNCATE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_TRUNCATE"
		end

	SQLITE_IOERR_FSTAT: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_FSTAT"
		end

	SQLITE_IOERR_UNLOCK: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_UNLOCK"
		end

	SQLITE_IOERR_RDLOCK: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_RDLOCK"
		end

	SQLITE_IOERR_DELETE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_DELETE"
		end

	SQLITE_IOERR_BLOCKED: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_BLOCKED"
		end

	SQLITE_IOERR_NOMEM: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_NOMEM"
		end

	SQLITE_IOERR_ACCESS: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_ACCESS"
		end

	SQLITE_IOERR_CHECKRESERVEDLOCK: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_CHECKRESERVEDLOCK"
		end

	SQLITE_IOERR_LOCK: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_LOCK"
		end

	SQLITE_IOERR_CLOSE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OK"
		end

	SQLITE_IOERR_DIR_CLOSE: INTEGER
			--
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR_DIR_CLOSE"
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
