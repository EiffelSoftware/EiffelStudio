note
	description: "[
		XML-RPC library error code and associate messages.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_ERROR_CODES

feature -- Status report

	is_valid_error_code (a_code: INTEGER): BOOLEAN
			-- Determines if the error code is a valid code for this library.
			--
			-- `a_code': An error code.
			-- `Result': True if the error code is valid; False otherwise.
		do
			Result := error_table.has (a_code)
		ensure
			error_table_has_a_code: Result implies error_table.has (a_code)
		end

feature -- Query

	message (a_code: INTEGER): STRING
			-- Retrieves a meaningful message for a given error code.
			--
			-- `a_code': An error code.
			-- `Result': A meaningful message.
		require
			is_valid_error_code: is_valid_error_code (a_code)
		local
			l_result: detachable STRING
		do
			l_result := error_table[a_code]
			if attached l_result then
				create Result.make_from_string (l_result)
			else
				create Result.make_from_string (once "???")
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature -- Access: Marshalling

	e_code_marshal_mask: INTEGER = -0x10100

	e_code_marshal_error: INTEGER = -0x10101
	e_marshal_error: STRING = "Marshalling error."

	e_code_marshal_invalid_type: INTEGER = -0x10102
	e_marshal_invalid_type: STRING = "Invalid type for automated marshalling."

	e_code_marshal_incompatible_type: INTEGER = -0x10103
	e_marshal_incompatible_type: STRING = "Incompatible marshalling types."

	e_code_marshal_integer_overflow: INTEGER = -0x10104
	e_marshal_integer_overflow: STRING = "Integer overflow during object marshalling."

	e_code_marshal_integer_underflow: INTEGER = -0x10105
	e_marshal_integer_underflow: STRING = "Integer underflow during object marshalling."

feature -- Access: Methods

	e_code_method_mask: INTEGER = -0x10200

	e_code_method_invalid: INTEGER = -0x10201
	e_method_invalid: STRING = "Invalid method."

	e_code_method_unknown: INTEGER = -0x10202
	e_method_unknown: STRING = "Unknown method name."

	e_code_method_too_few_arguments: INTEGER = -0x10203
	e_method_too_few_arguments: STRING = "Not enough arguments specified."

	e_code_method_too_many_arguments: INTEGER = -0x10204
	e_method_too_many_arguments: STRING = "Too many arguments specified."

	e_code_method_assertion_failure: INTEGER = -0x10205
	e_method_assertion_failure: STRING = "Method assertion checking failed."

	e_code_method_execution_failure: INTEGER = -0x10206
	e_method_execution_failure: STRING = "Method execution failed."

feature -- Access: Method arguments

	e_code_argument_mask: INTEGER = -0x10400

	e_code_argument_invalid: INTEGER = -0x10401
	e_argument_invalid_value: STRING = "Invalid argument value given RPC type."

feature -- Access: Request

	e_code_request_mask: INTEGER = 0x10800

	e_code_request_invalid: INTEGER = -0x10801
	e_request_invalid: STRING = "Invalid XML-RPC request."

	e_code_request_no_method_name: INTEGER = -0x10802
	e_request_no_method_name: STRING = "No method name supplied in XML-RPC request."

feature -- Access: Response

	e_code_response_mask: INTEGER = 0x11000

	e_code_response_invalid: INTEGER = -0x11001
	e_response_invalid: STRING = "Invalid XML-RPC response."

feature -- Access: Connection

	e_code_connection_mask: INTEGER = 0x12000

	e_code_connection_file_not_found: INTEGER = 0x12001
	e_connection_file_not_found: STRING = "File not found."

	e_code_connection_write_error: INTEGER = 0x12002
	e_connection_write_error: STRING = "Write error."

	e_code_connection_refused: INTEGER = 0x12003
	e_connection_refused: STRING = "Connection refused."

	e_code_connection_no_such_user: INTEGER = 0x12004
	e_connection_no_such_user: STRING = "No such user."

	e_code_connection_access_denied: INTEGER = 0x12005
	e_connection_access_denied: STRING = "Access denied."

	e_code_connection_wrong_command: INTEGER = 0x12006
	e_connection_wrong_command: STRING = "Wrong command."

	e_code_connection_permission_denied: INTEGER = 0x12007
	e_connection_permission_denied: STRING = "Permission denied."

	e_code_connection_transfer_failed: INTEGER = 0x12008
	e_connection_transfer_failed: STRING = "Transfer failed."

	e_code_connection_transmission_error: INTEGER = 0x12009
	e_connection_transmission_error: STRING = "Transmission error."

	e_code_connection_connection_timeout: INTEGER = 0x1200A
	e_connection_connection_timeout: STRING = "Connection timed out."

feature -- Access

	e_code_internal_error: INTEGER = -0x10000
	e_internal_error: STRING = "Internal error."

feature {NONE} -- Access

	error_table: HASH_TABLE [STRING, INTEGER]
			-- Table of error codes paired with a description.
			--
			-- Key: Error code.
			-- Value: Error message.
		once
			create Result.make (17)

			Result.put (e_internal_error, e_code_internal_error)

			Result.put (e_marshal_error, e_code_marshal_error)
			Result.put (e_marshal_invalid_type, e_code_marshal_invalid_type)
			Result.put (e_marshal_incompatible_type, e_code_marshal_incompatible_type)
			Result.put (e_marshal_integer_overflow, e_code_marshal_integer_overflow)
			Result.put (e_marshal_integer_underflow, e_code_marshal_integer_underflow)

			Result.put (e_method_invalid, e_code_method_invalid)
			Result.put (e_method_unknown, e_code_method_unknown)
			Result.put (e_method_too_few_arguments, e_code_method_too_few_arguments)
			Result.put (e_method_too_many_arguments, e_code_method_too_many_arguments)
			Result.put (e_method_assertion_failure, e_code_method_assertion_failure)
			Result.put (e_method_execution_failure, e_code_method_execution_failure)
			Result.put (e_argument_invalid_value, e_code_argument_invalid)

			Result.put (e_request_invalid, e_code_request_invalid)
			Result.put (e_request_no_method_name, e_code_request_no_method_name)
			Result.put (e_response_invalid, e_code_response_invalid)

			Result.put (e_connection_file_not_found, e_code_connection_file_not_found)
			Result.put (e_connection_write_error, e_code_connection_write_error)
			Result.put (e_connection_refused, e_code_connection_refused)
			Result.put (e_connection_no_such_user, e_code_connection_no_such_user)
			Result.put (e_connection_access_denied, e_code_connection_access_denied)
			Result.put (e_connection_wrong_command, e_code_connection_wrong_command)
			Result.put (e_connection_permission_denied, e_code_connection_permission_denied)
			Result.put (e_connection_transfer_failed, e_code_connection_transfer_failed)
			Result.put (e_connection_transmission_error, e_code_connection_transmission_error)
			Result.put (e_connection_connection_timeout, e_code_connection_connection_timeout)
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
