note
	description: "Output handler for results"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_HANDLER

inherit
	HELPER

	LOCALIZED_PRINTER

feature -- Access

	worker_count: INTEGER
			-- Count of workers

	increase_worker_count
			-- Increase worker count
		local
			l_workers: like non_reported_workers
		do
			worker_count := worker_count + 1
			l_workers := non_reported_workers
			if l_workers = Void then
				create l_workers.make (10)
				non_reported_workers := l_workers
			end
			l_workers.extend (worker_count)
		end

	finish_report (a_worker_id: INTEGER)
			-- Finish report
		deferred
		end

feature -- Query

	previous_worker_reported (a_worker_id: INTEGER): BOOLEAN
			-- Has all previous workers reported?
		do
			if a_worker_id /= 0 then
				if attached non_reported_workers as l_workers and then not l_workers.is_empty then
					Result := a_worker_id = l_workers.first
					debug
						print ("previous_worker_reported: a_worker_id" + a_worker_id.out + " first: " + l_workers.first.out)
					end
				else
					Result := True
				end
			else
				Result := True
			end
			debug
				print (" Result: " + Result.out + "%N")
			end
		end

	arguments: ARGUMENT_PARSER
			-- Command line arguments.
		deferred
		end

	base_location: detachable PATH
			-- Base location where to look for .ecf files.
		deferred
		end

	action_mode (a_input_handler: separate INPUT_HANDLER): STRING_32
		once
			if a_input_handler.is_test then
				Result := interface_text_testing
			elseif a_input_handler.is_melt then
				Result := interface_text_melting
			elseif a_input_handler.is_freeze then
				Result := interface_text_freezing
			elseif a_input_handler.is_finalize then
				Result := interface_text_finalizing
			else
				Result := "Unknown"
			end
		end

