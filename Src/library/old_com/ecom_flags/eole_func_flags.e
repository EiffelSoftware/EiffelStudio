indexing

	description: "FUNCFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FUNC_FLAGS

inherit
	EOLE_FLAGS
	
feature -- Access

	Funcflag_frestricted: INTEGER is
			-- Function should not be accessible fro"
			-- This flag is intended for system-level functions or functions
			-- that you do not want type browsers to display.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FRESTRICTED"
		end

	Funcflag_fsource: INTEGER is
			-- Function returns object that is source of events
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FSOURCE"
		end

	Funcflag_fbindable: INTEGER is
			-- Function that supports data binding
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FBINDABLE"
		end

	Funcflag_frequestedit: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FREQUESTEDIT"
		end

	Funcflag_fdisplaybind: INTEGER is
			-- Function that is displayed to user as bindable;
			-- that is, FUNC_FBINDABLE must also be set.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FDISPLAYBIND"
		end

	Funcflag_fdefaultbind: INTEGER is
			-- Function that best represents object
			-- Only one function in dispinterface may have this attribute.
		external
			"C [macro <oaidl.h>]"
		alias
			"FUNCFLAG_FDEFAULTBIND"
		end
	
	is_valid_funcflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of funcflags?
		do
			Result := c_and (Funcflag_frestricted + Funcflag_fsource
						+ Funcflag_fbindable + Funcflag_frequestedit
						+ Funcflag_fdisplaybind + Funcflag_fdefaultbind, flag)
						= Funcflag_frestricted + Funcflag_fsource
						+ Funcflag_fbindable + Funcflag_frequestedit
						+ Funcflag_fdisplaybind + Funcflag_fdefaultbind
		end
		
end -- class EOLE_FUNCFLAGS

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
