note
	description: "Convert eweasel testing control file to a testing control class file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_TEST_EWEASEL_TCF_CONVERTER

inherit
	ANY

	EW_INSTRUCTION_TABLES
		export
			{NONE} all
		end

	EW_STRING_UTILITIES
		export
			{NONE} all
		end

create
	make_default

feature {NONE} -- Initialization

	make_default
			-- Creation method which do nothing
		do
			prepare_catalog
		end

	catalog_converter: EW_EQA_TEST_EWEASEL_CATALOG_CONVERTER
			-- Catalog file converter

	prepare_catalog
			-- Prepare related catalog files
		local
			l_factory: EW_EQA_TEST_FACTORY
		do
			create catalog_converter
			create l_factory
			catalog_converter.convert_catalog
				((create {PATH}.make_from_string
					(l_factory.environment.substitute (l_factory.environment.value ({STRING_32} "EWEASEL")))).extended
					("control").extended
					("catalog"))
		end

feature -- Command

	set_ignore_non_exist_test_cases (a_bool: BOOLEAN)
			-- Set `is_ignore_non_exist_test_cases' with `a_bool'
		do
			is_ignore_non_exist_test_cases := a_bool
		ensure
			set: is_ignore_non_exist_test_cases = a_bool
		end

	append_one_test_routine (a_input_tcf: PATH; a_test_name: STRING)
			-- Convert testing instructions in `a_input_file'
		require
			not_void: a_input_tcf /= Void
			not_void: a_test_name /= Void
		do
			if temp_converted = Void then
				temp_converted := ""
			end
			if is_ignore_non_exist_test_cases then
				if catalog_converter.has_folder_name (a_test_name) then
					temp_converted.append ("%N" + convert_one_tcf (a_input_tcf, a_test_name))
				end
			else
				temp_converted.append ("%N" + convert_one_tcf (a_input_tcf, a_test_name))
			end
		end

	flush_to_output_file (a_output_file_name: PATH; a_class_name: READABLE_STRING_32)
			-- Write `temp_converted' to `a_output_file'
		require
			not_void: a_output_file_name /= Void
			not_void: a_class_name /= Void
			needed: is_flush_needed
		do
			temp_converted := test_control_file_template_content (temp_converted, a_class_name.as_upper)
			write_content_to_file (temp_converted, a_output_file_name)
			temp_converted := Void
		end

feature {EW_EQA_WINDOWS_SETUP} -- Internal

	write_content_to_file (a_content: STRING; a_output_file: PATH)
			-- Writing converted strings to template file
		require
			not_void: a_output_file /= Void
		local
			l_io: IO_MEDIUM
			l_raw_file: PLAIN_TEXT_FILE
		do
				-- Overwrite previous generated tcf
			create l_raw_file.make_with_path (a_output_file)
			if l_raw_file.exists then
				l_raw_file.delete
			end
			if not l_raw_file.is_closed then
				l_raw_file.close
			end
			l_io := create_file (a_output_file)
			l_io.put_string (a_content)
			l_io.close
		end

	all_eweasel_test_case_template_content (all_converted_class_content: READABLE_STRING_8): STRING
			--
		require
			all_converted_class_names_not_void: all_converted_class_content /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (all_eweasel_test_case_template_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)
				Result.replace_substring_all ("$TEST_CASES", all_converted_class_content)
			else
				Result := "Warning: template file not found"
				print ("%NWarning: can't read file " + all_eweasel_test_case_template_file_name.utf_8_name)
			end
		end

