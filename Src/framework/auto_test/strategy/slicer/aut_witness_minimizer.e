indexing
	description: "Summary description for {AUT_WITNESS_MINIMIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_WITNESS_MINIMIZER

inherit
	AUT_TASK

	AUT_SHARED_TYPE_FORMATTER
		export
			{NONE} all
		end

	ERL_CONSTANTS
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

create
	make

feature {NONE} -- Initialization

	make (a_result_repo: like result_repository;
	      a_interpreter: like interpreter;
	      a_error_handler: like error_handler;
	      a_system: like system;
	      a_output_dirname: like output_dirname;
	      a_ddmin_enabled: like is_ddmin_enabled;
	      a_slicing_enabled: like is_slicing_enabled)
		do
			result_repository := a_result_repo
			interpreter := a_interpreter
			error_handler := a_error_handler
			system := a_system
			output_dirname := a_output_dirname
			is_ddmin_enabled := a_ddmin_enabled
			is_slicing_enabled := a_slicing_enabled
		end

feature {NONE} -- Access

	interpreter: AUT_INTERPRETER_PROXY
			-- Interpreter for system under test

	result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Repository storing test case results

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	system: SYSTEM_I
			-- System under test

	output_dirname: STRING
			-- Name of output directory

	cursor: DS_LINEAR_CURSOR [AUT_WITNESS]
	slice_name_generator: AUT_UNIQUE_NAME_GENERATOR
	ddmin_name_generator: AUT_UNIQUE_NAME_GENERATOR
	ddmin_step_name_generator: AUT_UNIQUE_NAME_GENERATOR

	successfully_minimized_witnesses: DS_ARRAYED_LIST [AUT_WITNESS]
			-- List of witnesses that could be minimized and are added to the result repository


