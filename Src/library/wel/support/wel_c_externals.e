indexing
	description: "Collections of windows externals."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_C_EXTERNALS
	
feature -- Focus related features

	frozen set_active_window (hwnd: POINTER): POINTER is
			-- Activates window `hwnd'. Returns handle of previously
			-- active window. If NULL, call `get_last_error' to get
			-- extended error information.
		external
			"C inline use <windows.h>"
		alias
			"SetActiveWindow ($hwnd)"
		end

end
