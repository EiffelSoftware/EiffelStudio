indexing
	description: "Device independent bitmap which can be created %
		%from a file."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIB

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		redefine
			structure_size
		end

creation
	make_by_file

feature {NONE} -- Initialization

	make_by_file (file: RAW_FILE) is
			-- Create the dib by reading `file'.
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_opened: file.is_open_read
		local
			bitmap_file_header: WEL_BITMAP_FILE_HEADER						
			s: STRING
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			!! bitmap_file_header.make
			!! info_header.make
			file.read_stream (bitmap_file_header.structure_size)
			s := file.last_string
			!! a_wel_string1.make (s)
			bitmap_file_header.memory_copy (a_wel_string1.item,
				bitmap_file_header.structure_size)
			structure_size := bitmap_file_header.size
			structure_make
			file.read_stream (structure_size)
			s := file.last_string
			!! a_wel_string2.make (s)
			memory_copy (a_wel_string2.item, structure_size)
			info_header.memory_copy (item, info_header.structure_size)
			calculate_palette
			file.close
		ensure
			file_closed: file.is_closed
		end

feature -- Access

	color_count: INTEGER is
			-- How many colors in the dib?
		require
			exists: exists
		do
			if info_header.structure_size >= 36 then
				Result := info_header.clr_used
			end
			if Result = 0 and then info_header.bit_count /= 24 then
				Result := (2 ^ info_header.bit_count).truncated_to_integer
			end
		ensure
			positive_result: Result >= 0
		end

	width: INTEGER is
			-- Dib width
		require
			exists: exists
		do
			Result := info_header.width
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER is
			-- Dib height
		require
			exists: exists
		do
			Result := info_header.height
		ensure
			positive_result: Result >= 0
		end


	item_bits: POINTER is
		require
			exists: exists
		do
			Result := cwel_integer_to_pointer (
				cwel_pointer_to_integer(item) +
				info_header.structure_size + color_count *
				rgb_quad_size)
		end

	palette: WEL_PALETTE
			-- Dib palette

feature -- Basic operations

	set_pal_color is
			-- Transform the dib to be compatible with
			-- `Dib_pal_colors' mode.
		require
			exists: exists
		local
			i: INTEGER
			num_color: INTEGER
		do
			num_color := color_count
			from
				i := 0
			until
				i = num_color
			loop
				c_memcpy (cwel_integer_to_pointer (
					cwel_pointer_to_integer (item) +
					info_header.structure_size + i *
					rgb_quad_size // 2), $i, 1)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	structure_size: INTEGER

	i_th_quad (i: INTEGER): WEL_RGB_QUAD is
		require
			exists: exists
			positive_i: i >= 0
			i_small_enough: i < color_count
		do
			!! Result.make
			Result.memory_copy (cwel_integer_to_pointer (
				cwel_pointer_to_integer(item) + 
				info_header.structure_size + i * rgb_quad_size),
				rgb_quad_size)
		ensure
			result_not_void: Result /= Void
		end

	calculate_palette is
		require
			exists: exists
		local
			ind: INTEGER
			pal_entry: WEL_PALETTE_ENTRY
			log_pal: WEL_LOG_PALETTE
			rgb_quad: WEL_RGB_QUAD
			num_color: INTEGER
		do
			num_color := color_count
			!! log_pal.make (768, num_color)
			--| 768 is the Windows version (0x300)
			from
				ind := 0
			until
				ind = num_color
			loop
				rgb_quad := i_th_quad (ind)	
				!! pal_entry.make (rgb_quad.red, rgb_quad.green,
							rgb_quad.blue, 0)
				log_pal.set_pal_entry (ind, pal_entry)
				ind := ind + 1
			end
			!! palette.make (log_pal)	
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
		end

	rgb_quad_size: INTEGER is
		local
			rgb: WEL_RGB_QUAD
		once
			!! rgb.make
			Result := rgb.structure_size
		ensure
			positive_result: Result >= 0
		end

feature {WEL_BITMAP}

	info_header: WEL_BITMAP_INFO_HEADER

end -- class WEL_DIB

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
