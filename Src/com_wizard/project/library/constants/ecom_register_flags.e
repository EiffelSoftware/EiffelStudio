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

