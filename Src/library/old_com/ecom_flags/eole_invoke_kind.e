indexing

	description: "INVOKEKIND constants"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_INVOKE_KIND

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

	is_valid_invoke_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid invoke kind?
		do
			Result := kind = Invoke_func or
			kind = Invoke_propertyget or
			kind = Invoke_propertyput or
			kind = Invoke_propertyputref
		end
		
end -- class EOLE_INVOKEKIND

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
