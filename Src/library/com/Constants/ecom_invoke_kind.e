indexing
	description: "INVOKEKIND constants"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_INVOKE_KIND

inherit
	ECOM_FLAGS

feature -- Access

	Invoke_func: INTEGER is
			-- Member is called using normal function invocation syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_FUNC"
		end
		
	Invoke_propertyget: INTEGER is
			-- Function is invoked using normal property-access syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYGET"
		end
		
	Invoke_propertyput: INTEGER is
			-- Function is invoked using a property value assignment syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYPUT"
		end	
		
	Invoke_propertyputref: INTEGER is
			-- Function is invoked using property reference assignment syntax
		external
			"C [macro <oaidl.h>]"
		alias
			"INVOKE_PROPERTYPUTREF"
		end

feature -- Status report

	is_func (flag: INTEGER): BOOLEAN is
			-- Is normal function invocation syntax?
		do
			Result := binary_and (flag, Invoke_func) = Invoke_func
		end

	is_propertyget (flag: INTEGER): BOOLEAN is
			-- Is normal property-access syntax?
		do
			Result := binary_and (flag, Invoke_propertyget) = Invoke_propertyget
		end

	is_propertyput (flag: INTEGER): BOOLEAN is
			-- Is property value assignment syntax?
		do
			Result := binary_and (flag, Invoke_propertyput) = Invoke_propertyput
		end

	is_propertyputef (flag: INTEGER): BOOLEAN is
			-- Is property reference assignment syntax?
		do
			Result := binary_and (flag, Invoke_propertyputref) = Invoke_propertyputref
		end

	is_valid_invoke_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid invoke kind?
		do
			Result := is_func (kind) or
			is_propertyget (kind) or
			is_propertyput (kind) or
			is_propertyputef (kind)
		end
		
end -- class EOLE_INVOKEKIND

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

