indexing
	description: "Device technology (DT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEVICE_TECHNOLOGY_CONSTANTS

feature -- Access

	Dt_plotter: INTEGER is
			-- Vector plotter
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_PLOTTER"
		end

	Dt_rasdisplay: INTEGER is
			-- Raster display
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASDISPLAY"
		end

	Dt_rasprinter: INTEGER is
			-- Raster printer
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASPRINTER"
		end

	Dt_rascamera: INTEGER is
			-- Raster camera
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASCAMERA"
		end

	Dt_charstream: INTEGER is
			-- Character stream
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_CHARSTREAM"
		end

	Dt_metafile: INTEGER is
			-- Metafile
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_METAFILE"
		end

	Dt_dispfile: INTEGER is
			-- Display file
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_DISPFILE"
		end

end -- class WEL_DEVICE_TECHNOLOGY_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

