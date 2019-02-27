note
	description: "[
		Eiffel wrapper to load the Windows Scaling API dynamically
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCALING_EXTERNALS


feature -- Constants

	Mdt_effective_dpi: INTEGER  = 0

	Monitor_defaulttonearest: INTEGER = 0x00000002

	Default_dpi: INTEGER = 96
			-- Default DPI value of 96
			-- known as DPI unawre, the application render as if the screen that they are on has a DPI value of 96

	Process_per_monitor_dpi_aware: INTEGER  = 2

feature -- Status report

	is_api_available: BOOLEAN
			-- <Precursor>.
			-- i.e if dll/so file exists.
		do
			Result := api_loader.is_interface_usable
		end

feature -- Access

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
			l_value: INTEGER
			l_val_res: INTEGER
		do
			Result := [1.0, 1.0]
			l_monitor := {WEL_API}.monitor_from_window ({WEL_API}.get_window (hwnd, {WEL_GW_CONSTANTS}.gw_owner), Monitor_defaulttonearest)
			if l_monitor /= default_pointer then
				c_get_dpi_for_monitor (get_dpi_for_monitor_ptr, l_monitor, Mdt_effective_dpi, $l_dpi_x, $l_dpi_y)
				Result := [l_dpi_x/default_dpi, l_dpi_y/default_dpi]
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
			l_monitor := {WEL_API}.monitor_from_window ({WEL_API}.get_window (hwnd, {WEL_GW_CONSTANTS}.gw_owner), Monitor_defaulttonearest)
			if l_monitor /= default_pointer then
				c_get_dpi_for_monitor (get_dpi_for_monitor_ptr, l_monitor, Mdt_effective_dpi, $l_dpi_x, $l_dpi_y)
				Result := l_dpi_x
			end
		end

	set_process_per_monitor_dpi_aware
			-- Set ProcessDPIAwareness to PROCESS_PER_MONITOR_DPI_AWARE
			-- PROCESS_PER_MONITOR_DPI_AWARE	
			--|	Per monitor DPI aware. This app checks for the DPI when it is created and adjusts the scale factor whenever the DPI changes.
			--| These applications are not automatically scaled by the system.		
		local
			l_res: BOOLEAN
			l_value: INTEGER
			l_val_res: INTEGER
		do
			l_res := c_set_process_dpi_awareness (set_process_dpi_awareness_ptr, process_per_monitor_dpi_aware)
			debug
				l_val_res := c_get_process_dpi_awareness (get_process_dpi_awareness_ptr, default_pointer, $l_value )
				check process_dpi_awarness: l_value = process_per_monitor_dpi_aware  end
			end
		end

feature -- Function pointer

	get_dpi_for_monitor_ptr: POINTER
		do
			Result := api_loader.api_pointer ("GetDpiForMonitor")
		end

	set_process_dpi_awareness_ptr: POINTER
		do
			Result := api_loader.api_pointer ("SetProcessDpiAwareness")
		end

	get_process_dpi_awareness_ptr: POINTER
		do
			Result := api_loader.api_pointer ("GetProcessDpiAwareness")
		end


feature {NONE} --C externals

	c_get_dpi_for_monitor (a_api: POINTER; a_hwnd: POINTER; a_flags: INTEGER_32; dpi_x, dpi_y: TYPED_POINTER[INTEGER])
			-- Declared as HRESULT GetDpiForMonitor( HMONITOR hmonitor, MONITOR_DPI_TYPE dpiType, UINT *dpiX, UINT *dpiY );
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <shellscalingapi.h>"
		alias
			"[
		
				(FUNCTION_CAST(void , (HMONITOR, MONITOR_DPI_TYPE, UINT *, UINT * )) $a_api) ($a_hwnd, $a_flags, $dpi_x, $dpi_y );
			]"
		end

	c_set_process_dpi_awareness	(a_api: POINTER; a_level: INTEGER): BOOLEAN
			-- Declated as HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <shellscalingapi.h>"
		alias
			"[
		
				return (FUNCTION_CAST(HRESULT , (PROCESS_DPI_AWARENESS)) $a_api) ($a_level);
			]"
		end

	c_get_process_dpi_awareness	(a_api:POINTER; a_process: POINTER; a_value: TYPED_POINTER [INTEGER]): INTEGER
			-- Declated as HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS *value);
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <shellscalingapi.h>"
		alias
			"[
		
				return (FUNCTION_CAST(HRESULT , (HANDLE, PROCESS_DPI_AWARENESS * )) $a_api) ($a_process, $a_value);
			]"
		end

feature {NONE} -- Implementation

	api_loader: DYNAMIC_MODULE
			-- Module name.
		local
			l_utility: WEL_SCALING_UTILITY
		once
			create l_utility
			Result := l_utility.api_loader
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
