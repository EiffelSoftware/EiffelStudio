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

end -- class WEL_SYSTEM_PARAMETERS_INFO


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

