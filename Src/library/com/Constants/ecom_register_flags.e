indexing

	description: "COM Component registration code"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_REGISTER_FLAGS
	
feature -- Access

	Regcls_singleuse: INTEGER is
			-- Once an application is connected to a 
			-- class object, it is removed from public view
			-- so that no other applications can connect to it. 
		external
			"C [macro <objbase.h>]"
		alias
			"REGCLS_SINGLEUSE"
		end
		
	Regcls_multipleuse: INTEGER is
			-- Multiple applications can connect to the class object.
		external
			"C [macro <objbase.h>]"
		alias
			"REGCLS_MULTIPLEUSE"
		end
		
	is_valid_register_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of registration flags?
		do
			Result := flag = Regcls_singleuse or
						flag = Regcls_multipleuse
		end
		
end -- class EOLE_REGISTER_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1998-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

