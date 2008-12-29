note
	description	: "Constants used in function SetClassLong"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_GCL_CONSTANTS

create
	default_create

feature -- GCL Constants

	Gcl_cbclsextra: INTEGER = -20
			-- Sets the size, in bytes, of the extra memory associated with 
			-- the class. Setting this value does not change the number of 
			-- extra bytes already allocated.
			--
			-- Declared in Windows as GCL_CBCLSEXTRA

	Gcl_cbwndextra: INTEGER = -18
			-- Sets the size, in bytes, of the extra window memory associated 
			-- with each window in the class. Setting this value does not 
			-- change the number of extra bytes already allocated. For 
			-- information on how to access this memory, see SetWindowLong.
			--
			-- Declared in Windows as GCL_CBWNDEXTRA

	Gcl_hbrbackground, gclp_hbrbackground: INTEGER = -10
			-- Replaces a handle to the background brush associated with the 
			-- class. 
			--
			-- Declared in Windows as GCL_HBRBACKGROUND

	Gcl_hcursor, gclp_hcursor: INTEGER = -12
			-- Replaces a handle to the cursor associated with the class. 
			--
			-- Declared in Windows as GCL_HCURSOR

	Gcl_hicon, gclp_hicon: INTEGER = -14
			-- Replaces a handle to the icon associated with the class. 
			--
			-- Declared in Windows as GCL_HICON

	Gcl_hiconsm, gclp_hiconsm: INTEGER = -34
			-- Replace a handle to the small icon associated with the class. 
			--
			-- Declared in Windows as GCL_HICONSM

	Gcl_hmodule, gclp_hmodule: INTEGER = -16
			-- Replaces a handle to the module that registered the class. 
			--
			-- Declared in Windows as GCL_HMODULE

	Gcl_menuname, gclp_menuname: INTEGER = -8
			-- Replaces the address of the menu name string. The string 
			-- identifies the menu resource associated with the class. 
			--
			-- Declared in Windows as GCL_MENUNAME

	Gcl_style: INTEGER = -26
			-- Replaces the window-class style bits. 
			--
			-- Declared in Windows as GCL_STYLE

	Gcl_wndproc, gclp_wndproc: INTEGER = -24;
			-- Replaces the address of the window procedure associated with 
			-- the class. 
			--
			-- Declared in Windows as GCL_WNDPROC

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_GCL_CONSTANTS

