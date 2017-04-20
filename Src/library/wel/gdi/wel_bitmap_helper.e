note
	description: "Helper routines for WEL_BITMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BITMAP_HELPER

feature -- Command

	mirror_image (a_bitmap: WEL_BITMAP)
			-- Mirror image datas. It's a vertical filp conversion.
		require
			not_void: a_bitmap /= Void
			a_bitmap_exits: a_bitmap.exists
			bitmap_not_selected_by_dc: True
		local
			l_orignal_dc: WEL_MEMORY_DC
			l_bits: MANAGED_POINTER
			l_info: WEL_BITMAP_INFO
			l_result: INTEGER
		do
			create l_orignal_dc.make
			create l_info.make_by_dc (l_orignal_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

				-- When use SetDiBits/GetDiBits Api, windows require bitmap is not selected by any dc.
			l_bits := l_orignal_dc.di_bits_pointer (a_bitmap, 0, a_bitmap.height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

				-- Following line is KEY to mirror bitmap
			l_info.header.set_height (- l_info.header.height)
			l_result := l_orignal_dc.set_di_bits_pointer (a_bitmap, 0, a_bitmap.height, l_bits, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_info.dispose
			l_orignal_dc.delete
				-- Quick way to release the majority of the memory allocated
				-- for the image bits.
			l_bits.resize (0)
		end

feature -- Query

	bits_of_image (a_bitmap: WEL_BITMAP): ARRAY [CHARACTER]
			-- Data bits of `a_bitmap'
		require
			not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
		local
			l_dc: WEL_MEMORY_DC
			l_info: WEL_BITMAP_INFO
		do
			create l_dc.make
			create l_info.make_by_dc (l_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			Result := l_dc.di_bits (a_bitmap, 0, a_bitmap.height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_info.dispose
			l_dc.delete
		ensure
			not_void: Result /= Void
		end

	bits_of_image_bottom_up (a_bitmap: WEL_BITMAP): ARRAY [CHARACTER]
			-- Data bits of `a_bitmap', vertical filp data bits.
		require
			not_void: a_bitmap /= Void
			a_bitmap_exits: a_bitmap.exists
		local
			l_dc: WEL_MEMORY_DC
			l_info: WEL_BITMAP_INFO
		do
			create l_dc.make
			create l_info.make_by_dc (l_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_info.header.set_height (- l_info.header.height)
			Result := l_dc.di_bits (a_bitmap, 0, a_bitmap.height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_info.dispose
			l_dc.delete
		end

	bits_pointer_of_image_bottom_up (a_bitmap: WEL_BITMAP): MANAGED_POINTER
			-- Data bits of `a_bitmap', vertical filp data bits.
		require
			not_void: a_bitmap /= Void
			a_bitmap_exits: a_bitmap.exists
		local
			l_dc: WEL_MEMORY_DC
			l_info: WEL_BITMAP_INFO
			l_header: WEL_BITMAP_INFO_HEADER
		do
			create l_dc.make
			create l_info.make_by_dc (l_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_header := l_info.header
			l_header.set_height (- l_header.height)
			Result := l_dc.di_bits_pointer (a_bitmap, 0, a_bitmap.height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_info.dispose
			l_dc.delete
		end

	info_of_bitmap (a_bitmap: WEL_BITMAP): WEL_BITMAP_INFO
			-- Create a Result base on `a_bitmap'
		obsolete
			"Use `create {WEL_BITMAP_INFO}.make_by_dc instead (a_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)' [2017-05-31]."
		require
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exits: a_bitmap.exists
		local
			l_dc: WEL_MEMORY_DC
		do
			create l_dc.make
			create Result.make_by_dc (l_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			l_dc.delete
		end

feature -- Brush Query

 	half_tone_brush: WEL_BRUSH
			-- Half tone brush which is widely used in Windows feedback drawing
		local
			a_bitmap: WEL_BITMAP
			string_bitmap: STRING
			i: INTEGER
		do
				-- We create a bitmap 8x8 which follows the pattern:
				-- black / white / black... on one line
				-- and white / black / white... on the other.
				-- The hexa number 0xAA correspond to the first line
				-- and the 0x55 to the other line. Since Windows expects
				-- value aligned on DWORD, we have gap in our strings.

				-- Creating data of bitmaps
			create string_bitmap.make (16)
			string_bitmap.fill_blank
			from
				i := 1
			until
				i > 16
			loop
				string_bitmap.put ((0x000000AA).to_character_8, i)
				string_bitmap.put ((0x00000055).to_character_8, i + 2)
				i := i + 4
			end

				-- Then, we create the brush
			create a_bitmap.make_direct (8, 8, 1, 1, string_bitmap)
			create Result.make_by_pattern (a_bitmap)

			a_bitmap.delete
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
