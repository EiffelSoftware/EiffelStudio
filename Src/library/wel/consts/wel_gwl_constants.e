indexing
	description: "GetWindowLong (GWL), GetWindowLongPtr (GWLP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GWL_CONSTANTS

feature -- Access

	Gwl_exstyle: INTEGER is -20

	Gwl_style: INTEGER is -16

feature -- For windows

	Gwl_wndproc, Gwlp_wndproc: INTEGER is -4

	Gwl_hinstance, Gwlp_hinstance: INTEGER is -6

	Gwl_hwndparent, Gwlp_hwndparent: INTEGER is -8

	Gwl_id, Gwlp_id: INTEGER is -12

	Gwl_userdata, Gwlp_userdata: INTEGER is -21

feature -- For dialogs

	frozen dwlp_msgresult: INTEGER is
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_MSGRESULT"
		end

	frozen dwlp_dlgproc: INTEGER is
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_DLGPROC"
		end
		
	frozen Dwlp_user: INTEGER is
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_USER"
		end

feature -- Obsolete

	frozen dwl_msgresult: INTEGER is
		obsolete
			"Use `dwlp_msgresult' instead"
		do
			Result := 0
		end
		
	frozen dwl_dlgproc: INTEGER is
		obsolete
			"Use `dwlp_dlgproc' instead"
		do
			Result := 4
		end

	frozen dwl_user: INTEGER is
		obsolete
			"Use `dwlp_user' instead"
		do
			Result := 8
		end

end -- class WEL_GWL_CONSTANTS

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

