indexing
	description: 
		"Event mask constants used when adding event handlers..";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT_MASK_CONSTANTS

feature -- Event types

	NoEventMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"NoEventMask"
		end;

	KeyPressMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"KeyPressMask"
		end;

	KeyReleaseMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"KeyReleaseMask"
		end;

	ButtonPressMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ButtonPressMask"
		end;

	ButtonReleaseMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ButtonReleaseMask"
		end;

	EnterWindowMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"EnterWindowMask"
		end;

	LeaveWindowMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"LeaveWindowMask"
		end;

	PointerMotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"PointerMotionMask"
		end;

	PointerMotionHintMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"PointerMotionHintMask"
		end;

	Button1MotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"Button1MotionMask"
		end;

	Button2MotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"Button2MotionMask"
		end;

	Button3MotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"Button3MotionMask"
		end;

	Button4MotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"Button4MotionMask"
		end;

	Button5MotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"Button5MotionMask"
		end;

	ButtonMotionMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ButtonMotionMask"
		end;

	KeymapStateMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"KeymapStateMask"
		end;

	ExposureMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ExposureMask"
		end;

	VisibilityChangeMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"VisibilityChangeMask"
		end;

	StructureNotifyMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"StructureNotifyMask"
		end;

	ResizeRedirectMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ResizeRedirectMask"
		end;

	SubstructureNotifyMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"SubstructureNotifyMask"
		end;

	SubstructureRedirectMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"SubstructureRedirectMask"
		end;

	FocusChangeMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"FocusChangeMask"
		end;

	PropertyChangeMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"PropertyChangeMask"
		end;

	ColormapChangeMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"ColormapChangeMask"
		end;

	OwnerGrabButtonMask: POINTER is
		external
			"C [macro <X11/X.h>]: EIF_POINTER"
		alias
			"OwnerGrabButtonMask"
		end;

end -- class MEL_EVENT_MASK_CONSTANTS

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
