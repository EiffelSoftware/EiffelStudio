note
	description: "Wrapper for a MySQL database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_DATABASE

inherit

	PS_SQL_DATABASE

create
	make

feature

	acquire_connection: PS_SQL_CONNECTION
			-- Get a new connection.
			-- The transaction isolation level of the new connection is the same as in `Current.transaction_isolation_level', and autocommit is disabled.
		local
			internal_connection: MYSQLI_CLIENT
		do
				-- Create a new `internal_connection'
			create internal_connection.make
			internal_connection.set_username (database_user)
			internal_connection.set_password (database_user_password)
			internal_connection.set_database (database_name)
			internal_connection.set_host (mysql_server_hostname)
			internal_connection.set_port (mysql_server_port)
			internal_connection.connect
				-- Set the default settings
			internal_set_transaction_level (internal_connection)
				-- Use `internal_connection' to create the MySQL connection wrapper
			create {PS_MYSQL_CONNECTION} Result.make (internal_connection, transaction_isolation_level)
				-- Disable autocommit
			Result.set_autocommit (False)
		end

	release_connection (a_connection: PS_SQL_CONNECTION)
			-- Release connection `a_connection'
		do
				-- Just close the connection
			check attached {PS_MYSQL_CONNECTION} a_connection as conn then
			--	conn.internal_connection.rollback
				conn.internal_connection.close
			end
		end

	close_connections
			-- Close all currently open connections
		do
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all connections that are acquired in the future
			-- Note: Some databases don't support all transaction isolation levels. In that case, a higher isolation level is chosen.
		do
			transaction_isolation_level := a_level
		end

feature {NONE} -- Initialization

	make (username, user_password, db_name, db_host: STRING; db_port: INTEGER)
			-- Create the MySQL database wrapper
		do
			database_user := username
			database_user_password := user_password
			database_name := db_name
			mysql_server_hostname := db_host
			mysql_server_port := db_port
			create transaction_isolation_level
			transaction_isolation_level := transaction_isolation_level.repeatable_read -- This is the default in MySQL for InnoDB tables
		end

feature {NONE} -- Connection details

	database_user: STRING

	database_user_password: STRING

	database_name: STRING

	mysql_server_hostname: STRING

	mysql_server_port: INTEGER

feature {NONE} -- Implementation

	internal_set_transaction_level (a_connection: MYSQLI_CLIENT)
			-- Set the default transaction level defined in `Current.transaction_isolation_level'
		do
			if transaction_isolation_level = transaction_isolation_level.read_uncommitted then
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
			elseif transaction_isolation_level = transaction_isolation_level.read_committed then
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL READ COMMITTED")
			elseif transaction_isolation_level = transaction_isolation_level.repeatable_read then
					-- Do nothing - Repeatable Read is the standard
			elseif transaction_isolation_level = transaction_isolation_level.serializable then
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE")
			end
		end

end
