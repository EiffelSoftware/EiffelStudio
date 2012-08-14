note
	description: "Tests for EV_WINDOW"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_WINDOW

inherit
	VISION2_TEST_SET

feature -- Test routines

	test_show
			-- Shows an empty window without title bar, 100x200px in size.
		note
			testing: "execution/isolated"
		do
			run_test (agent show)
		end

	test_resize_action_called
			-- Checks if resize actions are called correctly
		note
			testing: "execution/isolated"
		do
			run_test (agent resize_action_called)
		end

feature {NONE} -- Actual Test

	show
			-- Shows an empty window without title bar, 100x200px in size.
		local
			window: EV_WINDOW
		do
			create window
			window.set_size (100, 200)
			window.show
		end

	resize_action_called
			-- Checks if resize actions are called correctly
		local
			window: EV_TITLED_WINDOW
			flag: BOOLEAN_REF
		do
			create window

			flag := (False).to_reference
			window.resize_actions.extend_kamikaze (agent (a_flag: BOOLEAN_REF; x, y, width, height: INTEGER) do
				a_flag.set_item (True)
			end (flag, ?, ?, ?, ?))

			window.set_size (100, 100)
			application.process_events

			assert ("Resize action called", flag.item)
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
