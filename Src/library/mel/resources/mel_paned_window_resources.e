indexing

	description: 
		"Paned Window resources.";
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

end -- class MEL_PANED_WINDOW_RESOURCES



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

