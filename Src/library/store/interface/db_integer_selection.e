indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: perform_select, search, retrieve
	Product: EiffelStore
	Database: All_Bases

-- Use this class to retrieve easily single integer values from the
-- database, such as min(), max() or count().

class
	DB_INTEGER_SELECTION

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok, is_connected
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
			-- Create an interface objet to query active base.
		do
			implementation := handle.database.db_integer_selection
		end

feature -- Access

	last_query: STRING is
			-- Last query set.
		require
			query_set: query_set
		do
			Result := query
		end

	load_result: INTEGER is
			-- Last result loaded.
		require
			connected: is_connected
			is_ok: is_ok
			query_executed: query_executed
		do
			Result := last_result
		end

feature -- Status report

	query_executed: BOOLEAN is
			-- Has a query been executed?
		do
			Result := last_result /= Void
		end

	query_set: BOOLEAN is
			-- Has a query been executed?
		do
			Result := query /= Void
		end

feature -- Basic operations

	set_query (a_query: STRING) is
			-- Set query to execute.
		require
			argument_exists: a_query /= Void
			argument_not_empty: not a_query.is_empty
		do
			query := a_query
		end

	execute_query is
			-- Execute `last_query' set.
		require
			connected: is_connected
			is_ok: is_ok
			query_set: last_query /= Void
		do
			last_result := implementation.execute_query (last_query)
		end

	terminate is
			-- Terminate operation.
		require
			connected: is_connected
		do
			implementation.terminate
		end

feature {NONE} -- Implementation

	query: STRING
			-- Query to execute.

	last_result: INTEGER
			-- Result of last query executed.

	implementation: DATABASE_INTEGER_SELECTION [DATABASE]
			-- Handle reference to specific database implementation

end -- class DB_INTEGER_SELECTION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
