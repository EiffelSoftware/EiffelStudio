note
	description: "Action to change the database"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CHANGE_ACTION

feature {NONE} -- Initialization

	make (a_change: like database_change)
			-- Initialization
		do
			database_change := a_change
		ensure
			database_change_set: database_change = a_change
		end

feature -- Execution

	execute_change
			-- Execute the change
		require
			execution_possible: is_execution_possible
		local
			l_change: like database_change
		do
			l_change := database_change
			l_change.set_query (statement)
			l_change.execute_query
			check_database_error
		end

feature -- Query

	is_execution_possible: BOOLEAN
			-- Is execution possible?
		do
			Result := database_change.is_connected
		end

feature -- Access

	statement: STRING_32
			-- The select statement
		deferred
		end

	database_change: DB_CHANGE
			-- Database change

feature -- Error handling

	check_database_error
			-- Check database error from `database_change'
		local
			l_change: like database_change
		do
			l_change := database_change
			if not l_change.is_ok then
				print (l_change.error_message_32)
			end
		end

end
