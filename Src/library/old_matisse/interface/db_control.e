indexing

	Status: "See notice at end of class";
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

creation -- Creation procedure

	make

feature -- Basic operations

	connect is
			-- Connect to database.
		require
			not_already_connected: not is_connected
		do
			handle.status.set (implementation.connect)
			if is_ok then
				handle.status.set_connect (true)
			end
		ensure
			not is_ok or else is_connected
		end

	disconnect is
			-- Disconnect from database.
		require
			connection_exists: is_connected
		do
			handle.status.reset
			handle.status.set (implementation.disconnect)
			handle.status.set_connect (false)
		ensure
			no_connection: not is_connected
			all_transaction_ended: transaction_count = 0
		end

	commit is
			-- Commit work.
		require
			connection_exists: is_connected
			transaction_exists: transaction_count > 0
		do
			handle.status.set (implementation.commit)
		end

	rollback is
			-- Rollback work.
		require
			connection_exists: is_connected
			transaction_exists: transaction_count > 0
		do
			handle.status.set (implementation.rollback)
		end

	raise_error is
			-- Prompt error code and error message on standard output.
		do
			if not is_ok then
				io.error.putstring ("EiffelStore Error")
				if error_code /= 1 then
					io.error.putstring (" <")
					io.error.putint (error_code)
					io.error.putchar ('>')
				end
				io.error.putstring (": ")
				io.error.putstring (error_message)
			end
		end

	begin is
			-- Start a new transaction.
		require
			connection_exists: is_connected
		do
			handle.status.set (implementation.begin)
		end

feature -- Status report

	transaction_count: INTEGER is
			-- Number of started transactions
		require
			connection_exists: is_connected
		do
			Result := implementation.transaction_count
		end

feature {NONE} -- Implementation

	implementation: DB_CONTROL_I
		-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make is
			-- Create an interface objet to control the active base.
		do
			implementation := handle.database.db_control_i
		end

end -- class DB_CONTROL


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
