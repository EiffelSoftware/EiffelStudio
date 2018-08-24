note
	description: "Task to merge results from two-step verification."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_MERGE_RESULTS_TASK

inherit

	ROTA_TASK_I

create
	make

feature {NONE} -- Initialization

	make (a_initial_result: attached like initial_result; a_secondary_result_generator: attached like secondary_result_generator)
			-- Initialize task.
		do
			initial_result := a_initial_result
			secondary_result_generator := a_secondary_result_generator
			has_next_step := True
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	step
			-- <Precursor>
		local
			l_new_success: BOOLEAN
			l_primary_result: E2B_VERIFICATION_RESULT
		do
			if
				attached initial_result and then
				attached secondary_result_generator.last_result
			then
				across secondary_result_generator.last_result.successful_verifications as l_second_success loop
					from
						l_new_success := True
						initial_result.verification_results.start
					until
						initial_result.verification_results.after or not l_new_success
					loop
						l_primary_result := initial_result.verification_results.item
						if
							l_primary_result.context_feature /= Void and then
							l_primary_result.context_class.class_id = l_second_success.item.context_class.class_id and then
							l_primary_result.context_feature.body_index = l_second_success.item.context_feature.body_index
						then
							if attached {E2B_SUCCESSFUL_VERIFICATION} l_primary_result then
								l_new_success := False
							elseif attached {E2B_FAILED_VERIFICATION} l_primary_result as l_primary_failed then
								across l_primary_failed.errors as l_errors loop
									l_second_success.item.add_original_error (l_errors.item)
								end
								initial_result.verification_results.remove
							elseif attached {E2B_INCONCLUSIVE_RESULT} l_primary_result then
									-- Ignore
							else
								check internal_error: False end
							end
						else
							initial_result.verification_results.forth
						end
					end
					if l_new_success then
						initial_result.verification_results.extend (l_second_success.item)
					end
				end

			end
			has_next_step := False
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {NONE} -- Implementation

	initial_result: attached E2B_RESULT
			-- Initial result.

	secondary_result_generator: attached E2B_RESULT_GENERATOR
			-- Boogie result generator.

end
