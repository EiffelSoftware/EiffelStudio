indexing

	description: "Method flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_METHOD_FLAGS

inherit
	EOLE_FLAGS

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
			Result := is_dispatch_method (flag) or
						is_dispatch_propertyget (flag) or
						is_dispatch_propertyput (flag) or
						is_dispatch_propertyputref (flag)
		end
	
	is_dispatch_method (flag: INTEGER): BOOLEAN is
			-- Is dispatch method bit is set?
		do
			Result := c_and (Dispatch_method, flag) = Dispatch_method
		end
	
	is_dispatch_propertyget (flag: INTEGER): BOOLEAN is
			-- Is dispatch propertyget bit is set?
		do
			Result := c_and (Dispatch_propertyget, flag) = Dispatch_propertyget
		end

	is_dispatch_propertyput (flag: INTEGER): BOOLEAN is
			-- Is dispatch propertyput bit is set?
		do
			Result := c_and (Dispatch_propertyput, flag) = Dispatch_propertyput
		end

	is_dispatch_propertyputref (flag: INTEGER): BOOLEAN is
			-- Is dispatch propertyputref bit is set?
		do
			Result := c_and (Dispatch_propertyputref, flag) = Dispatch_propertyputref
		end

end -- class EOLE_METHOD_FLAGS

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

