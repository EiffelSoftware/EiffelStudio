indexing

	description: "Generic flags class."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_FLAGS

feature {NONE} -- Externals

	binary_and (operand1, operand2: INTEGER): INTEGER is
			-- Binary 'and'.
		external
			"C [macro %"ecom_flags.h%"]"
		end

	binary_or (operand1, operand2: INTEGER): INTEGER is
			-- Binary 'or'.
		external
			"C [macro %"ecom_flags.h%"]"
		end

end -- class ECOM_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

