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

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
