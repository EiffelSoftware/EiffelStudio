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

