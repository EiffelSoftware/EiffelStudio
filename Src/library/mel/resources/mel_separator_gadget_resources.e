indexing

	description: 
		"Separator Gadget resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SEPARATOR_GADGET_RESOURCES

feature -- Implementation

	XmNmargin: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNmargin"
		end;


	XmNseparatorType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNseparatorType"
		end;

	XmNorientation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmVERTICAL: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmNO_LINE: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmNO_LINE"
		end;

	XmSINGLE_LINE: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSINGLE_LINE"
		end;

	XmDOUBLE_LINE: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmDOUBLE_LINE"
		end;

	XmSINGLE_DASHED_LINE: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSINGLE_DASHED_LINE"
		end;

	XmDOUBLE_DASHED_LINE: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmDOUBLE_DASHED_LINE"
		end;

	XmSHADOW_ETCHED_IN: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_IN"
		end;

	XmSHADOW_ETCHED_OUT: INTEGER is
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_OUT"
		end;

end -- class MEL_SEPARATOR_GADGET_RESOURCES

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
