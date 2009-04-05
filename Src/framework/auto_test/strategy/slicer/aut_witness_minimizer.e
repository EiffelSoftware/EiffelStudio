note
	description: "[
		Objects that minimize a witness.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_WITNESS_MINIMIZER

inherit
	AUT_STRATEGY
		redefine
			make,
			start,
			cancel
		end

	AUT_SHARED_TYPE_FORMATTER
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	KL_SHARED_STREAMS
		export
			{NONE} all
		end

	ERL_CONSTANTS
		export
			{NONE} all
		end

	ERL_G_TYPE_ROUTINES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_interpreter: like interpreter; a_system: like system; an_error_handler: like error_handler)
			-- <Precursor>
		do
			Precursor (a_interpreter, a_system, an_error_handler)

			create player.make (interpreter, system, error_handler)
			create slicer.make
			create ddminer.make (system, player, error_handler)
			create printer.make_null (system)
			create slice_name_generator.make_with_string_stream ("slice_")
			create ddmin_name_generator.make_with_string_stream ("ddmin_")
			create ddmin_step_name_generator.make_with_string_stream ("ddmin_step_")
			create timer_total.make
			create timer_execution.make

				-- TODO: set these according to options
			is_slicing_enabled := True
		end

feature -- Access

	witness: detachable AUT_WITNESS
		-- Witness currently being minimized

	minimized_witness: like witness
		-- Minimized version of `witness'

feature {NONE} -- Access

	slicer: AUT_SLICER
			-- Minimizer which uses slicing

	ddminer: AUT_DD_MINIMIZER
			-- Minimizer which uses ddmin

	player: AUT_REQUEST_PLAYER
			-- Player used to replay logged requests

	printer: AUT_TEST_CASE_PRINTER
			-- Test case printer

	timer_total: AUT_TIMER
	timer_execution: AUT_TIMER
			-- Timers

	slice_name_generator: AUT_UNIQUE_NAME_GENERATOR
	ddmin_name_generator: AUT_UNIQUE_NAME_GENERATOR
	ddmin_step_name_generator: AUT_UNIQUE_NAME_GENERATOR
			-- Filename generators

	slice_task: detachable AUT_TASK
			-- Current slice task

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := slice_task /= Void
		ensure then
			result_implies_witness_attached: Result implies witness /= Void
		end

feature {NONE} -- Status report

	is_slicing_enabled: BOOLEAN
			-- Should slicing be used as minimization technique?

	is_ddmin_enabled: BOOLEAN
			-- Should ddmin be used as minimization technique?

feature -- Status setting

	set_witness (a_witness: like witness)
			-- Assign new witness to `witness'.
			--
			-- `a_witness': New witness to be minimized.
		do
			witness := a_witness
			minimized_witness := Void
		ensure
			witness_set: witness = a_witness
			minimized_witness_reset: minimized_witness = Void
		end

	start
			-- <Precursor>
		do
			if attached witness as l_witness then
				if is_ddmin_enabled then
						-- TODO: make `ddmin_witness' use class attributes instead of arguments
						--       and implement it as an AUT_TASK
					--ddmin_witness
				end

				if is_slicing_enabled then
					prepare_slice_task
				end
			end
		end

	step
			-- <Precursor>
		local
			l_task: like slice_task
			l_itp: like interpreter
		do
			l_task := slice_task
			check l_task /= Void end
			if l_task.has_next_step then
				l_task.step
			else
				finish_slice
				l_itp := interpreter
				if l_itp.is_running then
					l_itp.stop
				end
				cancel
			end
		end

	cancel
			-- <Precursor>
		local
			l_task: like slice_task
		do
			Precursor
			l_task := slice_task
			check l_task /= Void end
			if l_task.has_next_step then
				l_task.cancel
			end
			slice_task := Void
		end

