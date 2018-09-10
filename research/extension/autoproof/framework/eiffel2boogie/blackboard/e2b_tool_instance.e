note
	description: "Summary description for {E2B_TOOL_INSTANCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TOOL_INSTANCE

inherit

	EBB_TOOL_INSTANCE

	EBB_SHARED_BLACKBOARD

create
	make

feature -- Status report

	is_running: BOOLEAN
			-- Is instance running?
		do
			Result := autoproof.is_running
		end

feature {EBB_TOOL_EXECUTION} -- Basic operations

	start
			-- Start instance.
		do
			create autoproof.make
			across input.individual_classes as c loop autoproof.add_class (c.item) end
			across input.individual_features as c loop autoproof.add_feature (c.item) end

			autoproof.add_notification (agent update_blackboard)
			autoproof.verify

			;(create {E2B_SHARED_CONTEXT}).status_notifier_agent_cell.put (agent set_status_message)
		end

	cancel
			-- Cancel instance.
		do
			autoproof.cancel
		end

	update_blackboard (a_result: E2B_RESULT)
		do
			blackboard.record_results
			across a_result.verification_results as c loop
				handle_verification_result (c.item)
			end
			blackboard.commit_results
		end

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
			if a_verification_result.context_feature /= Void then
				create l_result.make (a_verification_result, configuration, l_score)
				blackboard.add_verification_result (l_result)
			end
		end

feature {NONE} -- Implementation

	autoproof: E2B_AUTOPROOF
			-- Verifier

end
