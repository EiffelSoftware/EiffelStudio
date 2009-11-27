note
	description: "[
		Task performing testing part of test generation either randomly or by replaying a log.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_GENERATION_TESTING

inherit
	AUT_TASK

	ROTA_SERIAL_TASK_I
		redefine
			step,
			remove_task
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end

create
	make_random --, make_replay

feature {NONE} -- Initialization

	make (a_generation: like generation)
			-- Initialize `Current'.
			--
			-- `a_generation': Creation session which launches `Current'.
		require
			a_generation_attached: a_generation /= Void
		do
			generation := a_generation
			create interpreter_generator.make (generation)
			create used_witnesses.make_default
			create result_repository_builder.make (generation.system)
		end

	make_random (a_generation: like generation; a_class_names: detachable DS_LINEAR [STRING])
			-- Initialize `Current' to perform random testing.
			--
			-- `a_generation': Creation session which launches `Current'.
			-- `a_class_names': Class/type names which shall be tested.
		require
			a_generation_attached: a_generation /= Void
		local
			l_itp: like new_interpreter
			l_task: AUT_RANDOM_STRATEGY
		do
			make (a_generation)

			l_itp := new_interpreter
			l_itp.add_observer (result_repository_builder)
			l_itp.set_is_logging_enabled (True)

			create l_task.make (l_itp, generation.system, generation.error_handler)
			l_task.add_class_names (a_class_names)
			test_task := l_task
			sub_task := l_task
		ensure
			generation_set: generation = a_generation
		end

	make_replay (a_generation: like generation)
			-- Initialize `Current' to perform replay testing.
			--
			-- `a_generation': Creation session which launches `Current'.
		require
			a_generation_attached: a_generation /= Void
		do

				-- TODO: initialize replay

			make (a_generation)
		end

feature -- Access

	generation: TEST_GENERATOR
			-- Creation session which launches `Current'

	progress: REAL_32
			-- Progress of `Current'

	result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Repsitory for all results created during testing.
		do
			Result := result_repository_builder.result_repository
		end

	classes_under_test: DS_ARRAYED_LIST [CLASS_C]
			-- Classes under test
		do
			if attached {AUT_RANDOM_STRATEGY} test_task as l_task then
				Result := l_task.classes_under_test
			else
				create Result.make (0)
			end
		end

feature {NONE} -- Access

	sub_task: AUT_TASK
			-- <Precursor>

	test_task: AUT_STRATEGY
			-- Task which uses interpreter to perform test calls

	result_repository_builder: AUT_RESULT_REPOSITORY_BUILDER
			-- Result repository builder

	minimize_task: AUT_WITNESS_MINIMIZER
			-- Task for minimizing found witnesses
		do
			if attached minimize_task_cache as l_cache then
				Result := l_cache
			else
				create Result.make (new_interpreter, generation.system, generation.error_handler)
				minimize_task_cache := Result
			end
		ensure
			result_attached: Result /= Void
		end

	minimize_task_cache: detachable like minimize_task
			-- Cache for `minimize_task'
			--
			-- Note: do not use directly, use `minimize_task' instead.

	interpreter_generator: AUT_INTERPRETER_GENERATOR
			-- Generator for creating interpreter proxy instanced

	times_duration_logged: INTEGER
			-- Number of times that elapsed time has been recorded to proxy file

feature {NONE} -- Access: witness minimization

	used_witnesses: DS_ARRAYED_LIST [AUT_WITNESS]
			-- Witness which have been minimized and for which a test was created

	last_minimized_witness: INTEGER
			-- Index of last minimized witness in `result_repository_builder'

feature -- Status report

	frozen is_minimizing: BOOLEAN
			-- Are we currently minimizing a found witness?
		do
			Result := sub_task = minimize_task
		end

feature -- Status setting

	start
			-- <Precursor>
		local
			l_generation: like generation
		do
			l_generation := generation
			l_generation.error_handler.report_random_testing
			l_generation.error_handler.set_start_time (system_clock.date_time_now)
			if l_generation.time_out.second_count > 0 then
				update_remaining_time
			end
			l_generation.error_handler.reset_counters (l_generation.test_count)
			sub_task.start
		end

feature {ROTA_S, ROTA_TASK_I} -- Status setting

	step
			-- <Precursor>
		local
			l_total, l_remaining: INTEGER
			l_totalc, l_remainingc: NATURAL
			l_progress: REAL
			l_cancel: BOOLEAN
			l_generation: like generation
			l_error_handler: AUT_ERROR_HANDLER
		do
			l_generation := generation
			if sub_task = test_task then
				l_total := l_generation.time_out.second_count
				if l_total > 0 then
					update_remaining_time
				end
				l_error_handler := l_generation.error_handler

				l_progress := {REAL} 1.0
				if l_total > 0 then
					l_remaining := l_error_handler.remaining_time.second_count
					l_progress := (l_remaining/l_total).truncated_to_real
					if l_remaining <= 0 then
						l_cancel := True
					end
				end
				l_totalc := l_generation.test_count
				if l_totalc > 0 then
					l_remainingc := l_error_handler.counter
					l_progress := l_progress.min ((l_remainingc/l_totalc).truncated_to_real)
					if l_remainingc = 0 then
						l_cancel := True
					end
				end
				if l_total = 0 and l_totalc = 0 then
					l_progress := {REAL} 0.5
				else
					l_progress := {REAL} 1.0 - l_progress
				end
				progress := {REAL} 0.1 + ({REAL} 0.5)*l_progress
				if l_cancel then
					sub_task.cancel
					remove_task (sub_task, False)
				else
					Precursor
					if l_generation.is_minimization_enabled then
						start_minimization
					end
				end
			else
				Precursor
			end
			generation.flush_output
		end

feature {NONE} -- Status setting

	remove_task (a_task: like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		local
			l_witness: detachable AUT_WITNESS
		do
			if not a_cancel then

					-- We access the cache so if it wasn't initialized yet it won't be.
				if sub_task = minimize_task_cache then
					l_witness := minimize_task.minimized_witness
					if l_witness = Void then
						l_witness := minimize_task.witness
					end
					check l_witness /= Void end
					used_witnesses.force_last (l_witness)

						-- We set `sub_task' back to `test_task' since for the random testing task `has_next_step'
						-- is still True which makes `has_next_step' in `Current' also True.
					sub_task := test_task
					generation.print_test_set (l_witness.classifications.twin)
				end

				start_minimization
			end
			if not has_next_step then
				clean
			end
		end

	start_minimization
			-- <Precursor>
		require
			minimization_enabled: generation.is_minimization_enabled
			not_minimizing: sub_task /= minimize_task or not has_next_step
		local
			l_repo: AUT_TEST_CASE_RESULT_REPOSITORY
			l_witnesses: DS_ARRAYED_LIST [AUT_WITNESS]
			l_witness: AUT_WITNESS
			l_task: like minimize_task
		do
			l_repo := result_repository_builder.result_repository
			l_witnesses := l_repo.witnesses
			if l_witnesses.count > last_minimized_witness then
				last_minimized_witness := last_minimized_witness + 1
				l_witness := l_witnesses.item (last_minimized_witness)
				if
					l_witness.is_fail and then
					not used_witnesses.there_exists (agent {AUT_WITNESS}.is_same_bug (l_witness))
				then
					l_task := minimize_task
					l_task.set_witness (l_witness)
					l_task.start
					sub_task := l_task
				end
			end
		end

	clean
			-- Clean up any tasks.
		do
			if test_task.has_next_step then
				test_task.cancel
			end
			if attached minimize_task_cache as l_task and then l_task.has_next_step then
				l_task.cancel
			end
			generation.flush_output
			progress := {REAL_32} 0.0
		end

