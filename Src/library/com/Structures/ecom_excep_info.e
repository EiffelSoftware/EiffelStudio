indexing
	description: "Encapsulation of EXEPTINFO structure"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEP_INFO

inherit
	ECOM_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

feature -- Measurement

	structure_size: INTEGER is
			-- Size of EXCEPINFO structure
		do
			Result := c_size_of_excep_info
		end


feature -- Conversion

feature -- Miscellaneous

feature -- Basic operations

feature {NONE} -- Implementation

feature {NONE} -- Externals

	c_size_of_excep_info: INTEGER is
		external 
			"C [macro %"E_excepinfo.h%"]"
		alias
			"sizeof(EXCEPINFO)"
		end

end -- class ECOM_EXCEP_INFO

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

