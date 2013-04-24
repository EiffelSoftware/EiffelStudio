note
	description: "Contains information about the type, size, and layout %
		%of a file that contains a device-independent bitmap (DIB)."
	legal: "See notice at end of class."
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
create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
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

	type: INTEGER
		do
			Result := cwel_bitmapfileheader_get_type (item)
		end

	size: INTEGER
		do
			Result := cwel_bitmapfileheader_get_size (item)
		end

	reserved1: INTEGER
		do
			Result := cwel_bitmapfileheader_get_reserved1 (item)
		end

	reserved2: INTEGER
		do
			Result := cwel_bitmapfileheader_get_reserved2 (item)
		end

	off_bits: INTEGER
		do
			Result := cwel_bitmapfileheader_get_off_bits (item)
		end

feature -- Element change

	set_type (a_type: INTEGER)
		do
			cwel_bitmapfileheader_set_type (item, a_type)
		ensure
			type_set: type = a_type
		end

	set_size (a_size: INTEGER)
		do
			cwel_bitmapfileheader_set_size (item, a_size)
		ensure
			size_set: size = a_size
		end

	set_reserved1 (a_reserved1: INTEGER)
		do
			cwel_bitmapfileheader_set_reserved1 (item, a_reserved1)
		ensure
			reserved1_set: reserved1 = a_reserved1
		end

	set_reserved2 (a_reserved2: INTEGER)
		do
			cwel_bitmapfileheader_set_reserved2 (item, a_reserved2)
		ensure
			reserved2_set: reserved2 = a_reserved2
		end

	set_off_bits (a_off_bits: INTEGER)
		do
			cwel_bitmapfileheader_set_off_bits (item, a_off_bits)
		ensure
			off_bits_set: off_bits = a_off_bits
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_bitmapfileheader
		end

feature {NONE} -- Externals

	c_size_of_bitmapfileheader: INTEGER
		external
			"C [macro <bmpfileh.h>]"
		alias
			"sizeof (BITMAPFILEHEADER)"
		end

	cwel_bitmapfileheader_set_type (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_size (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_reserved1 (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_reserved2 (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_set_off_bits (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_type (ptr: POINTER): INTEGER
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_size (ptr: POINTER): INTEGER
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_reserved1 (ptr: POINTER): INTEGER
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_reserved2 (ptr: POINTER): INTEGER
		external
			"C [macro <bmpfileh.h>]"
		end

	cwel_bitmapfileheader_get_off_bits (ptr: POINTER): INTEGER
		external
			"C [macro <bmpfileh.h>]"
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

end
