indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: change, modify, update, insert, delete
	Product: EiffelStore
	Database: All_Bases

class DB_CHANGE

inherit

	DB_STATUS_USE
		export
			{ANY} is_connected
			{ANY} is_ok
		end

	DB_EXEC_USE
		export
			{NONE} all
			{ANY} set_trace
		end

	DB_EXPRESSION

	DB_CONSTANT

create -- Creation procedure

	make

feature -- Access

	last_parsed_query : STRING is
			-- Last parsed SQL query
		do
			Result := implementation.last_parsed_query
		end

feature -- Basic operations

	modify (request: STRING) is
			-- Execute `request' to modify persistent objects.
			-- When using the DBMS layer the request must be
			-- SQL-like compliant.
		require
			connected: is_connected
			request_exists: request /= Void
			is_ok: is_ok
		do
			last_query := request
			implementation.modify (request)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			last_query_changed: last_query = request
		end

	execute_query is
			-- Execute `modify' with `last_query'.
		do
			modify (last_query)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_CHANGE [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make is
			-- Create an interface object to change active base.
		do
			implementation := handle.database.db_change
			create ht.make (name_table_size)
			create ht_order.make (name_table_size)
			implementation.set_ht (ht)
			implementation.set_ht_order (ht_order)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_CHANGE



