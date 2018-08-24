note
	description: "Composite task of verifying Eiffel using the Boogie verifier."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BULK_VERIFICATION_TASK

inherit

	E2B_VERIFY_TASK

	ROTA_SERIAL_TASK_I
		redefine
			remove_task
		end

create
	make

feature {NONE} -- Implementation

	make (a_translator_input: E2B_TRANSLATOR_INPUT)
			-- Initialize task.
		do
			reset_local_state

			create verifier.make
			create result_generator.make

			create remaining_tasks.make
			remaining_tasks.extend (create {E2B_TRANSLATE_CHUNK_TASK}.make (a_translator_input, boogie_universe))
			remaining_tasks.extend (create {E2B_GENERATE_BOOGIE_TASK}.make (boogie_universe, verifier))
			remaining_tasks.extend (create {E2B_EXECUTE_BOOGIE_TASK}.make (verifier))
			remaining_tasks.extend (create {E2B_EVALUATE_BOOGIE_OUTPUT_TASK}.make (verifier, result_generator))
			if options.is_two_step_verification_enabled then
				remaining_tasks.extend (create {E2B_VERIFY_WITH_INLINING_TASK}.make (result_generator, remaining_tasks))
			end
		end

feature -- Access

	sleep_time: NATURAL
			-- <Precursor>
		do
			if attached {E2B_TRANSLATE_CHUNK_TASK} sub_task then
				Result := 0
			elseif attached {E2B_EXECUTE_BOOGIE_TASK} sub_task then
				Result := 200
			else
				Result := 50
			end
		end

	sub_task: detachable ROTA_TASK_I
			-- <Precursor>
		do
			if not remaining_tasks.is_empty then
				Result := remaining_tasks.first
			end
		end

	verifier_result: detachable E2B_RESULT
			-- Result of verification.
		do
			Result := result_generator.last_result
		end

feature -- Element change

	append_task (a_task: ROTA_TASK_I)
			-- Append a task to do after other tasks finished.
		do
			remaining_tasks.extend (a_task)
		end

	set_context (a_string: STRING)
		do
			verifier.input.set_context (a_string)
		end

	store_global_state
			-- Store AutoProof errors for result generation.
		do
			result_generator.store_global_state
		end

feature {NONE} -- Implementation

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		do
			if a_cancel then
				remaining_tasks.wipe_out
			else
				remaining_tasks.start
				remaining_tasks.remove

				if remaining_tasks.is_empty then
					notifiy_with_result (verifier_result)
				end
			end
		end

	remaining_tasks: LINKED_LIST [ROTA_TASK_I]
			-- Tasks to work on.

	verifier: E2B_VERIFIER
			-- Boogie verifier.

	result_generator: E2B_RESULT_GENERATOR
			-- Result generator.

end
