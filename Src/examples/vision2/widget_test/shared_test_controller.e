indexing
	description: "Objects that provide once access to a TEST_CONTROLLER"
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
	
end -- class SHARED_TEST_CONTROLLER
