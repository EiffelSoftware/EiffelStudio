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
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

