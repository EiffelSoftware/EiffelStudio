indexing
	description: "COM DESCKIND constants"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DESC_KIND

feature -- Access

	Desckind_none: INTEGER is
			-- No match was found
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_NONE"
		end

	Desckind_funcdesc: INTEGER is
			-- FUNCDESC was returned
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_FUNCDESC"
		end

	Desckind_vardesc: INTEGER is
			-- VARDESC was returned
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_VARDESC"
		end

	Desckind_typecomp: INTEGER is
			-- ITypeComp was returned
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_TYPECOMP"
		end

	Desckind_implicitappobj: INTEGER is
			-- IMPLICITAPPOBJ was returned
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_IMPLICITAPPOBJ"
		end

	Desckind_max: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"DESCKIND_MAX"
		end

feature -- Status report

	is_valid_desc_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' valid?
		do 
			Result := kind = Desckind_none or
					kind = Desckind_funcdesc or
					kind = Desckind_vardesc or
					kind = Desckind_typecomp or
					kind = Desckind_implicitappobj or
					kind = Desckind_max
		end

end -- class ECOM_DESC_KIND

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

