indexing

	description: "IMPLTYPEFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_IMPL_TYPE_FLAGS
	
inherit
	EOLE_FLAGS

feature -- Access

	impltypeflag_fdefault: INTEGER is
			-- Interface or dispinterface represents default for
			-- source or sink
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FDEFAULT"
		end
		
	impltypeflag_fsource: INTEGER is
			-- Member of coclass called rather than implemented
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FSOURCE"
		end
		
	impltypeflag_frestricted: INTEGER is
			-- Member should not be displayed or programmable by users
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FRESTRICTED"
		end

	is_valid_impltypeflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of impltypeflags?
		do
			Result := c_and (impltypeflag_fdefault + impltypeflag_fsource
						+ impltypeflag_frestricted, flag)
						= impltypeflag_fdefault + impltypeflag_fsource
						+ impltypeflag_frestricted
		end
		
end -- class EOLE_IMPLTYPEFLAGS

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
