indexing

	description: "Type Library flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_LIB_FLAGS

inherit
	ECOM_FLAGS

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
		
	is_valid_lib_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid library flag?
		do
			Result := binary_and (Libflag_frestricted + Libflag_fcontrol
						+ Libflag_fhidden + Libflag_fhasdiskimage
						, flag)
						= flag
		end
		
end -- class ECOM_LIB_FLAGS

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

