indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class DB_RESULT_I

feature -- Status setting

	fill_in (descriptor_index: INTEGER) is
			-- Fill in data with cursor value of `_descriptor_index'.
		deferred
		end

	update_map_table (object: ANY) is
			-- Update association table according to `object'.
		deferred
		end

feature -- Status report

	map_table: ARRAY [INTEGER] is
			-- Table returning a k-th object field position 
			-- corresponding to a i-th table column rank.
		deferred
		end

	data: DB_DATA is
			-- Loaded data from database cursor
		deferred
		end

end -- class DB_RESULT_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------