indexing
	description: "Contains information about the type, size, and layout %
		%of a file that contains a device-independent bitmap (DIB)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_FILE_HEADER

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
			set_type (0)
			set_size (0)
			set_reserved1 (0)
			set_reserved2 (0)
			set_off_bits (0)
		ensure
			type_set: type = 0
			size_set: size = 0
			reserved1_set: reserved1 = 0
			reserved2_set: reserved2 = 0
			off_bits_set: off_bits = 0
		end

feature -- Access

	type: INTEGER is
		do
			Result := cwel_bitmapfileheader_get_type (item)
		end

	size: INTEGER is
		do
			Result := cwel_bitmapfileheader_get_size (item)
		end

	reserved1: INTEGER is
		do
			Result := cwel_bitmapfileheader_get_reserved1 (item)
		end

	reserved2: INTEGER is
		do
			Result := cwel_bitmapfileheader_get_reserved2 (item)
		end

	off_bits: INTEGER is
		do
			Result := cwel_bitmapfileheader_get_off_bits (item)
		end

feature -- Element change

	set_type (a_type: INTEGER) is
		do
			cwel_bitmapfileheader_set_type (item, a_type)
		ensure
			type_set: type = a_type
		end

	set_size (a_size: INTEGER) is
		do
			cwel_bitmapfileheader_set_size (item, a_size)
		ensure
			size_set: size = a_size
		end

	set_reserved1 (a_reserved1: INTEGER) is
		do
			cwel_bitmapfileheader_set_reserved1 (item, a_reserved1)
		ensure
			reserved1_set: reserved1 = a_reserved1
		end

	set_reserved2 (a_reserved2: INTEGER) is
		do
			cwel_bitmapfileheader_set_reserved2 (item, a_reserved2)
		ensure
			reserved2_set: reserved2 = a_reserved2
		end

	set_off_bits (a_off_bits: INTEGER) is
		do
			cwel_bitmapfileheader_set_off_bits (item, a_off_bits)
		ensure
			off_bits_set: off_bits = a_off_bits
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_bitmapfileheader
		end

feature {NONE} -- Externals

	c_size_of_bitmapfileheader: INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		alias
			"sizeof (BITMAPFILEHEADER)"
		end

	cwel_bitmapfileheader_set_type (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_size (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_reserved1 (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_reserved2 (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_off_bits (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_type (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_size (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_reserved1 (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_reserved2 (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_off_bits (ptr: POINTER): INTEGER is
		external
			"C [macro <bmpfileh.h>]"
		end

end -- class WEL_BITMAP_FILE_HEADER


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

