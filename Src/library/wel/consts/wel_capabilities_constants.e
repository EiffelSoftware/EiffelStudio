indexing
	description: "Device-specific capabilities constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CAPABILITIES_CONSTANTS

feature -- Access

	driver_version: INTEGER is
			-- Version number of the device driver
		external
			"C [macro %"wel.h%"]"
		alias
			"DRIVERVERSION"
		end

	technology: INTEGER is
			-- Device technology.
			-- See class WEL_DEVICE_TECHNOLOGY_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"TECHNOLOGY"
		end

	horizontal_size: INTEGER is
			-- Width of the physical display in millimeters
		external
			"C [macro %"wel.h%"]"
		alias
			"HORZSIZE"
		end

	vertical_size: INTEGER is
			-- Height of the physical display in millimeters
		external
			"C [macro %"wel.h%"]"
		alias
			"VERTSIZE"
		end

	horizontal_resolution: INTEGER is
			-- Width of the display, in pixels
		external
			"C [macro %"wel.h%"]"
		alias
			"HORZRES"
		end

	vertical_resolution: INTEGER is
			-- Height of the display, in raster lines
		external
			"C [macro %"wel.h%"]"
		alias
			"VERTRES"
		end

	logical_pixels_x: INTEGER is
			-- Number of pixels per logical inch along
			-- the display width
		external
			"C [macro %"wel.h%"]"
		alias
			"LOGPIXELSX"
		end

	logical_pixels_y: INTEGER is
			-- Number of pixels per logical inch along
			-- the display height
		external
			"C [macro %"wel.h%"]"
		alias
			"LOGPIXELSY"
		end

	bits_pixel: INTEGER is
			-- Number of adjacent color bits for each pixel
		external
			"C [macro %"wel.h%"]"
		alias
			"BITSPIXEL"
		end

	planes: INTEGER is
			-- Number of color planes
		external
			"C [macro %"wel.h%"]"
		alias
			"PLANES"
		end

	num_brushes: INTEGER is
			-- Number of device-specific brushes
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMBRUSHES"
		end

	num_pens: INTEGER is
			-- Number of device-specific pens
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMPENS"
		end

	num_markers: INTEGER is
			-- Number of device-specific markers
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMMARKERS"
		end

	num_fonts: INTEGER is
			-- Number of device-specific fonts
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMFONTS"
		end

	num_colors: INTEGER is
			-- Number of entries in the device's color table
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMCOLORS"
		end

	aspect_x: INTEGER is
			-- Relative width of a device pixel
			-- used for line drawing
		external
			"C [macro %"wel.h%"]"
		alias
			"ASPECTX"
		end

	aspect_y: INTEGER is
			-- Relative height of a device pixel
			-- used for line drawing
		external
			"C [macro %"wel.h%"]"
		alias
			"ASPECTY"
		end

	aspect_x_y: INTEGER is
			-- Diagonal width of a device pixel
			-- used for line drawing
		external
			"C [macro %"wel.h%"]"
		alias
			"ASPECTXY"
		end

	pdevice_size: INTEGER is
			-- Size of the PDEVICE internal structure, in bytes
		external
			"C [macro %"wel.h%"]"
		alias
			"PDEVICESIZE"
		end

	clip_caps: INTEGER is
			-- See class WEL_CLIPPING_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"CLIPCAPS"
		end

	size_palette: INTEGER is
			-- Number of entries in the system palette
		external
			"C [macro %"wel.h%"]"
		alias
			"SIZEPALETTE"
		end

	num_reserved: INTEGER is
			-- Number of reserved entries in the system palette
		external
			"C [macro %"wel.h%"]"
		alias
			"NUMRESERVED"
		end

	color_resolution: INTEGER is
			-- Color resolution of the device in bits
		external
			"C [macro %"wel.h%"]"
		alias
			"COLORRES"
		end

	raster_caps: INTEGER is
			-- See class WEL_RASTER_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"RASTERCAPS"
		end

	curve_caps: INTEGER is
			-- See class WEL_CURVE_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"CURVECAPS"
		end

	line_caps: INTEGER is
			-- See class WEL_LINE_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"LINECAPS"
		end

	polygonal_caps: INTEGER is
			-- See class WEL_POLYGONAL_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"POLYGONALCAPS"
		end

	text_caps: INTEGER is
			-- See class WEL_TEXT_CAPABILITIES_CONSTANTS
		external
			"C [macro %"wel.h%"]"
		alias
			"TEXTCAPS"
		end

end -- class WEL_CAPABILITIES_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

