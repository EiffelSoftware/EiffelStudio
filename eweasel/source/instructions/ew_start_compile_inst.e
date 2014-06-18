note
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

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			name, compile_cmd, exec_error: STRING;
			env_vars: HASH_TABLE [STRING, STRING]
			l_compilation: like compilation_type
		do
			env_vars := test.environment.environment_variables
			l_compilation := test.e_compilation;
			if l_compilation = Void or else not l_compilation.suspended then
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
					create l_compilation.make (compile_cmd, compiler_arguments (test, test.environment), env_vars, name);
					test.set_e_compilation (l_compilation);
					test.set_e_compilation_result (l_compilation.next_compile_result);
					execute_ok := True;
				else
					failure_explanation := exec_error
					execute_ok := False;
				end
			else
				failure_explanation := "suspended compilation in progress";
				execute_ok := False;
			end
		end;

	compilation_options (a_test: EW_EIFFEL_EWEASEL_TEST): LIST [STRING]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		deferred
		ensure
			result_exists: Result /= Void
		end;


feature {EW_START_COMPILE_INST} -- For inherited classes

	compilation_type: EW_EIFFEL_COMPILATION
			-- For typing purposes of `compilation'
		do
			check callable: False then
			end
		end


feature {NONE} -- Implementation

	compiler_arguments (test: EW_EIFFEL_EWEASEL_TEST; env: EW_TEST_ENVIRONMENT): LINKED_LIST [STRING]
			-- The arguments to the compiler for test `test'.
		local
			l_compilation_options: LIST [STRING]
		do
			create Result.make;
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
			if test.target_name /= Void then
				Result.extend ("-target")
				Result.extend (test.target_name)
			end

				-- We must add the compilations options to the end of the command line, because
				-- some commands (e.g. -code-analysis) require so.
			l_compilation_options := compilation_options (test)
			from
				l_compilation_options.start
			until
				l_compilation_options.after
			loop
				Result.extend (l_compilation_options.item);
				l_compilation_options.forth
			end;
		end;


note
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
