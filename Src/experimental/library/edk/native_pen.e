indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	NATIVE_PEN

inherit
	EDK_OBJECT_I
		redefine
			default_create,
			dispose
		end

create
	default_create, make_with_attributes

feature {NONE} -- Creation

	default_create
			-- Create and initialize `Current'.
		do
			native_pen := c_native_new_pen (default_pen_width, default_color, False)
		end

	make_with_attributes (a_width: NATURAL_8; a_color: NATURAL_32; a_dashed: BOOLEAN)
			-- Make pen of width `a_width' using color `a_color' and whether dashed style is used or not.
		do
			native_pen := c_native_new_pen (a_width, a_color, a_dashed)
		end

feature {DRAWABLE_ROUTINES} -- Implementation

	native_pen: POINTER
			-- Handle to the native brush.

feature {NONE} -- Implementation

	default_pen_width: NATURAL_8 = 2
	default_color: NATURAL_32 = 0x00FF0000
		-- Windows COLORREF Format is 0x00bbggrr where the high order byte must be zero (ie: no alpha)

	c_native_new_pen (a_width: NATURAL_8; a_color: NATURAL_32; a_dashed: BOOLEAN): POINTER
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return CreatePen ($a_dashed ? PS_DASH : PS_SOLID, (int) $a_width, (COLORREF) $a_color);
				#endif
			]"
		end

	dispose
			-- Cleanup `Current'
		do
			Precursor
			c_native_dispose (native_pen)
		end

	c_native_dispose (a_pen: POINTER)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					DeleteObject ((HPEN) $a_pen);
				#endif
			]"
		end

end
