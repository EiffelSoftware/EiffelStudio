indexing
	description: "Storage Routines."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE_ROUTINES

inherit 
	ECOM_ROUTINES

feature -- Basic Operations

	is_compound_file (a_name: STRING): BOOLEAN is
			-- Does file `a_name' contain a storage object?
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			Result := ccom_is_compound_file (initializer_routines, wide_string.item) = 1
		end

feature {NONE} -- Externals

	ccom_is_compound_file (cpp_obj: POINTER; a_name: POINTER): INTEGER is
		external
			"C++ [E_Routines %"E_Routines.h%"] (WCHAR *): EIF_INTEGER"
		end

end -- class ECOM_STORAGE_ROUTINES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

