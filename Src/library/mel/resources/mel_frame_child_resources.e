indexing

	description: 
		"Resources for frame chilren.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME_CHILD_RESOURCES

feature -- Access

	XmNchildType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildType"
		end;

	XmNchildHorizontalAlignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildHorizontalAlignment"
		end;

	XmNchildHorizontalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildHorizontalSpacing"
		end;

	XmNchildVerticalAlignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildVerticalAlignment"
		end;

	XmFRAME_TITLE_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_TITLE_CHILD"
		end;

	XmFRAME_WORKAREA_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_WORKAREA_CHILD"
		end;

	XmFRAME_GENERIC_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_GENERIC_CHILD"
		end;

	XmCHILD_ALIGNMENT_BEGINNING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmCHILD_ALIGNMENT_END: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
		end;

	XmCHILD_ALIGNMENT_BASELINE_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BASELINE_BOTTOM"
		end;

	XmCHILD_ALIGNMENT_BASELINE_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BASELINE_TOP"
		end;

	XmCHILD_ALIGNMENT_WIDGET_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_WIDGET_TOP"
		end;

	XmCHILD_ALIGNMENT_CENTER: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmCHILD_ALIGNMENT_WIDGET_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_WIDGET_BOTTOM"
		end;

end -- class MEL_FRAME_CHILD_RESOURCES


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

