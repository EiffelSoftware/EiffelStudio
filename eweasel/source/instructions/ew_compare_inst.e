note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_COMPARE_INST

inherit
	EW_OS_ACCESS
	EW_PREDEFINED_VARIABLES
	EW_STRING_UTILITIES
	EW_TEST_INSTRUCTION

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
		do
			args := broken_into_words (line)
			if args.count = 2 then
				actual_output_file := args [1]
				expected_output_file := args [2]
				init_ok := True
			else
				failure_explanation := {STRING_32} "argument count must be 2"
				init_ok := False
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			actual, expected: RAW_FILE
		do
			execute_ok := False
			create actual.make_with_name (os.full_file_name (test.environment.value (Output_dir_name), actual_output_file))
			create expected.make_with_name (os.full_file_name (test.environment.value (Source_dir_name), expected_output_file))
			if not actual.exists then
				failure_explanation := {STRING_32} "file with actual output not found"
			elseif not actual.is_plain then
				failure_explanation := {STRING_32} "file with actual output not a plain file"
			elseif not expected.exists then
				failure_explanation := {STRING_32} "file with expected output not found"
			elseif not expected.is_plain then
				failure_explanation := {STRING_32} "file with expected output not a plain file"
			elseif not equal_files (actual, expected) then
				failure_explanation := {STRING_32} "files being compared do not have identical contents"
			else
				execute_ok := True
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE}  -- Implementation

	equal_files (file1: RAW_FILE; file2: RAW_FILE): BOOLEAN
			-- Do `file1' and `file2' have identical contents?
		require
			source_not_void: file1 /= Void
			destination_not_void: file2 /= Void
		local
			eof1, eof2: BOOLEAN
			done: BOOLEAN
			c1, c2: CHARACTER
		do
			from
				file1.open_read
				file2.open_read
			until
				done
			loop
				file1.read_character
				file2.read_character
				eof1 := file1.end_of_file
				eof2 := file2.end_of_file
				if eof1 or eof2 then
						-- At least one of files has reached its end.
					done := True
				else
					c1 := file1.last_character
					c2 := file2.last_character
					if c1 /= c2 then
						if c1 = '%R' and c2 = '%N' then
								-- `file1` might be using "%R%N" for line endings
								-- whereas `file2` is using just `%N`.
							file1.read_character
							if file1.end_of_file or else file1.last_character /= '%N' then
									-- Different contents.
								done := True
							end
						elseif c1 ='%N' and c2 = '%R' then
								-- `file2` might be using "%R%N" for line endings.
								-- whereas `file1` is using just `%N`.
							file2.read_character
							if file2.end_of_file or else file2.last_character /= '%N' then
									-- Different contents.
								done := True
							end
						else
								-- Different contents.
							done := True
						end
					end
				end
			end
			file1.close
			file2.close
				-- File are equal only when they reached EOF at the same time.
			Result := eof1 and eof2
		end

feature {NONE}

	actual_output_file: READABLE_STRING_32
			-- Name of file with actual output

	expected_output_file: READABLE_STRING_32
			-- Name of file with expected output

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
