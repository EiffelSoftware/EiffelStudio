note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW_ATTRIBUTES

feature

	toplevel_window: NATURAL
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return WS_OVERLAPPEDWINDOW;
				#endif
			]"
		end

	popup_window: NATURAL
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return WS_POPUPWINDOW;
				#endif
			]"
		end

end
