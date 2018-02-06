note
	description: "[
		SQLite C macros used to determine the success/failure of an SQLite API operation.
		
		These codes are used by the internals of the SQLite library, but are also used in the
		SQLite exceptions {e_EXCEPTION}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_RESULT_CODE

feature -- Access

	mask: INTEGER = 0xFF
			-- Mask for extracting the result code.

	failure_mask: INTEGER = 0x1F
			-- Mask for extracting the failure result code.

feature -- Constants: Success

	ok: INTEGER
			-- Successful result.
			--| SQLITE_OD = 0
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OK"
		ensure
			is_class: class
		end

feature -- Constants: Failure

	e_error: INTEGER
			-- SQL error or missing database.
			--| SQLITE_ERROR = 1
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ERROR"
		ensure
			is_class: class
		end

	e_internal: INTEGER
			-- Internal logic error in SQLite.
			--| SQLITE_INTERNAL = 2
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERNAL"
		ensure
			is_class: class
		end

	e_perm: INTEGER
			-- Access permission denied.
			--| SQLITE_PERM = 3
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PERM"
		ensure
			is_class: class
		end

	e_abort: INTEGER
			-- Callback routine requested an abort.
			--| SQLITE_ABORT = 4
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ABORT"
		ensure
			is_class: class
		end

	e_busy: INTEGER
			-- The database file is locked.
			--| SQLITE_BUSY = 5
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_BUSY"
		ensure
			is_class: class
		end

	e_locked: INTEGER
			-- A table in the database is locked.
			--| SQLITE_LOCKED = 6
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_LOCKED"
		ensure
			is_class: class
		end

	e_no_mem: INTEGER
			-- A malloc() failed.
			--| SQLITE_NOMEM = 7
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOMEM"
		ensure
			is_class: class
		end

	e_read_only: INTEGER
			-- Attempt to write a readonly database.
			--| SQLITE_READONLY = 8
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_READONLY"
		ensure
			is_class: class
		end

	e_interrupt: INTEGER
			-- Operation terminated by sqlite3_interrupt().
			--| SQLITE_INTERRUPT = 9
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERRUPT"
		ensure
			is_class: class
		end

	e_io_err: INTEGER
			-- Some kind of disk I/O error occurred.
			--| SQLITE_IOERR = 10
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR"
		ensure
			is_class: class
		end

	e_corrupt: INTEGER
			-- The database disk image is malformed.
			--| SQLITE_CORRUPT = 11
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CORRUPT"
		ensure
			is_class: class
		end

	e_not_found: INTEGER
			-- NOT USED. Table or record not found.
			--| SQLITE_NOTFOUND = 12
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTFOUND"
		ensure
			is_class: class
		end

	e_full: INTEGER
			-- Insertion failed because database is full.
			--| SQLITE_FULL = 13
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FULL"
		ensure
			is_class: class
		end

	e_cant_open: INTEGER
			-- Unable to open the database file.
			--| SQLITE_CANTOPEN = 14
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CANTOPEN"
		ensure
			is_class: class
		end

	e_protocol: INTEGER
			-- NOT USED. Database lock protocol error.
			--| SQLITE_PROTOCOL = 15
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PROTOCOL"
		ensure
			is_class: class
		end

	e_empty: INTEGER
			-- Database is empty.
			--| SQLITE_EMPTY = 16
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_EMPTY"
		ensure
			is_class: class
		end

	e_schema: INTEGER
			-- The database schema changed.
			--| SQLITE_SCHEMA = 17
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_SCHEMA"
		ensure
			is_class: class
		end

	e_too_big: INTEGER
			-- String or BLOB exceeds size limit.
			--| SQLITE_TOOBIG = 18
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_TOOBIG"
		ensure
			is_class: class
		end

	e_constraint: INTEGER
			-- Abort due to constraint violation.
			--| SQLITE_CONSTRAINT = 19
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONSTRAINT"
		ensure
			is_class: class
		end

	e_mismatch: INTEGER
			-- Data type mismatch.
			--| SQLITE_MISMATCH = 20
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISMATCH"
		ensure
			is_class: class
		end

	e_misuse: INTEGER
			-- Library used incorrectly.
			--| SQLITE_MISUSE = 21
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISUSE"
		ensure
			is_class: class
		end

	e_nolfs: INTEGER
			-- Uses OS features not supported on host.
			--| SQLITE_NOLFS = 22
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOLFS"
		ensure
			is_class: class
		end

	e_auth: INTEGER
			-- Authorization denied.
			--| SQLITE_AUTH = 23
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_AUTH"
		ensure
			is_class: class
		end

	e_format: INTEGER
			-- Auxiliary database format error.
			--| SQLITE_FORMAT = 24
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FORMAT"
		ensure
			is_class: class
		end

	e_range: INTEGER
			-- 2nd parameter to sqlite3_bind out of range.
			--| SQLITE_RANGE = 25
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_RANGE"
		ensure
			is_class: class
		end

	e_not_a_db: INTEGER
			-- File opened that is not a database file.
			--| SQLITE_NOTADB = 26
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTADB"
		ensure
			is_class: class
		end

feature -- Constants: Success

	row: INTEGER
			-- sqlite3_step() has another row ready.
			--| SQLITE_ROW = 100
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ROW"
		ensure
			is_class: class
		end

	done: INTEGER
			-- sqlite3_step() has finished executing.
			--| SQLITE_DONE = 101
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DONE"
		ensure
			is_class: class
		end

feature -- Status

	is_valid_result_code (a_code: INTEGER): BOOLEAN
			-- Is `a_code' a valid result code?
		do
			Result :=  a_code = ok
					or a_code = e_error
					or a_code = e_internal
					or a_code = e_perm
					or a_code = e_abort
					or a_code = e_busy
					or a_code = e_locked
					or a_code = e_no_mem
					or a_code = e_read_only
					or a_code = e_interrupt
					or a_code = e_io_err
					or a_code = e_corrupt
					or a_code = e_not_found
					or a_code = e_full
					or a_code = e_cant_open
					or a_code = e_protocol
					or a_code = e_empty
					or a_code = e_schema
					or a_code = e_too_big
					or a_code = e_constraint
					or a_code = e_mismatch
					or a_code = e_misuse
					or a_code = e_nolfs
					or a_code = e_auth
					or a_code = e_format
					or a_code = e_range
					or a_code = e_not_a_db
					or a_code = row
					or a_code = done
		ensure
			is_class: class
		end

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
