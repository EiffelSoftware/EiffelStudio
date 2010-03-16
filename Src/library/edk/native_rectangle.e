indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	NATIVE_RECTANGLE

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
			native_rectangle_handle := native_rectangle_handle.memory_calloc (1, rectangle_structure_size)
		end

feature -- Status Setting

	set_left_top_right_bottom_coordinates (a_left, a_top, a_right, a_bottom: INTEGER) is
			--
		do
			native_set_left_top_right_bottom (native_rectangle_handle, a_left, a_top, a_right, a_bottom)
		end


feature {DRAWABLE_ROUTINES} -- Implementation

	native_rectangle_handle: POINTER
			-- Handle to the native rectangle.

feature {NONE} -- Implementation

	native_set_left_top_right_bottom (a_native_rectangle_handle: POINTER; a_left, a_top, a_right, a_bottom: INTEGER)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					RECT* lRect;
					lRect = (RECT*) $a_native_rectangle_handle;
					lRect->left = (LONG) $a_left;
					lRect->top = (LONG) $a_top;
					lRect->right = (LONG) $a_right;
					lRect->bottom = (LONG) $a_bottom;
				#endif
			]"
		end

	rectangle_structure_size: INTEGER
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return sizeof (RECT);
				#endif
			]"
		end

	dispose
			-- <Precursor>
		do
			native_rectangle_handle.memory_free
		end

end
