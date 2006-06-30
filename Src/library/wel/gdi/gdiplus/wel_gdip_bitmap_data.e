indexing
	description: "Bitmap data strcuct used by GDI+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_BITMAP_DATA

create
	make,
	make_from_pointer

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create internal_item.make (structure_size)
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Create Current with `a_pointer'
		do
			create internal_item.make_from_pointer (a_pointer, structure_size)
		end

feature -- Command

	set_width (a_width: like width) is
			-- Set `width' with `a_width'
		do
			c_set_width (item, a_width)
		ensure
			set: width = a_width
		end

	set_height (a_height: like height) is
			-- Set `height' with `a_height'
		do
			c_set_height (item, a_height)
		ensure
			set: height = a_height
		end

	set_stride (a_stride: like stride) is
			-- Set `stride' with `a_stride'
		do
			c_set_stride (item, a_stride)
		ensure
			set: stride = a_stride
		end

	set_pixel_format (a_pixel_format: like pixel_format) is
			-- Set `pixel_format' with `a_pixel_format'
		do
			c_set_pixel_format (item, a_pixel_format)
		ensure
			set: pixel_format = a_pixel_format
		end

	set_scan_0 (a_scan_0: like scan_0) is
			-- Set `scan_0' with `a_pointer'
		do
			c_set_san_0 (item, a_scan_0)
		ensure
			set: scan_0 = a_scan_0
		end

	set_reserved (a_reserved: like reserved) is
			-- Set `reserved' with `reserved'
		do
			c_set_reserved (item, a_reserved)
		ensure
			set: reserved = a_reserved
		end

feature -- Query

	structure_size: INTEGER is
			-- Size of Current strucutre.
		do
			Result := c_size_of_bitmap_data
		end

	width: NATURAL_32 is
			-- Width
		do
			Result := c_width (item)
		end

	height: NATURAL_32 is
			-- Height
		do
			Result := c_height (item)
		end

	stride: INTEGER is
			-- Stride
		do
			Result := c_stride (item)
		end

	pixel_format: INTEGER is
			-- Pixel format.
		do
			Result := c_pixel_format (item)
		end

	scan_0: POINTER is
			-- Image data memory position.
		do
			Result := c_scan_0 (item)
		end

	reserved: NATURAL_32 is
			-- Reserved
		do
			Result := c_reserved (item)
		end

	item: POINTER is
			-- Pointer to C struct
		do
			Result := internal_item.item
		ensure
			not_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- Managed pointer to the struct.

feature {NONE} -- C externals

	c_size_of_bitmap_data: INTEGER is
			-- BitmapData struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (BitmapData)"
		end

	c_set_width (a_item: POINTER; a_width: NATURAL_32) is
			-- Set `a_item''s width with `a_width'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->Width = (EIF_NATURAL_32)$a_width;
			}
			]"
		end

	c_set_height (a_item: POINTER; a_height: NATURAL_32) is
			-- Set `a_item''s height with `a_height'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->Height = (EIF_NATURAL_32)$a_height;
			}
			]"
		end

	c_set_stride (a_item: POINTER; a_stride: INTEGER) is
			-- Set `a_item''s stride with `a_stride'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->Stride = (EIF_INTEGER)$a_stride;
			}
			]"
		end

	c_set_pixel_format (a_item: POINTER; a_pixel_format: INTEGER) is
			-- Set `a_item''s pixel_format with `a_pixel_format'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->PixelFormat = (EIF_INTEGER)$a_pixel_format;
			}
			]"
		end

	c_set_san_0 (a_item: POINTER; a_scan_0: POINTER) is
			-- Set `a_item''s scan0 with `a_scan_0'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->Scan0 = (EIF_POINTER)$a_scan_0;
			}
			]"
		end

	c_set_reserved (a_item: POINTER; a_reserved: NATURAL_32) is
			-- Set `a_item''s reserved with `a_reserved'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((BitmapData *)$a_item)->Reserved = (EIF_NATURAL_32)$a_reserved;
			}
			]"
		end

	c_width (a_item: POINTER): NATURAL_32 is
			-- Width of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->Width
			]"
		end

	c_height (a_item: POINTER): NATURAL_32 is
			-- Height of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->Height
			]"
		end

	c_stride (a_item: POINTER): INTEGER is
			-- Stride of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->Stride
			]"
		end

	c_pixel_format (a_item: POINTER): INTEGER is
			-- PixelFormat of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->PixelFormat
			]"
		end

	c_scan_0 (a_item: POINTER): POINTER is
			-- Scan0 of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->Scan0
			]"
		end

	c_reserved (a_item: POINTER): NATURAL_32 is
			-- Reserved of `a_item'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((BitmapData *)$a_item)->Reserved
			]"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
