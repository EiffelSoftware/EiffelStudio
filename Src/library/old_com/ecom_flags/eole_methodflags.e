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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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


