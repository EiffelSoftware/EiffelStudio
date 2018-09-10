note
	description: "Task to re-verify with inlining."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_VERIFY_WITH_INLINING_TASK

inherit

	E2B_VERIFY_TASK

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_initial_result_generator: attached like initial_result_generator; a_tasks: like remaining_tasks)
			-- Initialize task.
		do
			initial_result_generator := a_initial_result_generator
			remaining_tasks := a_tasks
			has_next_step := True
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	sleep_time: NATURAL = 0
			-- <Precursor>

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	step
			-- <Precursor>
		local
			l_translator_input: E2B_TRANSLATOR_INPUT
			l_boogie_universe: IV_UNIVERSE
			l_context: E2B_SHARED_CONTEXT
		do
			if
				attached initial_result_generator.last_result and then
				initial_result_generator.last_result.has_verification_errors
			then
					-- Verify again with inlining
				create l_translator_input.make
				create l_context
				l_context.options.routines_to_inline.wipe_out
				across initial_result_generator.last_result.failed_verifications as i loop
					if i.item.context_feature /= Void then
						l_translator_input.add_feature (i.item.context_feature)
						l_context.options.routines_to_inline.extend (i.item.context_feature.body_index)
					end
				end

--				reset_global_state
--				reset_local_state
				create l_boogie_universe.make
				boogie_universe_cell.put (l_boogie_universe)
				helper.reset
				translation_pool.reset
				autoproof_errors.wipe_out
				result_handlers.wipe_out

				create inlining_verifier.make
				create result_generator.make
				remaining_tasks.start
				remaining_tasks.forth -- Skip current taks in queue
				remaining_tasks.put_left (create {E2B_TRANSLATE_CHUNK_TASK}.make (l_translator_input, l_boogie_universe))
				remaining_tasks.put_left (create {E2B_GENERATE_BOOGIE_TASK}.make (l_boogie_universe, inlining_verifier))
				remaining_tasks.put_left (create {E2B_EXECUTE_BOOGIE_TASK}.make (inlining_verifier))
				remaining_tasks.put_left (create {E2B_EVALUATE_BOOGIE_OUTPUT_TASK}.make (inlining_verifier, result_generator))
				remaining_tasks.put_left (create {E2B_MERGE_RESULTS_TASK}.make (initial_result_generator.last_result, result_generator))
			end
			has_next_step := False
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {NONE} -- Implementation

	remaining_tasks: attached LINKED_LIST [ROTA_TASK_I]
			-- List of remaining tasks.

	initial_result_generator: attached E2B_RESULT_GENERATOR
			-- Boogie verifier.

	inlining_verifier: detachable E2B_VERIFIER
			-- Boogie verifier.

	result_generator: attached E2B_RESULT_GENERATOR
			-- Result generator.

end
