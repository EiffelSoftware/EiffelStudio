note
	description: "A connector to a relational database system."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_RDBMS_CONNECTOR

inherit
	PS_READ_REPOSITORY_CONNECTOR

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		local
			connection: PS_SQL_CONNECTION
		do
			connection := get_connection (a_transaction)
			connection.commit
			release_connection (a_transaction)
		rescue
			rollback (a_transaction)
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		local
			connection: PS_SQL_CONNECTION
		do
			if not a_transaction.has_error then -- Avoid a "double rollback"
				connection := get_connection (a_transaction)
				a_transaction.set_error (connection.last_error)
				connection.rollback
				release_connection (a_transaction)
			end
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- Set the transaction isolation level such that all values in `settings' are respected.
		do
			database.set_transaction_isolation (settings)
		end

	close
			-- Close all connections.
		do
			database.close_connections
		end

feature {PS_ABEL_EXPORT} -- Connection handling

	get_connection (transaction: PS_INTERNAL_TRANSACTION): PS_SQL_CONNECTION
			-- Get the connection associated with `transaction'.
			-- Acquire a new connection if the transaction is new.
		do
			if attached active_connections [transaction] as res then
				Result := res
			else
				Result := database.acquire_connection
				active_connections.extend (Result, transaction)
			end
		end

	release_connection (transaction: PS_INTERNAL_TRANSACTION)
			-- Release the connection associated with `transaction'.
		do
			if attached active_connections [transaction] as conn then
				active_connections.remove (transaction)
				database.release_connection (conn)
			end
		end

feature {NONE} -- Implementation

	active_connections: HASH_TABLE [PS_SQL_CONNECTION, PS_INTERNAL_TRANSACTION]
			-- These are the normal connections attached to a transaction.
			-- They do not have auto-commit and they are closed once the transaction is finished.
			-- They only write and read the ps_value table.

	database: PS_SQL_DATABASE
			-- The actual database.

feature {NONE} -- Initialization

	initialize (a_database: like database)
			-- Initialization for `Current'.
		do
			batch_retrieval_size := {PS_REPOSITORY}.Infinite_batch_size
			create plugins.make (1)

			create active_connections.make (1)
			database := a_database
		end

end
