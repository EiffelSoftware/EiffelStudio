indexing

	description: 
		"Paned Window resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW_RESOURCES

feature -- Implementation

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNrefigureMode: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNrefigureMode"
		end;

	XmNsashHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNsashHeight"
		end;

	XmNsashIndent: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNsashIndent"
		end;

	XmNsashShadowThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNsashShadowThickness"
		end;

	XmNsashWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNsashWidth"
		end;

	XmNseparatorOn: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNseparatorOn"
		end;

	XmNspacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNspacing"
		end;


	XmNorientation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmVertical: INTEGER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;	

	XmHorizontal: INTEGER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_INTEGER"
		alias
			"XmHORIZONTAL"
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




end -- class MEL_PANED_WINDOW_RESOURCES



