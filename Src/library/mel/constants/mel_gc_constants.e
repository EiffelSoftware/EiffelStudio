
note
	description: 
		"Constants used to set and retrieve values of a Graphic Context."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GC_CONSTANTS

feature -- Function mode access

	GXclear: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXclear"
		end;

	GXand: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXand"
		end;

	GXandReverse: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandReverse"
		end;

	GXcopy: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopy"
		end;

	GXandInverted: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandInverted"
		end;

	GXnoop: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnoop"
		end;

	GXxor: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXxor"
		end;

	GXor: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXor"
		end;

	GXnor: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnor"
		end;

	GXequiv: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXequiv"
		end;

	GXinvert: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXinvert"
		end;

	GXorReverse: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorReverse"
		end;

	GXcopyInverted: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopyInverted"
		end;

	GXorInverted: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorInverted"
		end;

	GXnand: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnand"
		end;

	GXset: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXset"
		end;

feature -- Arc mode access

	ArcChord: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ArcChord"
		end;

	ArcPieSlice: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ArcPieSlice"
		end;

feature -- Cap style access

	CapNotLast: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapNotLast"
		end;

	CapButt: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapButt"
		end;

	CapRound: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapRound"
		end;

	CapProjecting: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapProjecting"
		end;

feature -- Fill style access

	FillSolid: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillSolid"
		end;

	FillTiled: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillTiled"
		end;

	FillStippled: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillStippled"
		end;

	FillOpaqueStippled: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillOpaqueStippled"
		end;

feature -- File style access

	JoinMiter: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinMiter"
		end;

	JoinRound: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinRound"
		end;

	JoinBevel: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinBevel"
		end;

feature -- Line style access

	LineSolid: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineSolid"
		end;

	LineOnOffDash: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineOnOffDash"
		end;

	LineDoubleDash: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineDoubleDash"
		end;

feature -- Subwindow mode access

	ClipByChildren: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ClipByChildren"
		end;

	IncludeInferiors: INTEGER
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"IncludeInferiors"
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




end -- class MEL_GC_CONSTANTS


