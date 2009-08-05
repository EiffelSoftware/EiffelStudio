note
	description: "Base class from which all our Vision2 tests inherit. Contains shared functionality for setup."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISION2_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			run_test
		end

	EV_ANY_HANDLER

feature -- Access

	application: TEST_APPLICATION

	run_test (a_test: PROCEDURE [ANY, TUPLE])
			-- Run the test a_test - inside the event loop
		do
			create application.make_new
			application.post_launch_actions.extend (agent run_and_exit (a_test))
			application.launch
		end

	run_and_exit (a_test: PROCEDURE [ANY, TUPLE])
		do
			a_test.call ([]);
			application.destroy
		end

end
