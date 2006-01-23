indexing
	description: "Objects that provide once access to a TEST_CONTROLLER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_CONTROLLER

feature -- Access

	test_controller: TEST_CONTROLLER is
			-- Once access to TEST_CONTROLLER object.
		once
			create Result
		end

invariant
	test_controller_not_void: test_controller /= Void
	test_controller_consistent: test_controller = test_controller
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SHARED_TEST_CONTROLLER
