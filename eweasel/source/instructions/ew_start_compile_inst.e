indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

deferred class EW_START_COMPILE_INST

inherit
	EW_COMPILE_INST;
	EW_PREDEFINED_VARIABLES;
	EW_EIFFEL_TEST_CONSTANTS;
	EW_OS_ACCESS
	EXECUTION_ENVIRONMENT

feature

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			name, compile_cmd, exec_error: STRING;
			compilation: EW_EIFFEL_COMPILATION;
			curr_dir, test_dir: STRING;
		do
			-- Work around a bug in Eiffel 4.2 (can't start
			-- es4 on existing project unless project directory
			-- is current directory

			curr_dir := current_working_directory;
			test_dir := test.environment.value (Test_dir_name);
			-- FIXME: remove if -project_path works
			-- if test_dir /= Void then
			-- 	change_working_directory (test_dir);
			-- end
			compilation := test.e_compilation;
			if compilation = Void or else not compilation.suspended then
				compile_cmd := test.environment.value (Compile_command_name)
				exec_error := executable_file_error (compile_cmd)
				if exec_error = Void then
					test.increment_e_compile_count;
					test.set_e_compile_start_time (os.current_time_in_seconds);
					if output_file_name /= Void then
						name := output_file_name;
					else
						name := test.e_compile_output_name;
					end;
					name := os.full_file_name (test.environment.value (Output_dir_name), name);
					create compilation.make (compile_cmd, compiler_arguments (test, test.environment), name);
					test.set_e_compilation (compilation);
					test.set_e_compilation_result (compilation.next_compile_result);
					execute_ok := True;
				else
					failure_explanation := exec_error
					execute_ok := False;
				end
			else
				failure_explanation := "suspended compilation in progress";
				execute_ok := False;
			end
			change_working_directory (curr_dir);
		end;

	compilation_options: LIST [STRING] is
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		deferred
		ensure
			result_exists: Result /= Void
		end;

feature {NONE} -- Implementation

	compiler_arguments (test: EW_EIFFEL_EWEASEL_TEST; env: EW_TEST_ENVIRONMENT): LINKED_LIST [STRING] is
			-- The arguments to the compiler for test `test'.
		do
			create Result.make;
			from
				compilation_options.start
			until
				compilation_options.after
			loop
				Result.extend (compilation_options.item);
				compilation_options.forth
			end;
				-- Add compilation dir to avoid changing
				-- working directory, which does not work
				-- with multithreaded code
			Result.extend ("-project_path")
			Result.extend (env.value (Test_dir_name))
				-- Ignore user file for testing
			Result.extend ("-local")
				-- Path to configuration file
			Result.extend ("-config")
			Result.extend (os.full_file_name (env.value (Test_dir_name), test.ace_name))
		end;


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
