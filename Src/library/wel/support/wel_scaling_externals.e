note
	description: "[
			Eiffel wrapper to load the Windows Scaling API dynamically.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=High-DPI Reference", "src=https://docs.microsoft.com/en-us/windows/desktop/hidpi/high-dpi-reference", "protocol=uri"

class
	WEL_SCALING_EXTERNALS

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	frozen default_create
			-- Default creation method.
		local
			retried: BOOLEAN
		do
			if not retried then
				initialize_scaling
			end
		rescue
			retried := True
			retry
		end

	initialize_scaling
			-- Properly initialize Current.
		local
			dll: WEL_DLL
			dll2: WEL_DLL
		do
			create dll.make_permanent ("Shcore.dll")
			scaling_handle := dll.item
			create dll2.make_permanent ("User32.dll")
			scaling_handle_ctx := dll2.item
		end

feature -- Constants

	Mdt_effective_dpi: INTEGER  = 0

	Monitor_defaulttonearest: INTEGER = 0x00000002

	Default_dpi: INTEGER = 96
			-- Default DPI value of 96
			-- known as DPI unaware, the application render as
			-- if the screen that they are on has a DPI value of 96 .

	Process_dpi_unaware: INTEGER = 0
			-- Defined as PROCESS_DPI_UNAWARE = 0

	Process_system_dpi_aware: INTEGER = 1
			-- Defined as PROCESS_SYSTEM_DPI_AWARE = 1

	Process_per_monitor_dpi_aware: INTEGER  = 2
			-- Defined as PROCESS_PER_MONITOR_DPI_AWARE = 2


	Dpi_awareness_context_per_monitor_aware_v2 : NATURAL_64
		do
			Result := c_dpi_awareness_context_per_monitor_aware_v2
		end

feature -- Status report

	is_scaling_installed: BOOLEAN
			-- Is "Shcore.dll" available?
		do
			Result := not scaling_handle.is_default_pointer
		end

	is_scaling_context_installed: BOOLEAN
			-- Is "User32.dll" available?
		do
			Result := not scaling_handle_ctx.is_default_pointer
		end

