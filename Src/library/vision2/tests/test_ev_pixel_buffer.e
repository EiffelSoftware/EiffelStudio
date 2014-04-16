note
	description: "Tests for EV_PIXMAP"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_PIXEL_BUFFER

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

	TEST_CONSTANTS

feature -- Testing

	draw_sub_pixel_buffer
			-- Draws using draw_sub_pixmap and draw_pixmap (sub_pixmap), which should produce the same result
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap1: EV_PIXMAP
					pixmap2: EV_PIXEL_BUFFER
					window: EV_TITLED_WINDOW
				do
					create pixmap2
					pixmap2.set_with_named_file (lenna)

					create pixmap1.make_with_size (1024, 230)
					pixmap1.set_background_color (colors.green)
					pixmap1.clear

						-- Test for drawing a smaller or larger portion of `pixmap2' with a positive offset.
					pixmap1.draw_sub_pixel_buffer (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixel_buffer (110, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))

						-- Test for drawing a smaller or larger portion of `pixmap2' with a negative offset.
					pixmap1.draw_rectangle (530, 5, 100, 100)
					pixmap1.draw_sub_pixel_buffer (530, 5, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

						-- Test for drawing the bottom right portion of `pixmap2'.
					pixmap1.draw_rectangle (650, 5, 100, 100)
					pixmap1.draw_sub_pixel_buffer (650, 5, pixmap2, create {EV_RECTANGLE}.make (50, 50, 100, 100))

						-- Test for drawing a subpart of `pixmap2' using the same as above.
					pixmap1.draw_rectangle (530, 115, 100, 100)
					pixmap1.draw_sub_pixel_buffer (5, 115, pixmap2.sub_pixel_buffer (create {EV_RECTANGLE}.make (100, 100, 100, 100)), create {EV_RECTANGLE}.make (0, 0, 512, 512))
					pixmap1.draw_sub_pixel_buffer (110, 115, pixmap2.sub_pixel_buffer (create {EV_RECTANGLE}.make (100, 100, 1024, 100)),create {EV_RECTANGLE}.make (0, 0, 512, 512))
					pixmap1.draw_sub_pixel_buffer (530, 115, pixmap2.sub_pixel_buffer (create {EV_RECTANGLE}.make (-10, -10, 100, 100)), create {EV_RECTANGLE}.make (0, 0, 512, 512))
					pixmap1.draw_sub_pixel_buffer (650, 115, pixmap2.sub_pixel_buffer (create {EV_RECTANGLE}.make (50, 50, 100, 100)), create {EV_RECTANGLE}.make (0, 0, 512, 512))

					create window
					window.extend (pixmap1)
					window.set_size (1050, 300)
					window.show
					process_events
				end
			)
		end

	draw_sub_pixel_buffer2
			-- In this test
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap1: EV_PIXMAP
					pixmap2: EV_PIXEL_BUFFER
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

					pixmap1.draw_sub_pixel_buffer (5, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixel_buffer (110, 5, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))
					pixmap1.draw_rectangle (530, 5, 110, 110)
					pixmap1.draw_sub_pixel_buffer (530, 5, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

						-- Draw rectangle before chaning mode.
					pixmap1.draw_rectangle (530, 115, 110, 110)
						-- Now we draw the exact same image as above using `xor' not for using `xor' but to exercise
						-- the default drawing method on Windows which will use `BitBlt' instead of `AlphaBlend' and
						-- we make sure that visually it looks the same apart from the color.
					pixmap1.set_drawing_mode ({EV_DRAWABLE_CONSTANTS}.drawing_mode_xor)
					pixmap1.draw_sub_pixel_buffer (5, 115, pixmap2, create {EV_RECTANGLE}.make (100, 100, 100, 100))
					pixmap1.draw_sub_pixel_buffer (110, 115, pixmap2, create {EV_RECTANGLE}.make (100, 100, 1024, 100))
					pixmap1.draw_sub_pixel_buffer (530, 115, pixmap2, create {EV_RECTANGLE}.make (-10, -10, 100, 100))

					create window
					window.extend (pixmap1)
					window.set_minimum_size (1050, 300)
					window.show
					process_events
				end
			)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
