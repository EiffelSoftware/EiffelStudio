indexing

	description: "VARFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_VAR_FLAGS

inherit
	EOLE_FLAGS

feature -- Access

	Varflag_freadonly: INTEGER is
			-- Assignment to variable should not be allowed
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FREADONLY"
		end
		
	Varflag_fsource: INTEGER is
			-- Variable returns an object that is source of eventsd
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FSOURCE"
		end
		
	Varflag_fbindable: INTEGER is
			-- Variable supports data binding
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FBINDABLE"
		end
		
	Varflag_frequestedit: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FREQUESTEDIT"
		end
		
	Varflag_fdisplaybind: INTEGER is
			-- Variable is displayed to user as bindable
			-- VARFLAG_FBINDABLE must also be set
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FDISPLAYBIND"
		end
		
	Varflag_fdefaultbind: INTEGER is
			-- Variable is single property that best represents
			-- object. Only one variable in typeinfo may have this attibute.
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FDEFAULTBIND"
		end
		
	Varflag_fhidden: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FHIDDEN"
		end

	Varflag_frestricted: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FRESTRICTED"
		end

	Varflag_fdefaultcollelem: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FDEFAULTCOLLELEM"
		end

	Varflag_fuidefault: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FUIDEFAULT"
		end

	Varflag_fnonbrowsable: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FNONBROWSABLE"
		end

	Varflag_freplaceable: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FREPLACEABLE"
		end

	Varflag_fimmediatebind: INTEGER is
			-- Variable should not be displayed to user in browser,
			-- though it exists and is bindable.
		external
			"C [macro <oaidl.h>]"
		alias	
			"VARFLAG_FIMMEDIATEBIND"
		end

	is_valid_varflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of varflags?
		do
			Result := c_and (Varflag_freadonly + Varflag_fsource
						+ Varflag_fbindable + Varflag_frequestedit
						+ Varflag_fdisplaybind + Varflag_fdefaultbind
						+ Varflag_fhidden + Varflag_frestricted
						+ Varflag_fdefaultcollelem + Varflag_fuidefault
						+ Varflag_fnonbrowsable + Varflag_freplaceable
						+ Varflag_fimmediatebind, flag)
						= flag
		end
		
end -- class EOLE_VARFLAGS

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

