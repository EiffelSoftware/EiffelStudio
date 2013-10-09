note
	description: "Worker to proces"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_WORKER

inherit
	HELPER

create
	make

feature {NONE} -- Init

	make (a_output_handler: like output_handler; a_input_handler: like input_handler)
			-- Make with `a_output_handler'.
		require
			a_output_handler_set: a_output_handler /= Void
			a_input_handler: a_input_handler /= Void
		do
			output_handler := a_output_handler
			input_handler := a_input_handler
			create redirected_output_mutex.make
		end

feature -- Status change

	set_target (a_target: separate CONF_TARGET)
			-- Set target on which the process is running.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

	set_ecf_location_dir (a_dir: separate PATH)
			-- Set ecf location dir
		require
			a_dir_set: a_dir /= Void and then not a_dir.is_empty
		do
			create ecf_location_dir.make_from_separate (a_dir)
		end

	set_ec_command_name (a_name: separate READABLE_STRING_GENERAL)
			-- Set ec command name
		do
			create ec_command_name.make_from_separate (a_name)
		end

	set_worker_id (a_id: INTEGER)
			-- Set worker id
		do
			worker_id := a_id
		ensure
			worker_id_set: worker_id = a_id
		end

feature -- Action

	run (a_clean: BOOLEAN)
		local
			b: BOOLEAN
		do
			if target_setting_msil_generation (target) and skip_dotnet (input_handler) then
				output_action (output_handler)
				report_ignored (output_handler)
				output_status_ignored (output_handler)
				output_new_line (output_handler)
			elseif not target_ignored (input_handler, target) then
				b := run_imp (a_clean)
				if not b and has_keep_failed (input_handler) then
					--| Keep failed
				elseif b and has_keep_passed (input_handler) then
					--| Keep passed
				elseif has_keep_all (input_handler) then
					--| Keep all
				else
					clean_after (compilation_dir (input_handler) = Void, compilation_directory (compilation_dir (input_handler), ecf_location_dir), target_name (target))
				end
			else
				output_action (output_handler)
				report_ignored (output_handler)
				output_status_ignored (output_handler)
				output_new_line (output_handler)
			end
			finish_report (output_handler)
		end

feature {NONE} -- Implemenetation

	run_imp (a_clean: BOOLEAN): BOOLEAN
			-- Process `a_target' located in `a_dir', clean before compilation if `a_clean'.
			-- and return True if the process was Ok, and False if it failed.
		require
			a_target_ok: target /= Void
			a_dir_ok: ecf_location_dir /= Void and then not ecf_location_dir.is_empty
		local
			l_args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_system, l_target: STRING_32
			l_file: PATH
			l_dir: DIRECTORY
			l_info_file: RAW_FILE
			l_info_filename: PATH
			rescued: BOOLEAN
			u: UTF_CONVERTER
			l_conf_system: separate CONF_SYSTEM
			l_ec_option: STRING_32
		do
			if not rescued then

				l_conf_system := target_system (target)
				l_system := system_name (l_conf_system)
				l_target := target_name (target)

				create l_args.make (10)
				l_args.extend ("-config")
				l_args.extend (system_file_name (l_conf_system))
				l_args.extend ("-target")
				l_args.extend (l_target)
				l_args.extend ("-batch")

				if is_c_compile (input_handler) or is_test (input_handler) then
					l_args.extend ("-c_compile")
				end

				if a_clean then
					l_args.extend ("-clean")
				end

				if is_experiment (input_handler) then
					l_args.extend ("-experiment")
				elseif is_compatible (input_handler) then
					l_args.extend ("-compat")
				end

				l_args.extend ("-project_path")
				if attached compilation_dir (input_handler) as l_compile_dir then
					l_info_filename := compilation_directory (l_compile_dir, ecf_location_dir)
					create l_dir.make_with_path (l_info_filename)
					mkdir (l_dir)
					create l_info_file.make_with_path (l_info_filename.extended ("ecf_location"))
					l_info_file.create_read_write
					l_info_file.put_string (u.utf_8_bom_to_string_8)
					l_info_file.put_string (u.utf_32_string_to_utf_8_string_8 (system_file_name (l_conf_system)))
					l_info_file.close

					l_args.extend (l_info_filename.name)
				else
						-- We always use the directory of the ECF by default
					l_args.extend (compilation_directory (Void, ecf_location_dir).name)
				end

				if is_test (input_handler) then
					l_args.extend ("-tests")
				elseif is_melt (input_handler) then
					l_args.extend ("-melt")
					if attached melt_ec_options (input_handler) as l_opt and then not l_opt.is_empty then
						l_args.extend (l_opt)
					end
				elseif is_freeze (input_handler) then
					l_args.extend ("-freeze")
					if attached freeze_ec_options (input_handler) as l_opt and then not l_opt.is_empty then
						l_args.extend (l_opt)
					end
				elseif is_finalize (input_handler) then
					l_args.extend ("-finalize")
					if attached finalize_ec_options (input_handler) as l_opt and then not l_opt.is_empty then
						l_args.extend (l_opt)
					end
				end

				l_ec_option := ec_options (input_handler)
				if not l_ec_option.is_empty then
					l_args.extend (l_ec_option)
				end
				debug
					across
						l_args as c
					loop
						print (c.item + " ")
					end
					print ("%N")
				end

				create l_prc_factory
				l_prc_launcher := l_prc_factory.process_launcher (ec_command_name, l_args, Void)

				redirected_output_mutex.lock
				redirected_output := Void
				redirected_output_mutex.unlock
				l_prc_launcher.redirect_output_to_agent (agent redirect_output)

				l_prc_launcher.redirect_error_to_same_as_output
				l_prc_launcher.set_separate_console (False)
				l_prc_launcher.launch

					-- Output after the process being launched, otherwise no parallel computation.
				output_action (output_handler)
				l_file := logs_filename (logs_dir (input_handler), action_mode (output_handler), target)
				if is_log_verbose (input_handler) then
					add_data_to_file (output_handler, l_file, target, args_to_string (l_args))
				end

				check result_unset: Result = False end
				if l_prc_launcher.launched then
					l_prc_launcher.wait_for_exit
					if is_log_verbose (input_handler) then
						save_verbose_output (l_file)
					end
					if l_prc_launcher.exit_code = 0 then
						if not is_test (input_handler) or else not has_failed_tests then
							report_passed (output_handler)
							output_status_passed (output_handler)
							Result := True
						else
							report_failed (output_handler)
							output_status_failed (output_handler)
							if is_log_verbose (input_handler) then
								output_detailed_status (output_handler)
							end
						end
					else
						report_failed (output_handler)
						output_status_failed (output_handler)
					end
				else
					report_internal_error (output_handler)
					output_status_internal_error (output_handler)
				end
				output_new_line (output_handler)
			else
				report_internal_error (output_handler)
				output_status_internal_error (output_handler)
			end
		rescue
			rescued := True
			retry
		end

	compilation_directory (a_compilation_dir: detachable PATH; a_ecf_dir: PATH): PATH
			-- Compilation directory
		local
			l_system: separate CONF_SYSTEM
			l_entry: STRING_32
		do
			if a_compilation_dir /= Void then
				Result := a_compilation_dir
				l_system := target_system (target)
				if attached system_path (l_system) as l_path and then attached l_path.entry as l_e then
					l_entry := l_e.name
				else
					l_entry := "no_ecf_path"
				end
				Result := Result.extended (l_entry + "-" + system_name (l_system) + "-" + any_out (system_uuid (l_system)))
			else
					-- We always use the directory of the ECF by default
				Result := a_ecf_dir
			end
		end

	clean_after (a_using_ecf_dir: BOOLEAN; a_dir: PATH; a_target_name: READABLE_STRING_32)
			-- Clean compilation directory
		local
			dn: PATH
			d: DIRECTORY
		do
			dn := a_dir.extended ("EIFGENs").extended (a_target_name)
			create d.make_with_path (dn)
			rmdir (d) --| Safe to delete under EIFGENs

			dn := a_dir.extended ("EIFGENs")
			d.make_with_path (dn)
			if d.exists and then d.is_empty then
				if a_using_ecf_dir then
					rmdir (d) --| Safe to delete EIFGENs
				else
					d.make_with_path (a_dir)
					safe_rmdir (d) --| Try to delete parent of EIFGENs
				end
			end
		end

	mkdir (d: DIRECTORY)
			-- Create directory `d' recursively
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if not d.exists then
					d.recursive_create_dir
					directories_created_by_application.force (d.path)
				end
			else
				output_error (output_handler, "ERROR: unable to create directory %"" + d.path.name + "%".%N")
			end
		rescue
			rescued := True
			retry
		end

	rmdir (d: DIRECTORY)
			-- remove directory `d' if exists
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if d.exists then
					d.recursive_delete
				end
			else
				output_error (output_handler, "ERROR: unable to remove directory %"" + d.path.name + "%".%N")
			end
		rescue
			rescued := True
			retry
		end

	safe_rmdir (d: DIRECTORY)
			-- remove directory only if created by this session
			-- mainly to avoid removing user folders ...
		do
			if d.exists then
				if directories_created_by_application.has (d.path) then
					rmdir (d)
				else
					check not_created_by_application: False end
				end
			end
		end

	save_verbose_output (a_file: PATH)
			-- Save detailed output into log file
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				redirected_output_mutex.lock
				if attached redirected_output as l_output then
					create l_file.make_with_path (a_file)
					l_file.open_append
					l_file.put_string (l_output)
					l_file.close
				end
				redirected_output_mutex.unlock
			end
		rescue
			l_retried := True
			redirected_output_mutex.unlock
			retry
		end

	has_failed_tests: BOOLEAN
			-- Has failed tests in last redirected output?
		local
			l_matcher: like test_output_regex
		do
			redirected_output_mutex.lock
			if attached redirected_output as l_outputs then
				from
					l_matcher := test_output_regex
					l_matcher.match (l_outputs)
				until
					not l_matcher.has_matched or Result
				loop
					if attached l_matcher.captured_substring (0) as l_ms then
						Result := not test_pass_output_regex.matches (l_ms)
					end
					l_matcher.next_match
				end
			end
			redirected_output_mutex.unlock
		end

	redirect_output (a_str: STRING)
			-- Redirect output
		local
			l_str: STRING
		do
			redirected_output_mutex.lock
			l_str := redirected_output
			if l_str = Void then
				create l_str.make_from_string (a_str)
				redirected_output := l_str
			else
				l_str.append (a_str)
			end
			redirected_output_mutex.unlock
		end

	redirected_output: STRING
			-- Redirected output

	redirected_output_mutex: MUTEX

	args_to_string (a_args: ARRAYED_LIST [READABLE_STRING_GENERAL]): STRING_8
			-- Args to string
		local
			u: UTF_CONVERTER
		do
			create Result.make (10)
			across
				a_args as c
			loop
				Result.append (u.utf_32_string_to_utf_8_string_8 (c.item) + " ")
			end
		end

	directories_created_by_application: ARRAYED_LIST [PATH]
			-- List of directories created by this application execution
		once
			create Result.make (25)
			Result.compare_objects
		end

feature {NONE} -- Input handler separate wrappers

--	location (a_input_handler: like input_handler): PATH
--			-- Location of files to use
--		once
--			Result := a_input_handler.location
--		end

--	logs_dir: detachable PATH
--			-- Location where the logs are stored.
--		once
--			if attached option_of_name (logdir_switch) as l_option then
--				create Result.make_from_string (l_option.value)
--			end
--		end

--	ignore: detachable IMMUTABLE_STRING_32
--			-- File with the ignores.
--		once
--			if has_option (ignore_switch) then
--				Result := option_of_name (ignore_switch).value
--			end
--		ensure
--			Result_ok: Result /= Void implies not Result.is_empty and then (create {RAW_FILE}.make_with_name (Result)).exists or (create {DIRECTORY}.make (Result)).exists
--		end

	is_ecb (a_input_handler: separate INPUT_HANDLER): BOOLEAN
		once
			Result := a_input_handler.is_ecb
		end

	is_experiment (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Use experimental library?
		once
			Result := a_input_handler.is_experiment
		end

	is_compatible (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Use experimental library?
		once
			Result := a_input_handler.is_compatible
		end

	is_log_verbose (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Log verbose status information?
		once
			Result := a_input_handler.is_log_verbose
		end

	is_clean (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Clean before compilation?
		once
			Result := a_input_handler.is_clean
		end

	is_c_compile (a_input_handler: separate INPUT_HANDLER): BOOLEAN
		once
			Result := a_input_handler.is_c_compile
		end

	is_melt (a_input_handler: separate INPUT_HANDLER): BOOLEAN
		once
			Result := a_input_handler.is_melt
		end

	is_freeze (a_input_handler: separate INPUT_HANDLER): BOOLEAN
		once
			Result := a_input_handler.is_freeze
		end

	is_finalize (a_input_handler: separate INPUT_HANDLER): BOOLEAN
		once
			Result := a_input_handler.is_finalize
		end

	has_keep (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Keep EIFGENs after compilation?
			--| By default: compilation data is removed after related compilation(s)
			--| if we melt+freeze+finalize then
			--| the data are removed only after the last compilation made on the same target
		once
			Result := a_input_handler.has_keep
		end

	has_keep_all (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Keep EIFGENs after any compilation?
		once
			Result := a_input_handler.has_keep_all
		end

	has_keep_failed (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Keep EIFGENs after Failed compilation?
		once
			Result := a_input_handler.has_keep_failed
		end

	has_keep_passed (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Keep EIFGENs after Passed compilation?
		once
			Result := a_input_handler.has_keep_passed
		end

	list_failures (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Finalize the project?
		once
			Result := a_input_handler.list_failures
		end

	ec_options (a_input_handler: separate INPUT_HANDLER): STRING_32
			-- Ec options
		once
			create Result.make_from_separate (a_input_handler.ec_options)
		end

	melt_ec_options (a_input_handler: separate INPUT_HANDLER): STRING_32
			-- 'ec' compiler option when melting
		once
			create Result.make_from_separate (a_input_handler.melt_ec_options)
		end

	freeze_ec_options (a_input_handler: separate INPUT_HANDLER): STRING_32
			-- 'ec' compiler option when freezing
		once
			create Result.make_from_separate (a_input_handler.freeze_ec_options)
		end

	finalize_ec_options (a_input_handler: separate INPUT_HANDLER): STRING_32
			-- 'ec' compiler option when finalizing
		once
			create Result.make_from_separate (a_input_handler.finalize_ec_options)
		end

	logs_dir (a_input_handler: separate INPUT_HANDLER): PATH
			-- Logs dir
		once
			create Result.make_from_separate (a_input_handler.logs_dir)
		end

	compilation_dir (a_input_handler: separate INPUT_HANDLER): detachable PATH
			-- Logs dir
		once
			if attached a_input_handler.compilation_dir as l_dir then
				create Result.make_from_separate (l_dir)
			end
		end

	skip_dotnet (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Skip dotnet
		once
			Result := a_input_handler.skip_dotnet
		end

	target_ignored (a_input_handler: separate INPUT_HANDLER; a_target: separate CONF_TARGET): BOOLEAN
		do
			Result := a_input_handler.target_ignored (a_target)
		end

	is_test (a_input_handler: separate INPUT_HANDLER): BOOLEAN
			-- Is for testing?
		once
			Result := a_input_handler.is_test
		end

feature {NONE} -- Output handler separate wrappers

	output_action (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_action%N")
			end
			a_output_handler.output_action (a_output_handler.action_mode (input_handler), target, worker_id)
		end

	output_detailed_status (a_output_handler: separate OUTPUT_HANDLER)
			-- Output detailed status
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		local
			l_out: like redirected_output
		do
			debug
				print (worker_id.out + " output_detailed_status%N")
			end
			if attached redirected_output as l_outputs then
				redirected_output_mutex.lock
				create l_out.make_from_string (l_outputs)
				redirected_output_mutex.unlock
				a_output_handler.output_detailed_status (l_out, worker_id)
			end
		end

	output_new_line (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_new_line%N")
			end
			a_output_handler.output_new_line (worker_id)
		end

	output_status_passed (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_status_passed%N")
			end
			a_output_handler.output_status_passed (worker_id)
		end

	add_data_to_file (a_output_handler: separate OUTPUT_HANDLER; a_file_name: PATH; a_target: separate CONF_TARGET; ec_args: STRING_8)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " add_data_to_file%N")
			end
			a_output_handler.add_data_to_file (a_file_name, a_target, ec_args, worker_id)
		end

	report_passed (a_output_handler: separate OUTPUT_HANDLER)
		do
			a_output_handler.report_passed (worker_id)
		end

	report_failed (a_output_handler: separate OUTPUT_HANDLER)
		do
			a_output_handler.report_failed (a_output_handler.action_mode (input_handler), target, worker_id)
		end

	report_ignored (a_output_handler: separate OUTPUT_HANDLER)
		do
			a_output_handler.report_ignored (worker_id)
		end

	report_internal_error (a_output_handler: separate OUTPUT_HANDLER)
		do
			a_output_handler.report_internal_error (worker_id)
		end

	output_status_failed (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_status_failed%N")
			end
			a_output_handler.output_status_failed (worker_id)
		end

	output_status_ignored (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_status_ignored%N")
			end
			a_output_handler.output_status_ignored (worker_id)
		end

	output_status_internal_error (a_output_handler: separate OUTPUT_HANDLER)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_status_internal_error%N")
			end
			a_output_handler.output_status_internal_error (worker_id)
		end

	output_error (a_output_handler: separate OUTPUT_HANDLER; a_message: READABLE_STRING_GENERAL)
		require
			previous_worker_reported: a_output_handler.previous_worker_reported (worker_id)
		do
			debug
				print (worker_id.out + " output_error%N")
			end
			a_output_handler.output_error (a_message, worker_id)
		end

	finish_report (a_output_handler: separate OUTPUT_HANDLER)
			-- Finish report
		do
			a_output_handler.finish_report (worker_id)
		end

	action_mode (a_output_handler: separate OUTPUT_HANDLER): STRING_32
		once
			create Result.make_from_separate (a_output_handler.action_mode (input_handler))
		end

feature -- Access

	ecf_location_dir: PATH
			-- Compilation dir

	target: separate CONF_TARGET
			-- Target to process

	ec_command_name: STRING_32
			-- Ec command name

	worker_id: INTEGER
			-- Id of the worker

feature {NONE} -- Implementation

	input_handler: separate INPUT_HANDLER
			-- Input handler

	output_handler: separate OUTPUT_HANDLER;
			-- Output handler

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
