indexing

	description: 
		"Scrollbar resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLL_BAR_RESOURCES

feature -- Implementation

	XmNincrement: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNincrement"
		end;

	XmNinitialDelay: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNinitialDelay"
		end;

	XmNmaximum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNmaximum"
		end;

	XmNminimum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNminimum"
		end;

	XmNorientation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmNpageIncrement: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageIncrement"
		end;

	XmNprocessingDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNprocessingDirection"
		end;

	XmNrepeatDelay: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNrepeatDelay"
		end;

	XmNshowArrows: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNshowArrows"
		end;

	XmNsliderSize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNsliderSize"
		end;

	XmNtroughColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtroughColor"
		end;

	XmNvalue: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNvalue"
		end;

	XmNdecrementCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNdecrementCallback"
		end;

	XmNdragCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNdragCallback"
		end;

	XmNincrementCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNincrementCallback"
		end;

	XmNpageDecrementCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageDecrementCallback"
		end;

	XmNpageIncrementCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageIncrementCallback"
		end;

	XmNtoBottomCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtoBottomCallback"
		end;

	XmNtoTopCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtoTopCallback"
		end;

	XmNvalueChangedCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmVERTICAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmMAX_ON_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_TOP"
		end;

	XmMAX_ON_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_BOTTOM"
		end;

	XmMAX_ON_LEFT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_LEFT"
		end;

	XmMAX_ON_RIGHT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_RIGHT"
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




end -- class MEL_SCROLL_BAR_RESOURCES


