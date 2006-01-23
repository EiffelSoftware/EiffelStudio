indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: RDBMS

class DB_TUPLE

inherit

	DB_RESULT
		redefine
			implementation, data
		end

create -- Creation procedures

	copy, make

feature -- Status report

	data: DB_DATA_SQL is
			-- Loaded data returned from last SQL query result
		do
			Result := implementation.data
		end

	item (index: INTEGER): ANY is
			-- Retrieved value at `index' position in `data'.
		do
			Result := implementation.item (index)
		end

	column_name (index: INTEGER): STRING is
			-- Name of `index'-th item in Current tuple.
		do
			Result := implementation.column_name (index)
		end

	count: INTEGER is
			-- Number of columns in Current tuple
		do
			Result := implementation.count
		end

	empty: BOOLEAN is
			-- Is Curren tuple empty?
		obsolete
			"Please use `is_empty' instead to remain %
			%consistant with CONTAINER `is_empty' feature."
		do
			Result := is_empty
		end

	is_empty: BOOLEAN is
			-- Is Curren tuple empty?
		do
			if implementation = Void then
				Result := true	
			else
				Result := (count = 0)
			end
		end

feature {NONE} -- Implementation

	implementation: DATABASE_TUPLE [DATABASE];
			-- Handle reference to specific database implementation

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




end -- class DB_TUPLE



