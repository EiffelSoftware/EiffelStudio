indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE_ROUTINES

inherit 
	ECOM_ROUTINES

feature -- Basic Operations

	is_compound_file (a_name: STRING): BOOLEAN is
			-- Indicates whether a particular disk file contains 
			-- storage object
		local
			wide_string: ECOM_WIDE_STRING
			i: INTEGER
		do
			!!wide_string.make_from_string (a_name)
			i := ccom_is_compound_file (initializer_routines, wide_string.item)
			if (i = 1) then
				Result := true
			end
			
		end

feature {NONE} -- Externals

	ccom_is_compound_file (cpp_obj: POINTER; a_name: POINTER): INTEGER is
		external
			"C++ [E_Routines %"E_Routines.h%"] (WCHAR *):EIF_INTEGER"
		end

end -- class ECOM_STORAGE_ROUTINES

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

