indexing
	description: "System Parameters and configuration settings informations."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_PARAMETERS_INFO

inherit
	WEL_SPI_CONSTANTS
		export
			{NONE} all
		end

feature -- Status

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
			is_windows_95: BOOLEAN
		do
			is_windows_95 := (create {WEL_WINDOWS_VERSION}).is_windows_95
			if not is_windows_95 or else has_windows_plus then
				success := c_system_parameters_info (Spi_getdragfullwindows, 1, $res, 0)
				if success then
					Result := res /= 0
				end
			end
		end

	has_windows_plus: BOOLEAN is
			-- Windows 95: Indicates whether the Windows extension,
			-- Windows Plus!, is installed. Set the uiParam parameter to 1.
			-- The pvParam parameter is not used. The function returns TRUE
			-- if the extension is installed, or FALSE if it is not.
		require
			is_windows_95: (create {WEL_WINDOWS_VERSION}).is_windows_95
		local
			success: BOOLEAN
			res: INTEGER
		do
			success := c_system_parameters_info (Spi_getwindowsextension, 1, $res, 0)
			if success then
				Result := res /= 0
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

feature {NONE} -- Externals

	c_system_parameters_info (action, param: INTEGER; p_param: POINTER; win_ini: INTEGER): BOOLEAN is
		external
			"C [macro <windows.h>]"
		alias
			"SystemParametersInfo"
		end

end -- class WEL_SYSTEM_PARAMETERS_INFO
