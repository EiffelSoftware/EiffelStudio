indexing
	description: "REGKIND constants"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_REG_KIND

feature -- Access

	Regkind_default: INTEGER is
			-- Default register behavior
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_DEFAULT"
		end

	Rgkind_register: INTEGER is
			-- Registered type
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_REGISTER"
		end

 	Rgkind_none: INTEGER is
			-- Not registered type
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_NONE"
		end

end -- class ECOM_REG_KIND

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

