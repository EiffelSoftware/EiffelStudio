note

	description: 	
		"Window manager shell resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WM_SHELL_RESOURCES

feature -- Implementation

	XmNbaseHeight: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNbaseHeight"
		end;

	XmNbaseWidth: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNbaseWidth"
		end;

	XmNheightInc: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNheightInc"
		end;

	XmNiconMask: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNiconMask"
		end;

	XmNiconPixmap: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNiconPixmap"
		end;

	XmNiconWindow: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNiconWindow"
		end;

	XmNiconX: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNiconX"
		end;

	XmNiconY: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNiconY"
		end;

	XmNinitialState: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNinitialState"
		end;

	XmNinput: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNinput"
		end;

	XmNmaxAspectX: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNmaxAspectX"
		end;

	XmNmaxAspectY: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNmaxAspectY"
		end;

	XmNmaxHeight: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNmaxHeight"
		end;

	XmNmaxWidth: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNmaxWidth"
		end;

	XmNminAspectX: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNminAspectX"
		end;

	XmNminAspectY: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNminAspectY"
		end;

	XmNminHeight: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNminHeight"
		end;

	XmNminWidth: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNminWidth"
		end;

	XmNtitle: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNtitle"
		end;

	XmNtitleEncoding: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNtitleEncoding"
		end;

	XmNtransient: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNtransient"
		end;

	XmNwaitForWm: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwaitForWm"
		end;

	XmNwidthInc: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwidthInc"
		end;

	XmNwindowGroup: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwindowGroup"
		end;

	XmNwinGravity: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwinGravity"
		end;

	XmNwmTimeout: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwmTimeout"
		end;

	NormalState: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"NormalState"
		end;

	IconicState: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"IconicState"
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




end -- class MEL_WM_SHELL_RESOURCES


