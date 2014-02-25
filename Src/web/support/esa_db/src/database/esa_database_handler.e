note
	description: "Abstract Database Handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_DATABASE_HANDLER

feature -- Access

	store: detachable ESA_DATABASE_STORE_PROCEDURE
			-- Database stored_procedure to handle

	query: detachable ESA_DATABASE_QUERY

feature -- Modifiers

	set_store (a_store: ESA_DATABASE_STORE_PROCEDURE)
			-- Set store to execute
		require
			store_not_void: a_store /= Void
		do
			store := a_store
		ensure
			store = a_store
		end

	set_query (a_query: ESA_DATABASE_QUERY)
			-- Set query to execute
		require
			query_not_void: a_query /= Void
		do
			query := a_query
		ensure
			query = a_query
		end

feature -- Functionality

	execute_reader
			-- Execute store
		require
			store_not_void: store /= void
		deferred
		end

	execute_writer
			-- Execute store
		require
			store_not_void: store /= void
		deferred
		end

feature -- SQL Queries

	execute_query
			-- Execute query
		require
			query_not_void: query /= void
		deferred
		end

feature -- Iteration

	start
			-- Set the cursor on first element
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
			-- Retrieved value at `a_index' position in `item'
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {INTEGER_32_REF} l_item.item (a_index) as ll_item then
					Result := ll_item.item
				end
			end
		end

	read_string (a_index: INTEGER): detachable STRING
			-- Retrieved value at `a_index' position in `item'
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {STRING} l_item.item (a_index) as ll_item then
					Result := ll_item
				end
			end
		end

	read_date_time (a_index: INTEGER): detachable DATE_TIME
			-- Retrieved value at `a_index' position in `item'
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {DATE_TIME} l_item.item (a_index) as ll_item then
					Result := ll_item
				end
			end
		end

	read_boolean (a_index: INTEGER): detachable BOOLEAN
			-- Retrieved value at `a_index' position in `item'
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

	has_error: BOOLEAN

feature {ESA_REPORT_DATA_PROVIDER, ESA_LOGIN_DATA_PROVIDER} -- Implementation

	connect
			-- Connect to the database
		deferred
		ensure
			is_connected
		end

	disconnect
			-- Disconnect from the database
		deferred
		ensure
			not_connected: not is_connected
		end

	is_connected: BOOLEAN
			-- True if connected to the database
		deferred
		end

end
