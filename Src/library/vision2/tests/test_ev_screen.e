note
	description: "Tests for EV_SCREEN"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_SCREEN

inherit
	VISION2_TEST_SET

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
