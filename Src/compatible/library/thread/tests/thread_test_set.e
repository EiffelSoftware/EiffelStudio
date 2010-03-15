note
	description: "[
		Common ancestor for thread test set classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			is_prepared
		end

	THREAD_CONTROL

feature -- Status report

	is_prepared: BOOLEAN
		do
			Result := Precursor and then {PLATFORM}.is_thread_capable
		ensure then
			result_implies_thread_capable: {PLATFORM}.is_thread_capable
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
