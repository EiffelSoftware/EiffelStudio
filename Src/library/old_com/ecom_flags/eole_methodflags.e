indexing

	description: "Method flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_METHOD_FLAGS

feature -- Access

	Dispatch_method: INTEGER is
			-- Automation client wants to access 
			-- a method of Automation server
		external
			"C [macro <oleauto.h>]"
		alias
			"DISPATCH_METHOD"
		end

	Dispatch_propertyget: INTEGER is
			-- Automation client wants to access 
			-- a property of Automation server
		external
			"C [macro <oleauto.h>]"
		alias
			"DISPATCH_PROPERTYGET"
		end

	Dispatch_propertyput: INTEGER is
			-- Automation client wants to set 
			-- a property of Automation server
		external
			"C [macro <oleauto.h>]"
		alias
			"DISPATCH_PROPERTYPUT"
		end

	Dispatch_propertyputref: INTEGER is
			-- Automation client wants to set a property
			-- of Automation server by reference
		external
			"C [macro <oleauto.h>]"
		alias
			"DISPATCH_PROPERTYPUTREF"
		end
		
	is_valid_method_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid method flag?
		do
			Result := flag = Dispatch_method or
						flag = Dispatch_propertyget or
						flag = Dispatch_propertyput or
						flag = Dispatch_propertyputref
		end
		
end -- class EOLE_METHOD_FLAGS

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
