note
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_DRAWABLE_CONTEXT

inherit
	EDK_OBJECT_I
		redefine
			default_create
		end

create {NATIVE_WINDOW}
	default_create

feature {NONE} -- Creation

	default_create
			-- Create and initialize `Current'.
		do

			-- Thread ID should be set here too to prevent calls from differing threads.
		end

feature -- Status Setting

	initialized: BOOLEAN
			-- Is drawable context initialized?
		do
			Result := drawable /= Void
		end

	initialize_for_drawable (a_drawable: NATIVE_DRAWABLE_I)
			-- Initialize `Current' for use with `a_native_window'.
		require
			not_initialized: not initialized
		do
			c_native_initialize_graphics_context_from_handle (a_drawable.drawable_handle, native_handle, False)
			drawable := a_drawable
		end

	release
			-- Release drawable context
		require
			initialized: initialized
		do
			if not initialized_for_expose and then attached drawable as l_drawable then
				c_native_release_graphics_context (l_drawable.drawable_handle, native_handle, False)
				drawable := Void
			end
		end

feature -- Basic Operations.

feature -- Access

	drawable: detachable NATIVE_DRAWABLE_I
		-- Native Window for which `Current' is initialized for.

feature {EDK_DISPLAY, EDK_DESKTOP_EVENT_MANAGER, DRAWABLE_ROUTINES} -- Access

	native_handle: POINTER
			-- Handle to the native graphics context.
		do
			if native_handle_internal = Result then
					-- Current is a new object so we reinitialize
				native_handle_internal := Result.memory_calloc (1, c_native_graphics_context_structure_size)
			end
			Result := native_handle_internal
		end

	initialize_for_expose (a_drawable: NATIVE_DRAWABLE_I)
			-- Initialize `Current' for use via an expose event'.
		require
			a_drawable_not_void: a_drawable /= Void
			not_initialized: not initialized
			not_initialized_for_expose: not initialized_for_expose
		do
			drawable := a_drawable
			c_native_initialize_graphics_context_from_handle (a_drawable.drawable_handle, native_handle, True)
			initialized_for_expose := True
		ensure
			initialized_to_drawable: drawable = a_drawable
			initialized_for_expose: initialized_for_expose
		end

	initialized_for_expose: BOOLEAN
		-- Was `Current' initialized for expose event.

	reset_from_expose (a_drawable: NATIVE_DRAWABLE_I)
			-- Reset `Current' from the previous call to `initialize_for_expose'.
		require
			a_drawable_not_void: a_drawable /= Void
			is_initialized: drawable = a_drawable
			initialized_for_expose: initialized_for_expose
		do
			c_native_release_graphics_context (a_drawable.drawable_handle, native_handle, True)
			drawable := Void
			initialized_for_expose := False
		ensure
			not_initialized: not initialized
			not_initialized_for_expose: not initialized_for_expose
		end

feature {NONE} -- Implementation

	c_native_initialize_graphics_context_from_handle (window_handle, a_native_graphics_context_handle: POINTER; a_from_expose: BOOLEAN)
			-- Initialize graphics context for expose event.
			-- Must only be called during expose message and 'Current' must be released after drawing with 'release_expose_graphics_context'.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					if ($a_from_expose)
					{
						BeginPaint ((HWND) $window_handle, (LPPAINTSTRUCT) $a_native_graphics_context_handle);
					}
					else
					{
						HDC hdc;
						hdc = GetDC ((HWND) $window_handle);
						((PAINTSTRUCT*) $a_native_graphics_context_handle)->hdc = hdc;
					}
				#endif
			]"
		end

	c_native_release_graphics_context (window_handle, a_native_graphics_context_handle: POINTER; a_from_expose: BOOLEAN)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					if ($a_from_expose)
					{
						EndPaint ((HWND) $window_handle, (PAINTSTRUCT*) $a_native_graphics_context_handle);
					}
					else
					{
						HDC hdc;
						hdc = ((PAINTSTRUCT*) $a_native_graphics_context_handle)->hdc;
						ReleaseDC ((HWND) $window_handle, hdc);
						((PAINTSTRUCT*) $a_native_graphics_context_handle)->hdc = NULL;
					}
				#endif
			]"
		end

	c_native_clip_area_x (a_native_graphics_context_handle: POINTER): INTEGER_16
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return ((PAINTSTRUCT*) $a_native_graphics_context_handle)->rcPaint.left;				
				#endif
			]"
		end


feature {NONE} -- Implementation

	native_handle_internal: POINTER
		-- Internal handle for the native graphics context

	c_native_graphics_context_structure_size: INTEGER
			-- Memory size in byte of graphics context structure
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return sizeof (PAINTSTRUCT);
				#endif
			]"
		end

	dispose
			-- <Precursor>
		do
			if native_handle_internal /= default_pointer then
				native_handle_internal.memory_free
			end
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
