note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_GRID

inherit
	VISION2_TEST_SET

feature -- Test routines

	test_hide_row
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent hide_row)
		end

feature {NONE} -- Actual Test

	hide_row
		local
			l_grid: EV_GRID
			window: EV_WINDOW
			l_except: DEVELOPER_EXCEPTION
			is_retried: BOOLEAN
		do
			if not is_retried then
				create window

				create l_grid
				l_grid.set_row_count_to (10)
				l_grid.row (5).hide
				l_grid.row (5).show

				window.extend (l_grid)
				window.show

				application.process_events
			else
				create l_except
				first_recorded_exception := l_except
			end
		rescue
			is_retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
