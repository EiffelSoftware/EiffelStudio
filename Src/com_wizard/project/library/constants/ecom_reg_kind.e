indexing
	description: "REGKIND constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_REG_KIND

feature -- Access

	Regkind_default: INTEGER is
			-- Default register behavior
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_DEFAULT"
		end

	Rgkind_register: INTEGER is
			-- Registered type
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_REGISTER"
		end

 	Rgkind_none: INTEGER is
			-- Not registered type
		external
			"C [macro <oleauto.h>]"
		alias
			"REGKIND_NONE"
		end

end -- class ECOM_REG_KIND

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

