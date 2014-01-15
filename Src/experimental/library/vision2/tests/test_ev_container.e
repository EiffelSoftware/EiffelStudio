note
	description: "[
		Tests for containers that have a minimum size and making sure that resizing them does not shrink their children if they have a larger minimum size.
		]"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_CONTAINER

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

	TEST_CONSTANTS

feature -- Test routines

	test_container_background_pixmap
		note
			testing: "execution/isolated"
		local
			s: STRING
		do
			create s.make (10)
			run_test_with_delay (2000, agent (a_string: STRING)
				local
					l_window: EV_WINDOW
					l_hbox: EV_HORIZONTAL_BOX
					l_vbox: EV_VERTICAL_BOX
					l_pixel_buffer: EV_PIXEL_BUFFER
					i: INTEGER
				do
					create l_window
					create l_vbox
					l_vbox.set_minimum_size (1000, 500)
					l_vbox.set_border_width (50)
					l_vbox.set_padding (30)
					create l_pixel_buffer
					l_pixel_buffer.set_with_named_file (image_32bpp)
					l_vbox.set_background_pixmap (l_pixel_buffer.to_pixmap)
					l_window.extend (l_vbox)

					create l_hbox
					from
						i := 1
					until
						i > 3
					loop
						create l_hbox
						l_hbox.set_minimum_size (100, 100)
						create l_pixel_buffer
						l_pixel_buffer.set_with_named_file (lenna)
						l_hbox.set_background_pixmap (l_pixel_buffer.to_pixmap)
						l_vbox.extend (l_hbox)
						i := i + 1
					end
					l_window.show
					process_events
					a_string.append ("Success")
				end (s)
			)
			assert ("Completed", s.same_string ("Success"))
		end

	test_vertical_box_resizing
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_window: EV_WINDOW
					l_vbox: EV_VERTICAL_BOX
					l_button: EV_BUTTON
					l_cell: EV_CELL
				do
					create l_window
					create l_vbox
					l_vbox.set_minimum_size (200, 200)
					create l_cell
					create l_button
					l_cell.extend (l_button)
					l_vbox.extend (l_cell)
					l_window.extend (l_vbox)
					l_window.show
					process_events
					l_cell.set_minimum_size (500, 500)
					assert ("Size of button is " + l_button.width.out + "x" + l_button.height.out + " but should be 500x500.", l_button.width = 500 and l_button.height = 500)
				end
			)
		end

	test_horizontal_box_resizing
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_window: EV_WINDOW
					l_vbox: EV_HORIZONTAL_BOX
					l_button: EV_BUTTON
					l_cell: EV_CELL
				do
					create l_window
					create l_vbox
					l_vbox.set_minimum_size (200, 200)
					create l_cell
					create l_button
					l_cell.extend (l_button)
					l_vbox.extend (l_cell)
					l_window.extend (l_vbox)
					l_window.show
					process_events
					l_cell.set_minimum_size (500, 500)
					assert ("Size of button is " + l_button.width.out + "x" + l_button.height.out + " but should be 500x500.", l_button.width = 500 and l_button.height = 500)
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
