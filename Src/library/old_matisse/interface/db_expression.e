indexing

	Status: "See notice at end of class";
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

end -- class DB_EXPRESSION


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
