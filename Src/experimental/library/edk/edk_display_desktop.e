note
	description: "Summary description for {EDK_DESKTOP_DISPLAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_DISPLAY_DESKTOP

inherit
	EDK_DISPLAY


create
	{EDK_APPLICATION} default_create

feature

	frozen native_handle: POINTER
			-- Root Window for display, used for creating new windows.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return HWND_DESKTOP;
				#endif
			]"
		end
end
