note
	description: "Task to re-verify with inlining."

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
					if i.context_feature /= Void then
						l_translator_input.add_feature (i.context_feature)
						l_context.options.routines_to_inline.extend (i.context_feature.body_index)
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

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
