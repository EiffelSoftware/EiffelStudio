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

feature -- Access

	application: TEST_APPLICATION

	run_test (a_test: PROCEDURE [ANY, TUPLE [like Current]])
			-- Run the test a_test - inside the event loop
		do
			create application.make_new
			application.post_launch_actions.extend (agent run_and_exit (a_test))
			application.launch
		end

	run_and_exit (a_test: PROCEDURE [ANY, TUPLE [like Current]])
		local
			l_operands: TUPLE [like Current]
		do
			l_operands := a_test.empty_operands
			check
				valid_operand_count: l_operands.count = 1
				valid_operand: l_operands.valid_type_for_index (Current, 1)
			end
			l_operands.put (Current, 1)
			a_test.call (l_operands)
			application.destroy
		end

end
