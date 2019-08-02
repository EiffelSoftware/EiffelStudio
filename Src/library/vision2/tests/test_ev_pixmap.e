note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_PIXMAP

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

	TEST_CONSTANTS

feature -- Test routines

	create_with_size
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
		do
			create pixmap.make_with_size (123, 345)

			assert ("size_correct", pixmap.width = 123 and pixmap.height = 345)
		end

	clear
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent test_clear)
		end

	load_save
			-- Load and save
		note
			testing: "execution/isolated"
		do
			test_unicode_load_and_save
		end

	set_with_named_file
			-- Reads an image file into a pixmap
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap
			pixmap.set_with_named_file (lenna)

			create window
			window.extend (pixmap)
			window.show
		end

	save_to_named_file
			-- Reads an image file and saves it again
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			l_path: PATH
			l_file: RAW_FILE
		do
			create pixmap
			pixmap.set_with_named_file (lenna)
			create l_path.make_from_string ("graphics/img.png")
			pixmap.save_to_named_path (create {EV_BMP_FORMAT}, l_path)
			pixmap.save_to_named_path (create {EV_PNG_FORMAT}, l_path)
			create l_file.make_with_path (l_path)
			assert ("Pixmap missing in " + l_path.canonical_path.utf_8_name + ".", l_file.exists)
			l_file.delete
		end

	draw_segment
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (colors.white)
			pixmap.clear
			pixmap.set_foreground_color (colors.blue)
			pixmap.draw_segment (10, 10, 90, 90)
			pixmap.set_foreground_color (colors.black)
			pixmap.draw_segment (10, 10, 10, 90)

			create window
			window.extend (pixmap)
			window.show
		end

	draw_pixmap
		note
			testing: "execution/isolated"
		local
			pixmap1, pixmap2: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			io.put_string ("Coucou%N")
			create pixmap2
			pixmap2.set_with_named_file (lenna)


			create pixmap1.make_with_size (pixmap2.width + 15, pixmap2.height + 15)
			pixmap1.set_background_color (colors.red)
			pixmap1.clear

			pixmap1.draw_pixmap (5, 5, pixmap2)

			create window
			window.extend (pixmap1)
			window.show
		end

	draw_sub_pixmap
			-- Draws using draw_sub_pixmap and draw_pixmap (sub_pixmap), which should produce the same result
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap1, pixmap2: EV_PIXMAP
					window: EV_TITLED_WINDOW
				do
					create pixmap2
					pixmap2.set_with_named_file (lenna)

					create pixmap1.make_with_size (1024, 230)
					pixmap1.set_background_color (colors.green)
					pixmap1.clear

					pixmap1.draw_sub_pixmap (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixmap (110, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))
					pixmap1.draw_rectangle (530, 5, 110, 110)
					pixmap1.draw_sub_pixmap (530, 5, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

					pixmap1.draw_rectangle (530, 115, 110, 110)
					pixmap1.draw_pixmap (5, 115, pixmap2.sub_pixmap (create {EV_RECTANGLE}.make (100, 100, 100, 100)))
					pixmap1.draw_pixmap (110, 115, pixmap2.sub_pixmap (create {EV_RECTANGLE}.make (100, 100, 1024, 100)))
					pixmap1.draw_pixmap (530, 115, pixmap2.sub_pixmap (create {EV_RECTANGLE}.make (-10, -10, 100, 100)))

					create window
					window.extend (pixmap1)
					window.set_size (1050, 300)
					window.show
					process_events
				end
			)
		end

	draw_sub_pixmap2
			-- In this test
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap1, pixmap2: EV_PIXMAP
					window: EV_TITLED_WINDOW
				do
						-- It is very important to use `default_create' here, as otherwise
						-- it creates on Windows the drawable, not the widget version.
					create pixmap2
					pixmap2.set_with_named_file (lenna)

					assert_32 ("Proper width", pixmap2.width = 512)
					assert_32 ("Proper height", pixmap2.height = 512)

					create pixmap1.make_with_size (1024, 230)
					pixmap1.set_background_color (colors.green)
					pixmap1.clear

					pixmap1.draw_sub_pixmap (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixmap (110, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))
					pixmap1.draw_rectangle (530, 5, 110, 110)
					pixmap1.draw_sub_pixmap (530, 5, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

						-- Draw rectangle before chaning mode.
					pixmap1.draw_rectangle (530, 115, 110, 110)
						-- Now we draw the exact same image as above using `xor' not for using `xor' but to exercise
						-- the default drawing method on Windows which will use `BitBlt' instead of `AlphaBlend' and
						-- we make sure that visually it looks the same apart from the color.
					pixmap1.set_drawing_mode ({EV_DRAWABLE_CONSTANTS}.drawing_mode_xor)
					pixmap1.draw_sub_pixmap (5, 115, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixmap (110, 115, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))
					pixmap1.draw_sub_pixmap (530, 115, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

					create window
					window.extend (pixmap1)
					window.set_minimum_size (1050, 300)
					window.show
					process_events
				end
			)
		end

	draw_text
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.clear

			pixmap.draw_text (10, 10, "black text")

			pixmap.set_foreground_color (colors.red)
			pixmap.draw_text (10, 30, "red text")

			create window
			window.extend (pixmap)
			window.show
		end

	draw_text_draw_text_top_left
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
		do
			create pixmap.make_with_size (300, 50)
			pixmap.clear

			pixmap.set_foreground_color (colors.red)
			pixmap.draw_segment (8, 8, 12, 12)
			pixmap.draw_segment (8, 12, 12, 8)
			pixmap.draw_segment (98, 8, 102, 12)
			pixmap.draw_segment (98, 12, 102, 8)

			pixmap.set_foreground_color (colors.blue)
			pixmap.draw_segment (10, 10, 290, 10)

			pixmap.set_foreground_color (colors.black)
			pixmap.draw_text (10, 10, "draw_text")
			pixmap.draw_text_top_left (100, 10, "draw_text_top_left")

			create window
			window.extend (pixmap)
			window.show
		end

	set_font_draw_text
		note
			testing: "execution/isolated"
		local
			pixmap: EV_PIXMAP
			window: EV_TITLED_WINDOW
			font: EV_FONT
		do
			create pixmap.make_with_size (150, 150)
			pixmap.clear

			pixmap.draw_text (10, 10, "regular text")

			create font
			font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			pixmap.set_font (font)
			pixmap.draw_text (10, 30, "bold text")

			create font
			font.set_shape ({EV_FONT_CONSTANTS}.Shape_italic)
			pixmap.set_font (font)
			pixmap.draw_text (10, 50, "italic text")

			create font
			font.set_height (font.height + 5)
			pixmap.set_font (font)
			pixmap.draw_text (10, 70, "big text")

			create font
			font.set_height (font.height + 5)
			font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			pixmap.set_font (font)
			pixmap.draw_text (10, 90, "big, bold text")

			create window
			window.extend (pixmap)
			window.show
		end

feature {NONE} -- Actual Test

	test_clear
		local
			pixmap: EV_PIXMAP
			window: EV_WINDOW
		do
			create pixmap.make_with_size (100, 100)
			pixmap.set_background_color (red)
			pixmap.clear

			create window
			window.extend (pixmap)
			window.set_size (100, 100)
			window.show
		end

	test_unicode_load_and_save
		local
			pixmap: EV_PIXMAP
			l_file: RAW_FILE
		do
			create l_file.make_with_name (image_path)
			if l_file.exists then
				l_file.delete
			end

			create pixmap
			pixmap.set_size (10, 10)
			pixmap.save_to_named_file (create {EV_PNG_FORMAT}, image_path)

			assert ("File saved.", l_file.exists)

			create pixmap
			pixmap.set_with_named_file (image_path)

			assert ("File loaded.", pixmap.width = 10 and then pixmap.height = 10)

			create pixmap
			pixmap.set_size (10, 10)
			pixmap.save_to_named_file (create {EV_BMP_FORMAT}, image_path)

			create pixmap
			pixmap.set_with_named_file (image_path)

			assert ("File loaded.", pixmap.width = 10 and then pixmap.height = 10)

			l_file.delete
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
