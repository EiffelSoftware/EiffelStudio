indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class DB_CONTROL_I

inherit

	DB_STATUS_USE
		export
			{ANY} is_connected
		end

feature -- Status setting and report

	connect: INTEGER is
			-- Connection status from database handle
		require
			not_already_connected: not is_connected
		deferred
		end

	disconnect: INTEGER is
			-- Disconnection status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	commit: INTEGER is
			-- Commit status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	rollback: INTEGER is
			-- Rollback status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	transaction_count: INTEGER is
			-- Number of started transactions with database handle
		require
			connection_exists: is_connected
		deferred
		end

	begin: INTEGER is
			-- Start of transaction status from database handle
		require
			connection_exists: is_connected
		deferred
		end

end -- class DB_CONTROL_I


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
