note

	description: 	
		"Scale resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCALE_RESOURCES

feature -- Implementation

	XmNdecimalPoints: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNdecimalPoints"
		end;

	XmNhighlightOnEnter: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNhighlightOnEnter"
		end;

	XmNhighlightThickness: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNhighlightThickness"
		end;

	XmNmaximum: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNmaximum"
		end;

	XmNminimum: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNminimum"
		end;

	XmNorientation: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmNprocessingDirection: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNprocessingDirection"
		end;

	XmNscaleHeight: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleHeight"
		end;

	XmNscaleMultiple: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleMultiple"
		end;

	XmNscaleWidth: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleWidth"
		end;

	XmNshowValue: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNshowValue"
		end;

	XmNtitleString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNtitleString"
		end;

	XmNvalue: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNvalue"
		end;

	XmNdragCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNdragCallback"
		end;

	XmNvalueChangedCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmVERTICAL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmMAX_ON_TOP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_TOP"
		end;

	XmMAX_ON_BOTTOM: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_BOTTOM"
		end;

	XmMAX_ON_LEFT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_LEFT"
		end;

	XmMAX_ON_RIGHT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_RIGHT"
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




end -- class MEL_SCALE_RESOURCES



