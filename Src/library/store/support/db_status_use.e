note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database : All_Bases

class DB_STATUS_USE

inherit
	HANDLE_USE

	REFACTORING_HELPER

feature -- Status report

	exhausted: BOOLEAN
			-- Is there any more resulting row?
		do
			Result := not handle.status.found
		end

	is_connected: BOOLEAN
			-- Has connection to the database server succeeded?
		do
			Result := handle.status.is_connected
		end

	error_code: INTEGER
			-- Error code of last transaction
		do
			Result := handle.status.error_code
		end

	is_ok: BOOLEAN
			-- Is last SQL statement ok ?
		do
			Result := handle.status.is_ok
		end

	error_message: STRING
			-- SQL error message prompted by database server
		obsolete
			"Use `error_message_32' instead [2017-11-30]."
		do
			Result := error_message_32.as_string_8
		end

	warning_message: STRING
			-- SQL warning message prompted by database server
		obsolete
			"Use `warning_message_32' instead [2017-11-30]."
		do
			Result := warning_message_32.as_string_8
		end

	utf_8_error_message: STRING_8
			-- SQL error message prompted by database server, UTF-8 encoded.
		do
			Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (error_message_32)
		end

	error_message_32: STRING_32
			-- SQL error message prompted by database server
		do
			Result := handle.status.error_message_32
		end

	utf_8_warning_message: STRING_8
			-- SQL warning message prompted by database server, UTF-8 encoded.
		do
			Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (warning_message_32)
		end

	warning_message_32: STRING_32
			-- SQL warning message prompted by database server
		do
			Result := handle.status.warning_message_32
		end

feature -- Status setting

	reset
			-- Reset `is_ok', `error_code_stored',`error_message_stored' and `warning_message' after error occurred.
			--| Perform this operation through `DB_CONTROL'.
		do
			handle.status.reset
		ensure
			is_ok: is_ok
			no_error: error_code = 0 and error_message_32.is_empty and warning_message_32.is_empty
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_STATUS_USE
