indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

deferred class START_COMPILE_INST

inherit
	COMPILE_INST;
	PREDEFINED_VARIABLES;
	EIFFEL_TEST_CONSTANTS;
	OS_ACCESS
	EXECUTION_ENVIRONMENT

feature

	execute (test: EIFFEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			name, compile_cmd, exec_error: STRING;
			compilation: EIFFEL_COMPILATION;
			curr_dir, test_dir: STRING;
		do
			-- Work around a bug in Eiffel 4.2 (can't start
			-- es4 on existing project unless project directory
			-- is current directory

			curr_dir := current_working_directory;
			test_dir := test.environment.value (Test_dir_name);
			if test_dir /= Void then
				change_working_directory (test_dir);
			end
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

	compiler_arguments (test: EIFFEL_TEST; env: TEST_ENVIRONMENT): LINKED_LIST [STRING] is
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
				-- Ignore user file for testing
			Result.extend ("-local")
				-- Path to configuration file
			Result.extend ("-config")
			Result.extend (os.full_file_name (env.value (Test_dir_name), test.ace_name))
		end;

	project_file_name (env: TEST_ENVIRONMENT): STRING is
			-- Name of first Eiffel project file (.epr file)
			-- found in test directory or Void if none
		local
			dir: DIRECTORY
			dir_entries: ARRAYED_LIST [STRING]
			dir_name, name, ext: STRING
			len: INTEGER
		do
			ext := Eiffel_project_extension;
			len := ext.count
			dir_name := env.value (Test_dir_name);
			create dir.make (dir_name)
			dir_entries := dir.linear_representation;
			from
				dir_entries.start
			until
				dir_entries.after or Result /= Void
			loop
				name := dir_entries.item.twin
				name.keep_tail (len)
				if name.is_equal (ext) then
					Result := os.full_file_name (dir_name, dir_entries.item)
				end
				dir_entries.forth
			end
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
