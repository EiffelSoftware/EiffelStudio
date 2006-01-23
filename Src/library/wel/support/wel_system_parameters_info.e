indexing
	description: "System Parameters and configuration settings informations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_PARAMETERS_INFO

inherit
	ANY

	WEL_SPI_CONSTANTS
		export
			{NONE} all
		end
	
	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end

feature -- Status

	has_flat_menu: BOOLEAN is
			-- Determines whether native User menus have flat menu appearance
		local
			res: INTEGER
			success: BOOLEAN
		do
			if is_windows_xp_compatible then
				success := c_system_parameters_info (Spi_getflatmenu, 0, $res, 0)
				if success then
					Result := res /= 0
				end
			end
		end

	has_drag_full_windows: BOOLEAN is
			-- Determines whether dragging of full windows is enabled.
			-- The pvParam parameter must point to a BOOL variable that
			-- receives TRUE if enabled, or FALSE otherwise.
			-- 
			-- Windows 95: This flag is supported only if Windows Plus!
			-- is installed. See SPI_GETWINDOWSEXTENSION.
		local
			res: INTEGER
			success: BOOLEAN
		do
			if not is_windows_95 or else has_windows95_plus then
				success := c_system_parameters_info (Spi_getdragfullwindows, 1, $res, 0)
				if success then
					Result := res /= 0
				end
			end
		end

	has_windows95_plus: BOOLEAN is
			-- Windows 95 only: Indicates whether the Windows extension,
			-- Windows Plus!, is installed. Set the uiParam parameter to 1.
			-- The pvParam parameter is not used. The function returns TRUE
			-- if the extension is installed, or FALSE if it is not.
		local
			success: BOOLEAN
			res: INTEGER
		do
			if is_windows_95 then
				success := c_system_parameters_info (Spi_getwindowsextension, 1, $res, 0)
				if success then
					Result := res /= 0
				end
			end
		end

	get_non_client_metrics: WEL_NON_CLIENT_METRICS is
			-- Retrieves the metrics associated with the nonclient area of
			-- nonminimized windows. 
			--
			-- Void if an error occurred.
		local
			success: BOOLEAN
		do
			create Result.make
			success := c_system_parameters_info (
				Spi_getnonclientmetrics, 
				Result.structure_size, 
				Result.item, 
				0)
			if not success then
				Result := Void
			end
		end
		
	get_wheel_scroll_lines: INTEGER is
			-- Retrieves the number of lines that will be scrolled when the mouse wheel is rotated.
		local
			success: BOOLEAN
		do
			success := c_system_parameters_info (Spi_getwheelscrolllines, 0, $Result, 0)
		end

feature -- Obsolete

	has_windows_plus: BOOLEAN is
			-- Windows 95 only: Indicates whether the Windows extension,
			-- Windows Plus!, is installed. Set the uiParam parameter to 1.
			-- The pvParam parameter is not used. The function returns TRUE
			-- if the extension is installed, or FALSE if it is not.
		obsolete "Use `has_windows95_plus' instead"
		do
			Result := has_windows95_plus
		end

feature {NONE} -- Externals

	c_system_parameters_info (action, param: INTEGER; p_param: POINTER; win_ini: INTEGER): BOOLEAN is
		external
			"C [macro <windows.h>]"
		alias
			"SystemParametersInfo"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SYSTEM_PARAMETERS_INFO

