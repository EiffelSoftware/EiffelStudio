note
	description: "[
					Compare the file <output-file> in the output directory $OUTPUT
					with the file <correct-output-file> in the source directory
					$SOURCE.  If they are not identical, then the test has failed
					and the rest of the test instructions are skipped.  If they
					are identical, continue processing with the next test
					instruction.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_COMPARE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

	EQA_ACCESS
	
create
	make

feature {NONE} -- Initialization

	make (a_actual_output_file, a_expected_output_file: STRING)
			-- Initialize instruction
		require
			not_void: attached a_actual_output_file
			not_void: attached a_expected_output_file
		do
			actual_output_file := a_actual_output_file
			expected_output_file := a_expected_output_file
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_act_name, l_exp_name: STRING
			l_actual, l_expected: RAW_FILE
			l_output_dir: detachable STRING
			l_failure_explanation: like failure_explanation
		do
			execute_ok := False
			l_output_dir := a_test.environment.value ({EQA_EW_PREDEFINED_VARIABLES}.Output_dir_name)
			check attached l_output_dir end -- Implied by environment values have been set before executing test cases
			l_act_name := string_util.file_path (<<l_output_dir, actual_output_file>>)
			l_exp_name := string_util.file_path (<<a_test.file_system.environment.source_directory, expected_output_file>>)
			create l_actual.make (l_act_name)
			create l_expected.make (l_exp_name)
			if (l_actual.exists and then l_actual.is_plain) and
			   (l_expected.exists and then l_expected.is_plain) then
				execute_ok := equal_files (l_actual, l_expected)
				if not execute_ok then
					failure_explanation := "files being compared do not have identical contents"
				end
			elseif not l_actual.exists then
				failure_explanation := "file with actual output not found"
			elseif not l_actual.is_plain then
				failure_explanation := "file with actual output not a plain file"
			elseif not l_expected.exists then
				failure_explanation := "file with expected output not found"
			elseif not l_expected.is_plain then
				failure_explanation := "file with expected output not a plain file"
			end

			if not execute_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, execute_ok)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?


feature {NONE}  -- Implementation

	equal_files (a_file1: RAW_FILE; a_file2: RAW_FILE): BOOLEAN
			-- Do `a_file1' and `a_file2' have identical contents?
		require
			source_not_void: a_file1 /= Void
			destination_not_void: a_file2 /= Void
		local
			l_diff: EQA_DIFF_UTILITY
			l_src, l_dst: ARRAY [STRING_GENERAL]
		do
			create l_diff.make

			l_src := file_content (a_file1)
			l_dst := file_content (a_file2)

			l_diff.compare (l_src, l_src)

			Result := not (attached l_diff.differing_lines) -- Note: we can use {EQA_DIFF_UTILITY} to show more infomation
		end

feature {NONE} -- Implementation

	file_content (a_file: RAW_FILE): ARRAY [STRING]
			-- Content of `a_file'
		require
			not_empty: attached a_file
		local
			l_arrayed_list: ARRAYED_LIST [STRING]
		do
			create l_arrayed_list.make (50)
			if a_file.exists then
				from
					a_file.open_read
					a_file.start
				until
					a_file.after
				loop
					a_file.read_line

					l_arrayed_list.extend (a_file.last_string)
				end
			end

			-- Cannot use `to_array' since, the result lower would be 1 but not 0 which is not acceptable by DIFF.compare
			create Result.make (0, l_arrayed_list.count - 1)
			from
				l_arrayed_list.start
			until
				l_arrayed_list.after
			loop
				Result.put (l_arrayed_list.item, l_arrayed_list.index - 1)

				l_arrayed_list.forth
			end
		ensure
			not_void: attached Result
		end

	actual_output_file: STRING
			-- Name of file with actual output

	expected_output_file: STRING
			-- Name of file with expected output

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"







end
