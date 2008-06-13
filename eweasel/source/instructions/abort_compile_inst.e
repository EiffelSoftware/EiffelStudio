indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class ABORT_COMPILE_INST

inherit
	TEST_INSTRUCTION;
	STRING_UTILITIES;
	PREDEFINED_VARIABLES;
	EIFFEL_TEST_CONSTANTS;
	OS_ACCESS;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
		do
			args := broken_into_words (line);
			if args.count /= 0 then
				init_ok := False;
				failure_explanation := "no arguments allowed";
			else
				init_ok := True;
			end
		end;

	execute (test: EIFFEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			compilation: EIFFEL_COMPILATION;
			dir: STRING;
		do
			compilation := test.e_compilation;
			if compilation = Void then
				execute_ok := False;
				failure_explanation := "no compilation has been started";
			elseif not compilation.suspended then
				execute_ok := False;
				failure_explanation := "compilation not suspended";
			else
				compilation.abort;
				dir := test.environment.value (Test_dir_name); 
				dir := os.full_directory_name (dir, Eiffel_gen_directory); 
				os.delete_directory_tree (dir)
				execute_ok := True;
			end
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

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
