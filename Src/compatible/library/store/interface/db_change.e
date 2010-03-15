note

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

	last_parsed_query : detachable STRING
			-- Last parsed SQL query
		do
			Result := implementation.last_parsed_query
		end

feature -- Basic operations

	modify (request: STRING)
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

	execute_query
			-- Execute `modify' with `last_query'.
		local
			l_query: like last_query
		do
			l_query := last_query
			check l_query /= Void end -- implied by precursor's precondition `last_query_not_void'
			modify (l_query)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_CHANGE [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make
			-- Create an interface object to change active base.
		local
			l_ht: like ht
			l_ht_order: like ht_order
		do
			implementation := handle.database.db_change
			create l_ht.make (name_table_size)
			ht := l_ht
			create l_ht_order.make (name_table_size)
			ht_order := l_ht_order
			l_ht_order.compare_objects
			implementation.set_ht (l_ht)
			implementation.set_ht_order (l_ht_order)
		end

note
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



