indexing

	description: 	
		"Scale resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCALE_RESOURCES

feature -- Implementation

	XmNdecimalPoints: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNdecimalPoints"
		end;

	XmNhighlightOnEnter: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNhighlightOnEnter"
		end;

	XmNhighlightThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNhighlightThickness"
		end;

	XmNmaximum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNmaximum"
		end;

	XmNminimum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNminimum"
		end;

	XmNorientation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmNprocessingDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNprocessingDirection"
		end;

	XmNscaleHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleHeight"
		end;

	XmNscaleMultiple: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleMultiple"
		end;

	XmNscaleWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNscaleWidth"
		end;

	XmNshowValue: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNshowValue"
		end;

	XmNtitleString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNtitleString"
		end;

	XmNvalue: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNvalue"
		end;

	XmNdragCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNdragCallback"
		end;

	XmNvalueChangedCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Scale.h>] : EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmVERTICAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmMAX_ON_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_TOP"
		end;

	XmMAX_ON_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_BOTTOM"
		end;

	XmMAX_ON_LEFT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_LEFT"
		end;

	XmMAX_ON_RIGHT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Scale.h>] : EIF_INTEGER"
		alias
			"XmMAX_ON_RIGHT"
		end;

end -- class MEL_SCALE_RESOURCES



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

