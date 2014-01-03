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
			-- <Precursor>
		local
			internal_connection: MYSQLI_CLIENT
		do
			fixme ("Implement connection pooling.")

--			if connection_stack.is_empty then
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
				create {PS_MYSQL_CONNECTION} Result.make (internal_connection)
					-- Disable autocommit
				Result.set_autocommit (False)
--			else
--				Result := connection_stack.item
--				connection_stack.remove
--				check attached {PS_MYSQL_CONNECTION} Result as conn then
--					Result.set_autocommit (false)
--					internal_set_transaction_level (conn.internal_connection)
--				end
--			end

		end

	release_connection (a_connection: PS_SQL_CONNECTION)
			-- <Precursor>
		do
--			a_connection.rollback
--			connection_stack.extend (a_connection)

				-- Just close the connection.
			check attached {PS_MYSQL_CONNECTION} a_connection as conn then
				conn.internal_connection.close
			end
		end

	close_connections
			-- <Precursor>
		do
--			from
--			until
--				connection_stack.is_empty
--			loop
--				check attached {PS_MYSQL_CONNECTION} connection_stack.item as conn then
--					conn.internal_connection.close
--					connection_stack.remove
--				end
--			variant
--				connection_stack.count
--			end
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- <Precursor>
		do
			internal_settings := settings.twin
		end

feature {NONE} -- Initialization

	make (username, user_password, db_name, db_host: STRING; db_port: INTEGER)
			-- Initialization for `Current'.
		do
			database_user := username
			database_user_password := user_password
			database_name := db_name
			mysql_server_hostname := db_host
			mysql_server_port := db_port

			create connection_stack.make
			create internal_settings
		end

feature {NONE} -- Connection details

	connection_stack: LINKED_STACK [PS_SQL_CONNECTION]

	database_user: STRING

	database_user_password: STRING

	database_name: STRING

	mysql_server_hostname: STRING

	mysql_server_port: INTEGER

feature {NONE} -- Implementation

	internal_set_transaction_level (a_connection: MYSQLI_CLIENT)
			-- Set the default transaction level defined in `internal_settings'
		do
			if
				not internal_settings.is_phantom_allowed
			then
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE")
			elseif
				not internal_settings.is_read_skew_allowed
				or not internal_settings.is_write_skew_allowed
				or not internal_settings.is_lost_update_allowed
				or not internal_settings.is_fuzzy_read_allowed
			then
					-- Do nothing, as Repeatable Read is the standard in MySQL.
				--a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ")
			elseif
				not internal_settings.is_dirty_read_allowed
			then
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL READ COMMITTED")
			else
				a_connection.execute_query ("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
			end
		end

	internal_settings: PS_TRANSACTION_SETTINGS

end
