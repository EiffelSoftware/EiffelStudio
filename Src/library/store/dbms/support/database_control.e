indexing
	description: "Implementation of DB_CONTROL";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_CONTROL [G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE
		export
			{ANY} is_connected
		end

	DATABASE_HANDLE_USE [G]

feature -- Status setting and report

	connect: INTEGER is
			-- Connection status from database handle
		require
			not_already_connected: not is_connected
		local
			temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8: STRING
		do
			temp1 := database_handle.login.name
			temp2 := database_handle.login.passwd
			temp3 := database_handle.login.data_source
			temp4 := database_handle.login.application
			temp5 := database_handle.login.hostname
			temp6 := database_handle.login.roleId
			temp7 := database_handle.login.rolePassWd
			temp8 := database_handle.login.groupId

			Result := db_spec.connect (temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8)

		end

	disconnect: INTEGER is
			-- Disconnection status from database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.disconnect
		end

	commit: INTEGER is
			-- Commit status from database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.commit
		end

	rollback: INTEGER is
			-- Rollback status from database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.rollback
		end

	transaction_count: INTEGER is
			-- Number of started transactions with database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.trancount
		end

	begin: INTEGER is
			-- Start of transaction status from database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.begin
		end

end -- class DATABASE_CONTROL

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
