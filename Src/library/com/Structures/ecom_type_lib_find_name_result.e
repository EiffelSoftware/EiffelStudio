indexing
	description: "Result structure of ECOM_TYPE_INFO.find_name"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_TYPE_LIB_FIND_NAME_RESULT
	
creation
	make
	
feature -- Initialization

	make (cnt: INTEGER) is
			-- Initialize attributes
		do
			!! type_info.make (1, cnt)
			!! member_ids.make (1, cnt)
			count := cnt
		end
		
feature -- Access 

	type_info: ARRAY [ECOM_TYPE_INFO]
			-- Array of pointers on ITypeInfo interfaces matching `find_name'
			-- These pointer should by attached to an object EOLE_TYPE_INFO.
		
	member_ids: ARRAY [INTEGER]
			-- Array of identifiers of ITypeInfo interfaces
		
	count: INTEGER
			-- Size of arrays
			
feature -- Element Change

	put_member_ids (value, index: INTEGER) is
			-- Set `item' of `member_ids' at `index' with `value'.
		do
			member_ids.put (value, index)
		end
		
	put_type_info (value: ECOM_TYPE_INFO; index: INTEGER) is
			-- Set `item' of `type_info' at `index' with `value'.
		do
			type_info.put (value, index)
		end
		
end -- class ECOM_TYPE_LIB_FIND_NAME_RESULT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

