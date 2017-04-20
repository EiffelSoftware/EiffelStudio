note
	description: "GetWindowLong (GWL), GetWindowLongPtr (GWLP) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GWL_CONSTANTS

feature -- Access

	Gwl_exstyle: INTEGER = -20

	Gwl_style: INTEGER = -16

feature -- For windows

	Gwl_wndproc, Gwlp_wndproc: INTEGER = -4

	Gwl_hinstance, Gwlp_hinstance: INTEGER = -6

	Gwl_hwndparent, Gwlp_hwndparent: INTEGER = -8

	Gwl_id, Gwlp_id: INTEGER = -12

	Gwl_userdata, Gwlp_userdata: INTEGER = -21

feature -- For dialogs

	frozen dwlp_msgresult: INTEGER
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_MSGRESULT"
		end

	frozen dwlp_dlgproc: INTEGER
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_DLGPROC"
		end

	frozen Dwlp_user: INTEGER
		external
			"C inline use %"wel.h%""
		alias
			"DWLP_USER"
		end

feature -- Obsolete

	frozen dwl_msgresult: INTEGER
		obsolete
			"Use `dwlp_msgresult' instead [2017-05-31]."
		do
			Result := 0
		end

	frozen dwl_dlgproc: INTEGER
		obsolete
			"Use `dwlp_dlgproc' instead [2017-05-31]."
		do
			Result := 4
		end

	frozen dwl_user: INTEGER
		obsolete
			"Use `dwlp_user' instead [2017-05-31]."
		do
			Result := 8
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_GWL_CONSTANTS

