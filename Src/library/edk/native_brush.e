note
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_BRUSH

inherit
	EDK_OBJECT_I
		redefine
			default_create
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
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
