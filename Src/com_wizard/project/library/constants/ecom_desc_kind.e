indexing
	description: "COM DESCKIND constants"
	status: "See notice at end of class"
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

