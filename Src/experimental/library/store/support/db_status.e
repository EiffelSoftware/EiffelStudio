note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: status, error
	Product: EiffelStore
	Database: All_Bases

class DB_STATUS

inherit
	HANDLE_USE

create -- Creation procedure

	make

feature {NONE} -- Initialization

	make
			-- Create `implementation' handle.
		require
			database_set: is_database_set
		do
			implementation := handle.database.db_status
			error_message_stored := empty_string
			no_error_code_stored := implementation.no_error_code
			warning_message_stored := empty_string
		end

feature -- Status report

	is_connected: BOOLEAN
			-- Has connection to the data base server succeeded?

	is_ok: BOOLEAN
			-- Is last SQL statement ok ?
		do
			Result := error_code = no_error_code_stored
		end

	is_error_updated: BOOLEAN
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated error status?
		do
			Result := implementation.is_error_updated
		end

	is_warning_updated: BOOLEAN
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated warnings?
		do
			Result := implementation.is_warning_updated
		end

	error_code: INTEGER
			-- Error code prompted by database server
		do
			if not is_error_updated then
				update_error_status
			end
			Result := error_code_stored
		end

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?
		do
			Result := implementation.found
		end

	error_message: STRING
			-- SQL error message prompted by database server
		obsolete
			"Use `error_message_32' instead [2017-11-30]."
		do
			Result := error_message_32.as_string_8
		end

	error_message_32: STRING_32
			-- SQL error message prompted by database server
		do
			if not handle.status.is_error_updated then
				update_error_status
			end
				-- Return a copy of the stored error string for safety.
			create Result.make_from_string (error_message_stored)
		end

	warning_message: STRING
			-- SQL warning message prompted by database server
		obsolete
			"Use `warning_message_32' instead [2017-11-30]."
		do
			Result := warning_message_32.as_string_8
		end

	warning_message_32: STRING_32
			-- SQL warning message prompted by database server
		do
			if not handle.status.is_warning_updated then
				update_warning_status
			end
				-- Return a copy of the stored error string for safety.
			create Result.make_from_string (warning_message_stored)
		end

feature -- Status setting

	set_connect (new_value: BOOLEAN)
			-- Change state of connection.
		do
			is_connected := new_value
		ensure
			is_connected_reset: is_connected = new_value
		end

	reset
			-- Reset database error status.
		do
			error_code_stored := 0
			error_message_stored := empty_string
			warning_message_stored := empty_string
			implementation.reset
		ensure
			no_error: error_code_stored = 0
			no_message_error: error_message_stored.is_empty
			no_message_warning: warning_message_stored.is_empty
		end

feature {NONE} -- Implementation

	implementation: DATABASE_STATUS [DATABASE]

feature {NONE} -- error status implementation

	error_message_stored: STRING_32
			-- error message

	error_code_stored: INTEGER
			-- error code

	no_error_code_stored: INTEGER
			-- Default value of `error_code' from database (ie: no error).

	warning_message_stored: STRING_32
			-- Warning message

	update_error_status
			-- set `error_message_stored', `error_code_stored', with
			-- error_status from the database server.
		do
			error_code_stored := implementation.error_code
			if error_code_stored /= no_error_code_stored then
				error_message_stored := implementation.error_message_32
			else
				error_message_stored := empty_string
			end
		ensure
			is_error_updated: is_error_updated
		end

	update_warning_status
			-- set `warning_message_stored' from the database server.
		do
			warning_message_stored := implementation.warning_message_32
		ensure
			is_warning_update: is_warning_updated
		end

feature {NONE} -- Implementation

	empty_string: STRING_32 = ""
		-- Empty string constant.

invariant

	has_handle: implementation /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_STATUS



