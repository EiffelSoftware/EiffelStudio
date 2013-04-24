
note
	description: 
		"Constants used for XPM bitmap format."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XPM_CONSTANTS

feature -- Attribute Access

	XmpVisual: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmVisual"
		end;

	XpmColormap: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColormap"
		end;

	XpmDepth: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmDepth"
		end;

	XpmSize: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmSize"
		end;

	XpmHotspot: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmHotspot"
		end;

	XpmCharsPerPixel: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmCharsPerPixel"
		end;

	XpmColorSymbols: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColorSymbols"
		end;

	XpmRgbFilename: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmRgbFilename"
		end;

	XpmInfos: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmInfos"
		end;

	XpmReturnPixels: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmReturnPixels"
		end;

	XpmReturnExtensions, XpmExtensions: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmExtensions"
		end;

	XpmExactColors: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmExactColors"
		end;

	XpmCloseness: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmCloseness"
		end;

	XpmRGBCloseness: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmRGBCloseness"
		end;

	XpmColorKey: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColorKey"
		end;

	XpmReturnColorTable, XpmColorTable: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColorTable"
		end;

	XpmReturnAllocPixels: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmReturnAllocPixels"
		end;

	XpmAllocCloseColors: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmAllocCloseColors"
		end;

	XpmBitmapFormat: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmBitmapFormat"
		end;

feature -- Error access

	XpmColorError: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColorError"
		end;

	XpmSuccess: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmSuccess"
		end;

	XpmOpenFailed: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmOpenFailed"
		end;

	XpmFileInvalid: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmFileInvalid"
		end;

	XpmNoMemory: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmNoMemory"
		end;

	XpmColorFailed: INTEGER
		external
			"C [macro %"xpm.h%"]: EIF_INTEGER"
		alias
			"XpmColorFailed"
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




end -- class MEL_XPM_CONSTANTS