feature {NONE} -- Implementation

	prepare_slice_task
			-- Initialize and start `slice_task'.
		require
			witness_attached: witness /= Void
		local
			l_witness: like witness
		do
			l_witness := witness
			check l_witness /= Void end
			error_handler.report_minimization_task
			timer_total.start
			slicer.extract_backward_slice (l_witness)
			timer_total.calculate_duration
			error_handler.report_benchmark_message ("slice extraction time: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + " ms.")
			slice_name_generator.output_string.wipe_out
			slice_name_generator.generate_new_name
			player.set_request_list (slicer.last_slice)
			timer_execution.start

			player.start
			slice_task := player
		end

	finish_slice
			-- Finalize slicing of `witness'.
		require
			witness_attached: witness /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			last_all_used_vars: like all_used_vars
			l_witness: like witness
			l_sliced_witness: AUT_WITNESS
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			l_witness := witness
			check l_witness /= Void end
			timer_execution.calculate_duration
			timer_total.calculate_duration
			create l_sliced_witness.make_default (slicer.last_slice)
			create file.make (file_system.nested_pathname (log_dirname, << slice_name_generator.output_string >>))
			if l_sliced_witness.is_fail and then l_sliced_witness.is_same_bug (l_witness) then
				last_all_used_vars := all_used_vars (slicer.last_slice)
				l_sliced_witness.set_used_vars (last_all_used_vars)
				file.open_write
				if file.is_open_write then
					create response_printer.make (file)
					printer.set_output_stream (file)
					printer.print_test_case (l_witness.request_list, Void)
					l_witness.item (l_witness.count).response.process (response_printer)
					printer.print_test_case (slicer.last_slice, last_all_used_vars)
					if l_sliced_witness.item (l_sliced_witness.count).response /= Void then
						l_sliced_witness.item (l_sliced_witness.count).response.process (response_printer)
					end
					printer.set_output_stream (null_output_stream)
					file.close
				else
					error_handler.report_cannot_read_error (file.name)
				end
				minimized_witness := l_sliced_witness
			end
			error_handler.report_benchmark_message ("slice execution time: " + timer_execution.last_duration.second_count.out + "s, " + timer_execution.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice minimization time total: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice fn: " + file.name)
			error_handler.report_benchmark_message ("slice original loc: " + l_witness.count.out)
			error_handler.report_benchmark_message ("slice minimized loc: " + l_sliced_witness.count.out)
			error_handler.report_benchmark_message ("slice successful: " + (l_sliced_witness.is_fail and then l_sliced_witness.is_same_bug (l_witness)).out)
		end

	ddmin_witness (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR; a_step_name_generator: AUT_UNIQUE_NAME_GENERATOR)
			-- Use ddmin to minimize witness `a_witness' (using ddmin algorithm by Andreas Zeller).
			--
			-- Note: this is not implemented as an {AUT_TASK}, which means the interface is blocked until
			--       a minimized witness was found.
		require
--			a_witness_not_void: a_witness /= Void
--			a_witness_is_fail: a_witness.is_fail
--			a_name_generator_not_void: a_name_generator /= Void
--			a_step_name_generator_not_void: a_step_name_generator /= Void
--			player_not_void: player /= Void
--			printer_not_void: printer /= Void
--			ddminer_not_void: ddminer /= Void
		local
--			file: KL_TEXT_OUTPUT_FILE
--			steps_file: KL_TEXT_OUTPUT_FILE
--			l_minimized_witness: AUT_WITNESS
--			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
--			error_handler.report_minimization_task
--			a_step_name_generator.output_string.wipe_out
--			a_step_name_generator.generate_new_name
--			create steps_file.make (file_system.nested_pathname (output_dirname, <<"log", a_step_name_generator.output_string >>))
--			steps_file.open_write
--			if steps_file.is_open_write then
--				ddminer.minimize (a_witness, steps_file)
--				l_minimized_witness := ddminer.last_result
--				a_name_generator.output_string.wipe_out
--				a_name_generator.generate_new_name
--				create file.make (file_system.nested_pathname (output_dirname, <<"log", a_name_generator.output_string >>))
--				file.open_write
--				if file.is_open_write then
--					create response_printer.make (file)
--					printer.set_output_stream (file)
--					printer.print_test_case (a_witness.request_list, Void)
--					a_witness.item (a_witness.count).response.process (response_printer)
--					printer.print_test_case (ddminer.last_result.request_list, Void)
--					l_minimized_witness.item (l_minimized_witness.count).response.process (response_printer)
--					printer.set_output_stream (null_output_stream)
--					file.close
--				else
--					error_handler.report_cannot_write_error (file.name)
--				end
--				error_handler.report_benchmark_message ("ddmin total time: " + ddminer.total_time.second_count.out + "s, " + ddminer.total_time.millisecond_count.out + "ms.")
--				error_handler.report_benchmark_message ("ddmin execution time: " + ddminer.execution_time.second_count.out + "s, " + ddminer.execution_time.millisecond_count.out + "ms.")
--				error_handler.report_benchmark_message ("ddmin number of executions: " + ddminer.execution_count.out)
--				if ddminer.execution_count > 0 then
--					error_handler.report_benchmark_message ("ddmin avg. execution time: " + (ddminer.execution_time.second_count / ddminer.execution_count).out + "s, " + (ddminer.execution_time.millisecond_count / ddminer.execution_count).out + "ms.")
--				else
--					error_handler.report_benchmark_message ("ddmin avg. execution time: 0s, 0ms.")
--				end
--				error_handler.report_benchmark_message ("ddmin fn: " + file.name)
--				error_handler.report_benchmark_message ("ddmin original loc: " + a_witness.count.out)
--				error_handler.report_benchmark_message ("ddmin minimized loc: " + l_minimized_witness.count.out)
--				error_handler.report_benchmark_message ("ddmin successful: " + (l_minimized_witness.is_fail and then l_minimized_witness.is_same_bug (a_witness)).out)
--			else
--				error_handler.report_cannot_write_error (steps_file.name)
--			end
		end

	all_used_vars (a_req_list: DS_LIST [AUT_REQUEST]): DS_HASH_TABLE [TUPLE [type: detachable TYPE_A; name: detachable STRING; check_dyn_type: BOOLEAN; use_void: BOOLEAN], ITP_VARIABLE]
			-- All variables used in the request list `a_req_list' with the names of their types
		require
			a_req_list_not_void: a_req_list /= Void
		local
			all_used_vars_updater: AUT_ALL_USED_VARIABLES_UPDATER
			request: AUT_REQUEST
			i: INTEGER
			l_type_name: STRING
			l_type: TYPE_A
		do
			from
				create all_used_vars_updater.make (system)
				i := 1
			until
				i > a_req_list.count
			loop
				request := a_req_list.item (i)
				request.process (all_used_vars_updater)
				i := i + 1
			end
			Result := all_used_vars_updater.variables
			from
				Result.start
			until
				Result.after
			loop
				if Result.item_for_iteration.name = Void or Result.item_for_iteration.check_dyn_type then
					if interpreter.variable_table.is_variable_defined (Result.key_for_iteration) then
						l_type := interpreter.variable_table.variable_type (Result.key_for_iteration)
						if l_type /= Void then
							l_type_name := type_name_with_context (l_type, interpreter.interpreter_root_class, Void)
						else
							interpreter.retrieve_type_of_variable (Result.key_for_iteration)
							l_type := interpreter.variable_table.variable_type (Result.key_for_iteration)
							if l_type = Void then
								l_type := none_type
								l_type_name := none_type_name
							else
								l_type_name := type_name_with_context (l_type, interpreter.interpreter_root_class, Void)
							end
						end
					else
						l_type := none_type
						l_type_name := none_type_name
					end
					if
						Result.item_for_iteration.name /= Void and
						Result.item_for_iteration.check_dyn_type and
						l_type_name.is_equal (none_type_name)
					then
						Result.force ([l_type, l_type_name, False, True], Result.key_for_iteration)
					else
						Result.force ([l_type, l_type_name, False, False], Result.key_for_iteration)
					end
				end
				Result.forth
			end
		end

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
