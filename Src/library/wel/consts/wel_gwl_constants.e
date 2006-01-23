indexing
	description: "GetWindowLong (GWL), GetWindowLongPtr (GWLP) constants."
	legal: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_GWL_CONSTANTS

