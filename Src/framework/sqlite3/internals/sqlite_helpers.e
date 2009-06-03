note
	description: "[
		Helper function for interacting the the raw SQLite API.
		
		Currently the helpers are limited to checking results and raising exceptions on non-successful
		result codes are checked.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_HELPERS

feature -- Query

	frozen sqlite_success (a_code: INTEGER): BOOLEAN
			-- Indicates if a result was a success or failure.
			--
			-- `a_code': A result code.
			-- `Result': True if the result code was a successful code; False for all errors codes.
		do
			Result := ({SQLITE_RESULT_CODES}.failure_mask & a_code) = 0 or
				a_code = {SQLITE_RESULT_CODES}.sqlite_row or
				a_code = {SQLITE_RESULT_CODES}.sqlite_done
		ensure
			result_is_ok: Result implies (
				({SQLITE_RESULT_CODES}.failure_mask & a_code) = 0 or
				a_code = {SQLITE_RESULT_CODES}.sqlite_row or
				a_code = {SQLITE_RESULT_CODES}.sqlite_done)
		end

	frozen sqlite_exception (a_code: INTEGER; a_message: detachable READABLE_STRING_8): detachable SQLITE_EXCEPTION
			-- Retrieves an exception object based on the exception error code and message.
			--
			-- `a_code': A non-successful result code.
			-- `a_message': An optional exception message. NOt supplying an error message will generated a
			--              default error message.
		require
			not_a_code_sqlite_success: not sqlite_success (a_code)
			not_a_message_is_empty: attached a_message implies not a_message.is_empty
		do
			if (a_code & {SQLITE_RESULT_CODES}.sqlite_ioerr) = {SQLITE_RESULT_CODES}.sqlite_ioerr then
				if attached a_message then
					create {SQLITE_IO_EXCEPTION}Result.make_with_message (a_code, a_message)
				else
					create {SQLITE_IO_EXCEPTION}Result.make (a_code)
				end
			else
				if attached a_message then
					create Result.make_with_message (a_code, a_message)
				else
					create Result.make (a_code)
				end
			end
		end

feature -- Basic operations

	sqlite_raise_on_failure (a_code: INTEGER)
			-- Raises an sqlite exception ({SQLITE_EXCEPTION}) in the event of an error.
			--
			-- `a_code': A result code.
		local
			l_exception: like sqlite_exception
		do
			if not sqlite_success (a_code) then
				l_exception := sqlite_exception (a_code, Void)
				if attached l_exception then
					l_exception.raise
				end
			end
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
