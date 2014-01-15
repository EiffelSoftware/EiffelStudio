note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_GRID

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_hide_row
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_grid: EV_GRID
					window: EV_WINDOW
				do
					create window

					create l_grid
					l_grid.set_row_count_to (10)
					l_grid.row (5).hide
					l_grid.row (5).show

					window.extend (l_grid)
					window.show
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
