indexing
	description: "Encapsulation of DISPPARAMS structure"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DISP_PARAMS

inherit
	ECOM_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Measurement

	structure_size: INTEGER is
			-- Size of DISPPARAMS structure
		do
			Result := c_size_of_disp_params
		end

feature {NONE} -- Externals

	c_size_of_disp_params: INTEGER is
		external 
			"C [macro %"E_dispparams.h%"]"
		alias
			"sizeof(DISPPARAMS)"
		end

end -- class ECOM_DISP_PARAMS

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

