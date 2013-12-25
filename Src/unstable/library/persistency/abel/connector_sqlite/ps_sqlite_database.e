note
	description: "Wrapper for a SQLite database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_DATABASE

inherit

	PS_SQL_DATABASE

create
	make

feature {PS_ABEL_EXPORT}

	acquire_connection: PS_SQL_CONNECTION
			-- Get a new connection.
			-- The transaction isolation level of the new connection is the same as in `Current.transaction_isolation_level', and autocommit is disabled.
		do
				-- It only works with one connection, so create a wrapper around it and return that.
			create {PS_SQLITE_CONNECTION} Result.make (unique_connection)
		end

	release_connection (a_connection: PS_SQL_CONNECTION)
			-- Release connection `a_connection'
		do
				-- There is only one connection which should not be closed, therefore do nothing.
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- Set the transaction isolation level such that all values in `settings' are respected.
		do
			-- Due to the global write lock of SQLite, the highest isolation is default
			-- (and cannot be changed). Thus this function does not need an implementation.
		end

	close_connections
			-- Close all currently open connections.
		do
			unique_connection.rollback
			unique_connection.close
		end

feature {NONE} -- Initialization

	make (database_file: STRING)
			-- Initialization for `Current'.
		do
			database_location := database_file
			create unique_connection.make_create_read_write (database_location)
			unique_connection.begin_transaction (false)
		end

	database_location: STRING
			-- The location of the database file.

	unique_connection: SQLITE_DATABASE
			-- The only connection to the database.

end
