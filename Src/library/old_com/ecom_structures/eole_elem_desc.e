indexing

	description: "ELEMDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_ELEM_DESC

inherit
	EOLE_OBJECT_WITH_POINTER
		
feature -- Access

	typedesc: EOLE_TYPE_DESC is
			-- Info about parameter
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_get_elemdesc_typedesc (ole_ptr))
		end

	idldesc: EOLE_IDL_DESC is
			-- Info for remoting element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_get_elemdesc_idldesc (ole_ptr))
		end

feature {NONE} -- Externals

	ole2_get_elemdesc_typedesc (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_get_elemdesc_typedesc"
		end

	ole2_get_elemdesc_idldesc (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_get_elemdesc_idldesc"
		end
	
end -- class EOLE_ELEM_DESC

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

