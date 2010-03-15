note
	description: "Device technology (DT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEVICE_TECHNOLOGY_CONSTANTS

feature -- Access

	Dt_plotter: INTEGER
			-- Vector plotter
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_PLOTTER"
		end

	Dt_rasdisplay: INTEGER
			-- Raster display
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASDISPLAY"
		end

	Dt_rasprinter: INTEGER
			-- Raster printer
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASPRINTER"
		end

	Dt_rascamera: INTEGER
			-- Raster camera
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_RASCAMERA"
		end

	Dt_charstream: INTEGER
			-- Character stream
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_CHARSTREAM"
		end

	Dt_metafile: INTEGER
			-- Metafile
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_METAFILE"
		end

	Dt_dispfile: INTEGER
			-- Display file
		external
			"C [macro %"wel.h%"]"
		alias
			"DT_DISPFILE"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_DEVICE_TECHNOLOGY_CONSTANTS

