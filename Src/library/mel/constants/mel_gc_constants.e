
indexing
	description: 
		"Constants used to set and retrieve values of a Graphic Context.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GC_CONSTANTS

feature -- Access

	GXclear: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXclear"
		end;

	GXand: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXand"
		end;

	GXandReverse: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandReverse"
		end;

	GXcopy: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopy"
		end;

	GXandInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXandInverted"
		end;

	GXnoop: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnoop"
		end;

	GXxor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXxor"
		end;

	GXor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXor"
		end;

	GXnor: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnor"
		end;

	GXequiv: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXequiv"
		end;

	GXinvert: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXinvert"
		end;

	GXorReverse: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorReverse"
		end;

	GXcopyInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXcopyInverted"
		end;

	GXorInverted: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXorInverted"
		end;

	GXnand: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXnand"
		end;

	GXset: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"GXset"
		end;

end -- class MEL_GC_CONSTANTS

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
