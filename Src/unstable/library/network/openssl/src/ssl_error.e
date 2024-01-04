note
	description: "Summary description for {SSL_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_code:NATURAL_64)
		do
			code := a_code
		end

feature -- Access

	code: NATURAL_64

	error_lib_code: INTEGER
		do
			Result := {SSL_ERROR_EXTERNALS}.c_error_get_lib (code)
		end

	error_reason_code: INTEGER
		do
			Result := {SSL_ERROR_EXTERNALS}.c_error_get_reason (code)
		end

	error_lib: STRING
		local
			c_string: C_STRING
			l_pointer: POINTER
		do
			create Result.make_empty
			l_pointer := {SSL_ERROR_EXTERNALS}.c_err_lib_error_string (code)
			if l_pointer /= default_pointer then
				create c_string.make_by_pointer (l_pointer)
				Result.append (c_string.string)
			end
		end

	error_function: STRING
		local
			c_string: C_STRING
			l_pointer: POINTER
		do
			create Result.make_empty
			l_pointer := {SSL_ERROR_EXTERNALS}.c_err_func_error_string (code)
			if l_pointer /= default_pointer then
				create c_string.make_by_pointer (l_pointer)
				Result.append (c_string.string)
			end
		end

	error_reason: STRING
		local
			c_string: C_STRING
			l_pointer: POINTER
		do
			create Result.make_empty
			l_pointer := {SSL_ERROR_EXTERNALS}.c_err_reason_error_string (code)
			if l_pointer /= default_pointer then
				create c_string.make_by_pointer (l_pointer)
				Result.append (c_string.string)
			end
		end

feature -- Status Report

	lib_and_reason_match (a_lib, a_reason: INTEGER): BOOLEAN
			-- Does 'a_lib' match with 'error_lib_code' and
			-- 'a_reason' with 'error_reason_code'?
		do
			Result := a_lib = error_lib_code and then a_reason = error_reason_code
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