feature -- Query

	is_ignore_non_exist_test_cases: BOOLEAN
			-- If test case not found in catalog file, should we ignore it?

	is_flush_needed: BOOLEAN
			-- If `flush_to_output_file' needed?
		do
			Result := temp_converted /= Void and then not temp_converted.is_empty
		end

feature {NONE} -- Implementation

	temp_converted: STRING
			-- Temppoary converted testing instructions
			-- Used by `append_one_test_routine' and `flush_to_output_file' only!

	convert_class_file (a_input_file: PATH; a_output_class_name: READABLE_STRING_32)
				-- Convert an old eweasel testing instruction plain text file (`a_input_file') to
				-- new style Eiffel class testing class file (`a_output_file')
		require
			not_void: a_input_file /= Void
			not_void: a_output_class_name /= Void
		local
			l_converted: STRING
		do
			l_converted := convert_one_tcf (a_input_file, "start")
			l_converted := test_control_file_template_content (l_converted, a_output_class_name)
			write_content_to_file (l_converted, (create {PATH}.make_from_string (a_output_class_name)).appended_with_extension ("e"))
		end

	test_description: detachable READABLE_STRING_8
			-- Test description

	test_name: detachable READABLE_STRING_8
			-- Test name

	digits_of (a_routine_name: STRING): STRING
			-- Digits of `a_routine_name'
		require
			not_void: a_routine_name /= Void
		do
			from
				Result := a_routine_name.twin
			until
				Result.is_integer or Result.count < 2
			loop
				Result := Result.substring (2, Result.count)
			end
		ensure
			not_void: Result /= Void
			not_same_instance: Result /= a_routine_name
		end

	convert_one_tcf (a_input_file: PATH; a_routine_name: STRING): STRING
			-- Convert instructions in `a_input_file' to correspond Eiffel codes
		require
			not_void: a_input_file /= Void
			not_void: a_routine_name /= Void
			cleared: test_description = Void and test_name = Void
		local
			l_index: INTEGER
			l_final_arguments: STRING
		do
			create control_file.make_for_convertion

			across
				control_file.parse_file (a_input_file) as i
			from
				Result := "%N%Ttest_" + digits_of (a_routine_name)
				Result.append ("%N%T%T%T-- Test " + a_routine_name)
				-- Insert test name and test description here
				l_index := Result.count
				Result.append ("%N%T%Tdo")
				catalog_converter.clear_test_arguments
				catalog_converter.append_related_setup (a_routine_name, Result)
			loop
				if attached convert_instruction_to_one_line (i.item) as l_temp_string and then not l_temp_string.is_empty then
					Result.append ("%N%T%T%T" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_temp_string))
				end
			end

			Result.append ("%N%T%Tend")

			l_index := l_index + 1

			if attached catalog_converter.test_arguments as l_arguments and then not l_arguments.is_empty then
				l_arguments.right_adjust
				across
					broken_into_words_8 (l_arguments) as w
				from
					create l_final_arguments.make_empty
				loop
					l_final_arguments.append ("eweasel/" + w.item)
					if not w.is_last then
						l_final_arguments.append (", ")
					end
				end
				Result.insert_string ("%N%T%T%Ttesting: %"" + l_final_arguments + "%"", l_index)
				Result.insert_string ("%N%T%Tnote", l_index)
			end

			if attached test_description as l_description then
				Result.insert_string ("%N%T%T%T-- " + l_description, l_index)
				test_description := Void
			end

			if attached test_name as l_name then
				Result.insert_string ("%N%T%T%T-- " + l_name, l_index)
				test_name := Void
			end

		ensure
			not_void: Result /= Void
			cleared: test_description = Void and test_name = Void
		end

	create_file (a_file_name: PATH): IO_MEDIUM
			-- Create a new {IO_MEDIUM} which file name is `a_file_name'
			-- Callers have to close `Result' themselves
		require
			not_void: a_file_name /= Void
			valid: not a_file_name.is_empty
			not_exists: not (create {PLAIN_TEXT_FILE}.make_with_path (a_file_name)).exists
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (a_file_name)
			check not_exits: not l_file.exists end
			l_file.create_read_write
			Result := l_file
		ensure
			not_void: Result /= Void
			created: (create {PLAIN_TEXT_FILE}.make_with_path (a_file_name)).exists
		end

	control_file: EW_EQA_TEST_CONTROL_FILE
			-- Tcf file

	test_control_file_template_content (a_tcf_content: STRING; a_class_name: READABLE_STRING_32): STRING
			-- Default control file template content
		require
			not_void: a_tcf_content /= Void
			not_void: a_class_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (tcf_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)
				Result.replace_substring_all ("$TCF_CONTENT", a_tcf_content)
				Result.replace_substring_all ("$TEST_CLASS_NAME", to_utf_8 (a_class_name))
			else
				Result := "Warning: template file not found"
				print ("%NWarning: can't read file " + tcf_content_file_name.utf_8_name)
			end
		ensure
			not_void: Result /= Void
		end

	tcf_content_file_name: PATH
			-- Tcf content file name
			-- (export status {NONE})
		do
			Result := (create {PATH}.make_from_string ((create {EW_EQA_TEST_FACTORY}).environment.value ({STRING_32} "ISE_EIFFEL"))).extended
				("studio").extended
				("help").extended
				("defaults").extended
				("eiffel_eweasel_tcf_template.e")
		end

	all_eweasel_test_case_template_file_name: PATH
			-- All eweasel test case template file name
		do
			Result := (create {PATH}.make_from_string ((create {EW_EQA_TEST_FACTORY}).environment.value ({STRING_32} "ISE_EIFFEL"))).extended
				("studio").extended
				("help").extended
				("defaults").extended
				("all_eweasel_test_case_template.e")
		end

	convert_instruction_to_one_line (a_instruction: EW_TEST_INSTRUCTION): detachable STRING_32
			-- Convert one testing instruction
		require
			not_void: a_instruction /= Void
		local
			l_keyword: READABLE_STRING_32
			l_arg: STRING_32
			l_list: LIST [READABLE_STRING_32]
			l_array: STRING_32
			l_instruction: EW_TEST_INSTRUCTION
		do
			l_keyword := a_instruction.command

			if l_keyword.same_string (abort_compile_keyword) then
				Result := "abort_compile"
			elseif l_keyword.same_string (ace_keyword) then
				Result := "ace"
			elseif l_keyword.same_string (c_compile_final_keyword) then
				l_arg := a_instruction.orig_arguments -- or using orign)arguments?
				if l_arg /= Void and then not l_arg.is_empty then
					Result := {STRING_32} "c_compile_final (%"" + l_arg + "%")"
				else
					Result := "c_compile_final (Void)"
				end
			elseif l_keyword.same_string (c_compile_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := {STRING_32} "c_compile_result (%"" + l_arg + "%")"
			elseif l_keyword.same_string (c_compile_work_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg /= Void then
					Result := {STRING_32} "c_compile_work (%"" + l_arg + "%")"
				else
					Result := "c_compile_work (Void)"
				end
			elseif l_keyword.same_string (cleanup_compile_keyword) then
				Result := "cleanup_compile"
			elseif l_keyword.same_string (compare_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := {STRING_32} "compare (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) +  "%")"
			elseif l_keyword.same_string (compile_final_keep_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_final_keep (Void)"
				else
					Result := {STRING_32} "compile_final_keep (%"" + l_arg + "%")"
				end
			elseif l_keyword.same_string (compile_final_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_final (Void)"
				else
					Result := {STRING_32} "compile_final (%"" + l_arg + "%")"
				end
			elseif l_keyword.same_string (compile_frozen_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_frozen (Void)"
				else
					Result := {STRING_32} "compile_frozen (%"" + l_arg + "%")"
				end
			elseif l_keyword.same_string (compile_melted_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void or else l_arg.is_empty then
					Result := "compile_melted (Void)"
				else
					Result := {STRING_32} "compile_melted (%"" + l_arg + "%")"
				end
			elseif l_keyword.same_string (compile_precompiled_keyword) then
				Result := "compile_precompiled"
			elseif l_keyword.same_string (compile_quick_melted_keyword) then
				Result := "compile_quick_melted"
			elseif l_keyword.same_string (compile_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := {STRING_32} "compile_result (%"" + l_arg + "%")"
			elseif l_keyword.same_string (copy_bin_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := {STRING_32} "copy_bin (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.same_string (copy_file_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := {STRING_32} "copy_file (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.same_string (copy_raw_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := {STRING_32} "copy_raw (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.same_string (copy_sub_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := {STRING_32} "copy_sub (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.same_string (cpu_limit_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void end
				Result := {STRING_32} "cpu_limit (%"" + l_arg + "%")"
			elseif l_keyword.same_string (define_directory_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				from
					l_array := {STRING_32} "<<"
					l_list.go_i_th (2)
				until
					l_list.after
				loop
					if l_list.index = 2 then
						l_array.append ({STRING_32} "%"" + l_list.item + "%"")
					else
						l_array.append ({STRING_32} ", %"" + l_list.item + "%"")
					end
					l_list.forth
				end
				l_array.append ({STRING_32} ">>")
				Result := {STRING_32} "define_directory (%"" + l_list.i_th (1) + "%", " + l_array + ")"
			elseif l_keyword.same_string (define_file_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 3 end
				from
					l_array := {STRING_32} "<<"
					l_list.go_i_th (2)
				until
					l_list.index > l_list.count - 1
				loop
					if l_list.index = 2 then
						l_array.append ({STRING_32} "%"" + l_list.item + "%"")
					else
						l_array.append ({STRING_32} ", %"" + l_list.item + "%"")
					end
					l_list.forth
				end
				l_array.append ({STRING_32} ">>")
				Result := {STRING_32} "define_file (%"" + l_list.i_th (1) + "%", " + l_array + ", %"" + l_list.last + "%")"
			elseif l_keyword.same_string (define_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				l_arg.remove_substring (1, l_list.i_th (1).count + 1)
				l_arg.left_adjust
				decorate_quote (l_arg, True)
				Result := {STRING_32} "define (%"" + l_list.i_th (1) + "%", %"" + l_arg + "%")"
			elseif l_keyword.same_string (delete_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := {STRING_32} "delete (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"
			elseif l_keyword.same_string (execute_final_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				if l_list.count = 2 then
					Result := {STRING_32} "execute_final (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", " + "Void)"
				else
					from
						l_array := {STRING_32} ""
						l_list.go_i_th (3)
					until
						l_list.after
					loop
						l_array := l_array + l_list.item + " "
						l_list.forth
					end
					decorate_quote (l_array, False)
					Result := {STRING_32} "execute_final (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_array + "%")"
				end
			elseif l_keyword.same_string (execute_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void end
				Result := {STRING_32} "execute_result (%"" + l_arg + "%")"
			elseif l_keyword.same_string (execute_work_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				if l_list.count = 2 then
					Result := {STRING_32} "execute_work (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", " + "Void)"
				else
					from
						l_array := {STRING_32} ""
						l_list.go_i_th (3)
					until
						l_list.after
					loop
						l_array := l_array + l_list.item + " "
						l_list.forth
					end
					decorate_quote (l_array, False)
					Result := {STRING_32} "execute_work (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_array + "%")"
				end
			elseif l_keyword.same_string (exit_compile_keyword) then
				Result := "exit_compile"
			elseif l_keyword.same_string (if_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				if l_list.first.same_string ({STRING_32} "not") then
					l_arg.remove_substring (1, l_list.i_th (1).count + l_list.i_th (2).count + 2)
					l_arg.left_adjust
					--decorate_quote (l_arg, True)
					Result := {STRING_32} "if not has_env (%"" + l_list.i_th (2) + "%") then"
					-- Recursive convert
					l_instruction := one_line_to_instruction (l_arg)
					check not_void: attached l_instruction end
					Result.append ({STRING_32} "%N" + convert_instruction_to_one_line (l_instruction))
					Result.append ("%N%T%T%Tend")
				else
					l_arg.remove_substring (1, l_list.i_th (1).count + 1)
					l_arg.left_adjust
					--decorate_quote (l_arg, True)
					Result := {STRING_32} "if has_env (%"" + l_list.i_th (1) + "%") then"
					-- Recursive convert
					l_instruction := one_line_to_instruction (l_arg)
					check not_void: attached l_instruction end
					Result.append ({STRING_32} "%N" + convert_instruction_to_one_line (l_instruction))
					Result.append ("%N%T%T%Tend")
				end
			elseif l_keyword.same_string (include_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := {STRING_32} "include (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"
			elseif l_keyword.same_string (not_keyword) then
				Result := "not"
			elseif l_keyword.same_string (resume_compile_keyword) then
				Result := "resume_compile"
			elseif l_keyword.same_string (setenv_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := {STRING_32} "setenv (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"
			elseif l_keyword.same_string (system_keyword) then
				l_arg := a_instruction.orig_arguments
				decorate_quote (l_arg, True)
				check not_void: l_arg /= Void end
				Result := {STRING_32} "system (%"" + l_arg + "%")"
			elseif l_keyword.same_string (test_description_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				decorate_quote (l_arg, True)
				check test_description = Void end
				test_description := to_utf_8 (l_arg)
			elseif l_keyword.same_string (test_end_keyword) then
				-- Test end keyword ignored
			elseif l_keyword.same_string (test_name_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				check test_name = Void end
				test_name := to_utf_8 (l_arg)
			elseif l_keyword.same_string (undefine_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := {STRING_32} "undefine (%"" + l_arg + "%")"
			elseif l_keyword.same_string (unknown_keyword) then
				Result := "unknown"
			else
				print ("%NError! Eweasel tcf converter instruction not found!")
			end
		end

	one_line_to_instruction (a_line: READABLE_STRING_32): detachable EW_TEST_INSTRUCTION
			-- Convert `a_line' to {EW_TEST_INSTRUCTION}
			-- Adapted from {EW_IF_INST}.inst_initialize
		require
			not_void: attached a_line
		local
			l_args: LIST [READABLE_STRING_32]
			l_count, l_pos: INTEGER
			l_val, l_controlled_inst, l_table_cmd, l_variable: READABLE_STRING_32
			l_cmd: STRING_32
			l_rest: STRING_32
			l_init_ok, l_positive: BOOLEAN
			l_failure_explanation: STRING_32
			l_factory: EW_EQA_TEST_FACTORY
		do
			l_args := broken_into_words (a_line)
			l_count := l_args.count
			if l_count < 1 then
				l_failure_explanation := {STRING_32} "argument count must be at least 1"
				l_init_ok := False
			else
				if l_args.first.as_lower.is_equal (Not_keyword) then
					l_positive := False
					if l_count < 2 then
						l_failure_explanation := {STRING_32} "argument count for instruction with %"" + Not_keyword + "%" must be at least 2"
						l_init_ok := False
					else
						l_pos := 2
						l_init_ok := True
					end
				else
					l_positive := True
					l_pos := 1
					l_init_ok := True
				end
			end
			if l_init_ok then	-- OK so far
				l_variable := l_args.i_th (l_pos)
				create l_factory
				if attached l_factory.environment.value (l_variable) as l_attached_val then
					l_val := l_attached_val
				else
					l_val := l_variable
				end
				if l_positive and l_val /= Void or not l_positive and l_val = Void then
					-- Condition satisified
					l_controlled_inst := a_line
					l_pos :=  first_white_position (l_controlled_inst)

					if l_pos <= 0 then
						l_cmd := l_controlled_inst
						create l_rest.make_empty
					else
						l_cmd := l_controlled_inst.substring (1, l_pos - 1)
						l_rest := l_controlled_inst.substring (l_pos + 1, l_controlled_inst.count)
					end
					l_cmd.to_lower
					l_table_cmd := l_cmd
					if not control_file.command_table.has (l_cmd) then
						l_table_cmd := Unknown_keyword
					end
					check
						known_command: control_file.command_table.has (l_table_cmd)
					end
					Result := control_file.command_table.item (l_table_cmd).twin
					Result.initialize_for_conditional (control_file, l_cmd, l_rest)
					l_init_ok := Result.init_ok
					-- FIXME: add text about "if"
					l_failure_explanation := Result.failure_explanation
				else
					Result := Void
				end
			end
				---- TODO: Use `l_failure_explanation` and `l_init_ok`
			if attached l_failure_explanation then
				l_init_ok.do_nothing
			end
		end

	decorate_quote (a_string: STRING_32; a_decorate_head_and_tail: BOOLEAN)
			-- Append "%%" to "%"" except starting and ending quote
			-- If `a_include_head_and_tail'
		require
			not_void: a_string /= Void
		do
			a_string.replace_substring_all ({STRING_32} "%%", {STRING_32} "%%%%")
			a_string.replace_substring_all ({STRING_32} "%"", {STRING_32} "%%%"")
			if not a_decorate_head_and_tail then
				-- We revert first quote if found
				if a_string.starts_with ({STRING_32} "%%%"") then
					a_string.remove_head (1)
				end
				if a_string.ends_with ({STRING_32} "%%%"") then
					a_string.remove_tail (2)
					a_string.append_string ({STRING_32} "%"")
				end
			end
		end

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
