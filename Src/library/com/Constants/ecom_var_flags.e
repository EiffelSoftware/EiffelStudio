indexing
	description: "VARFLAGS flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_VAR_FLAGS

inherit
	ECOM_FLAGS
	
feature -- Access

	Varflag_freadonly: INTEGER is
			-- Assignment to variable should not be allowed
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FREADONLY"
		end

	Varflag_fsource: INTEGER is
			-- Variable returns object that is source of events
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
			-- Variable is displayed to user as bindable;
			-- that is, VARFLAG_FBINDABLE must also be set.
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
			-- Permits optimization.
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FDEFAULTCOLLELEM"
		end

	Varflag_fuidefault: INTEGER is
			-- Variable  is default 
			-- display in user interface. 
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FUIDEFAULT"
		end

	Varflag_fnonbrowsable: INTEGER is
			-- Variable appears in object browser, 
			-- but not in properties browser
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FNONBROWSABLE"
		end

	Varflag_freplaceable: INTEGER is
			-- Tags interface as having default behaviors. 
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FREPLACEABLE"
		end

	Varflag_fimmediatebind: INTEGER is
			-- Variable is mapped as individual bindable properties.
		external
			"C [macro <oaidl.h>]"
		alias
			"VARFLAG_FIMMEDIATEBIND"
		end

feature -- Status report

	is_varflag_frestricted (flag: INTEGER): BOOLEAN is
			-- Is flag FRESTRICTED?
		do
			Result := binary_and (flag, Varflag_frestricted) = Varflag_frestricted
		end

	is_varflag_fsource (flag: INTEGER): BOOLEAN is
			-- Is flag fsource?
		do
			Result := binary_and (flag, Varflag_fsource) = Varflag_fsource
		end

	is_varflag_fbindable (flag: INTEGER): BOOLEAN is
			-- Is flag fbindable?
		do
			Result := binary_and (flag, Varflag_fbindable) = Varflag_fbindable
		end

	is_varflag_frequestedit (flag: INTEGER): BOOLEAN is
			-- Is flag frequestedit?
		do
			Result := binary_and (flag, Varflag_frequestedit) = Varflag_frequestedit
		end

	is_varflag_fdisplaybind (flag: INTEGER): BOOLEAN is
			-- Is flag fdisplaybind?
		do
			Result := binary_and (flag, Varflag_fdisplaybind) = Varflag_fdisplaybind
		end

	is_varflag_fdefaultbind (flag: INTEGER): BOOLEAN is
			-- Is flag fdefaultbind?
		do
			Result := binary_and (flag, Varflag_fdefaultbind) = Varflag_fdefaultbind
		end

	is_varflag_fhidden (flag: INTEGER): BOOLEAN is
			-- Is flag fhidden?
		do
			Result := binary_and (flag, Varflag_fhidden) = Varflag_fhidden
		end

	is_varflag_fdefaultcollelem (flag: INTEGER): BOOLEAN is
			-- Is flag fdefaultcollelem?
		do
			Result := binary_and (flag, Varflag_fdefaultcollelem) = Varflag_fdefaultcollelem
		end

	is_varflag_fuidefault (flag: INTEGER): BOOLEAN is
			-- Is flag fuidefault?
		do
			Result := binary_and (flag, Varflag_fuidefault) = Varflag_fuidefault
		end

	is_varflag_fnonbrowsable (flag: INTEGER): BOOLEAN is
			-- Is flag fnonbrowsable?
		do
			Result := binary_and (flag, Varflag_fnonbrowsable) = Varflag_fnonbrowsable
		end

	is_varflag_freplaceable (flag: INTEGER): BOOLEAN is
			-- Is flag freplaceable?
		do
			Result := binary_and (flag, Varflag_freplaceable) = Varflag_freplaceable
		end

	is_varflag_fimmediatebind (flag: INTEGER): BOOLEAN is
			-- Is flag fimmediatebind?
		do
			Result := binary_and (flag, Varflag_fimmediatebind) = Varflag_fimmediatebind
		end

	is_valid_varflag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid combination of varflags?
		do
			Result := is_varflag_frestricted (flag) or
					is_varflag_fsource (flag) or
					is_varflag_fbindable (flag) or
					is_varflag_frequestedit (flag) or
					is_varflag_fdisplaybind (flag) or
					is_varflag_fdefaultbind (flag) or
					is_varflag_fhidden (flag) or
					is_varflag_frestricted (flag) or
					is_varflag_fdefaultcollelem (flag) or
					is_varflag_fuidefault (flag) or
					is_varflag_fnonbrowsable (flag) or
					is_varflag_freplaceable (flag) or
					is_varflag_fimmediatebind (flag)
		end
		
end -- class ECOM_FUNC_FLAGS

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

