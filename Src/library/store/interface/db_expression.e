indexing

	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

deferred class DB_EXPRESSION inherit

	STRING_HDL

feature -- Status report

	last_query: STRING
			-- Last SQL statement used

feature -- Status setting

	set_query (query: STRING) is
			-- Set `last_query' with `query'.
		require
			query_not_void: query /= Void
		do
			last_query := query
		ensure
			last_query_changed: last_query = query
		end

feature -- Basic operations

	execute_query is
			-- Execute `last_query'.
		require
			last_query_not_void: last_query /= Void
		deferred
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




end -- class DB_EXPRESSION



