note
	description: "Wrapper for DB_HANLDER"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATA_VALUE

create
	make

feature {NONE} --Initialization

	make (a_handler: ESA_DATABASE_HANDLER)
			-- Create a new data value object with a handler `a_handler'
		do
 			db_handler := a_handler
 		ensure
 			database_handler_set: db_handler = a_handler
		end

feature -- Iteration

	start
			-- Set the cursor on first element
		do
			db_handler.start
		end

	forth
			-- Move cursor to next element
		do
			db_handler.forth
		end

	after: BOOLEAN
			-- True for the last element
		do
			Result := db_handler.after
		end

feature -- Access

	read_integer_32 (a_index: INTEGER): INTEGER_32
			-- Retrieved value at `a_index' position in `item'
		do
			if attached item as l_item then
				if attached {INTEGER_32_REF} l_item.item (a_index) as  ll_item then
					Result := ll_item.item
				end
			end
		end

	read_string (a_index: INTEGER): detachable STRING
			-- Retrieved value at `a_index' position in `item'
		do
			if attached item as l_item then
				if attached {STRING} l_item.item (a_index) as  ll_item then
					Result := ll_item
				end
			end
		end

	read_date_time (a_index: INTEGER): detachable DATE_TIME
			-- Retrieved value at `a_index' position in `item'
		do
			if attached item as l_item then
				if attached {DATE_TIME} l_item.item (a_index) as  ll_item then
					Result := ll_item
				end
			end
		end


	read_boolean (a_index: INTEGER): detachable BOOLEAN
			-- Retrieved value at `a_index' position in `item'
		do
			if attached item as l_item then
				if attached {BOOLEAN} l_item.item (a_index) as  ll_item then
					Result := ll_item
				end
			end
		end


	item: detachable DB_TUPLE
			-- Current element
		do
			if attached {DB_TUPLE} db_handler.item as l_item then
				Result := l_item
			end
		end

feature {NONE} -- Implementation

	db_handler: ESA_DATABASE_HANDLER
			-- Database Handler
end
