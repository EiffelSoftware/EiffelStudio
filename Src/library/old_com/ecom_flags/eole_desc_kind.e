indexing

	description: "DESCKIND values"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_DESC_KIND

feature -- Access

	Desckind_none: INTEGER is
			-- No match was found.
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_NONE"
		end

	Desckind_funcdesc: INTEGER is
			-- A FUNCDESC was returned. 
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_FUNCDESC"
		end

	Desckind_vardesc: INTEGER is
			-- A VARDESC was returned.
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_VARDESC"
		end

	Desckind_typecomp: INTEGER is
			-- A TYPECOMP was returned.
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_TYPECOMP"
		end

	Desckind_implicitappobj: INTEGER is
			-- An IMPLICITAPPOBJ was returned.
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_IMPLICITAPPOBJ"
		end
		
	is_valid_desc_kind (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid SYSKIND value?
		do
			Result := flag = Desckind_none or
						flag = Desckind_funcdesc or
						flag = Desckind_vardesc or
						flag = Desckind_typecomp or
						flag = Desckind_implicitappobj
		end
		
end -- class EOLE_DESC_KIND

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