feature {NONE} -- Access: slice

	slice_task: ?AUT_TASK

	last_witness: AUT_WITNESS
			-- Last witness minimized

	slicer: AUT_SLICER
	player: AUT_REQUEST_PLAYER
	printer: AUT_TEST_CASE_PRINTER
	ddminer: AUT_DD_MINIMIZER

	timer_total: AUT_TIMER
	timer_execution: AUT_TIMER

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status report

	has_launched: BOOLEAN
			-- Has `start' been called before?

	is_slicing_enabled: BOOLEAN
			-- Should test cases be minimized via slicing?

	is_ddmin_enabled: BOOLEAN
			-- Should test cases be minimized via ddmin?

feature -- Basic operations

	start
			-- <Precursor>
		do
			interpreter.set_is_logging_enabled (False)
			interpreter.set_is_in_replay_mode (True)
			create player.make (system, interpreter)
			create slicer.make
			create ddminer.make (system, player, error_handler)
			create printer.make_null (system)
			create slice_name_generator.make_with_string_stream ("slice_")
			create ddmin_name_generator.make_with_string_stream ("ddmin_")
			create ddmin_step_name_generator.make_with_string_stream ("ddmin_step_")
			create successfully_minimized_witnesses.make_default
			cursor := result_repository.witnesses.new_cursor
			cursor.start
			has_next_step := True
		end

	step
			-- <Precursor>
		do
			if slice_task /= Void then
				if slice_task.has_next_step then
					slice_task.step
				else
					slice_task := Void
					finish_slice (last_witness, slice_name_generator)
				end
			elseif not cursor.off then
				if cursor.item.is_fail then
					last_witness := cursor.item
					if is_slicing_enabled then
						prepare_slice (last_witness, slice_name_generator)
					end
					if is_ddmin_enabled then
						ddmin_witness (last_witness, ddmin_name_generator, ddmin_step_name_generator)
					end
				end
				cursor.item.set_used_vars (all_used_vars (cursor.item.request_list))
				cursor.forth
			else
				if interpreter.is_running then
					interpreter.stop
				end
				from
					successfully_minimized_witnesses.start
				until
					successfully_minimized_witnesses.after
				loop
					result_repository.add_witness (successfully_minimized_witnesses.item_for_iteration)
					successfully_minimized_witnesses.forth
				end
				cancel
			end
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

feature {NONE} -- Implementation

	prepare_slice (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR)
		do
			create timer_total.make
			create timer_execution.make
			error_handler.report_minimization_task
			timer_total.start
			slicer.extract_backward_slice (a_witness)
			timer_total.calculate_duration
			error_handler.report_benchmark_message ("slice extraction time: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + " ms.")
			a_name_generator.output_string.wipe_out
			a_name_generator.generate_new_name
			player.set_request_list (slicer.last_slice)
			timer_execution.start

			player.start
			slice_task := player
		end

	finish_slice (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR)
		local
			file: KL_TEXT_OUTPUT_FILE
			last_all_used_vars: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE]
			sliced_witness: AUT_WITNESS
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			timer_execution.calculate_duration
			timer_total.calculate_duration
			create sliced_witness.make_default (slicer.last_slice)
			create file.make (file_system.nested_pathname (output_dirname, <<"log", a_name_generator.output_string >>))
			if sliced_witness.is_fail and then sliced_witness.is_same_bug (a_witness) then
				last_witness := sliced_witness
				last_all_used_vars := all_used_vars (slicer.last_slice)
				last_witness.set_used_vars (last_all_used_vars)
				successfully_minimized_witnesses.force_last (last_witness)
				file.open_write
				if file.is_open_write then
					create response_printer.make (file)
					printer.set_output_stream (file)
					printer.print_test_case (a_witness.request_list, Void)
					a_witness.item (a_witness.count).response.process (response_printer)
					printer.print_test_case (slicer.last_slice, last_all_used_vars)
					if sliced_witness.item (sliced_witness.count).response /= Void then
						sliced_witness.item (sliced_witness.count).response.process (response_printer)
					end
					printer.set_output_stream (null_output_stream)
					file.close
				else
					error_handler.report_cannot_read_error (file.name)
				end
			end
			error_handler.report_benchmark_message ("slice execution time: " + timer_execution.last_duration.second_count.out + "s, " + timer_execution.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice minimization time total: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice fn: " + file.name)
			error_handler.report_benchmark_message ("slice original loc: " + a_witness.count.out)
			error_handler.report_benchmark_message ("slice minimized loc: " + last_witness.count.out)
			error_handler.report_benchmark_message ("slice successful: " + (sliced_witness.is_fail and then a_witness.is_same_bug (sliced_witness)).out)
		end

	ddmin_witness (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR; a_step_name_generator: AUT_UNIQUE_NAME_GENERATOR) is
			-- Use ddmin to minimize witness `a_witness' (using ddmin algorithm by Andreas Zeller).
		require
			a_witness_not_void: a_witness /= Void
			a_witness_is_fail: a_witness.is_fail
			a_name_generator_not_void: a_name_generator /= Void
			a_step_name_generator_not_void: a_step_name_generator /= Void
			player_not_void: player /= Void
			printer_not_void: printer /= Void
			ddminer_not_void: ddminer /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			steps_file: KL_TEXT_OUTPUT_FILE
			minimized_witness: AUT_WITNESS
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			error_handler.report_minimization_task
			a_step_name_generator.output_string.wipe_out
			a_step_name_generator.generate_new_name
			create steps_file.make (file_system.nested_pathname (output_dirname, <<"log", a_step_name_generator.output_string >>))
			steps_file.open_write
			if steps_file.is_open_write then
				ddminer.minimize (a_witness, steps_file)
				minimized_witness := ddminer.last_result
				a_name_generator.output_string.wipe_out
				a_name_generator.generate_new_name
				create file.make (file_system.nested_pathname (output_dirname, <<"log", a_name_generator.output_string >>))
				file.open_write
				if file.is_open_write then
					create response_printer.make (file)
					printer.set_output_stream (file)
					printer.print_test_case (a_witness.request_list, Void)
					a_witness.item (a_witness.count).response.process (response_printer)
					printer.print_test_case (ddminer.last_result.request_list, Void)
					minimized_witness.item (minimized_witness.count).response.process (response_printer)
					printer.set_output_stream (null_output_stream)
					file.close
				else
					error_handler.report_cannot_write_error (file.name)
				end
				error_handler.report_benchmark_message ("ddmin total time: " + ddminer.total_time.second_count.out + "s, " + ddminer.total_time.millisecond_count.out + "ms.")
				error_handler.report_benchmark_message ("ddmin execution time: " + ddminer.execution_time.second_count.out + "s, " + ddminer.execution_time.millisecond_count.out + "ms.")
				error_handler.report_benchmark_message ("ddmin number of executions: " + ddminer.execution_count.out)
				if ddminer.execution_count > 0 then
					error_handler.report_benchmark_message ("ddmin avg. execution time: " + (ddminer.execution_time.second_count / ddminer.execution_count).out + "s, " + (ddminer.execution_time.millisecond_count / ddminer.execution_count).out + "ms.")
				else
					error_handler.report_benchmark_message ("ddmin avg. execution time: 0s, 0ms.")
				end
				error_handler.report_benchmark_message ("ddmin fn: " + file.name)
				error_handler.report_benchmark_message ("ddmin original loc: " + a_witness.count.out)
				error_handler.report_benchmark_message ("ddmin minimized loc: " + minimized_witness.count.out)
				error_handler.report_benchmark_message ("ddmin successful: " + (minimized_witness.is_fail and then minimized_witness.is_same_bug (minimized_witness)).out)
			else
				error_handler.report_cannot_write_error (steps_file.name)
			end
		end

	all_used_vars (a_req_list: DS_LIST [AUT_REQUEST]): DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE] is
			-- All variables used in the request list `a_req_list' with the names of their types
		require
			a_req_list_not_void: a_req_list /= Void
		local
			all_used_vars_updater: AUT_ALL_USED_VARIABLES_UPDATER
			request: AUT_REQUEST
			i: INTEGER
			l_type_name: STRING
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
				if Result.item_for_iteration.item (1) = Void or Result.item_for_iteration.item (2).is_equal (True) then
					if interpreter.variable_table.is_variable_defined (Result.key_for_iteration) then
						if interpreter.variable_table.variable_type (Result.key_for_iteration) /= Void then
							l_type_name := type_name_with_context (interpreter.variable_table.variable_type (Result.key_for_iteration), interpreter.interpreter_root_class, Void)
						else
							interpreter.retrieve_type_of_variable (Result.key_for_iteration)
							if interpreter.variable_table.variable_type (Result.key_for_iteration) = Void then
								l_type_name := none_type_name
							else
								l_type_name := type_name_with_context (interpreter.variable_table.variable_type (Result.key_for_iteration), interpreter.interpreter_root_class, Void)
							end
						end
					else
						l_type_name := none_type_name
					end
					if Result.item_for_iteration.item (1) /= Void and Result.item_for_iteration.item (2).is_equal (True) and
						l_type_name.is_equal (none_type_name) then
							-- Do nothing.
					else
						Result.force ([l_type_name, False], Result.key_for_iteration)
					end
				end
				Result.forth
			end
		end

end
