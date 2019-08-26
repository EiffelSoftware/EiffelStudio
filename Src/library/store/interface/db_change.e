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

	DB_EXEC_USE
		export
			{NONE} all
			{ANY} set_trace
		end

	DB_EXPRESSION
		redefine
			is_executable
		end

	DB_CONSTANT

create
	make

feature -- Access

	last_parsed_query : detachable STRING
			-- Last parsed SQL query
		obsolete
			"Use `last_parsed_query_32' instead [2017-11-30]."
		do
			if attached last_parsed_query_32 as l_str then
				Result := l_str.as_string_8
			end
		end

	last_parsed_query_32 : detachable STRING_32
			-- Last parsed SQL query
		do
			if attached implementation.last_parsed_query_32 as l_query then
				Result := l_query
			end
		end

	is_affected_row_count_supported: BOOLEAN
			-- Is `affected_row_count' supported?
		do
			Result := implementation.is_affected_row_count_supported
		end

	affected_row_count: INTEGER_32
			-- The number of rows changed, deleted, or inserted by the last statement
		do
			Result := implementation.affected_row_count
		end

feature -- Basic operations

	modify (request: READABLE_STRING_GENERAL)
			-- Execute `request' to modify persistent objects.
			-- When using the DBMS layer the request must be
			-- SQL-like compliant.
		require
			connected: is_connected
			request_exists: request /= Void
			is_ok: is_ok
		do
			last_query_32 := request.as_string_32
			implementation.modify (request)
			if not is_ok and then is_tracing then
				trace_message (error_message_32)
			end
		ensure
			last_query_changed: attached last_query_32 as l_s and then l_s.same_string_general (request)
		end

	execute_query
			-- Execute `modify' with `last_query'.
		do
			if attached last_query_32 as l_query then
				modify (l_query)
			end
		end

feature -- Query

	is_executable: BOOLEAN
			-- <Precursor>
		do
			Result := attached last_query_32 as l_s and then
						not l_s.is_empty and then
						is_connected and then
						is_ok
		end

feature {NONE} -- Implementation

	implementation: DATABASE_CHANGE [DATABASE]
			-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make
			-- Create an interface object to change active base.
		require
			database_set: is_database_set
		local
			l_imp: like implementation
		do
			create ht.make (name_table_size)
			create ht_order.make (name_table_size)
			ht_order.compare_objects
			l_imp := handle.database.db_change
			l_imp.set_ht (ht)
			l_imp.set_ht_order (ht_order)
			implementation := l_imp
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_CHANGE



