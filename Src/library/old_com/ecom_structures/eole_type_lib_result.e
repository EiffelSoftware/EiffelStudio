indexing

	description: "Result structure of EOLE_TYPE_INFO.find_name"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_LIB_RESULT
	
creation
	make
	
feature -- Initialization

	make (cnt: INTEGER) is
			-- Initialize attributes
		do
			!! type_info.make (0, cnt - 1)
			!! member_ids.make (0, cnt - 1)
			count := cnt
		end
		
feature -- Access

	type_info: ARRAY [POINTER]
			-- Array of pointers on ITypeInfo interfaces matching `find_name'
		
	member_ids: ARRAY [INTEGER]
			-- Array of identifiers of ITypeInfo interfaces.
		
	count: INTEGER
			-- Size of arrays
		
end -- class EOLE_TYPE_LIB_RESULT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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

