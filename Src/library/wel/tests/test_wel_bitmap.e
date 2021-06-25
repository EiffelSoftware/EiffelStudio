note
	description: "Tests for bitmaps"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_WEL_BITMAP

inherit
	WEL_TEST_SET

feature -- Test routines

	save_bitmaps
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			⟳ b: bitmaps ¦ save_one_bitmap (b) ⟲
		end

feature {NONE} -- Implementation

	save_one_bitmap (a_bitmap: STRING)
			-- Save a copy of `a_bitmap' in `output_path'.
		note
			testing: "execution/isolated"
		local
			l_dc: WEL_CLIENT_DC
			l_bitmap: WEL_BITMAP
			l_file: RAW_FILE
			l_dib: WEL_DIB
			l_window: WEL_FRAME_WINDOW
		do
			create l_window.make_top ("test")
			create l_dc.make (l_window)

			create l_file.make_with_name (a_bitmap)
			l_file.open_read
			create l_dib.make_by_file (l_file)

			l_dc.get
			create l_bitmap.make_by_dib (l_dc, l_dib, {WEL_DIB_COLORS_CONSTANTS}.Dib_rgb_colors)

			l_dc.draw_bitmap (l_bitmap, 10, 10, l_bitmap.width, l_bitmap.height)

			l_dc.save_bitmap_into (l_bitmap, output_path)

			l_dc.release

			create l_file.make_with_path (output_path)
			l_file.delete
		end

feature {NONE} -- Constants

	bitmaps: ARRAYED_LIST [STRING]
		once
			create Result.make (10)
			Result.extend (image_01bpp)
			Result.extend (image_04bpp)
			Result.extend (image_08bpp)
			Result.extend (image_16bpp)
			Result.extend (image_24bpp)
			Result.extend (image_32bpp)
		end

	image_32bpp: STRING
		once
			Result := "graphics/32bpp.bmp"
		end

	image_24bpp: STRING
		once
			Result := "graphics/24bpp.bmp"
		end

	image_16bpp: STRING
		once
			Result := "graphics/16bpp.bmp"
		end

	image_08bpp: STRING
		once
			Result := "graphics/08bpp.bmp"
		end

	image_04bpp: STRING
		once
			Result := "graphics/04bpp.bmp"
		end

	image_01bpp: STRING
		once
			Result := "graphics/01bpp.bmp"
		end

	output_path: PATH
		once
			create Result.make_from_string ("graphics/output.bmp")
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