feature -- Output

	interface_output_action_template: READABLE_STRING_32

	interface_text_target: READABLE_STRING_32

	interface_text_error: READABLE_STRING_32
	interface_text_passed: READABLE_STRING_32
	interface_text_failed: READABLE_STRING_32
	interface_text_ignored: READABLE_STRING_32

	interface_text_parsing: READABLE_STRING_32
	interface_text_melting: READABLE_STRING_32
	interface_text_freezing: READABLE_STRING_32
	interface_text_finalizing: READABLE_STRING_32
	interface_text_testing: READABLE_STRING_32

	initialize_interface_texts
			-- Initialize interface_text_* with default values
		do
			interface_output_action_template := "#action #target from #system-#uuid (#ecf): "

			interface_text_target := "Target"
			interface_text_parsing := "Parsing"
			interface_text_melting := "Melting"
			interface_text_freezing := "Freezing"
			interface_text_finalizing := "Finalizing"
			interface_text_testing := "Testing"

			interface_text_error := "error"
			interface_text_passed := "passed"
			interface_text_failed := "failed"
			interface_text_ignored := "ignored"
		end

	set_interface_texts_from_argument (args: like arguments)
			-- Initialize interface_text_* with eventual values specified via the arguments
		do
			if attached arguments.interface_output_action_template as tpl then
				interface_output_action_template := tpl
			end

			interface_text_target := args.interface_text ("Target")

			interface_text_parsing := args.interface_text ("Parsing")
			interface_text_melting := args.interface_text ("Melting")
			interface_text_freezing := args.interface_text ("Freezing")
			interface_text_finalizing := args.interface_text ("Finalizing")

			interface_text_error := args.interface_text ("error")
			interface_text_passed := args.interface_text ("passed")
			interface_text_failed := args.interface_text ("failed")
			interface_text_ignored := args.interface_text ("ignored")
		end

	output_status_internal_error (a_worker_id: INTEGER)
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			localized_print (interface_text_error)
		end

	output_status_passed (a_worker_id: INTEGER)
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			localized_print (interface_text_passed)
		end

	output_status_failed (a_worker_id: INTEGER)
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			localized_print (interface_text_failed)
		end

	output_status_ignored (a_worker_id: INTEGER)
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			localized_print (interface_text_ignored)
		end

	output_detailed_status (a_output: separate STRING; a_worker_id: INTEGER)
			-- Output detailed status
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		local
			l_matcher: like test_output_regex
			l_outputs: STRING
		do
			create l_outputs.make_from_separate (a_output)
			from
				l_matcher := test_output_regex
				l_matcher.match (l_outputs)
			until
				not l_matcher.has_matched
			loop
				if attached l_matcher.captured_substring (0) as l_ms then
					io.output.put_string ("%N%T")
					localized_print (l_ms)
				end
				l_matcher.next_match
			end
		end

	output_new_line (a_worker_id: INTEGER)
			-- Output a new line
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			io.new_line
		end

	output_error (a_message: separate READABLE_STRING_GENERAL; a_worker_id: INTEGER)
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		do
			localized_print_error (create {STRING_32}.make_from_separate (a_message))
		end

	output_action (a_action: separate READABLE_STRING_32; a_target: separate CONF_TARGET; a_worker_id: INTEGER)
			-- Display in the console the output progress report for compilations
		require
			previous_worker_reported: previous_worker_reported (a_worker_id)
		local
			l_system: separate CONF_SYSTEM
			l_target_name, l_system_name, l_uuid: READABLE_STRING_32
			l_ecf: PATH
			t: STRING_32
			l_action: STRING_32
		do
			l_system := target_system (a_target)
			l_system_name := system_name (l_system)
			l_ecf := system_path (l_system)
			l_uuid := any_out (system_uuid (l_system))
			l_target_name := target_name (a_target)

			create t.make_from_string (interface_output_action_template)
			create l_action.make_from_separate (a_action)
			t.replace_substring_all ("#action", l_action)
			t.replace_substring_all ("#system", l_system_name)
			t.replace_substring_all ("#target", l_target_name)
			t.replace_substring_all ("#uuid", l_uuid)
			t.replace_substring_all ("#absolute_ecf", l_ecf.name)
			if arguments.is_log_verbose then
				t.replace_substring_all ("#log_filename", logs_filename (arguments.logs_dir, l_action, a_target).name)
			else
				t.replace_substring_all ("#log_filename", "")
			end

				-- To avoid a lot of display, we try to only display the part after
				-- `base_location'.
			if l_ecf.name.substring_index (base_location.name, 1) = 1 then
				t.replace_substring_all ("#ecf", l_ecf.name.substring (base_location.name.count + 2, l_ecf.name.count))
			else
				t.replace_substring_all ("#ecf", l_ecf.name)
			end

			localized_print (t)
		end

	add_data_to_file (a_file_name: separate PATH; a_target: separate CONF_TARGET; ec_args: separate STRING_8; a_worker_id: INTEGER)
			-- Insert some data in `a_file_name' saying what we are compiling and when.
		require
			a_file_name_attached: a_file_name /= Void
			a_target_attached: a_target /= Void
			ec_args_attached: ec_args /= Void
			previous_worker_reported: previous_worker_reported (a_worker_id)
		local
			retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_date: DATE_TIME
			u: UTF_CONVERTER
			l_config: STRING_32
		do
			if not retried then
				l_config := system_file_name (target_system (a_target))

				create l_date.make_now
				create l_file.make_with_path (create {PATH}.make_from_separate (a_file_name))

				l_file.open_append
				if l_file.is_empty then
					l_file.put_string ({UTF_CONVERTER}.utf_8_bom_to_string_8)
				end
				l_file.put_string ("**********************************************************************%N")
				l_file.put_string ("Date: ")
				l_file.put_string (l_date.out)
				l_file.put_string ("%NCompiling target %"")
				l_file.put_string (u.utf_32_string_to_utf_8_string_8 (target_name (a_target)))
				l_file.put_string ("%" from config %"")
				l_file.put_string (u.utf_32_string_to_utf_8_string_8 (l_config))
				l_file.put_string ("%"%N%N")
				l_file.put_string ("Compiler's arguments in UTF-8 encoding: ")
				l_file.put_string (create {STRING_8}.make_from_separate (ec_args))
				l_file.put_string ("%N")
				if attached ISE_EC_FLAGS_environment_variable_value as v then
					l_file.put_string ("ISE_EC_FLAGS: "+ v + "%N")
				end

				l_file.close
			end
		rescue
			retried := True
			retry
		end

	report_internal_error (a_worker_id: INTEGER)
			-- Report tool internal error
		do
			internal_error_count := internal_error_count + 1
		end

	report_passed (a_worker_id: INTEGER)
			-- Report passed targets
		do
			passed_count := passed_count + 1
		end

	report_failed (a_action: separate STRING_32; a_target: separate CONF_TARGET; a_worker_id: INTEGER)
			-- Report failed targets
		local
			l_logfn: detachable PATH
		do
			if arguments.is_log_verbose then
				l_logfn := logs_filename (arguments.logs_dir, create {STRING_32}.make_from_separate (a_action), a_target)
			end
			failed_targets.extend ([l_logfn, system_path (target_system (a_target)), system_name (target_system (a_target)), target_name (a_target), any_out (system_uuid (target_system (a_target)))])
		end

	report_ignored (a_worker_id: INTEGER)
			-- Report skipped or ignored target
		do
			ignored_count := ignored_count + 1
		end

feature {NONE} -- Implementation: results

	failed_targets: LINKED_LIST [TUPLE [log: detachable PATH; ecf: PATH; system, target, uuid: READABLE_STRING_GENERAL]]

	failed_count: INTEGER
			-- Count of failed targets
		do
			Result := failed_targets.count
		end

	passed_count: INTEGER
			-- Count of passed targets

	ignored_count: INTEGER
			-- Count of ignored targets

	internal_error_count: INTEGER
			-- Count of internal error targets

	total_count: INTEGER
			-- Total number of ECFs under processing. Only accurate at the end.
		do
			Result := passed_count + failed_count + ignored_count + internal_error_count
		end

	report_summary
			-- Report summary
		do
			io.put_new_line
			localized_print("Passed: ")
			io.put_integer (passed_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print("  (")
			io.put_integer (((passed_count / total_count) * 100).truncated_to_integer)
			localized_print ("%%)")
			io.put_new_line

			localized_print ("Failed: ")
			io.put_integer (failed_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print ("  (")
			io.put_integer (((failed_count / total_count) * 100).truncated_to_integer)
			localized_print ("%%)")
			io.put_new_line

			localized_print ("Ignored: ")
			io.put_integer (ignored_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print ("  (")
			io.put_integer (((ignored_count / total_count) * 100).truncated_to_integer)
			localized_print ("%%)")
			io.put_new_line

			io.put_new_line
			if arguments.list_failures then
				io.put_new_line
				if failed_count > 0 then
					localized_print (failed_count.out + " failure(s):")
					io.put_new_line
					across
						failed_targets as c
					loop
						localized_print ({STRING_32} "" + c.item.system + "-" + c.item.uuid + "-" + c.item.target + " (" + c.item.ecf.name + ")")
						if attached c.item.log as l_logfn then
							localized_print ({STRING_32} ": " + l_logfn.name)
						end
						io.put_new_line
					end
				end
			end
		end

feature {NONE} -- Implementation

	ISE_EC_FLAGS_environment_variable_value: detachable READABLE_STRING_32
		local
			e: EXECUTION_ENVIRONMENT
		once
			create e
			if attached e.item ("ISE_EC_FLAGS") as v then
				v.left_adjust
				if not v.is_empty then
					Result := v
				end
			end
		end

feature {NONE} -- Implementation

	non_reported_workers: detachable ARRAYED_LIST [INTEGER];

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
