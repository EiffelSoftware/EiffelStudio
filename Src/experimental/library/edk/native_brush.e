indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_BRUSH

inherit
	EDK_OBJECT_I
		redefine
			default_create,
			dispose
		end

feature {NONE} -- Creation

	default_create
			-- Create and initialize `Current'.
		do
			native_brush := default_brush
		end

feature {DRAWABLE_ROUTINES} -- Implementation

	native_brush: POINTER
			-- Handle to the native brush.

feature {NONE} -- Implementation

	default_brush: POINTER
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return GetSysColorBrush (0);
				#endif
			]"
		end

	dispose
			-- Clean up `Current'.
		do
			Precursor
		end

end
