indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: ODBC
				
class

	DB_PARA_ODBC

creation
	
	make

feature -- Initialization

	make ( size: INTEGER) is
		do
			!! ptr.make(1, size)
			count := size
		end

feature -- Status Setting

	resize (size: INTEGER) is
		require
			array_exist: ptr /= Void
		do
			ptr.resize(1, size)
			count := size
		end	

	set (val: POINTER; pos: INTEGER) is
		do
			ptr.put(val, pos)
		end

	get (pos: INTEGER): POINTER is
		do
			Result := ptr @ pos
		end

	release is
		local 
			i: INTEGER
		do
			from 	
				i := 1
			until 
				i > count
			loop
				odbc_c_free (ptr @ i)
				i := i + 1
			end		
			count := 0
		end


feature  -- Status
	
	count: INTEGER
	
	ptr: ARRAY[POINTER]

	
feature { NONE} -- External Features

	odbc_c_free ( p: POINTER ) is
		external
			"C"
		end

end -- class DB_PARA_ODBC


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

