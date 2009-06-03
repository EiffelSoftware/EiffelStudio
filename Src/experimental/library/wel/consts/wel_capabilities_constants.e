note
	description: "Device-specific capabilities constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CAPABILITIES_CONSTANTS

feature -- Access

	driver_version: INTEGER = 1
			-- Version number of the device driver

	technology: INTEGER = 2
			-- Device technology.
			-- See class WEL_DEVICE_TECHNOLOGY_CONSTANTS

	horizontal_size: INTEGER = 4
			-- Width of the physical display in millimeters

	vertical_size: INTEGER = 6
			-- Height of the physical display in millimeters

	horizontal_resolution: INTEGER = 8
			-- Width of the display, in pixels

	vertical_resolution: INTEGER = 10
			-- Height of the display, in raster lines

	logical_pixels_x: INTEGER = 88
			-- Number of pixels per logical inch along
			-- the display width

	logical_pixels_y: INTEGER = 90
			-- Number of pixels per logical inch along
			-- the display height

	bits_pixel: INTEGER = 12
			-- Number of adjacent color bits for each pixel

	planes: INTEGER = 14
			-- Number of color planes

	num_brushes: INTEGER = 16
			-- Number of device-specific brushes

	num_pens: INTEGER = 18
			-- Number of device-specific pens

	num_markers: INTEGER = 20
			-- Number of device-specific markers

	num_fonts: INTEGER = 22
			-- Number of device-specific fonts

	num_colors: INTEGER = 24
			-- Number of entries in the device's color table

	aspect_x: INTEGER = 40
			-- Relative width of a device pixel
			-- used for line drawing

	aspect_y: INTEGER = 42
			-- Relative height of a device pixel
			-- used for line drawing

	aspect_x_y: INTEGER = 44
			-- Diagonal width of a device pixel
			-- used for line drawing

	pdevice_size: INTEGER = 26
			-- Size of the PDEVICE internal structure, in bytes

	clip_caps: INTEGER = 36
			-- See class WEL_CLIPPING_CAPABILITIES_CONSTANTS

	size_palette: INTEGER = 104
			-- Number of entries in the system palette

	num_reserved: INTEGER = 106
			-- Number of reserved entries in the system palette

	color_resolution: INTEGER = 108
			-- Color resolution of the device in bits

	physical_offset_x: INTEGER = 112
		-- Distance from left edge of the printable area, in
		-- device units.

	physical_offset_y: INTEGER = 113
		-- Distance from top edge of the printable area, in
		-- device units.

	scaling_factor_x: INTEGER = 114
			-- Scaling factor for the x-axis of the printer.
	
	scaling_factor_y: INTEGER = 115
			-- Scaling factor for the y-axis of the printer.

	raster_caps: INTEGER = 38
			-- See class WEL_RASTER_CAPABILITIES_CONSTANTS

	curve_caps: INTEGER = 28
			-- See class WEL_CURVE_CAPABILITIES_CONSTANTS

	line_caps: INTEGER = 30
			-- See class WEL_LINE_CAPABILITIES_CONSTANTS

	polygonal_caps: INTEGER = 32
			-- See class WEL_POLYGONAL_CAPABILITIES_CONSTANTS

	text_caps: INTEGER = 34;
			-- See class WEL_TEXT_CAPABILITIES_CONSTANTS

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




end -- class WEL_CAPABILITIES_CONSTANTS

