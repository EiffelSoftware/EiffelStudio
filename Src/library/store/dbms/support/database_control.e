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

	HANDLE_SPEC [G]

feature -- Status setting and report

	connect is
			-- Connection from database
		require
			not_already_connected: not is_connected
		local
			temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8: STRING
		do
			temp1 := handle.login.name
			temp2 := handle.login.passwd
			temp3 := handle.login.data_source
			temp4 := handle.login.application
			temp5 := handle.login.hostname
			temp6 := handle.login.roleId
			temp7 := handle.login.rolePassWd
			temp8 := handle.login.groupId

			db_spec.connect (temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8)
		end

	disconnect is
			-- Disconnection from database 
		require
			connection_exists: is_connected
		do
			db_spec.disconnect
		end

	commit is
			-- Commit status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.commit
		end

	rollback is
			-- Rollback status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.rollback
		end

	transaction_count: INTEGER is
			-- Number of started transactions with database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.trancount
		end

	begin is
			-- Start of transaction status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.begin
		end

end -- class DATABASE_CONTROL

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
