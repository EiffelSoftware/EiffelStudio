note
	description: "Abstract Database Handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_HANDLER

inherit
--	SHARED_LOGGER

feature -- Access

	store: detachable DATABASE_STORE_PROCEDURE
			-- Database stored_procedure to handle.

	query: detachable DATABASE_QUERY
			-- Database query.

feature -- Modifiers

	set_store (a_store: DATABASE_STORE_PROCEDURE)
			-- Set `store' to `a_store' to execute.
		require
			store_not_void: a_store /= Void
		do
			store := a_store
		ensure
			store_set: store = a_store
		end

	set_query (a_query: DATABASE_QUERY)
			-- Set `query' to `a_query' to execute.
		require
			query_not_void: a_query /= Void
		do
			query := a_query
		ensure
			query_set: query = a_query
		end

feature -- Functionality Store Procedures

	execute_store_reader
			-- Execute a `store' to read data.
		require
			store_not_void: store /= Void
		deferred
		end

	execute_store_writer
			-- Execute a `store' to write data.
		require
			store_not_void: store /= Void
		deferred
		end

feature -- SQL Queries

	execute_query
			-- Execute sql query, the read data from the database.
		require
			query_not_void: query /= Void
		deferred
		end

	execute_change
			-- Execute sql query that update/add data.
		require
			query_not_void: query /= Void
		deferred
		end


feature -- Iteration

	start
			-- Set the cursor on first element.
		deferred
		end

	item: ANY
			-- Item at current cursor position.
		require
			valid_position: not after
		deferred
		end

	after: BOOLEAN
			-- Are there no more items to iterate over?
		deferred
		end

	forth
			-- Move to next position.
		require
			valid_position: not after
		deferred
		end

feature -- Access

	read_integer_32 (a_index: INTEGER): INTEGER_32
			-- Retrieved value at `a_index' position in `item'.
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {INTEGER_32_REF} l_item.item (a_index) as ll_item then
					Result := ll_item.item
				end
			end
		end

	read_string (a_index: INTEGER): detachable STRING
			-- Retrieved value at `a_index' position in `item'.
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {STRING} l_item.item (a_index) as ll_item then
					Result := ll_item
				elseif attached {BOOLEAN_REF} l_item.item (a_index) as ll_item then
					Result := ll_item.item.out
				end
			end
		end

	read_date_time (a_index: INTEGER): detachable DATE_TIME
			-- Retrieved value at `a_index' position in `item'.
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {DATE_TIME} l_item.item (a_index) as ll_item then
					Result := ll_item
				end
			end
		end

	read_boolean (a_index: INTEGER): detachable BOOLEAN
			-- Retrieved value at `a_index' position in `item'.
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {BOOLEAN} l_item.item (a_index) as ll_item then
					Result := ll_item
				elseif attached {BOOLEAN_REF} l_item.item (a_index) as ll_item then
					Result := ll_item.item
				end
			end
		end

feature -- Status Report

	count: INTEGER
			-- Number of rows, last execution.
		deferred
		end

	connection: DATABASE_CONNECTION
			-- Database connection.

	db_control: DB_CONTROL
			-- Database control.
		do
			Result := connection.db_control
		end

	db_result: detachable DB_RESULT
			-- Database query result.

	db_selection: detachable DB_SELECTION
			-- Database selection.

	db_change: detachable DB_CHANGE
			-- Database modification.	

feature -- Error handling

	check_database_change_error
			-- Check database error from `db_change'.
		do
			if attached db_change as l_change and then not l_change.is_ok then
				database_error_handler.add_database_error (l_change.error_message_32, l_change.error_code)
				l_change.reset
			end
		end

	check_database_selection_error
			-- Check database error from `db_selection'.
		do
			if attached db_selection as l_selection and then not l_selection.is_ok then
				database_error_handler.add_database_error (l_selection.error_message_32, l_selection.error_code)
				l_selection.reset
			end
		end

feature -- Error Handling

	database_error_handler: DATABASE_ERROR_HANDLER
			-- Error handler.

feature -- Status Report

	has_error: BOOLEAN
			-- Has error?
		do
			Result := database_error_handler.has_error
		end

feature -- Helper

	exception_as_error (a_e: like {EXCEPTION_MANAGER}.last_exception)
			-- Record exception as an error.
		do
			if attached a_e as l_e and then attached l_e.trace as l_trace then
				database_error_handler.add_error_details (l_e.code, once "Exception", l_trace.as_string_32)
			end
		end

feature -- Connection Handling

	connect
			-- Connect to the database.
		deferred
		end

	disconnect
			-- Disconnect from the database.
		deferred
		ensure
			not_connected: not is_connected
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		deferred
		end

end
