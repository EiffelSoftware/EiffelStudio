note
	description: "Verification task that verifies one feature at a time and (possibly) in parallel."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_FORK_VERIFICATION_TASK

inherit

	E2B_VERIFY_TASK

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (a_translator_input: E2B_TRANSLATOR_INPUT)
			-- Initialize task.
		do
			create remaining_inputs.make
			create verification_tasks.make
			across a_translator_input.feature_list as l_cursor loop
				add_sub_task_for_feature (l_cursor.item)
			end
			across a_translator_input.class_list as l_cursor loop
				add_sub_tasks_for_class (l_cursor.item)
			end
			across a_translator_input.feature_of_type_list as l_cursor loop
				add_sub_task_for_feature_of_type (l_cursor.item.f, l_cursor.item.t)
			end
			across a_translator_input.class_check_list as l_cursor loop
				add_sub_task_for_class_check (l_cursor.item)
			end
		end

	add_sub_tasks_for_class (a_class: CLASS_C)
			-- Add subtasks for class `a_class'.
		local
			l_feature: FEATURE_I
		do
			if not helper.is_class_logical (a_class) then
				add_sub_task_for_class_check (helper.constraint_type (a_class))
			end
			if a_class.has_feature_table then
				from
					a_class.feature_table.start
				until
					a_class.feature_table.after
				loop
					l_feature := a_class.feature_table.item_for_iteration
					if helper.verify_feature_in_class (l_feature, a_class) then
						add_sub_task_for_feature_of_type (l_feature, a_class.actual_type)
					end
					a_class.feature_table.forth
				end
			end
		end

	add_sub_task_for_feature (a_feature: FEATURE_I)
			-- Add single subtask for feature `a_feature'.
		local
			l_input: E2B_TRANSLATOR_INPUT
		do
			create l_input.make
			l_input.add_feature (a_feature)
			remaining_inputs.extend (l_input)
		end

	add_sub_task_for_feature_of_type (a_feature: FEATURE_I; a_context_type: TYPE_A)
			-- Add single subtask for feature `a_feature'.
		local
			l_input: E2B_TRANSLATOR_INPUT
		do
			create l_input.make
			l_input.add_feature_of_type (a_feature, helper.constraint_type (a_context_type.base_class))
			remaining_inputs.extend (l_input)
		end

	add_sub_task_for_class_check (a_class: CL_TYPE_A)
			-- Add class check of `a_class'.
		local
			l_input: E2B_TRANSLATOR_INPUT
		do
			create l_input.make
			l_input.add_class_check (a_class)
			remaining_inputs.extend (l_input)
		end

feature -- Access

	sleep_time: NATURAL
			-- <Precursor>
		do
			if verification_tasks.count < options.max_parallel_boogies and (translation_task /= Void or not remaining_inputs.is_empty) then
				Result := 0
			else
				Result := 50
			end
		end

	verifier_result: detachable E2B_RESULT
			-- Result of verification.
		do
			Result := last_result
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result :=
				not remaining_inputs.is_empty or
				(translation_task /= Void and then translation_task.has_next_step) or
				not verification_tasks.is_empty
		end

feature -- Element change

	cancel
			-- <Precursor>
		do
			remaining_inputs.wipe_out
			translation_task := Void
			verification_tasks.wipe_out
		end

feature {ROTA_S, ROTA_TASK_I, ROTA_TASK_COLLECTION_I} -- Basic operation

	step
			-- <Precursor>
		local
			l_result: E2B_RESULT
		do
			from
				verification_tasks.start
			until
				verification_tasks.after
			loop
				verification_tasks.item.step
				if not verification_tasks.item.has_next_step then
					l_result := verification_tasks.item.verifier_result
					verification_tasks.remove
					notifiy_with_result (l_result)
				else
					verification_tasks.forth
				end
			end

			if translation_task = Void and not remaining_inputs.is_empty and verification_tasks.count < options.max_parallel_boogies then
				remaining_inputs.start
				create translation_task.make (remaining_inputs.item)
				translation_task.set_context (context_from_input (remaining_inputs.item))
				remaining_inputs.remove
			end
			if translation_task /= Void then
				translation_task.step
				if attached {E2B_EXECUTE_BOOGIE_TASK} translation_task.sub_task then
					translation_task.store_global_state
					reset_global_state
					verification_tasks.extend (translation_task)
					translation_task := Void
				end
			end
		end

feature {NONE} -- Implementation

	remaining_inputs: LINKED_LIST [E2B_TRANSLATOR_INPUT]
			-- Remaining inputs to work on.

	translation_task: E2B_BULK_VERIFICATION_TASK
			-- Task currently doing translation

	verification_tasks: LINKED_LIST [E2B_BULK_VERIFICATION_TASK]
			-- List of subtasks.

	last_result: E2B_RESULT
			-- Result.

	context_from_input (a_input: E2B_TRANSLATOR_INPUT): STRING
		do
			if not a_input.class_check_list.is_empty then
				Result := "CC-" + a_input.class_check_list.first.base_class.name_in_upper
			end
			if not a_input.class_list.is_empty then
				check False end
				Result := "C-" + a_input.class_list.first.name_in_upper
			end
			if not a_input.feature_list.is_empty then
				Result := "F-" + a_input.feature_list.first.written_class.name_in_upper + "." + a_input.feature_list.first.feature_name_32.out
			end
			if not a_input.feature_of_type_list.is_empty then
				Result := "FT-" + a_input.feature_of_type_list.first.t.base_class.name_in_upper + "." + a_input.feature_of_type_list.first.f.feature_name_32.out
			end
		end

end
