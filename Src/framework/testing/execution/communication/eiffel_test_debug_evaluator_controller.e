indexing
	description: "[
		Controller for evaluators running in the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_DEBUG_EVALUATOR_CONTROLLER

inherit
	EIFFEL_TEST_EVALUATOR_CONTROLLER

create
	make

feature -- Status report

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do

		end

	is_ready: BOOLEAN
			-- <Precursor>
		do

		end

feature -- Status setting

	terminate_evaluator
			-- <Precursor>
		do

		end

	launch_evaluator (a_args: !LIST [!STRING])
			-- <Precursor>
		do

		end

end
