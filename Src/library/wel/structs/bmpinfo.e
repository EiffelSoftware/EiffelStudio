indexing
	description: "Defines the dimensions and color information for a %
		%Windows device-independent bitmap (DIB)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_bitmap_info_header: WEL_BITMAP_INFO_HEADER;
			a_num_rgb_quad: INTEGER) is
			-- Make a BITMAPINFO structure
			-- with `a_bitmap_info_header'
		require
			a_bitmap_info_header_not_void: a_bitmap_info_header
				/= Void
		do
			structure_make
			private_num_rgb_quad := a_num_rgb_quad
			set_bitmap_info_header (a_bitmap_info_header)
		ensure
			bitmap_info_header_set: bitmap_info_header =
				a_bitmap_info_header
		end

feature -- Access

	bitmap_info_header: WEL_BITMAP_INFO_HEADER is
		do
			!! Result.make_by_pointer (
				cwel_bitmap_info_get_bitmap_info_header (item))
		end

	rgb_quad (index: INTEGER): WEL_RGB_QUAD is
		require
			positive_index: index > 0
		do
			!! Result.make
			Result.memory_copy (
				cwel_bitmap_info_get_rgb_quad (item, index), 
				c_size_of_rgb_quad)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_bitmap_info_header (a_bitmap_info_header: WEL_BITMAP_INFO_HEADER) is
		require
			a_bitmap_info_header_not_void: a_bitmap_info_header /= Void
		do
			memory_copy (a_bitmap_info_header.item, structure_size)
		ensure
			bitmap_info_header_set: bitmap_info_header =
				a_bitmap_info_header
		end

	set_rgb_quad (index: INTEGER; a_rgb_quad: WEL_RGB_QUAD) is
		require
			a_rgb_quad_not_void: a_rgb_quad /= Void
		do
			cwel_bitmap_info_set_rgb_quad_rgb_red (item, index,
				a_rgb_quad.red)
			cwel_bitmap_info_set_rgb_quad_rgb_green (item, index,
				a_rgb_quad.green)
			cwel_bitmap_info_set_rgb_quad_rgb_blue (item, index,
				a_rgb_quad.blue)
			cwel_bitmap_info_set_rgb_quad_rgb_reserved (item,
				index, a_rgb_quad.reserved)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_bitmap_info +
				(private_num_rgb_quad * c_size_of_rgb_quad)
		end

feature {NONE} -- Implementation

	private_num_rgb_quad: INTEGER
			-- Number of entries used to allocate the memory

feature {NONE} -- Externals

	c_size_of_bitmap_info: INTEGER is
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (BITMAPINFO)"
		end

	c_size_of_rgb_quad: INTEGER is
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (RGBQUAD)"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_red (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_green (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_blue (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_reserved (ptr: POINTER; index,
			value: INTEGER) is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_get_bitmap_info_header (ptr: POINTER): POINTER is
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_get_rgb_quad (ptr: POINTER; i: INTEGER): POINTER is
		external
			"C [macro <bmpinfo.h>]"
		end

end -- class WEL_BITMAP_INFO

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
