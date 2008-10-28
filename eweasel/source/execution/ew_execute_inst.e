indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

deferred class EW_EXECUTE_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;
	EW_PREDEFINED_VARIABLES;
	EW_EIFFEL_TEST_CONSTANTS;
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
			if args.count < 2 then
				init_ok := False;
				failure_explanation := "must have at least 2 arguments";
			else
				input_file_name := args.i_th (1);
				output_file_name := args.i_th (2);
				if equal (input_file_name, No_file_name) then
					input_file_name := Void;
				end;
				if equal (output_file_name, No_file_name) then
					output_file_name := Void;
				end;
				create arguments.make;
				from
					args.start;
					args.forth;
					args.forth;
				until
					args.after
				loop
					arguments.extend (args.item);
					args.forth;
				end;
				init_ok := True;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			prog, exec_dir, infile, outfile, savefile: STRING;
			execute_cmd, exec_error: STRING;
			prog_file: RAW_FILE;
			execution: EW_SYSTEM_EXECUTION;
		do
			execute_cmd := test.environment.value (Execute_command_name);
			execute_cmd := test.environment.substitute (execute_cmd)
			exec_error := executable_file_error (execute_cmd)
			if exec_error = Void then
				test.increment_execution_count;
				exec_dir := test.environment.value (execution_dir_name);
				prog := os.executable_full_file_name (exec_dir, test.system_name);
				if input_file_name /= Void then
					infile := os.full_file_name (test.environment.value (Source_dir_name), input_file_name);
				else
					infile := os.null_file_name
				end;
				outfile := Void;	-- Pipe output back to parent
				if output_file_name /= Void then
					savefile := output_file_name;
				else
					savefile := test.execution_output_name;
				end;
				savefile := os.full_file_name (test.environment.value (Output_dir_name), savefile);

				create prog_file.make (prog);
				exec_error := executable_file_error (prog)
				if exec_error = Void then
					create execution.make (prog, arguments, execute_cmd, exec_dir, infile, outfile, savefile);
					test.set_execution_result (execution.next_execution_result);
					execute_ok := True;
				else
					failure_explanation := exec_error
					execute_ok := False;
				end

			else
				failure_explanation := exec_error
				execute_ok := False;
			end
		end;

feature -- Status

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE} -- Constants

	No_file_name: STRING is "NONE";

feature {NONE} -- Implementation

	input_file_name: STRING;
			-- Name of input file

	output_file_name: STRING;
			-- Name of output file

	arguments: LINKED_LIST [STRING];

	execution_dir_name: STRING is
			-- Name of directory where executable resides
		deferred
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
