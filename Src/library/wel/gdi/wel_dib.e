indexing
	description: "Device independent bitmap which can be created %
		%from a file."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "Not all variants of the bmp format can be read. If you have%
			%problems with a certain image please use i.e. MS Paint to convert%
			%the image to the standard bmp format and then try again."

class
	WEL_DIB

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		redefine
			structure_size,
			destroy_item
		end

	WEL_OBJECT_ID_MANAGER

creation
	make_by_file,
	make_by_content_pointer

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
			create bitmap_file_header.make
			create info_header.make
			file.read_stream (bitmap_file_header.structure_size)
			s := file.last_string
			create a_wel_string1.make (s)
			bitmap_file_header.memory_copy (a_wel_string1.item,
				bitmap_file_header.structure_size)
			structure_size := bitmap_file_header.size - bitmap_file_header.structure_size
			structure_make
			file.read_stream (structure_size)
			s := file.last_string
			create a_wel_string2.make (s)
					--| !!FIXME!!
					--| In the next line, we should use `structure_size' that is
					--| the size read in the header of the bitmap, instead
					--| of `s.count' that is the size of the bitmap actually 
					--| read directly on the disk.
					--| BUT it seems that `structure_size' can have a wrong
					--| value, leading to a `segmentation violation'.
			memory_copy (a_wel_string2.item, s.count)
			info_header.memory_copy (item, info_header.structure_size)
			calculate_palette
			file.close
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
			file_closed: file.is_closed
		end

	make_by_content_pointer (bits_ptr: POINTER; size: INTEGER) is
		do
			create info_header.make

			structure_size := size
			structure_make

			memory_copy (bits_ptr, structure_size)
			info_header.memory_copy (item, info_header.structure_size)
			calculate_palette
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
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
			-- Dib palette.
			--
			-- You can track the references of `palette' if you want to
			-- free the GDI object contained in `palette' more quickly.

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

feature {NONE} -- Removal

	destroy_item is
			-- Free all GDI resource allocated by Current.
			-- Should be called by the GC or by the user if i
		local
			internal_palette: like palette
		do
			internal_palette ?= eif_id_object (object_id_palette)
			if internal_palette /= Void and then internal_palette.reference_tracked then
				internal_palette.decrement_reference
			end
			Precursor
		end

feature {NONE} -- Implementation
	
	object_id_palette: INTEGER
			-- Object id of `palette'.

	structure_size: INTEGER
			-- Size of the C structure representing `Current'.

	i_th_quad (i: INTEGER): WEL_RGB_QUAD is
		require
			exists: exists
			positive_i: i >= 0
			i_small_enough: i < color_count
		do
			create Result.make
			Result.memory_copy (cwel_integer_to_pointer (
				cwel_pointer_to_integer(item) + 
				info_header.structure_size + i * rgb_quad_size),
				rgb_quad_size)
		ensure
			result_not_void: Result /= Void
		end

	calculate_palette is
			-- Calculates pallete for images regardless of their colordepth
		require
			exists: exists
		local
			num_color: INTEGER
		do
			num_color := color_count
			if
				num_color /= 0
			then
				calculate_palette_all_but_24_bits
			elseif
				has_24_bits
			then
				calculate_palette_24_bits
			else
				-- Dead end! This code must never be reached
				check
					dead_end: False
				end
			end
			object_id_palette := palette.object_id
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
		end

	calculate_palette_all_but_24_bits is
			-- Calculates pallete for images with all colordepths except 24 bits
		require
			exists: exists
			has_not_24_bits: not has_24_bits

		local
			ind: INTEGER
			pal_entry: WEL_PALETTE_ENTRY
			log_pal: WEL_LOG_PALETTE
			rgb_quad: WEL_RGB_QUAD
			num_color: INTEGER
		do
			num_color := color_count
			create log_pal.make (768, num_color)
			--| 768 is the Windows version (0x300)
			from
				ind := 0
			until
				ind = num_color
			loop
				rgb_quad := i_th_quad (ind)	
				create pal_entry.make (rgb_quad.red, rgb_quad.green,
							rgb_quad.blue, 0)
				log_pal.set_pal_entry (ind, pal_entry)
				ind := ind + 1
			end
			create palette.make (log_pal)
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
		end
		
	calculate_palette_24_bits is
			-- Calculates pallete for images with a colordepth of 24 bits
         -- A 24 bitcount DIB has no color table entries so, set the number of
         -- to the maximum value (max_palette).
		require
			exists: exists
			has_24_bits: has_24_bits
		local
			ind, red, green, blue: INTEGER
			pal_entry: WEL_PALETTE_ENTRY
			log_pal: WEL_LOG_PALETTE
		do
			create log_pal.make (768, max_palette)
			from
				ind := 0
			until
				ind = max_palette
			loop
				create pal_entry.make (red, green, blue, 0)
				log_pal.set_pal_entry (ind, pal_entry)


				red := red + 32
				if
					red = 256
				then
					red := 0
					green := green + 32
					if
						green = 256
					then
						green := 0
						blue := blue + 64
						if
							blue = 256
						then
							blue := 0
						end
					end
				end
				
				ind := ind + 1
			end
			create palette.make (log_pal)	
		ensure
			palette_not_void: palette /= Void
			palette_exists: palette.exists
		end

	has_24_bits: BOOLEAN is
		require
			exists: exists
		do
			Result := info_header.bit_count = 24		
		end

	max_palette: INTEGER is 256

	rgb_quad_size: INTEGER is
		local
			rgb: WEL_RGB_QUAD
		once
			create rgb.make
			Result := rgb.structure_size
		ensure
			positive_result: Result >= 0
		end

feature {WEL_BITMAP}

	info_header: WEL_BITMAP_INFO_HEADER

end -- class WEL_DIB


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

