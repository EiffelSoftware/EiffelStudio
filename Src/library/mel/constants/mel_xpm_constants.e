
indexing
	description: 
		"Constants used for XPM bitmap format."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XMP_CONSTANTS

feature -- Attribute Access

	XmpVisual: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmVisual"
		end;

	XpmColormap: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColormap"
		end;

	XpmDepth: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmDepth"
		end;

	XpmSize: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmSize"
		end;

	XpmHotspot: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmHotspot"
		end;

	XpmCharsPerPixel: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmCharsPerPixel"
		end;

	XpmColorSymbols: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColorSymbols"
		end;

	XpmRgbFilename: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmRgbFilename"
		end;

	XpmInfos: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmInfos"
		end;

	XpmReturnPixels: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmReturnPixels"
		end;

	XpmReturnExtensions, XpmExtensions: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmExtensions"
		end;

	XpmExactColors: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmExactColors"
		end;

	XpmCloseness: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmCloseness"
		end;

	XpmRGBCloseness: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmRGBCloseness"
		end;

	XpmColorKey: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColorKey"
		end;

	XpmReturnColorTable, XpmColorTable: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColorTable"
		end;

	XpmReturnAllocPixels: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmReturnAllocPixels"
		end;

	XpmAllocCloseColors: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmAllocCloseColors"
		end;

	XpmBitmapFormat: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmBitmapFormat"
		end;

feature -- Error access

	XpmColorError: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColorError"
		end;

	XpmSuccess: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmSuccess"
		end;

	XpmOpenFailed: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmOpenFailed"
		end;

	XpmFileInvalid: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmFileInvalid"
		end;

	XpmNoMemory: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmNoMemory"
		end;

	XpmColorFailed: INTEGER is
		external
			"C [macro <xpm.h>]: EIF_INTEGER"
		alias
			"XpmColorFailed"
		end;

end -- class MEL_XMP_CONSTANTS

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
