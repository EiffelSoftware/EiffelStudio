note

	description: 
		"Scrollbar resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLL_BAR_RESOURCES

feature -- Implementation

	XmNincrement: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNincrement"
		end;

	XmNinitialDelay: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNinitialDelay"
		end;

	XmNmaximum: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNmaximum"
		end;

	XmNminimum: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNminimum"
		end;

	XmNorientation: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmNpageIncrement: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageIncrement"
		end;

	XmNprocessingDirection: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNprocessingDirection"
		end;

	XmNrepeatDelay: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNrepeatDelay"
		end;

	XmNshowArrows: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNshowArrows"
		end;

	XmNsliderSize: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNsliderSize"
		end;

	XmNtroughColor: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtroughColor"
		end;

	XmNvalue: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNvalue"
		end;

	XmNdecrementCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNdecrementCallback"
		end;

	XmNdragCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNdragCallback"
		end;

	XmNincrementCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNincrementCallback"
		end;

	XmNpageDecrementCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageDecrementCallback"
		end;

	XmNpageIncrementCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNpageIncrementCallback"
		end;

	XmNtoBottomCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtoBottomCallback"
		end;

	XmNtoTopCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNtoTopCallback"
		end;

	XmNvalueChangedCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrollBar.h>]: EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmVERTICAL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmMAX_ON_TOP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_TOP"
		end;

	XmMAX_ON_BOTTOM: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_BOTTOM"
		end;

	XmMAX_ON_LEFT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_LEFT"
		end;

	XmMAX_ON_RIGHT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrollBar.h>] : EIF_INTEGER"
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




end -- class MEL_SCROLL_BAR_RESOURCES


