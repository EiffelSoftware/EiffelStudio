note
	description: "Summary description for {E2B_UPDATE_BLACKBOARD_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_UPDATE_BLACKBOARD_TASK

inherit

	ROTA_TASK_I

	SHARED_WORKBENCH

	EBB_SHARED_BLACKBOARD

create
	make

feature {NONE} -- Initialization

	make (a_tool_instance: attached like tool_instance; a_verify_task: attached like verify_task)
			-- Initialize task.
		do
			tool_instance := a_tool_instance
			verify_task := a_verify_task
			has_next_step := True
		end

feature -- Access

	tool_instance: E2B_TOOL_INSTANCE
			-- Tool instance running.

	verify_task: E2B_VERIFY_TASK
			-- Parent task.

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	step
			-- <Precursor>
		do
			if attached verify_task.verifier_result then
				blackboard.record_results
				verify_task.verifier_result.verification_results.do_all (agent handle_verification_result (?))
				blackboard.commit_results
			end
			has_next_step := False
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {NONE} -- Implementation

	handle_verification_result (a_verification_result: E2B_VERIFICATION_RESULT)
			-- Handle procedure result `a_procedure_result'.
		local
			l_result: E2B_BLACKBOARD_RESULT
			l_score: REAL
		do
			if attached {E2B_SUCCESSFUL_VERIFICATION} a_verification_result as l_success then
				if attached l_success.original_errors and then not l_success.original_errors.is_empty then
					l_score := {E2B_BLACKBOARD_SCORES}.successful_with_errors
				else
					l_score := {E2B_BLACKBOARD_SCORES}.successful
				end
			else
				l_score := {E2B_BLACKBOARD_SCORES}.failed
			end
			create l_result.make (a_verification_result, tool_instance.configuration, l_score)
			blackboard.add_verification_result (l_result)
		end

end
