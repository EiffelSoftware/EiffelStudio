indexing
	description: 
		"Used for comparing the `type' field in MEL_EVENT and %
		%other constants that may be reference in MEL_EVENT fields.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT_CONSTANTS

feature -- Event types

	KeyPress: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyPress"
		end;

	KeyRelease: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyRelease"
		end;

	ButtonPress: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonPress"
		end;

	ButtonRelease: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonRelease"
		end;

	MotionNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MotionNotify"
		end;

	EnterNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"EnterNotify"
		end;

	LeaveNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LeaveNotify"
		end;

	FocusIn: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusIn"
		end;

	FocusOut: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusOut"
		end;

	KeymapNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeymapNotify"
		end;

	Expose: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Expose"
		end;

	GraphicsExpose: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GraphicsExpose"
		end;

	NoExpose: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NoExpose"
		end;

	VisibilityNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityNotify"
		end;

	CreateNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CreateNotify"
		end;

	DestroyNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"DestroyNotify"
		end;

	UnmapNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"UnmapNotify"
		end;

	MapNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MapNotify"
		end;

	MapRequest: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MapRequest"
		end;

	ReparentNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ReparentNotify"
		end;

	ConfigureNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ConfigureNotify"
		end;

	ConfigureRequest: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ConfigureRequest"
		end;

	GravityNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GravityNotify"
		end;

	ResizeRequest: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ResizeRequest"
		end;

	CirculateNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CirculateNotify"
		end;

	CirculateRequest: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CirculateRequest"
		end;

	PropertyNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyNotify"
		end;

	SelectionClear: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionClear"
		end;

	SelectionRequest: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionRequest"
		end;

	SelectionNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionNotify"
		end;

	ColormapNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapNotify"
		end;

	ClientMessage: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ClientMessage"
		end;

	MappingNotify: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MappingNotify"
		end;

	None: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"None"
		end;

feature -- Other constants

	LASTEvent: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LASTEvent"
		end;

	PlaceOnTop: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PlaceOnTop"
		end;

	PlaceOnBottom: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PlaceOnBottom"
		end;

	Above: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Above"
		end;

	Below: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Below"
		end;

	TopIf: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"TopIf"
		end;

	BottomIf: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"BottomIf"
		end;

	Opposite: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Opposite"
		end;

	NotifyNormal: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNormal"
		end;

	NotifyGrab: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyGrab"
		end;

	NotifyUngrab: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyUngrab"
		end;

	NotifyWhileGrabbed: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyWhileGrabbed"
		end;

	NotifyHint: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyHint"
		end;

	NotifyAncestor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyAncestor"
		end;

	NotifyVirtual: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyVirtual"
		end;

	NotifyInferior: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyInferior"
		end;

	NotifyNonlinear: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNonlinear"
		end;

	NotifyNonlinearVirtual: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNonlinearVirtual"
		end;

	NotifyPointer: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyPointer"
		end;

	NotifyPointerRoot: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyPointerRoot"
		end;

	NotifyDetailNone: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyDetailNone"
		end;

	PropertyNewValue: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyNewValue"
		end;

	PropertyDelete: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyDelete"
		end;

	VisibilityUnobscured: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityUnobscured"
		end;

	VisibilityPartiallyObscured: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityPartiallyObscured"
		end;

	VisibilityFullyObscured: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityFullyObscured"
		end;

	Button1: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1"
		end;

	Button2: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2"
		end;

	Button3: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3"
		end;

	Button4: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4"
		end;

	Button5: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5"
		end;

	ShiftMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ShiftMask"
		end;

	LockMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LockMask"
		end;

	ControlMask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ControlMask"
		end;

	Mod1Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod1Mask"
		end;

	Mod2Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod2Mask"
		end;

	Mod3Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod3Mask"
		end;

	Mod4Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod4Mask"
		end;

	Mod5Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod5Mask"
		end;

	Button1Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1Mask"
		end;

	Button2Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2Mask"
		end;

	Button3Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3Mask"
		end;

	Button4Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4Mask"
		end;

	Button5Mask: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5Mask"
		end;

	ColormapInstalled: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapInstalled"
		end;

	ColormapUninstalled: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapUninstalled"
		end;

feature -- Convenience routine to compare masks

	and_masks (mask1, mask2: INTEGER): BOOLEAN is
			-- Call C routine that will return the result of the
			-- `mask1' & `mask2' operation
		external
			"C"
		end

end -- class MEL_EVENT_CONSTANTS


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

