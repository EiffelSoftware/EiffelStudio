note
	description: "[
		An expecption specific to exceptional cases in the SQLite library.
		
		This exception will only be raised in exception circumstances where an error needs to be
		propagated back to the client. Clients should alway check for this exception on critical
		calls.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			internal_meaning
		end

create
	make,
	make_with_message

feature {NONE} -- Initialization

	make (a_code: INTEGER)
			-- Creates a new exception with a reported SQLite code.
			--
			-- `a_code': A SQLite result code, possibily with a extended code.
		require
			not_a_code_is_ok: a_code /= {SQLITE_RESULT_CODES}.sqlite_ok
		do
			make_with_message (a_code, message_from_code (a_code))
		ensure
			internal_code_set: internal_code = a_code
		end

	make_with_message (a_code: INTEGER; a_message: READABLE_STRING_8)
			-- Creates a new exception with a code and an error message.
			--
			-- `a_code': A SQLite result code, possibily with a extended code.
			-- `a_message': A message string returned from SQLite.
		require
			not_a_code_is_ok: a_code /= {SQLITE_RESULT_CODES}.sqlite_ok
		do
			internal_code := a_code
			create internal_meaning.make_from_string (a_message)
		ensure
			internal_code_set: internal_code = a_code
			internal_meaning_set: internal_meaning.same_string (a_message)
		end

feature -- Access

	result_code: INTEGER
			-- Result error code. See {SQLITE_RESULT_CODES} for meanings.
		do
			Result := internal_code & {SQLITE_RESULT_CODES}.mask
		ensure
			not_result_is_ok: Result /= {SQLITE_RESULT_CODES}.sqlite_ok
		end

	extended_code: INTEGER
			-- Any extended error code, giving further information to the exception.
		do
			Result := internal_code.bit_shift_left (8)
		end

feature {NONE} -- Query

	message_from_code (a_code: INTEGER): READABLE_STRING_8
			-- Retrieves an SQLite default error message from an SQLite result code.
			--
			-- `a_code': A SQLite result code, possibily with a extended code.
			-- `Result': The default message.
		require
			not_a_code_is_ok: a_code /= {SQLITE_RESULT_CODES}.sqlite_ok
		local
			l_code: INTEGER
		do
			l_code := a_code & {SQLITE_RESULT_CODES}.mask
			if l_code = {SQLITE_RESULT_CODES}.SQLITE_ERROR then
				Result := "SQL error or missing database"
			elseif l_code =  {SQLITE_RESULT_CODES}.SQLITE_INTERNAL then
				Result := "Internal logic error in SQLite"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_PERM then
				Result := "Access permission denied"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_ABORT then
				Result := "Callback routine requested an abort"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_BUSY then
				Result := "The database file is locked"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_LOCKED then
				Result := "A table in the database is locked"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_NOMEM then
				Result := "There is not enough memory"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_READONLY then
				Result := "Attempted to write a read-only database"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_INTERRUPT then
				Result := "Operation interrupted"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_IOERR then
				Result := "I/O operation error"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_CORRUPT then
				Result := "The database disk image is malformed"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_NOTFOUND then
				check not_used: False end
				Result := "Table or record not found"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_FULL then
				Result := "Insertion failed because database is full"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_CANTOPEN then
				Result := "Unable to open the database file"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_PROTOCOL then
				check not_used: False end
				Result := "Database lock protocol error"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_EMPTY then
				Result := "Database is empty"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_SCHEMA then
				Result := "The database schema changed"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_TOOBIG then
				Result := "String or BLOB exceeds size limit"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_CONSTRAINT then
				Result := "Abort due to constraint violation"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_MISMATCH then
				Result := "Data type mismatch"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_MISUSE then
				Result := "Library used incorrectly"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_NOLFS then
				Result := "Use of OS features not supported on host"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_AUTH then
				Result := "Authorization denied"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_FORMAT then
				Result := "Auxiliary database format error"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_RANGE then
				Result := "2nd parameter to sqlite3_bind out of range"
			elseif l_code = {SQLITE_RESULT_CODES}.SQLITE_NOTADB then
				Result := "File opened that is not a database file"
			else
				check unhandled_error: False end
				Result := "Unknown error"
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	internal_meaning: STRING
			-- <Precursor>

	internal_code: INTEGER
			-- Actual reported code.

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
