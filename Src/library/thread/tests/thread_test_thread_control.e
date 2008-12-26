note
	description: "[
		Unit tests for {THREAD_CONTROL}.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	THREAD_TEST_THREAD_CONTROL

inherit
	THREAD_TEST_SET

feature -- Test routines

	test_native_join
			-- Test originally revealed using AutoTest.
		note
			testing:  "covers/{THREAD_CONTROL}.native_join"
		local
			l_tc: THREAD_CONTROL
		do
			create l_tc
			l_tc.native_join (default_pointer)
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end


