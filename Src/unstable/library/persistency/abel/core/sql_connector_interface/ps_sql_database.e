note
	description: "[
		Provides the interface for a wrapper to a database like MySQL or SQlite.
		Descendants may implement connection pooling, or just open and close connections all the time.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_SQL_DATABASE

inherit

	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT}

	acquire_connection: PS_SQL_CONNECTION
			-- Get a new connection.
			-- The transaction isolation level of the new connection is the same as in `Current.transaction_isolation_level', and autocommit is disabled.
		deferred
			-- Remarks when implementing this feature:
			-- You can create a new connection to the database or use a pool of connections.
			-- It is also possible to run ABEL with only one connection. However, note that to do this, you have to ensure the following:
				-- This function always returns the same connection (the only one you have).
				-- `release_connection' should not close it
				-- Autocommit always has to stay disabled
				-- To have proper transaction support, you should create ABEL with client-side transaction management support enabled.
		ensure
			autocommit_disabled: not Result.autocommit
			transaction_level_set: Result.transaction_isolation_level.is_equal (Current.transaction_isolation_level)
		end

	release_connection (a_connection: PS_SQL_CONNECTION)
			-- Release connection `a_connection'.
		deferred
				-- Remarks when implementing this feature:
				-- Close it or add it back to the pool of free connections.
				-- If you only have one connection, don't do anything.
		end

	close_connections
			-- Close all currently open connections.
		deferred
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The transaction isolation level for new connections.

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all connections that are acquired in the future
			-- Note: Some databases don't support all transaction isolation levels. In that case, a higher isolation level is chosen.
		deferred
		ensure
			correct_result: transaction_isolation_level >= a_level
		end

end
