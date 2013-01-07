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
			l_act_name, l_exp_name: STRING_32
			l_actual, l_expected: PLAIN_TEXT_FILE
			l_diff: like equal_files
		do
			execute_ok := False
			l_act_name := a_test.file_system.build_path_from_key ({EQA_EXECUTION}.output_path_key, << actual_output_file >>)
			l_exp_name := a_test.file_system.build_source_path (<< expected_output_file >>)
			create l_actual.make_with_name (l_act_name)
			create l_expected.make_with_name (l_exp_name)
			if (l_actual.exists and then l_actual.is_plain) and
			   (l_expected.exists and then l_expected.is_plain) then
			   	l_diff := equal_files (l_actual, l_expected)
				if l_diff.is_empty then
					execute_ok := True
				else
					failure_explanation := "files being compared do not have identical contents:%N%N" + l_diff
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
				print (failure_explanation)
				a_test.assert ("Comparison failed", False)
			end
		end

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?


feature {NONE}  -- Implementation

	equal_files (a_file1: PLAIN_TEXT_FILE; a_file2: PLAIN_TEXT_FILE): STRING
			-- Differences between content of `a_file1' and `a_file2', empty if files are equal.
		require
			source_not_void: a_file1 /= Void
			destination_not_void: a_file2 /= Void
		local
			l_c1, l_c2: like file_content
			l_diff: DIFF_TEXT
		do
			l_c1 := file_content (a_file1)
			l_c2 := file_content (a_file2)
			if l_c1.same_string (l_c2) then
				create Result.make_empty
			else
				create l_diff
				l_diff.set_text (l_c1, l_c2)
				l_diff.compute_diff
				Result := l_diff.unified
			end
		end

feature {NONE} -- Implementation

	file_content (a_file: PLAIN_TEXT_FILE): STRING
			-- Content of `a_file'
		require
			not_empty: attached a_file
		do
			create Result.make (a_file.count)
			if a_file.exists then
				from
					a_file.open_read
					a_file.start
				until
					a_file.after or not a_file.readable
				loop
					a_file.read_line
					Result.append (a_file.last_string)
					Result.append_character ('%N')
				end
				a_file.close
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
