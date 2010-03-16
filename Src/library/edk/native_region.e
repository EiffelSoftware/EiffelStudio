indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	NATIVE_REGION

inherit
	DISPOSABLE
		redefine
			default_create
		end

creation
	make_from_rectangle, make_from_native_rectangle, default_create

feature {NONE} -- Creation

	default_create
			-- Create an empty region.
		do
			make_from_rectangle (0, 0, 0, 0)
		end

	make_from_native_rectangle (a_rect: POINTER)
			-- Create region based on native rectangle `a_rect'
		require
			a_rect_not_null: a_rect /= default_pointer
		do
			native_handle := native_region_from_native_rectangle (a_rect)
		end

	make_from_rectangle (a_left, a_top, a_right, a_bottom: INTEGER_16)
			-- Create region from specified rectangle (x1, y1, x2, y2).
		do
			native_handle := native_region_from_rectangle (a_left, a_top, a_right, a_bottom)
		end

feature {NONE} -- Implementation

	native_region_from_rectangle (a_left, a_top, a_right, a_bottom: INTEGER_16): POINTER
			-- Create a native region from the native rectangle `a_rect'.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return CreateRectRgn ((int) $a_left, (int) $a_top, (int) $a_right, (int) $a_bottom);
				#endif
			]"
		end

	native_region_from_native_rectangle (a_rect: POINTER): POINTER
			-- Create a native region from the native rectangle `a_rect'.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return CreateRectRgnIndirect ((RECT *) $a_rect);
				#endif
			]"
		end

	native_handle: POINTER
		-- Handle to the native region.

	dispose
			-- Cleanup `Current'
		do
			native_dispose (native_handle)
		end

	native_dispose (a_region: POINTER)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					DeleteObject ((HRGN) $a_region);
				#endif
			]"
		end

end
