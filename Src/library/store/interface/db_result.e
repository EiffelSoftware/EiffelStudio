indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class DB_RESULT

inherit

	HANDLE_USE
		rename
			copy as hard_copy
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
			-- Create an interface object
			-- to receive query result.
		do
			implementation := handle.database.db_result
		end

feature -- Element change

	fill_in is
			-- Fill in `data'.
		do
			implementation.fill_in (descriptor)
		end

	copy (other: DB_RESULT) is
			-- Assign Current attributes with `other' attributes.
		require
			other /= Void
		do
			implementation := other.implementation
		ensure
			implementation /= Void
		end

feature -- Status report

	data: DB_DATA is
			-- Loaded data
		do
			Result := implementation.data
		end
	
	map_table_to_create: BOOLEAN is
			-- Does map table need to be created? 
		do
			Result := map_table = Void
		end
	
feature {DB_SELECTION} -- Status setting

	update_map_table (obj: ANY) is
			-- Update table mapping field
			-- position in `obj' with column rank.
		do
			implementation.update_map_table (obj)
		end

	set_descriptor (d: INTEGER) is
			-- Associate `d' to `Current' for selection.
		do
			descriptor := d
		ensure
			descriptor = d
		end

	update_metadata is
			-- Cursor must update database metadata to
			-- fill in properly.
		do
			data.update_metadata
		end

feature {DB_RESULT} -- Implementation

	implementation: DATABASE_TUPLE [DATABASE]
			-- Current class implementation

feature {NONE} -- Status report

	descriptor: INTEGER
			-- Cursor descriptor
			
	map_table: ARRAY [INTEGER] is
			-- Map table which allows to find data position
			-- into an Eiffel object.
		do
			Result := implementation.map_table
		end

end -- class DB_RESULT



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
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

