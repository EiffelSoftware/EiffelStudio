note
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

	DB_EXEC_USE

	HANDLE_SPEC [G]

feature -- Status setting and report

	connect
			-- Connection from database
		require
			not_already_connected: not is_connected
		local
			l_connect_string: STRING
			l_login: like handle.login
		do
			l_login := handle.login
			if not l_login.is_login_by_connection_string then
				db_spec.connect (l_login.name, l_login.passwd, l_login.data_source, l_login.application, l_login.hostname,
									l_login.role_id, l_login.role_passwd, l_login.group_id
							)
				if is_ok then
					handle.status.set_connect (True)
				end
			else
				if db_spec.is_connection_string_supported then
					l_connect_string := l_login.connection_string
					db_spec.connect_by_connection_string (l_connect_string)
					if is_ok then
						handle.status.set_connect (True)
					end
				else
					if is_tracing then
						trace_message ("Current implementation does not support connection string.")
					end
					handle.status.set_connect (False)
				end
			end
		end

	disconnect
			-- Disconnection from database
		require
			connection_exists: is_connected
		do
			db_spec.disconnect
		end

	commit
			-- Commit status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.commit
		end

	rollback
			-- Rollback status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.rollback
		end

	transaction_count: INTEGER
			-- Number of started transactions with database handle
		require
			connection_exists: is_connected
		do
			Result := db_spec.trancount
		end

	begin
			-- Start of transaction status from database handle
		require
			connection_exists: is_connected
		do
			db_spec.begin
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

end -- class DATABASE_CONTROL


