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

	Impltypeflag_fdefault: INTEGER is
			-- Interface or dispinterface represents default for
			-- source or sink
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FDEFAULT"
		end
		
	Impltypeflag_fsource: INTEGER is
			-- Member of coclass called rather than implemented
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FSOURCE"
		end
		
	Impltypeflag_frestricted: INTEGER is
			-- Member should not be displayed or programmable by users
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FRESTRICTED"
		end

	Impltypeflag_fdefaultvtable: INTEGER is
			-- Sink receive events through the VTABLE.
		external
			"C [macro <oaidl.h>]"
		alias
			"IMPLTYPEFLAG_FDEFAULTVTABLE"
		end
		
	is_valid_impltypeflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of impltypeflags?
		do
			Result := c_and (Impltypeflag_fdefault + Impltypeflag_fsource
						+ Impltypeflag_frestricted + Impltypeflag_fdefaultvtable, flag)
						= flag
		end
		
end -- class EOLE_IMPLTYPEFLAGS

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

