note
	description: "Abstract Database Handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DATABASE_HANDLER

inherit

	SHARED_ERROR

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

	execute_reader
			-- Execute store.
		require
			store_not_void: store /= void
		deferred
		end

	execute_writer
			-- Execute store.
		require
			store_not_void: store /= void
		deferred
		end

feature -- SQL Queries

	execute_query
			-- Execute query.
		require
			query_not_void: query /= void
		deferred
		end

	execute_change
			-- Execute sqlquery that update/add data.
		require
			query_not_void: query /= void
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

	read_string_8 (a_index: INTEGER): detachable STRING_8
			-- Retrieved value at `a_index' position in `item'.
		do
			if attached {DB_TUPLE} item as l_item then
				if attached {STRING_8} l_item.item (a_index) as ll_item then
					Result := ll_item
				elseif attached {BOOLEAN_REF} l_item.item (a_index) as ll_item then
					Result := ll_item.item.out
				end
			end
		end

	read_string_32 (a_index: INTEGER): detachable STRING_32
			-- Retrieved value at `a_index' position in `item'.
		do
				-- FIXME: handle string_32 !
			if attached {DB_TUPLE} item as l_item then
				if attached {READABLE_STRING_32}  l_item.item (a_index) as l_string then
					Result := l_string
				elseif  attached {STRING_32} l_item.item (a_index) as l_string then
					Result := l_string
				else
					if attached read_string (a_index) as s8 then
						Result := s8.to_string_32 -- FIXME: any escape?
					else
						debug
							check is_string_nor_null: l_item = Void end
						end
					end
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

	has_error: BOOLEAN
			-- Is there an error?

	count: INTEGER
			-- Number of rows, last execution.
		deferred
		end

feature {REPORT_DATA_PROVIDER, LOGIN_DATA_PROVIDER} -- Implementation

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
