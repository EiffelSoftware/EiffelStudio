indexing

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

feature -- Status report

	is_connected: BOOLEAN
			-- Has connection to the data base server succeeded?

	is_error_updated: BOOLEAN is
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated error status?
		do
			Result := implementation.is_error_updated
		end

	error_code: INTEGER is
			-- Error code prompted by database server
		do
			if not is_error_updated then
				update_error_status
			end
			Result := error_code_stored
		end

	found: BOOLEAN is
			-- Is there any record matching the last
			-- selection condition used ?
		do
			Result := implementation.found
		end

	error_message: STRING is
			-- SQL error message prompted by database server
		do
			if not handle.status.is_error_updated then
				update_error_status
			end
			Result := error_message_stored
		end

	warning_message: STRING is
			-- SQL warning message prompted by database server
		do
			if not handle.status.is_error_updated then
				update_error_status
			end
			Result := warning_message_stored
		end

feature -- Status setting

	set_connect (new_value: BOOLEAN) is
			-- Change state of connection.
		do
			is_connected := new_value
		ensure
			is_connected_reset: is_connected = new_value
		end

	reset is
			-- Reset database error status.

		do
			implementation.reset
			error_code_stored := 0
			error_message_stored := ""
			warning_message_stored := ""
		ensure
			no_error: error_code_stored = 0
			no_message_error: error_message_stored.is_equal ("")
			no_message_warning: warning_message_stored.is_equal ("")
		end

feature {NONE} -- Implementation

	implementation: DATABASE_STATUS [DATABASE]

feature {NONE} -- error status implementation

	error_message_stored: STRING
			-- error message

	warning_message_stored: STRING
			-- warning message

	error_code_stored: INTEGER
			-- error code

	update_error_status is
			-- set `error_message_stored', `error_code_stored', `warning_message_stored' with
			-- error_status from the database server.
		do
			error_message_stored := implementation.error_message
			error_code_stored := implementation.error_code
			warning_message_stored := implementation.warning_message
		ensure
			is_error_updated
		end

feature {NONE} -- Initialization

	make is
			-- Create `implementation' handle.
		do
			implementation := handle.database.db_status
		end

invariant

	has_handle: implementation /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_STATUS



