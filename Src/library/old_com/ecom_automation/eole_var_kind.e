indexing

	description: "VARKIND contants"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_VARKIND

feature 

	Var_perinstance: INTEGER is
			-- Variable is field or member of type
			-- it exists at fixed offset within each instance of type.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_PERINSTANCE"
		end

	Var_static: INTEGER is
			-- Only one instance of variable
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_STATIC"
		end

	Var_const: INTEGER is
			-- VARDESC describes symbolic constant
			-- There is no memory associated with it.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_CONST"
		end

	Var_dispatch: INTEGER is
			-- Variable can only be accessed via feature
			-- `invoke' of class EOLE_DISPATCH.
		external
			"C [macro <oaidl.h>]"
		alias
			"VAR_DISPATCH"
		end

	is_valid_var_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid variable kind?
		do
			Result := kind = Var_perinstance or
			kind = Var_static or
			kind = Var_const or
			kind = Var_dispatch
		end
		
end -- class EOLE_VARKIND

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
