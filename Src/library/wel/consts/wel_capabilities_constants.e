indexing
	description: "Device-specific capabilities constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CAPABILITIES_CONSTANTS

feature -- Access

	driver_version: INTEGER is 1
			-- Version number of the device driver

	technology: INTEGER is 2
			-- Device technology.
			-- See class WEL_DEVICE_TECHNOLOGY_CONSTANTS

	horizontal_size: INTEGER is 4
			-- Width of the physical display in millimeters

	vertical_size: INTEGER is 6
			-- Height of the physical display in millimeters

	horizontal_resolution: INTEGER is 8
			-- Width of the display, in pixels

	vertical_resolution: INTEGER is 10
			-- Height of the display, in raster lines

	logical_pixels_x: INTEGER is 88
			-- Number of pixels per logical inch along
			-- the display width

	logical_pixels_y: INTEGER is 90
			-- Number of pixels per logical inch along
			-- the display height

	bits_pixel: INTEGER is 12
			-- Number of adjacent color bits for each pixel

	planes: INTEGER is 14
			-- Number of color planes

	num_brushes: INTEGER is 16
			-- Number of device-specific brushes

	num_pens: INTEGER is 18
			-- Number of device-specific pens

	num_markers: INTEGER is 20
			-- Number of device-specific markers

	num_fonts: INTEGER is 22
			-- Number of device-specific fonts

	num_colors: INTEGER is 24
			-- Number of entries in the device's color table

	aspect_x: INTEGER is 40
			-- Relative width of a device pixel
			-- used for line drawing

	aspect_y: INTEGER is 42
			-- Relative height of a device pixel
			-- used for line drawing

	aspect_x_y: INTEGER is 44
			-- Diagonal width of a device pixel
			-- used for line drawing

	pdevice_size: INTEGER is 26
			-- Size of the PDEVICE internal structure, in bytes

	clip_caps: INTEGER is 36
			-- See class WEL_CLIPPING_CAPABILITIES_CONSTANTS

	size_palette: INTEGER is 104
			-- Number of entries in the system palette

	num_reserved: INTEGER is 106
			-- Number of reserved entries in the system palette

	color_resolution: INTEGER is 108
			-- Color resolution of the device in bits

	physical_offset_x: INTEGER is 112
		-- Distance from left edge of the printable area, in
		-- device units.

	physical_offset_y: INTEGER is 113
		-- Distance from top edge of the printable area, in
		-- device units.

	scaling_factor_x: INTEGER is 114
			-- Scaling factor for the x-axis of the printer.
	
	scaling_factor_y: INTEGER is 115
			-- Scaling factor for the y-axis of the printer.

	raster_caps: INTEGER is 38
			-- See class WEL_RASTER_CAPABILITIES_CONSTANTS

	curve_caps: INTEGER is 28
			-- See class WEL_CURVE_CAPABILITIES_CONSTANTS

	line_caps: INTEGER is 30
			-- See class WEL_LINE_CAPABILITIES_CONSTANTS

	polygonal_caps: INTEGER is 32
			-- See class WEL_POLYGONAL_CAPABILITIES_CONSTANTS

	text_caps: INTEGER is 34
			-- See class WEL_TEXT_CAPABILITIES_CONSTANTS

end -- class WEL_CAPABILITIES_CONSTANTS


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

