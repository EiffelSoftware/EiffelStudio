indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_COMPARE_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_PREDEFINED_VARIABLES;
	EW_STRING_UTILITIES;
	EW_OS_ACCESS;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
		do
			args := broken_into_words (line);
			if args.count /= 2 then
				failure_explanation := "argument count must be 2";
				init_ok := False;
			else
				actual_output_file := args.i_th (1);
				expected_output_file := args.i_th (2);
				init_ok := True;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			act_name, exp_name: STRING;
			actual, expected: RAW_FILE;
		do
			execute_ok := False;
			act_name := os.full_file_name (test.environment.value (Output_dir_name),
				actual_output_file);
			exp_name := os.full_file_name (test.environment.value (Source_dir_name),
				expected_output_file);
			create actual.make (act_name);
			create expected.make (exp_name);
			if (actual.exists and then actual.is_plain) and 
			   (expected.exists and then expected.is_plain) then
				execute_ok := equal_files (actual, expected);
				if not execute_ok then
					failure_explanation := "files being compared do not have identical contents";
				end
			elseif not actual.exists then
				failure_explanation := "file with actual output not found";
			elseif not actual.is_plain then
				failure_explanation := "file with actual output not a plain file";
			elseif not expected.exists then
				failure_explanation := "file with expected output not found";
			elseif not expected.is_plain then
				failure_explanation := "file with expected output not a plain file";
			end
			
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

	
feature {NONE}  -- Implementation

	equal_files (file1: RAW_FILE; file2: RAW_FILE): BOOLEAN is
			-- Do `file1' and `file2' have identical contents?
		require
			source_not_void: file1 /= Void;
			destination_not_void: file2 /= Void;
		local
			eof1, eof2, unequal: BOOLEAN;
		do
			from
				file1.open_read;
				file2.open_read;
			until
				eof1 or eof2 or unequal
			loop
				file1.readchar;
				file2.readchar;
				eof1 := file1.end_of_file;
				eof2 := file2.end_of_file;
				if not eof1 and not eof2 then
					if file1.lastchar /= file2.lastchar then
						unequal := True;
					end
				elseif (eof1 and not eof2) or (eof2 and not eof1) then
					unequal := True;
				end
			end;
			file1.close;
			file2.close;
			Result := not unequal;
		end;
	
feature {NONE}
	
	actual_output_file: STRING;
			-- Name of file with actual output
	
	expected_output_file: STRING;
			-- Name of file with expected output
	
	
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
