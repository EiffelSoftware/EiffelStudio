
indexing
	description: 
		"Constants used to set and retrieve values of a Graphic Context."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GC_CONSTANTS

feature -- Function mode access

	GXclear: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXclear"
		end;

	GXand: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXand"
		end;

	GXandReverse: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandReverse"
		end;

	GXcopy: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopy"
		end;

	GXandInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandInverted"
		end;

	GXnoop: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnoop"
		end;

	GXxor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXxor"
		end;

	GXor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXor"
		end;

	GXnor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnor"
		end;

	GXequiv: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXequiv"
		end;

	GXinvert: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXinvert"
		end;

	GXorReverse: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorReverse"
		end;

	GXcopyInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopyInverted"
		end;

	GXorInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorInverted"
		end;

	GXnand: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnand"
		end;

	GXset: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXset"
		end;

feature -- Arc mode access

	ArcChord: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ArcChord"
		end;

	ArcPieSlice: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ArcPieSlice"
		end;

feature -- Cap style access

	CapNotLast: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapNotLast"
		end;

	CapButt: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapButt"
		end;

	CapRound: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapRound"
		end;

	CapProjecting: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CapProjecting"
		end;

feature -- Fill style access

	FillSolid: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillSolid"
		end;

	FillTiled: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillTiled"
		end;

	FillStippled: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillStippled"
		end;

	FillOpaqueStippled: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"FillOpaqueStippled"
		end;

feature -- File style access

	JoinMiter: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinMiter"
		end;

	JoinRound: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinRound"
		end;

	JoinBevel: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"JoinBevel"
		end;

feature -- Line style access

	LineSolid: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineSolid"
		end;

	LineOnOffDash: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineOnOffDash"
		end;

	LineDoubleDash: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"LineDoubleDash"
		end;

feature -- Subwindow mode access

	ClipByChildren: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"ClipByChildren"
		end;

	IncludeInferiors: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"IncludeInferiors"
		end;

indexing
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


