indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_INCLUDE_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_OS_ACCESS;
	EW_STRING_UTILITIES;
	EW_SUBSTITUTION_CONST;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
			count: INTEGER;
			tcf: EW_TEST_CONTROL_FILE;
		do
			args := broken_into_words (line);
			count := args.count;
			if count /= 2 then
				failure_explanation := "argument count must be 2";
				init_ok := False;
			else
				include_directory_name := args.i_th (1);
				include_file_name := args.i_th (2);
				include_tcf_name := os.full_directory_name (include_directory_name, include_file_name);
				if makes_include_cycle (include_tcf_name) then
					create failure_explanation.make (0);
					failure_explanation.append ("include cycle on include file ");
					failure_explanation.append (include_tcf_name);
					init_ok := False;
				else
					create tcf.make (include_tcf_name, test_control_file, command_table, False);
					tcf.parse (init_environment);
					if tcf.last_ok then
						include_instructions := tcf.instructions;
						init_ok := True;
					else
						test_control_file.add_errors (tcf.errors);
						create failure_explanation.make (0);
						failure_explanation.append ("error parsing include file ");
						failure_explanation.append (include_tcf_name);
						init_ok := False;
					end
				end
			end;
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			saved_insts: LIST [EW_TEST_INSTRUCTION];
		do
			saved_insts := test.instructions;
			test.set_instructions (include_instructions);
			test.execute (test.environment);
			test.set_instructions (saved_insts);
			if test.last_ok then
				execute_ok := True;
			else
				create failure_explanation.make (0);
				failure_explanation.append ("error executing include file ");
				failure_explanation.append (include_tcf_name);
				execute_ok := False;
			end
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation
	
	makes_include_cycle (fn: STRING): BOOLEAN is
			-- Would processing include file named `fn' cause
			-- an include cycle?
		local
			tcf: EW_TEST_CONTROL_FILE;
		do
			from
				tcf := test_control_file;
			until
				tcf = Void or Result
			loop
				if equal (tcf.file_name, fn) then
					Result := True;
				end;
				tcf := tcf.include_parent;
			end
		end;
	
feature {NONE}
	
	include_directory_name: STRING;
			-- Name of directory where include file resides
	
	include_file_name: STRING;
			-- Name of include file
	
	include_tcf_name: STRING;
			-- Full name of included test control file
	
	include_instructions: LIST [EW_TEST_INSTRUCTION];
			-- Test instructions from include file
	
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
