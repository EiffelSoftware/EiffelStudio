note
	description: 
		"Event mask constants used when adding event handlers.."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT_MASK_CONSTANTS

feature -- Event types

	NoEventMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NoEventMask"
		end;

	KeyPressMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyPressMask"
		end;

	KeyReleaseMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyReleaseMask"
		end;

	ButtonPressMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonPressMask"
		end;

	ButtonReleaseMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonReleaseMask"
		end;

	EnterWindowMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"EnterWindowMask"
		end;

	LeaveWindowMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LeaveWindowMask"
		end;

	PointerMotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PointerMotionMask"
		end;

	PointerMotionHintMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PointerMotionHintMask"
		end;

	Button1MotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1MotionMask"
		end;

	Button2MotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2MotionMask"
		end;

	Button3MotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3MotionMask"
		end;

	Button4MotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4MotionMask"
		end;

	Button5MotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5MotionMask"
		end;

	ButtonMotionMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonMotionMask"
		end;

	KeymapStateMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeymapStateMask"
		end;

	ExposureMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ExposureMask"
		end;

	VisibilityChangeMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityChangeMask"
		end;

	StructureNotifyMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"StructureNotifyMask"
		end;

	ResizeRedirectMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ResizeRedirectMask"
		end;

	SubstructureNotifyMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SubstructureNotifyMask"
		end;

	SubstructureRedirectMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SubstructureRedirectMask"
		end;

	FocusChangeMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusChangeMask"
		end;

	PropertyChangeMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyChangeMask"
		end;

	ColormapChangeMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapChangeMask"
		end;

	OwnerGrabButtonMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"OwnerGrabButtonMask"
		end;

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




end -- class MEL_EVENT_MASK_CONSTANTS


