indexing
	description	: "Constants used in function SetClassLong"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_GCL_CONSTANTS

create
	default_create

feature -- GCL Constants

	Gcl_cbclsextra: INTEGER is -20
			-- Sets the size, in bytes, of the extra memory associated with 
			-- the class. Setting this value does not change the number of 
			-- extra bytes already allocated.
			--
			-- Declared in Windows as GCL_CBCLSEXTRA

	Gcl_cbwndextra: INTEGER is -18
			-- Sets the size, in bytes, of the extra window memory associated 
			-- with each window in the class. Setting this value does not 
			-- change the number of extra bytes already allocated. For 
			-- information on how to access this memory, see SetWindowLong.
			--
			-- Declared in Windows as GCL_CBWNDEXTRA

	Gcl_hbrbackground, gclp_hbrbackground: INTEGER is -10
			-- Replaces a handle to the background brush associated with the 
			-- class. 
			--
			-- Declared in Windows as GCL_HBRBACKGROUND

	Gcl_hcursor, gclp_hcursor: INTEGER is -12
			-- Replaces a handle to the cursor associated with the class. 
			--
			-- Declared in Windows as GCL_HCURSOR

	Gcl_hicon, gclp_hicon: INTEGER is -14
			-- Replaces a handle to the icon associated with the class. 
			--
			-- Declared in Windows as GCL_HICON

	Gcl_hiconsm, gclp_hiconsm: INTEGER is -34
			-- Replace a handle to the small icon associated with the class. 
			--
			-- Declared in Windows as GCL_HICONSM

	Gcl_hmodule, gclp_hmodule: INTEGER is -16
			-- Replaces a handle to the module that registered the class. 
			--
			-- Declared in Windows as GCL_HMODULE

	Gcl_menuname, gclp_menuname: INTEGER is -8
			-- Replaces the address of the menu name string. The string 
			-- identifies the menu resource associated with the class. 
			--
			-- Declared in Windows as GCL_MENUNAME

	Gcl_style: INTEGER is -26
			-- Replaces the window-class style bits. 
			--
			-- Declared in Windows as GCL_STYLE

	Gcl_wndproc, gclp_wndproc: INTEGER is -24
			-- Replaces the address of the window procedure associated with 
			-- the class. 
			--
			-- Declared in Windows as GCL_WNDPROC

end -- class WEL_GCL_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

