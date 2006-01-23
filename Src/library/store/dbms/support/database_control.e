indexing
	description: "Implementation of DB_CONTROL"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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




end -- class DATABASE_CONTROL


