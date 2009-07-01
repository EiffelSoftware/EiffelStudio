indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_WINDOW

inherit
	EDK_SESSION_ID_OBJECT_I
		undefine
			is_equal, copy
		end

	NATIVE_DRAWABLE_I
		rename
			drawable_handle as native_handle
		end

create
	make_with_style

feature {NONE} -- Creation

	frozen make_with_style (a_style: NATURAL)
			-- Create `Current' with style `a_style'.
		local
			l_session_id: POINTER
		do
			create drawable_context
			create_underlying_implementation
			l_session_id := l_session_id + session_id
			native_handle_internal := c_native_create_window ({EDK_DISPLAY_DESKTOP}.native_handle, a_style, l_session_id)
		end

feature -- Access

	drawable_context: NATIVE_DRAWABLE_CONTEXT
		-- Drawable Context for rendering graphics on `Current'.

	default_event_handler (a_event: EDK_MESSAGE)
		local
			l_native_rectangle: NATIVE_RECTANGLE
			l_native_brush: NATIVE_BRUSH
			l_native_pen: NATIVE_PEN
			l_graphics_context: NATIVE_DRAWABLE_CONTEXT
			l_drawable_routines: DRAWABLE_ROUTINES
			n: NATURAL_8
		do
			l_graphics_context := drawable_context
			create l_native_rectangle
			l_native_rectangle.set_left_top_right_bottom_coordinates (0, 0, 200, 200)
			create l_native_brush
--			create l_native_pen
			create l_drawable_routines
			l_drawable_routines.fill_rectangle (l_graphics_context, l_native_rectangle, l_native_brush)
--			from
--				n := 1
--			until
--				n > 100
--			loop
--				l_drawable_routines.draw_point (l_graphics_context, n, n, l_native_pen)
--				n := n + 1
--			end


			l_drawable_routines.draw_text (l_graphics_context, l_native_rectangle, "Hello World!")
		end



feature {EDK_OBJECT_I, EDK_DESKTOP_EVENT_MANAGER} -- Implementation

	native_handle: POINTER
			-- Window handle of `Current' created by underlying toolkit.
		do
			Result := native_handle_internal
		end

feature {EDK_DESKTOP_EVENT_MANAGER} -- Implementation

	native_handle_internal: POINTER
		-- Window handle of `Current' create by underlying toolkit.

	frozen c_native_create_window (a_parent_window: POINTER; a_style: NATURAL; a_data: POINTER): POINTER
		external
			"C inline use <edk.h>"
		alias
			"[
				// Create a window at (0, 0) with dimensions of (640, 480)
				#if EIF_OS = EIF_WINNT
  					return CreateWindow ("EDK_Window", "", (DWORD) $a_style, 0, 0, 640, 480, (HWND) $a_parent_window, NULL, eif_hInstance, (LPVOID) $a_data);
				#endif
				
				// Use gdk_window_add_filter to hook in to all events on gdk.
			]"
		end

end
