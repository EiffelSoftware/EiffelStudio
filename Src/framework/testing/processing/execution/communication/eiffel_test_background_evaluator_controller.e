indexing
	description: "[
		Controller for evaluators running in separate process.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_BACKGROUND_EVALUATOR_CONTROLLER

inherit
	EIFFEL_TEST_EVALUATOR_CONTROLLER
		rename
			make as make_controller
		end

create
	make

feature {NONE} -- Initialization

	make (a_assigner: like assigner; a_executable: like executable) is
			-- Initizialize `Current'
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
		require
			a_executable_not_empty: not a_executable.is_empty
		do
			make_controller (a_assigner)
			executable := a_executable
			create output.make (1024)
		ensure
			executable_set: executable = a_executable
		end

feature {NONE} -- Access

	executable: !STRING
			-- Name of executable for `process'

	process: ?PROCESS
			-- Process

	output: !STRING
			-- Output of `process'
			--
			-- Note: used for debugging purposes

feature {NONE} -- Status report

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do
			Result := process.is_running
		end

feature -- Status setting

	terminate_evaluator
			-- <Precursor>
		do
			if not process.force_terminated then
				process.terminate
				process.wait_for_exit
			end
		end

	launch_evaluator (a_args: !LIST [!STRING]) is
			-- <Precursor>
		do
			process := process_factory.process_launcher (executable, a_args, Void)
			output.wipe_out
			process.redirect_output_to_agent (
				agent (s: STRING)
					do
						output.append (s)
					end)
			process.redirect_error_to_same_as_output
			process.launch
		end

feature {NONE} -- Implementation

	process_factory: PROCESS_FACTORY
			-- Factory for creating processes.
		once
			create Result
		end

invariant
	running_implies_process_attached: is_running implies
		(process /= Void and then process.launched)

end
