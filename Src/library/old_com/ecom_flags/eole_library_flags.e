indexing

	description: "Type Library flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_LIBRARY_FLAGS

inherit
	EOLE_FLAGS

feature -- Access

	Libflag_frestricted: INTEGER is
			-- Type library is restricted, and should not 
			-- be displayed to users.
		external
			"C [macro <oaidl.h>]"
		alias
			"LIBFLAG_FRESTRICTED"
		end

	Libflag_fcontrol: INTEGER is
			-- Type library describes controls, and should
			-- not be displayed in type browsers intended 
			-- for nonvisual objects. 
		external
			"C [macro <oaidl.h>]"
		alias
			"LIBFLAG_FCONTROL"
		end

	Libflag_fhidden: INTEGER is
			-- Type library should not be displayed to users,
			-- although its use is not restricted.
		external
			"C [macro <oaidl.h>]"
		alias
			"LIBFLAG_FHIDDEN"
		end

	Libflag_fhasdiskimage: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"LIBFLAG_FHASDISKIMAGE"
		end
		
	is_valid_library_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid library flag?
		do
			Result := c_and (Libflag_frestricted + Libflag_fcontrol
						+ Libflag_fhidden + Libflag_fhasdiskimage
						, flag)
						= Libflag_frestricted + Libflag_fcontrol
						+ Libflag_fhidden + Libflag_fhasdiskimage
		end
		
end -- class EOLE_LIBRARY_FLAGS

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

