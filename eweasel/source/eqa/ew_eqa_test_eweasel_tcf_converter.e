indexing
	description: "[
						Convert eweasel testing control file to a testing control class file
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

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

	make_default is
			-- Creation method which do nothing
		do
			prepare_catalog
		end

	catalog_converter: EW_EQA_TEST_EWEASEL_CATALOG_CONVERTER
			-- Catalog file converter

	prepare_catalog is
			-- Prepare related catalog files
		local
			l_factory: EW_EQA_TEST_FACTORY
			l_path: FILE_NAME
			l_tmp: STRING
		do
			create catalog_converter

			create l_factory

			l_tmp := l_factory.environment.value ("EWEASEL")
			l_tmp := l_factory.environment.substitute (l_tmp)

			create l_path.make_from_string (l_tmp)
			l_path.extend ("control")
			l_path.set_file_name ("catalog")

			catalog_converter.convert_catalog (l_path)
		end

feature -- Command

	set_ignore_non_exist_test_cases (a_bool: BOOLEAN) is
			-- Set `is_ignore_non_exist_test_cases' with `a_bool'
		do
			is_ignore_non_exist_test_cases := a_bool
		ensure
			set: is_ignore_non_exist_test_cases = a_bool
		end

	append_one_test_routine (a_input_tcf: STRING; a_test_name: STRING) is
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

	flush_to_output_file (a_output_file_name: STRING; a_class_name: STRING) is
			-- Write `temp_converted' to `a_output_file'
		require
			not_void: a_output_file_name /= Void
			not_void: a_class_name /= Void
			needed: is_flush_needed
		do
			temp_converted := test_control_file_template_content (temp_converted, a_class_name.as_upper)
			write_content_to_template (temp_converted, a_output_file_name)
			temp_converted := Void
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

	convert_class_file (a_input_file, a_output_class_name: STRING) is
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
			write_content_to_template (l_converted, a_output_class_name + ".e")
		end

	convert_one_tcf (a_input_file: STRING; a_routine_name: STRING): STRING is
			-- Convert instructions in `a_input_file' to correspond Eiffel codes
		require
			not_void: a_input_file /= Void
			not_void: a_routine_name /= Void
		local
			l_instructions: LIST [EW_TEST_INSTRUCTION]
		do
			create control_file.make_for_convertion
			l_instructions := control_file.parse_file (a_input_file)

			from
				l_instructions.start
				Result := "%N%Ttest_" + a_routine_name + " is"
				Result.append ("%N%T%T%T-- Test " + a_routine_name)
				Result.append ("%N%T%Tdo")

				catalog_converter.append_related_setup (a_routine_name, Result)

			until
				l_instructions.after
			loop
				Result.append ("%N%T%T%T" + convert_instruction_to_one_line (l_instructions.item))

				l_instructions.forth
			end

			Result.append ("%N%T%Tend")
		ensure
			not_void: Result /= Void
		end

	write_content_to_template (a_content: STRING; a_output_file: STRING) is
			-- Writing converted strings to template file
		require
			not_void: a_output_file /= Void
		local
			l_io: IO_MEDIUM
			l_file_name: FILE_NAME
			l_raw_file: RAW_FILE
		do
			create l_file_name.make_from_string (a_output_file)

			-- Overwrite previous generated tcf
			create l_raw_file.make (l_file_name)
			if l_raw_file.exists then
				l_raw_file.delete
			end
			if not l_raw_file.is_closed then
				l_raw_file.close
			end

			l_io := create_file (l_file_name)
			l_io.put_string (a_content)
			l_io.close
		end

	create_file (a_file_name: FILE_NAME): IO_MEDIUM  is
			-- Create a new {IO_MEDIUM} which file name is `a_file_name'
			-- Callers have to close `Result' themselves
		require
			not_void: a_file_name /= Void
			valid: a_file_name.is_valid
			not_exists: not (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			check not_exits: not l_file.exists end

			l_file.create_read_write

			Result := l_file
		ensure
			not_void: Result /= Void
			created: (create {RAW_FILE}.make (a_file_name)).exists
		end

--	template_class_file_name: STRING is "testing_control_file.e"
--			-- Template eiffel testing control file

	control_file: EW_EQA_TEST_CONTROL_FILE
			--

	test_control_file_template_content (a_tcf_content: STRING; a_class_name: STRING): STRING is
			-- Default control file template content
		require
			not_void: a_tcf_content /= Void
			not_void: a_class_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (tcf_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)
				Result.replace_substring_all ("$TCF_CONTENT", a_tcf_content)
				Result.replace_substring_all ("$TEST_CLASS_NAME", a_class_name)
			else
				Result := "Warning: template file not found"
				print ("%NWarning: can't read file " + tcf_content_file_name)
			end
		ensure
			not_void: Result /= Void
		end

	tcf_content_file_name: !FILE_NAME
			-- Tcf content file name
			-- (export status {NONE})
		do
			create Result.make
			Result.set_directory ("c:") -- FIXIT: Configurable? Move to singleton factory?
			Result.set_file_name ("eiffel_eweasel_tcf_template.txt")
		end

	convert_instruction_to_one_line (a_instruction: EW_TEST_INSTRUCTION): STRING is
			-- Convert one testing instruction
		require
			not_void: a_instruction /= Void
		local
			l_keyword: STRING
			l_arg: STRING
			l_list: LIST [STRING]
			l_array: STRING
		do
			l_keyword := a_instruction.command

			if l_keyword.is_equal (abort_compile_keyword) then
				Result := "abort_compile"
			elseif l_keyword.is_equal (ace_keyword) then
				Result := "ace"
			elseif l_keyword.is_equal (c_compile_final_keyword) then
				l_arg := a_instruction.orig_arguments -- or using orign)arguments?
				if l_arg /= Void and then not l_arg.is_empty then
					Result := "c_compile_final (%"" + l_arg + "%")"
				else
					Result := "c_compile_final (Void)"
				end
			elseif l_keyword.is_equal (c_compile_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := "c_compile_result (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (c_compile_work_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg /= Void then
					Result := "c_compile_work (%"" + l_arg + "%")"
				else
					Result := "c_compile_work (Void)"
				end
			elseif l_keyword.is_equal (cleanup_compile_keyword) then
				Result := "cleanup_compile"
			elseif l_keyword.is_equal (compare_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := "compare (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) +  "%")"
			elseif l_keyword.is_equal (compile_final_keep_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_final_keep (Void)"
				else
					Result := "compile_final_keep (%"" + l_arg + "%")"
				end
			elseif l_keyword.is_equal (compile_final_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_final (Void)"
				else
					Result := "compile_final (%"" + l_arg + "%")"
				end
			elseif l_keyword.is_equal (compile_frozen_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void then
					Result := "compile_frozen (Void)"
				else
					Result := "compile_frozen (%"" + l_arg + "%")"
				end
			elseif l_keyword.is_equal (compile_melted_keyword) then
				l_arg := a_instruction.orig_arguments
				if l_arg = Void or else l_arg.is_empty then
					Result := "compile_melted (Void)"
				else
					Result := "compile_melted (%"" + l_arg + "%")"
				end
			elseif l_keyword.is_equal (compile_precompiled_keyword) then
				Result := "compile_precompiled"
			elseif l_keyword.is_equal (compile_quick_melted_keyword) then
				Result := "compile_quick_melted"
			elseif l_keyword.is_equal (compile_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := "compile_result (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (copy_bin_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := "copy_bin (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.is_equal (copy_raw_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := "copy_raw (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.is_equal (copy_sub_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 3 end
				Result := "copy_sub (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_list.i_th (3) + "%")"
			elseif l_keyword.is_equal (cpu_limit_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void end
				Result := "cpu_limit (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (define_directory_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end

				from
					l_array := "<<"
					l_list.go_i_th (2)
				until
					l_list.after
				loop
					if l_list.index = 2 then
						l_array.append ("%"" + l_list.item + "%"")
					else
						l_array.append (", %"" + l_list.item + "%"")
					end

					l_list.forth
				end
				l_array.append (">>")
				Result := "define_directory (%"" + l_list.i_th (1) + "%", " + l_array + ")"
			elseif l_keyword.is_equal (define_file_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 3 end

				from
					l_array := "<<"
					l_list.go_i_th (2)
				until
					l_list.index > l_list.count - 1
				loop
					if l_list.index = 2 then
						l_array.append ("%"" + l_list.item + "%"")
					else
						l_array.append (", %"" + l_list.item + "%"")
					end

					l_list.forth
				end
				l_array.append (">>")

				Result := "define_file (%"" + l_list.i_th (1) + "%", " + l_array + ", %"" + l_list.last + "%")"

			elseif l_keyword.is_equal (define_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end

				l_arg.remove_substring (1, l_list.i_th (1).count + 1)
				l_arg.left_adjust

				decorate_quote (l_arg, True)
				Result := "define (%"" + l_list.i_th (1) + "%", %"" + l_arg + "%")"

			elseif l_keyword.is_equal (delete_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := "delete (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"

			elseif l_keyword.is_equal (execute_final_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				if l_list.count = 2 then
					Result := "execute_final (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", " + "Void)"
				else
					from
						l_array := ""
						l_list.go_i_th (3)
					until
						l_list.after
					loop
						l_array := l_array + l_list.item + " "
						l_list.forth
					end
					Result := "execute_final (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_array + "%")"
				end
			elseif l_keyword.is_equal (execute_result_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void end

				Result := "execute_result (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (execute_work_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end
				if l_list.count = 2 then
					Result := "execute_work (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", " + "Void)"
				else
					from
						l_array := ""
						l_list.go_i_th (3)
					until
						l_list.after
					loop
						l_array := l_array + l_list.item + " "
						l_list.forth
					end

					Result := "execute_work (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%", %"" + l_array + "%")"
				end
			elseif l_keyword.is_equal (exit_compile_keyword) then
				Result := "exit_compile"
			elseif l_keyword.is_equal (if_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count >= 2 end


				if l_list.first.is_equal ("not") then
					l_arg.remove_substring (1, l_list.i_th (1).count + l_list.i_th (2).count + 2)
					l_arg.left_adjust
					decorate_quote (l_arg, True)

					Result := "if_not (%"" + l_list.i_th (2) + "%", %"" + l_arg + "%")"
				else
					l_arg.remove_substring (1, l_list.i_th (1).count + 1)
					l_arg.left_adjust
					decorate_quote (l_arg, True)

					Result := "if_ (%"" + l_list.i_th (1) + "%", %"" + l_arg + "%")"
				end
			elseif l_keyword.is_equal (include_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := "include (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"
			elseif l_keyword.is_equal (not_keyword) then
				Result := "not"
			elseif l_keyword.is_equal (resume_compile_keyword) then
				Result := "resume_compile"
			elseif l_keyword.is_equal (setenv_keyword) then
				l_arg := a_instruction.orig_arguments
				l_list := broken_into_words (l_arg)
				check count_right: l_list.count = 2 end
				Result := "setenv (%"" + l_list.i_th (1) + "%", %"" + l_list.i_th (2) + "%")"
			elseif l_keyword.is_equal (system_keyword) then
				l_arg := a_instruction.orig_arguments
				decorate_quote (l_arg, True)
				check not_void: l_arg /= Void end
				Result := "system (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (test_description_keyword) then
				l_arg := a_instruction.orig_arguments.twin
				check not_void: l_arg /= Void and then not l_arg.is_empty end

				decorate_quote (l_arg, True)

				Result := "test_description (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (test_end_keyword) then
				Result := "test_end"
			elseif l_keyword.is_equal (test_name_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := "test_name (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (undefine_keyword) then
				l_arg := a_instruction.orig_arguments
				check not_void: l_arg /= Void and then not l_arg.is_empty end
				Result := "undefine (%"" + l_arg + "%")"
			elseif l_keyword.is_equal (unknown_keyword) then
				Result := "unknown"
			else
				print ("%NError! Eweasel tcf converter instruction not found!")
			end
		ensure
			not_void: Result /= Void
		end

	decorate_quote (a_string: STRING; a_decorate_head_and_tail: BOOLEAN) is
			-- Append "%%" to "%"" except starting and ending quote
			-- If `a_include_head_and_tail'
		require
			not_void: a_string /= Void
		do
			a_string.replace_substring_all ("%%", "%%%%")
			a_string.replace_substring_all ("%"", "%%%"")


			if not a_decorate_head_and_tail then
				-- We revert first quote if found
				if a_string.starts_with ("%%%"") then
					a_string.remove_head (1)
				end
				if a_string.ends_with ("%%%"") then
					a_string.remove_tail (2)
					a_string.append_string ("%"")
				end
			end
		end

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
