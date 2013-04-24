note
	description: 
		"Used for comparing the `type' field in MEL_EVENT and %
		%other constants that may be reference in MEL_EVENT fields."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT_CONSTANTS

feature -- Event types

	KeyPress: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyPress"
		end;

	KeyRelease: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeyRelease"
		end;

	ButtonPress: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonPress"
		end;

	ButtonRelease: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ButtonRelease"
		end;

	MotionNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MotionNotify"
		end;

	EnterNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"EnterNotify"
		end;

	LeaveNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LeaveNotify"
		end;

	FocusIn: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusIn"
		end;

	FocusOut: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FocusOut"
		end;

	KeymapNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"KeymapNotify"
		end;

	Expose: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Expose"
		end;

	GraphicsExpose: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GraphicsExpose"
		end;

	NoExpose: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NoExpose"
		end;

	VisibilityNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityNotify"
		end;

	CreateNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CreateNotify"
		end;

	DestroyNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"DestroyNotify"
		end;

	UnmapNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"UnmapNotify"
		end;

	MapNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MapNotify"
		end;

	MapRequest: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MapRequest"
		end;

	ReparentNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ReparentNotify"
		end;

	ConfigureNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ConfigureNotify"
		end;

	ConfigureRequest: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ConfigureRequest"
		end;

	GravityNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GravityNotify"
		end;

	ResizeRequest: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ResizeRequest"
		end;

	CirculateNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CirculateNotify"
		end;

	CirculateRequest: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CirculateRequest"
		end;

	PropertyNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyNotify"
		end;

	SelectionClear: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionClear"
		end;

	SelectionRequest: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionRequest"
		end;

	SelectionNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"SelectionNotify"
		end;

	ColormapNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapNotify"
		end;

	ClientMessage: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ClientMessage"
		end;

	MappingNotify: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"MappingNotify"
		end;

	None: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"None"
		end;

feature -- Other constants

	LASTEvent: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LASTEvent"
		end;

	PlaceOnTop: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PlaceOnTop"
		end;

	PlaceOnBottom: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PlaceOnBottom"
		end;

	Above: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Above"
		end;

	Below: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Below"
		end;

	TopIf: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"TopIf"
		end;

	BottomIf: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"BottomIf"
		end;

	Opposite: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Opposite"
		end;

	NotifyNormal: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNormal"
		end;

	NotifyGrab: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyGrab"
		end;

	NotifyUngrab: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyUngrab"
		end;

	NotifyWhileGrabbed: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyWhileGrabbed"
		end;

	NotifyHint: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyHint"
		end;

	NotifyAncestor: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyAncestor"
		end;

	NotifyVirtual: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyVirtual"
		end;

	NotifyInferior: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyInferior"
		end;

	NotifyNonlinear: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNonlinear"
		end;

	NotifyNonlinearVirtual: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyNonlinearVirtual"
		end;

	NotifyPointer: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyPointer"
		end;

	NotifyPointerRoot: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyPointerRoot"
		end;

	NotifyDetailNone: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"NotifyDetailNone"
		end;

	PropertyNewValue: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyNewValue"
		end;

	PropertyDelete: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"PropertyDelete"
		end;

	VisibilityUnobscured: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityUnobscured"
		end;

	VisibilityPartiallyObscured: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityPartiallyObscured"
		end;

	VisibilityFullyObscured: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"VisibilityFullyObscured"
		end;

	Button1: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1"
		end;

	Button2: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2"
		end;

	Button3: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3"
		end;

	Button4: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4"
		end;

	Button5: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5"
		end;

	ShiftMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ShiftMask"
		end;

	LockMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LockMask"
		end;

	ControlMask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ControlMask"
		end;

	Mod1Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod1Mask"
		end;

	Mod2Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod2Mask"
		end;

	Mod3Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod3Mask"
		end;

	Mod4Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod4Mask"
		end;

	Mod5Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Mod5Mask"
		end;

	Button1Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button1Mask"
		end;

	Button2Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button2Mask"
		end;

	Button3Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button3Mask"
		end;

	Button4Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button4Mask"
		end;

	Button5Mask: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Button5Mask"
		end;

	ColormapInstalled: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapInstalled"
		end;

	ColormapUninstalled: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ColormapUninstalled"
		end;

feature -- Convenience routine to compare masks

	and_masks (mask1, mask2: INTEGER): BOOLEAN
			-- Call C routine that will return the result of the
			-- `mask1' & `mask2' operation
		external
			"C"
		end

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




end -- class MEL_EVENT_CONSTANTS


