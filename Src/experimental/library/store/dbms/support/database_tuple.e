note
	description: "Implementation of DB_TUPLE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_TUPLE [G -> DATABASE create default_create end]

inherit

	HANDLE_USE

create -- Creation procedure

	make

feature -- Initialization

	make
			-- Create `implementation'.
		do
			create data
		ensure
			data_not_void: data /= void
		end

feature -- Status report

	data: DATABASE_DATA [G]
			-- Associated data description

	item (index: INTEGER): detachable ANY
			-- Value of `index' column in current row
			-- pointed to by active database cursor
		require
			valid_index: valid_index (index)
		do
			Result := data.item (index)
		end

	valid_index (index: INTEGER): BOOLEAN
			-- Is `index' valid for `item'?
		do
			Result := data.valid_index (index)
		end

	map_table: detachable ARRAY [INTEGER]
			-- Association table returning k-th field 	
			-- position mapping i-th column value of current active tuple
		do
			Result := data.map_table
		ensure then
			resulting_data: Result = data.map_table
		end

	count: INTEGER
			-- Number of items
		do
			Result := data.count
		ensure
			resulting_data: Result = data.count
		end

	column_name (position: INTEGER): detachable STRING
			-- Name of the `position'-th column
		do
			Result := data.column_name (position)
		ensure
			resulting_data: Result = data.column_name (position)
		end

feature -- Status setting

	fill_in (no_descriptor: INTEGER)
			-- Fill in current tuple with database cursor.
		require else
			data_exists: data /= Void
		do
			data.fill_in (no_descriptor)
		end

	update_map_table (object: ANY)
			-- Update map table according to new `object'.
		require else
			data_exists: data /= Void
		do
			data.update_map_table (object)
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




end -- class DATABASE_TUPLE


