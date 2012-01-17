note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class DB_CONTROL

inherit
	DB_STATUS_USE
		export
			{ANY} all
			{NONE} handle
		end

	DB_EXEC_USE
		export
			{ANY} all
			{NONE} handle
		end

	NUMERIC_NULL_VALUE
		export
			{ANY} numeric_null_value, set_numeric_null_value
		end

create
	make

feature -- Basic operations

	connect
			-- Connect to database.
		require
			not_already_connected: not is_connected
		do
			implementation.connect
		end

	disconnect
			-- Disconnect from database.
		require
			connection_exists: is_connected
		do
			handle.status.reset
			implementation.disconnect
			handle.status.set_connect (False)
		ensure
			no_connection: not is_connected
			all_transaction_ended: transaction_count = 0
		end

	commit
			-- Commit work.
		require
			connection_exists: is_connected
			transaction_exists: transaction_count >= 0
		do
			implementation.commit
		end

	rollback
			-- Rollback work.
		require
			connection_exists: is_connected
			transaction_exists: transaction_count >= 0
		do
			implementation.rollback
		end

	raise_error
			-- Prompt error code and error message on standard output.
		do
			if not is_ok then
				fixme ("Unicode support for output.")
				io.error.putstring ("EiffelStore Error")
				if error_code /= 0 then
					io.error.putstring (" <")
					io.error.putint (error_code)
					io.error.putchar ('>')
				end
				io.error.putstring (": ")
				io.error.putstring (error_message_32.as_string_8)
			end
		end

	begin
			-- Start a new transaction.
		require
			connection_exists: is_connected
		do
			implementation.begin
		end

feature -- Status report

	transaction_count: INTEGER
			-- Number of started transactions
		require
			connection_exists: is_connected
		do
			Result := implementation.transaction_count
		end

feature {NONE} -- Implementation

	implementation: DATABASE_CONTROL [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make
			-- Create an interface objet to control the active base.
		require
			database_set: is_database_set
		do
			implementation := handle.database.db_control
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_CONTROL



