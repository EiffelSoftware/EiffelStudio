indexing
	description: "Properties of a bitmap."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOG_BITMAP

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_bitmap

feature {NONE} -- Initialization

	make (a_width, a_height, a_width_bytes, a_planes,
		a_bits_pixel: INTEGER; a_bits: POINTER) is
		require
			positive_width: a_width >= 0
			positive_height: a_height >= 0
			positive_width_bytes: a_width_bytes >= 0
			positive_planes: a_planes >= 0
			positive_bits_pixel: a_bits_pixel >= 0
			count_width_bytes: (a_width_bytes \\ 2) = 0
		do
			structure_make
			set_type (0)
			set_width (a_width)
			set_height (a_height)
			set_width_bytes (a_width_bytes)
			set_planes (a_planes)
			set_bits_pixel (a_bits_pixel)
			set_bits (a_bits)
		ensure
			type_set: type = 0
			width_set: width = a_width
			height_set: height = a_height
			width_bytes_set: width_bytes = a_width_bytes
			planes_set: planes = a_planes
			bits_pixel_set: bits_pixel = a_bits_pixel
			bits_set: bits = a_bits
		end

	make_by_bitmap (bitmap: WEL_BITMAP) is
			-- Make a log bitmap using the information of `bitmap'.
		require
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
		do
			structure_make
			cwin_get_object (bitmap.item, structure_size, item)
		end

feature -- Access

	type: INTEGER is
			-- Bitmap type
		do
			Result := cwel_logbitmap_get_type (item)
		end

	width: INTEGER is
			-- Bitmap width
		do
			Result := cwel_logbitmap_get_width (item)
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER is
			-- Bitmap height
		do
			Result := cwel_logbitmap_get_height (item)
		ensure
			positive_result: Result >= 0
		end

	width_bytes: INTEGER is
			-- Bitmap width_bytes
		do
			Result := cwel_logbitmap_get_width_bytes (item)
		ensure
			positive_result: Result >= 0
		end

	planes: INTEGER is
			-- Bitmap planes
		do
			Result := cwel_logbitmap_get_planes (item)
		ensure
			positive_result: Result >= 0
		end

	bits_pixel: INTEGER is
			-- Bitmap bits_pixel
		do
			Result := cwel_logbitmap_get_bits_pixel (item)
		ensure
			positive_result: Result >= 0
		end

	bits: POINTER is
			-- Bitmap bits
		do
			result := cwel_logbitmap_get_bits (item)
		end

feature -- Element change

	set_type (a_type: INTEGER) is
			-- Set `type' with `a_type'
		do
			cwel_logbitmap_set_type (item, a_type)
		ensure
			set_type: type = a_type
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		require
			positive_width: a_width >= 0
		do
			cwel_logbitmap_set_width (item, a_width)
		ensure
			set_width: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		require
			positive_height: a_height >= 0
		do
			cwel_logbitmap_set_height (item, a_height)
		ensure
			set_height: height = a_height
		end

	set_width_bytes (a_width_bytes: INTEGER) is
			-- Set `width_bytes' with `a_width_bytes'
		require
			positive_width_bytes: a_width_bytes >= 0
		do
			cwel_logbitmap_set_width_bytes (item, a_width_bytes)
		ensure
			set_width_bytes: width_bytes = a_width_bytes
		end

	set_planes (a_planes: INTEGER) is
			-- Set `planes' with `a_planes'
		require
			positive_planes: a_planes >= 0
		do
			cwel_logbitmap_set_planes (item, a_planes)
		ensure
			set_planes: planes = a_planes
		end

	set_bits_pixel (a_bits_pixel: INTEGER) is
			-- Set `bits_pixel' with `a_bits_pixel'
		require
			positive_bits_pixel: a_bits_pixel >= 0
		do
			cwel_logbitmap_set_bits_pixel (item, a_bits_pixel)
		ensure
			set_bits_pixel: bits_pixel = a_bits_pixel
		end

	set_bits (a_bits: POINTER) is
			-- Set `bits' with `a_bits'
		do
			cwel_logbitmap_set_bits (item, a_bits)
		ensure
			set_bits: bits = a_bits
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_logbitmap
		end

feature {NONE} -- Externals

	c_size_of_logbitmap: INTEGER is
		external
			"C [macro <logbmp.h>]"
		alias
			"sizeof (BITMAP)"
		end

	cwel_logbitmap_get_type (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_height (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_width_bytes (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_planes (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_bits_pixel (ptr: POINTER): INTEGER is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_get_bits (ptr: POINTER): POINTER is
		external
			"C [macro <logbmp.h>] : EIF_POINTER"
		end

	cwel_logbitmap_set_type (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_height (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_width_bytes (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_planes (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_bits_pixel (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwel_logbitmap_set_bits (ptr: POINTER; value: POINTER) is
		external
			"C [macro <logbmp.h>]"
		end

	cwin_get_object (hgdi_object: POINTER; buffer_size: INTEGER;
			object: POINTER) is
		external
			"C [macro <wel.h>] (HGDIOBJ, int, LPVOID)"
		alias
			"GetObject"
		end

end -- class WEL_LOG_BITMAP


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