feature -- Access

	scaling_handle: POINTER
			-- Handle to Schore.dll if present.

	scaling_handle_ctx: POINTER
			-- Handle to User32.dll if present.


	monitor_scale (hwnd: POINTER): TUPLE [scalex: DOUBLE; scaley: DOUBLE]
			-- Return the scale DIP (device independent pixels) size, based on the current DPI
			-- (Dots per inch).
			-- examples
			-- DPI Size             DIP size
			--   96                    1 pixel
			--  120                    1.25 pixel
		note
			EIS:"name=", "protocol=https://docs.microsoft.com/en-us/windows/desktop/learnwin32/dpi-and-device-independent-pixels", "protocol=src"
		local
			l_monitor: POINTER
			l_dpi_x: INTEGER
			l_dpi_y: INTEGER
		do
			Result := [1.0, 1.0]
			if not scaling_handle.is_default_pointer then
				l_monitor := {WEL_API}.monitor_from_window ({WEL_API}.get_window (hwnd, {WEL_GW_CONSTANTS}.gw_owner), Monitor_defaulttonearest)
				if not l_monitor.is_default_pointer then
					c_get_dpi_for_monitor (scaling_handle, l_monitor, Mdt_effective_dpi, $l_dpi_x, $l_dpi_y)
					Result := [l_dpi_x / default_dpi, l_dpi_y / default_dpi]
				end
			end
		end

	dpi_for_monitor (hwnd: POINTER): INTEGER
			-- Return the dots per inch (dpi) of a display `hwnd`.
			-- DPI sizes 96, 120, 144, 192, etc.
		require
			hwnd_exists: not hwnd.is_default_pointer
		local
			l_monitor: POINTER
			l_dpi_x: INTEGER
			l_dpi_y: INTEGER
		do
			if not scaling_handle.is_default_pointer then
				l_monitor := {WEL_API}.monitor_from_window ({WEL_API}.get_window (hwnd, {WEL_GW_CONSTANTS}.gw_owner), Monitor_defaulttonearest)
				if not l_monitor.is_default_pointer then
					c_get_dpi_for_monitor (scaling_handle, l_monitor, Mdt_effective_dpi, $l_dpi_x, $l_dpi_y)
					Result := l_dpi_x
				end
			end
		end

	set_process_per_monitor_dpi_aware
			-- Set ProcessDPIAwareness to PROCESS_PER_MONITOR_DPI_AWARE
			-- PROCESS_PER_MONITOR_DPI_AWARE
			--| Per monitor DPI aware. This app checks for the DPI when it is created and adjusts the scale factor whenever the DPI changes.
			--| These applications are not automatically scaled by the system.
		local
			l_res: BOOLEAN
			l_value: INTEGER
			l_val_res: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				if not scaling_handle.is_default_pointer  then
					l_res := c_set_process_dpi_awareness (scaling_handle, process_per_monitor_dpi_aware)
					debug
						l_val_res := c_get_process_dpi_awareness (scaling_handle, default_pointer, $l_value )
						check process_dpi_awarness: l_value = process_per_monitor_dpi_aware  end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	set_process_per_monitor_dpi_aware_v2
		local
			l_res: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				if not scaling_handle_ctx.is_default_pointer  then
					l_res := c_set_process_dpi_awareness_context (scaling_handle_ctx, c_dpi_awareness_context_per_monitor_aware_v2)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- C externals

	c_get_dpi_for_monitor (a_scaling_handle: POINTER; a_hwnd: POINTER; a_flags: INTEGER_32; dpi_x, dpi_y: TYPED_POINTER [INTEGER])
			-- Declared as HRESULT GetDpiForMonitor( HMONITOR hmonitor, MONITOR_DPI_TYPE dpiType, UINT *dpiX, UINT *dpiY );
		require
			a_api_exists: a_scaling_handle /= default_pointer
		external
			"C inline use <wel_scaling_api.h>"
		alias
			"[
				#if defined(_MSC_VER) && defined(DPI_ENUMS_DECLARED)
					FARPROC GetDpiForMonitor = NULL;
					HMODULE user32_module = (HMODULE) $a_scaling_handle;
					
					GetDpiForMonitor = GetProcAddress (user32_module, "GetDpiForMonitor");
					if (GetDpiForMonitor) {
						(FUNCTION_CAST_TYPE(void, WINAPI, (HMONITOR, MONITOR_DPI_TYPE, UINT *, UINT * )) GetDpiForMonitor) ((HMONITOR) $a_hwnd, (MONITOR_DPI_TYPE) $a_flags, (UINT *) $dpi_x, (UINT *) $dpi_y );
					}
				#endif
			]"
		end

	c_set_process_dpi_awareness	(a_scaling_handle: POINTER; a_level: INTEGER): BOOLEAN
			-- Declated as HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);
		require
			a_api_exists: a_scaling_handle /= default_pointer
		external
			"C inline use <wel_scaling_api.h>"
		alias
			"[
				#if defined(_MSC_VER) && defined(DPI_ENUMS_DECLARED)
					FARPROC SetProcessDpiAwareness = NULL;
					HMODULE user32_module = (HMODULE) $a_scaling_handle;
							
					SetProcessDpiAwareness = GetProcAddress (user32_module, "SetProcessDpiAwareness");
					if (SetProcessDpiAwareness) {
						return EIF_TEST((FUNCTION_CAST_TYPE(HRESULT, WINAPI, (PROCESS_DPI_AWARENESS)) SetProcessDpiAwareness) ((PROCESS_DPI_AWARENESS)$a_level));
					} else {
						return EIF_FALSE;
					}
				#else
					return EIF_FALSE;
				#endif
			]"
		end

	c_dpi_awareness_context_per_monitor_aware_v2 : NATURAL_64
			-- Declared as
		external
			"C inline use <wel_scaling_api.h>"
		alias
		  "[
			#if defined(_MSC_VER) && defined(_DPI_AWARENESS_CONTEXTS_) && defined(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2)
				return DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2;
			#else
				return 0;
			#endif
			]"
		end

	c_set_process_dpi_awareness_context	(a_scaling_handle: POINTER; a_level: NATURAL_64): BOOLEAN
			-- Declated as BOOL SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT value);
		require
			a_api_exists: a_scaling_handle /= default_pointer
		external
			"C inline use <wel_scaling_api.h>"
		alias
			"[
				#if defined(_MSC_VER) && defined(_DPI_AWARENESS_CONTEXTS_)
					FARPROC SetProcessDpiAwarenessContext = NULL;
					HMODULE user32_module = (HMODULE) $a_scaling_handle;
					SetProcessDpiAwarenessContext = GetProcAddress (user32_module, "SetProcessDpiAwarenessContext");
					if (SetProcessDpiAwarenessContext) {
						return EIF_TEST((FUNCTION_CAST_TYPE(BOOL, WINAPI, (DPI_AWARENESS_CONTEXT)) SetProcessDpiAwarenessContext) ((DPI_AWARENESS_CONTEXT) $a_level));
					} else {
						return EIF_FALSE;
					}
				#else
					return EIF_FALSE;
				#endif
			]"
		end

	c_get_process_dpi_awareness	(a_scaling_handle:POINTER; a_process: POINTER; a_value: TYPED_POINTER [INTEGER]): INTEGER
			-- Declared as HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS *value);
		require
			a_api_exists: a_scaling_handle /= default_pointer
		external
			"C inline use <wel_scaling_api.h>"
		alias
			"[
				#if defined(_MSC_VER) && defined(DPI_ENUMS_DECLARED)
					FARPROC GetProcessDpiAwareness = NULL;
					HMODULE user32_module = (HMODULE) $a_scaling_handle;
									
					GetProcessDpiAwareness = GetProcAddress (user32_module, "GetProcessDpiAwareness");
					if (GetProcessDpiAwareness) {
						return (FUNCTION_CAST_TYPE(HRESULT, WINAPI, (HANDLE, PROCESS_DPI_AWARENESS * )) GetProcessDpiAwareness) ((HANDLE) $a_process, (PROCESS_DPI_AWARENESS *) $a_value);
					} else {
						return 0;
					}
				#else
					return 0;
				#endif
			]"
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
