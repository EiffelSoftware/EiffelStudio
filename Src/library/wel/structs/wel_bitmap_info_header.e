indexing
	description: "Contains information about the dimensions and color %
		%format of a device-independent bitmap (DIB)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_INFO_HEADER

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
		do
			structure_make
			cwel_bitmapinfoheader_set_size (item, structure_size)
			set_width (0)
			set_height (0)
			set_planes (0)
			set_bit_count (0)
			set_compression (0)
			set_size_image (0)
			set_x_pels_per_meter (0)
			set_y_pels_per_meter (0)
			set_clr_used (0)
			set_clr_important (0)
		ensure
			width_set: width = 0
			height_set: height = 0
			planes_set: planes = 0
			bit_count_set: bit_count = 0
			compression_set: compression = 0
			size_image_set: size_image = 0
			x_pels_per_meter_set: x_pels_per_meter = 0
			y_pels_per_meter_set: y_pels_per_meter = 0
			clr_used_set: clr_used = 0
			clr_important_set: clr_important = 0
		end

feature -- Access

	width: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_width (item)
		end

	height: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_height (item)
		end

	planes: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_planes (item)
		end

	bit_count: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_bitcount (item)
		end

	compression: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_compression (item)
		end

	size_image: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_sizeimage (item)
		end

	x_pels_per_meter: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_xpelspermeter (item)
		end

	y_pels_per_meter: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_ypelspermeter (item)
		end

	clr_used: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_clrused (item)
		end

	clr_important: INTEGER is
		do
			Result := cwel_bitmapinfoheader_get_clrimportant (item)
		end

feature -- Element change

	set_width (a_width: INTEGER) is
		do
			cwel_bitmapinfoheader_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
		do
			cwel_bitmapinfoheader_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_planes (a_planes: INTEGER) is
		do
			cwel_bitmapinfoheader_set_planes (item, a_planes)
		ensure
			planes_set: planes = a_planes
		end

	set_bit_count (a_bit_count: INTEGER) is
		do
			cwel_bitmapinfoheader_set_bitcount (item, a_bit_count)
		ensure
			bit_count_set: bit_count = a_bit_count
		end

	set_compression (a_compression: INTEGER) is
		do
			cwel_bitmapinfoheader_set_compression (item,
				a_compression)
		ensure
			compression_set: compression = a_compression
		end

	set_size_image (a_size_image: INTEGER) is
		do
			cwel_bitmapinfoheader_set_sizeimage (item,
				a_size_image)
		ensure
			size_image_set: size_image = a_size_image
		end

	set_x_pels_per_meter (a_x_pels_per_meter: INTEGER) is
		do
			cwel_bitmapinfoheader_set_xpelspermeter (item,
				a_x_pels_per_meter)
		ensure
			x_pels_per_meter_set: x_pels_per_meter =
				a_x_pels_per_meter
		end

	set_y_pels_per_meter (a_y_pels_per_meter: INTEGER) is
		do
			cwel_bitmapinfoheader_set_ypelspermeter (item,
				a_y_pels_per_meter)
		ensure
			y_pels_per_meter_set: y_pels_per_meter =
				a_y_pels_per_meter
		end

	set_clr_used (a_clr_used: INTEGER) is
		do
			cwel_bitmapinfoheader_set_clrused (item, a_clr_used)
		ensure
			clr_used_set: clr_used = a_clr_used
		end

	set_clr_important (a_clr_important: INTEGER) is
		do
			cwel_bitmapinfoheader_set_clrimportant (item,
				a_clr_important)
		ensure
			clr_important_set: clr_important = a_clr_important
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_bitmapinfoheader
		end

feature {NONE} -- Externals

	c_size_of_bitmapinfoheader: INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		alias
			"sizeof (BITMAPINFOHEADER)"
		end

	cwel_bitmapinfoheader_set_size (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_height (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_planes (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_bitcount (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_compression (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_sizeimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_xpelspermeter (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_ypelspermeter (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_clrused (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_set_clrimportant (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_height (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_planes (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_bitcount (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_compression (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_sizeimage (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_xpelspermeter (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_ypelspermeter (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_clrused (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

	cwel_bitmapinfoheader_get_clrimportant (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpinfoh.h>]"
		end

end -- class WEL_BITMAP_INFO_HEADER


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

