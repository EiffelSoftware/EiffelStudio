indexing

	description: "SYSKIND values"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_SYS_KIND 

feature -- Access

	Sys_win16: INTEGER is
			-- Target operating system for the type 
			-- library is 16-bit Windows systems.
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_WIN16"
		end

	Sys_win32: INTEGER is
			-- Target operating system for the type 
			-- library is 32-bit Windows systems. 
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_WIN32"
		end

	Sys_mac: INTEGER is
			-- Target operating system for the type 
			-- library is Apple Macintosh.
		external
			"C [macro <oaidl.h>]"
		alias
			"SYS_MAC"
		end

	is_valid_sys_kind (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid SYSKIND value?
		do
			Result := flag = Sys_win16 or
						flag = Sys_win32 or
						flag = Sys_mac
		end
		
end -- class ECOM_SYS_KIND

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

