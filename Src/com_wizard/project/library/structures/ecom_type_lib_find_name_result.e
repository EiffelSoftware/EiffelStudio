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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

