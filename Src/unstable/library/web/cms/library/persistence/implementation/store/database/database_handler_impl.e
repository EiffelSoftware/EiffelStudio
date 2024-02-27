note
	description: "Database handler Implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_HANDLER_IMPL

inherit
	DATABASE_HANDLER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a database handler with connnection `connection'.
		do
			connection := a_connection
			create last_query.make_now
			create database_error_handler.make
		ensure
			connection_not_void: connection /= Void
			last_query_not_void: last_query /= Void
			database_error_handler_set: attached database_error_handler
		end

feature -- Functionality

	execute_store_reader
			-- Execute stored procedure that returns data.
		local
			l_db_selection: DB_SELECTION
			l_retried: BOOLEAN
		do
			if not l_retried then
				database_error_handler.reset
				if attached store as l_store then
					create l_db_selection.make
					db_selection := l_db_selection
					items := l_store.execute_reader (l_db_selection)
					check_database_selection_error
				end
			end
		rescue
			l_retried := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			if attached db_selection as l_selection then
				l_selection.reset
			end
			retry
		end

	execute_store_writer
			-- Execute stored procedure that update/add data.
		local
			l_db_change: DB_CHANGE
			l_retried : BOOLEAN
		do
		    if not  l_retried then
				database_error_handler.reset
				if attached store as l_store then
					create l_db_change.make
					db_change := l_db_change
					l_store.execute_writer (l_db_change)
					check_database_change_error
				end
			end
		rescue
			l_retried := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			if attached db_change as l_change then
				l_change.reset
			end
			retry
		end

feature -- SQL Queries

	execute_query
			-- Execute query.
		local
			l_db_selection: DB_SELECTION
			l_retried: BOOLEAN
		do
			if not l_retried then
				database_error_handler.reset
				if attached query as l_query then
					create l_db_selection.make
					db_selection := l_db_selection
					items := l_query.execute_reader (l_db_selection)
					check_database_selection_error
				end
			end
		rescue
			l_retried := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			if attached db_selection as l_selection then
				l_selection.reset
			end
			retry
		end


	execute_change
			-- Execute sql_query that update/add data.
		local
			l_db_change: DB_CHANGE
			l_retried : BOOLEAN
		do
		    if not  l_retried then
				database_error_handler.reset
				if attached query as l_query then
					create l_db_change.make
					db_change := l_db_change
					l_query.execute_change (l_db_change)
					check_database_change_error
				end
			end
		rescue
			l_retried := True
			exception_as_error ((create {EXCEPTION_MANAGER}).last_exception)
			if attached db_change as l_change then
				l_change.reset
			end
			retry
		end


feature -- Iteration

	start
			-- Set the cursor on first element.
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				l_db_selection.start
			end
		end

	forth
			-- Move cursor to next element.
		do
			if attached db_selection as l_db_selection then
				l_db_selection.forth
			else
				check False end
			end
		end

	after: BOOLEAN
			-- True for the last element.
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				Result := l_db_selection.after or else l_db_selection.cursor = Void
			else
				Result := True
			end
		end

	item: DB_TUPLE
			-- Current element.
		do
			if attached db_selection as l_db_selection and then attached l_db_selection.cursor as l_cursor then
				create {DB_TUPLE} Result.copy (l_cursor)
			else
				check False then end
			end
		end


feature {NONE} -- Implementation

	last_query: DATE_TIME
		-- Last time when a query was executed.

	keep_connection: BOOLEAN
		-- Keep connection alive?
		do
			Result := connection.keep_connection
		end

	connect
			-- Connect to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database.
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

	affected_row_count: INTEGER
			--  The number of rows changed, deleted, or inserted by the last statement.
		do
			if attached db_change as l_update then
				Result := l_update.affected_row_count
			end
		end

feature -- Result

	items : detachable LIST[DB_RESULT]
		-- Query result.

	count: INTEGER
			-- <Precursor>
		do
			if attached items as l_items then
				Result := l_items.count
			end
		end

end
