indexing

	description: "PARAMDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PARAM_DESC

inherit
	EOLE_OBJECT_WITH_POINTER

	EOLE_PARAM_FLAGS
	
feature -- Access

	flags: INTEGER is
			-- Describe parameter
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_paramdesc_flags (ole_ptr)
		end

	default: EOLE_VARIANT is
			-- Defaul value for parameter if `flags'
			-- contain `Paramflag_fopt' and
			-- `Paramflag_fhasdefault'
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_flags: has_fopt_and_fhasdefault (flags)
		do
			!! Result
			Result.attach (ole2_paramdesc_default (ole_ptr))
		end

feature {NONE} -- Externals

	ole2_paramdesc_flags (this: POINTER): INTEGER is
		external
			"C [macro %"paramdesc.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_paramdesc_flags"
		end

	ole2_paramdesc_default (this: POINTER): POINTER is
		external
			"C [macro %"paramdesc.h%"] (EIF_POINTER): EIF_POINTER"
		alias
			"eole2_paramdesc_default"
		end
	
end -- class EOLE_PARAM_DESC

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

