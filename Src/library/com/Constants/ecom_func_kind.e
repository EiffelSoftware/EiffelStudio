indexing
	description: "FUNCKIND constants"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_FUNC_KIND

feature -- Access

	Func_purevirtual: INTEGER is
			-- Function is accessed via virtual function table
			-- and takes implicit 'this' pointer		
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_PUREVIRTUAL"
		end
		
	Func_virtual: INTEGER is
			-- Function is accessed same as PUREVIRTUAL,
			-- except function has implementation
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_VIRTUAL"
		end
		
	Func_nonvirtual: INTEGER is
			-- Function is accessed by static address and takes
			-- implicit 'this' pointer		
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_NONVIRTUAL"
		end
		
	Func_static: INTEGER is
			-- Function is accessed by static address
			-- and does not take implicit 'this' pointer
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_STATIC"
		end
		
	Func_dispatch: INTEGER is
			-- Function can be accessed only via IDispatch
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNC_DISPATCH"
		end

feature -- Status setting
		
	is_valid_func_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid function kind?
		do
			Result := kind = Func_purevirtual or
			kind = Func_virtual or
			kind = Func_nonvirtual or
			kind = Func_static or
			kind = Func_dispatch
		end
		
end -- class ECOM_FUNC_KIND

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

