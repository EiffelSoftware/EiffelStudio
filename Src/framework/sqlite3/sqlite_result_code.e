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

inherit
	ENUMERATED_TYPE [INTEGER]

create
	make

convert
	make ({INTEGER}),
	item: {INTEGER}

feature -- Access

	mask: INTEGER = 0xFF
			-- Mask for extracting the result code.

	failure_mask: INTEGER = 0x1F
			-- Mask for extracting the failure result code.

feature -- Constants: Success

	ok: INTEGER
			-- Successful result.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_OK"
		end

feature -- Constants: Failure

	e_error: INTEGER
			-- SQL error or missing database.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ERROR"
		end

	e_internal: INTEGER
			-- Internal logic error in SQLite.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERNAL"
		end

	e_perm: INTEGER
			-- Access permission denied.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PERM"
		end

	e_abort: INTEGER
			-- Callback routine requested an abort.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ABORT"
		end

	e_busy: INTEGER
			-- The database file is locked.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_BUSY"
		end

	e_locked: INTEGER
			-- A table in the database is locked.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_LOCKED"
		end

	e_no_mem: INTEGER
			-- A malloc() failed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOMEM"
		end

	e_read_only: INTEGER
			-- Attempt to write a readonly database.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_READONLY"
		end

	e_interrupt: INTEGER
			-- Operation terminated by sqlite3_interrupt().
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_INTERRUPT"
		end

	e_io_err: INTEGER
			-- Some kind of disk I/O error occurred.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_IOERR"
		end

	e_corrupt: INTEGER
			-- The database disk image is malformed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CORRUPT"
		end

	e_not_found: INTEGER
			-- NOT USED. Table or record not found.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTFOUND"
		end

	e_full: INTEGER
			-- Insertion failed because database is full.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FULL"
		end

	e_cant_open: INTEGER
			-- Unable to open the database file.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CANTOPEN"
		end

	e_protocol: INTEGER
			-- NOT USED. Database lock protocol error.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_PROTOCOL"
		end

	e_empty: INTEGER
			-- Database is empty.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_EMPTY"
		end

	e_schema: INTEGER
			-- The database schema changed.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_SCHEMA"
		end

	e_too_big: INTEGER
			-- String or BLOB exceeds size limit.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_TOOBIG"
		end

	e_constraint: INTEGER
			-- Abort due to constraint violation.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONSTRAINT"
		end

	e_mismatch: INTEGER
			-- Data type mismatch.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISMATCH"
		end

	e_misuse: INTEGER
			-- Library used incorrectly.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_MISUSE"
		end

	e_nolfs: INTEGER
			-- Uses OS features not supported on host.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOLFS"
		end

	e_auth: INTEGER
			-- Authorization denied.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_AUTH"
		end

	e_format: INTEGER
			-- Auxiliary database format error.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_FORMAT"
		end

	e_range: INTEGER
			-- 2nd parameter to sqlite3_bind out of range.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_RANGE"
		end

	e_not_a_db: INTEGER
			-- File opened that is not a database file.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_NOTADB"
		end

feature -- Constants: Success

	row: INTEGER
			-- sqlite3_step() has another row ready.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_ROW"
		end

	done: INTEGER
			-- sqlite3_step() has finished executing.
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_DONE"
		end

feature {NONE} -- Factory

	members: ARRAY [INTEGER]
			-- <Precursor>
		once
			Result := <<
				ok, e_error, e_internal, e_perm, e_abort, e_busy,
				e_locked, e_no_mem, e_read_only, e_interrupt, e_io_err,
				e_corrupt, e_not_found, e_full, e_cant_open, e_protocol,
				e_empty, e_schema, e_too_big, e_constraint, e_mismatch,
				e_misuse, e_nolfs, e_auth, e_format, e_range, e_not_a_db,
				row, done
			>>
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