feature {NONE} -- Implementation

	update_remaining_time
			-- Update `error_handler.remaining_time' and mark in the proxy log every elapsed minute.
		require
			time_out_set: generation.time_out /= Void
		local
			l_generation: like generation
			l_time_out, duration, time_left: DT_DATE_TIME_DURATION
			elapsed_minutes: INTEGER
			l_error_handler: AUT_ERROR_HANDLER
		do
			l_generation := generation
			l_time_out := l_generation.time_out
			l_error_handler := l_generation.error_handler
			duration := l_error_handler.duration_to_now

			elapsed_minutes := (duration.second_count / 60).floor
			if elapsed_minutes /= times_duration_logged then
				--interpreter.log_line (time_passed_mark + duration.second_count.out)
				times_duration_logged := times_duration_logged + 1
			end

			time_left := l_time_out - duration
			time_left.set_time_canonical
			if time_left.second_count < 0 then
				create time_left.make (0, 0, 0, 0, 0, 0)
			end
			l_error_handler.set_remaining_time (time_left)
		end

feature {NONE} -- Factory

	new_interpreter: AUT_INTERPRETER_PROXY
			-- Create a new interpreter proxy, Void if executable did not exist.
		local
			l_itp_gen: AUT_INTERPRETER_GENERATOR
		do
			l_itp_gen := interpreter_generator
			l_itp_gen.create_interpreter (file_system.pathname (generation.output_dirname, "log"))

				-- FIXME: ensure `last_interpreter' is attached, even if executable does not exist!
			Result := l_itp_gen.last_interpreter
		end

feature {NONE} -- Implementation: log replay

--	replay_log (a_log_file: STRING)
--			-- Replay log stored in `a_log_file'.
--		local
--			l_replay_strategy: AUT_REQUEST_PLAYER
--			l_itp: like new_interpreter
--		do
--			--interpreter.set_is_in_replay_mode (True)
--			test_task := Void
--			l_itp := new_interpreter
--			if l_itp /= Void then
--				create l_replay_strategy.make (l_itp, system, error_handler)
--				l_replay_strategy.set_request_list (requests_from_file (a_log_file, create {AUT_LOG_PARSER}.make (system, error_handler)))
--				l_replay_strategy.set_is_interpreter_started_by_default (False)
--				l_replay_strategy.start
--				test_task := l_replay_strategy
--			end
--		end

--	requests_from_file (a_log_file_name: STRING; a_log_loader: AUT_LOG_PARSER): DS_ARRAYED_LIST [AUT_REQUEST]
--			-- Result repository from log file `a_log_file_name' loaded by `a_log_loader'
--		require
--			a_log_file_name_attached: a_log_file_name /= Void
--			a_log_loader_attached: a_log_loader /= Void
--		local
--			log_stream: KL_TEXT_INPUT_FILE
--			l_recorder: AUT_PROXY_EVENT_RECORDER
--		do
--			create log_stream.make (a_log_file_name)
--			log_stream.open_read
--			if not log_stream.is_open_read then
--				error_handler.report_cannot_read_error (a_log_file_name)
--				create Result.make (0)
--			else
--				create l_recorder.make (system)
--				a_log_loader.add_observer (l_recorder)
--				a_log_loader.parse_stream (log_stream)
--				a_log_loader.remove_observer (l_recorder)
--				l_recorder.cleanup
--				Result := l_recorder.request_history
--			end
--			log_stream.close
--		ensure
--			result_attached: Result /= Void
--		end

invariant
	sub_task_tester_or_minimizer: sub_task = test_task or else sub_task = minimize_task
	minimizing_implies_test_task_has_next_step: minimize_task_cache = sub_task implies test_task.has_next_step

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
