indexing
	description: 
		"Event mask constants used when adding event handlers..";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT_MASK_CONSTANTS

feature -- Event types

	NoEventMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NoEventMask"
		end;

	KeyPressMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyPressMask"
		end;

	KeyReleaseMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyReleaseMask"
		end;

	ButtonPressMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonPressMask"
		end;

	ButtonReleaseMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonReleaseMask"
		end;

	EnterWindowMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"EnterWindowMask"
		end;

	LeaveWindowMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LeaveWindowMask"
		end;

	PointerMotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PointerMotionMask"
		end;

	PointerMotionHintMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PointerMotionHintMask"
		end;

	Button1MotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1MotionMask"
		end;

	Button2MotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2MotionMask"
		end;

	Button3MotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3MotionMask"
		end;

	Button4MotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4MotionMask"
		end;

	Button5MotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5MotionMask"
		end;

	ButtonMotionMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonMotionMask"
		end;

	KeymapStateMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeymapStateMask"
		end;

	ExposureMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ExposureMask"
		end;

	VisibilityChangeMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityChangeMask"
		end;

	StructureNotifyMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"StructureNotifyMask"
		end;

	ResizeRedirectMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ResizeRedirectMask"
		end;

	SubstructureNotifyMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SubstructureNotifyMask"
		end;

	SubstructureRedirectMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SubstructureRedirectMask"
		end;

	FocusChangeMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusChangeMask"
		end;

	PropertyChangeMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyChangeMask"
		end;

	ColormapChangeMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapChangeMask"
		end;

	OwnerGrabButtonMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"OwnerGrabButtonMask"
		end;

end -- class MEL_EVENT_MASK_CONSTANTS


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

