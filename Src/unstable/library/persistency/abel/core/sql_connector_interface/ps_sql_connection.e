note
	description: "Provides an interface for a wrapper to a database connection."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_SQL_CONNECTION

inherit

	PS_ABEL_EXPORT

	ITERABLE [PS_SQL_ROW]

feature {PS_ABEL_EXPORT} -- Settings

	set_autocommit (flag: BOOLEAN)
			-- Enable or disable autocommit on this connection.
		deferred
		ensure
			autocommit_correctly_disabled: not flag implies not is_auto_commit_enabled -- We actually can't guarantee it the other way round in all cases
		end

	is_auto_commit_enabled: BOOLEAN
			-- Is autocommit enabled? Default: no

feature {PS_ABEL_EXPORT} -- Database operations

	execute_sql (statement: STRING)
			-- Execute the SQL statement `statement', and store the result (if any) in `last_result'
			-- In case of an error, it will report it in `last_error' and raise an exception.
		deferred
				-- Remarks when implementing this feature:
				-- The SQL string can come with or without a `;' character at the end.
				-- It is also possible that there are multiple statements in `statement'. In this case they are separated by a `;'.
				-- In case of such multi-statement function call, only the result of the last statement has to be stored in `last_result'.
		end

	commit
			-- Commit the currently active transaction.
			-- In case of an error, including a failed commit, it will report it in `last_error' and raise an exception.
		deferred
		end

	rollback
			-- Rollback the currently active transaction.
			-- In case of an error, it will report it in `last_error' and raise an exception.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Database results

	last_result: ITERATION_CURSOR [PS_SQL_ROW]
			-- The result of the last database operation.
		deferred
		end

	last_results: LIST [ITERATION_CURSOR [PS_SQL_ROW]]
			-- The results from the last multi-statement database operations
		deferred
		end

	last_error: detachable PS_ERROR
			-- The last occurred error
		deferred
		end

	last_primary_key: INTEGER
			-- The last automatically generated primary key.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Utilities

	new_cursor: ITERATION_CURSOR [PS_SQL_ROW]
			-- Get a cursor over the `last_result' (Convenience function to support the `across' syntax).
		do
			Result := last_result
		end

end
