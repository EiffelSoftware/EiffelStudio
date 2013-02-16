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
	VISION2_TEST_SET

feature -- Test routines

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
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
