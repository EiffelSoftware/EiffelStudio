note
	description: "[
		SQLite C macros used to determine the success/failure of an SQLite API operation.
		
		These codes are used by the internals of the SQLite library, but are also used in the
		SQLite exceptions {SQLITE_EXCEPTION}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_RESULT_CODES

feature -- Access

	mask: INTEGER = 0xFF
			-- Mask for extracting the result code.

	failure_mask: INTEGER = 0x1F
			-- Mask for extracting the failure result code.

feature -- Constants: Success

	SQLITE_OK: INTEGER
			-- Successful result.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OK"
		end

feature -- Constants: Failure

	SQLITE_ERROR: INTEGER
			-- SQL error or missing database.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ERROR"
		end

	SQLITE_INTERNAL: INTEGER
			-- Internal logic error in SQLite.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERNAL"
		end

	SQLITE_PERM: INTEGER
			-- Access permission denied.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PERM"
		end

	SQLITE_ABORT: INTEGER
			-- Callback routine requested an abort.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ABORT"
		end

	SQLITE_BUSY: INTEGER
			-- The database file is locked.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_BUSY"
		end

	SQLITE_LOCKED: INTEGER
			-- A table in the database is locked.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_LOCKED"
		end

	SQLITE_NOMEM: INTEGER
			-- A malloc() failed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOMEM"
		end

	SQLITE_READONLY: INTEGER
			-- Attempt to write a readonly database.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_READONLY"
		end

	SQLITE_INTERRUPT: INTEGER
			-- Operation terminated by sqlite3_interrupt().
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERRUPT"
		end

	SQLITE_IOERR: INTEGER
			-- Some kind of disk I/O error occurred.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR"
		end

	SQLITE_CORRUPT: INTEGER
			-- The database disk image is malformed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CORRUPT"
		end

	SQLITE_NOTFOUND: INTEGER
			-- NOT USED. Table or record not found.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTFOUND"
		end

	SQLITE_FULL: INTEGER
			-- Insertion failed because database is full.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FULL"
		end

	SQLITE_CANTOPEN: INTEGER
			-- Unable to open the database file.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CANTOPEN"
		end

	SQLITE_PROTOCOL: INTEGER
			-- NOT USED. Database lock protocol error.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PROTOCOL"
		end

	SQLITE_EMPTY: INTEGER
			-- Database is empty.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_EMPTY"
		end

	SQLITE_SCHEMA: INTEGER
			-- The database schema changed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_SCHEMA"
		end

	SQLITE_TOOBIG: INTEGER
			-- String or BLOB exceeds size limit.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_TOOBIG"
		end

	SQLITE_CONSTRAINT: INTEGER
			-- Abort due to constraint violation.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONSTRAINT"
		end

	SQLITE_MISMATCH: INTEGER
			-- Data type mismatch.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISMATCH"
		end

	SQLITE_MISUSE: INTEGER
			-- Library used incorrectly.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISUSE"
		end

	SQLITE_NOLFS: INTEGER
			-- Uses OS features not supported on host.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOLFS"
		end

	SQLITE_AUTH: INTEGER
			-- Authorization denied.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_AUTH"
		end

	SQLITE_FORMAT: INTEGER
			-- Auxiliary database format error.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FORMAT"
		end

	SQLITE_RANGE: INTEGER
			-- 2nd parameter to sqlite3_bind out of range.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_RANGE"
		end

	SQLITE_NOTADB: INTEGER
			-- File opened that is not a database file.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTADB"
		end

feature -- Constants: Success

	SQLITE_ROW: INTEGER
			-- sqlite3_step() has another row ready.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ROW"
		end

	SQLITE_DONE: INTEGER
			-- sqlite3_step() has finished executing.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DONE"
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
