note
	description: "Tests for EV_SCREEN"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_SCREEN

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_creation
			-- New test routine
		note
			testing: "execution/isolated"
		local
			main: EV_SCREEN
		do
			create main.default_create
		end

	test_pixel_color_relative_to
		note
			testing: "execution/isolated"
		do
			run_test (agent pixel_color_relative_to)
		end

feature {NONE} -- Real test

	pixel_color_relative_to
		note
			testing: "execution/isolated"
		local
			main: EV_SCREEN
			window: EV_TITLED_WINDOW
			l_color: EV_COLOR
		do
			create window
			window.set_size (100, 100)
			window.show

			create main
			l_color := main.pixel_color_relative_to (window, 10, 10)
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
