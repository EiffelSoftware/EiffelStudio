class MATISSE_TABLES 

inherit

	IDF_ID 

feature -- Access

	idf_table_name : STRING is once Result:="IDF_TABLE" end -- idf_table_name

	idf_table : CELL[MATISSE_IDF_TABLE] is once !!Result.put(Void) end -- idf_table

end -- class MATISSE_TABLES

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

