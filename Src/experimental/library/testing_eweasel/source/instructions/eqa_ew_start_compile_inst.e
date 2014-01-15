note
	description: "[
					Document not found...
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EW_START_COMPILE_INST

inherit
	EQA_EW_COMPILE_INST

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EQA_EW_OS_ACCESS
		export
			{NONE} all
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- <Precursor>
		local
			l_name: STRING
			l_exec_error: detachable STRING
			l_compilation: detachable EQA_EW_EIFFEL_COMPILATION
			l_curr_dir: PATH
			l_file_system: EQA_FILE_SYSTEM
		do
			-- Work around a bug in Eiffel 4.2 (can't start
			-- es4 on existing project unless project directory
			-- is current directory

			l_curr_dir := current_working_path
--			l_test_dir := a_test.environment.target_directory -- FIXME: use file system to build target directory

			l_compilation := a_test.e_compilation
			if l_compilation = Void or else not l_compilation.suspended then
				l_file_system := a_test.file_system
--				l_exec_error := l_file_system.executable_file_exists (a_test.environment.executable_name) -- FIXME: use env to retrieve executable name
				if l_exec_error = Void then
					a_test.increment_e_compile_count
					a_test.set_e_compile_start_time (os.current_time_in_seconds)
					if attached output_file_name as l_output_file_name and then not l_output_file_name.is_empty then
						l_name := l_output_file_name
					else
						l_name := a_test.e_compile_output_name
					end
					create l_compilation.make_and_launch (compiler_arguments (a_test), l_name, a_test)
					a_test.set_e_compilation (l_compilation)
					a_test.set_e_compilation_result (l_compilation.last_result)

					execute_ok := True
				else
					failure_explanation := l_exec_error
					execute_ok := False
					print (failure_explanation)
					a_test.assert ("Compilation failed", False)
				end
			else
				failure_explanation := "suspended compilation in progress"
				print (failure_explanation)
				a_test.assert ("Invalid compile instruction", False)
			end
			change_working_path (l_curr_dir)
		end

feature {NONE} -- Query

	compiler_arguments (a_test: EQA_EW_SYSTEM_TEST_SET): LINKED_LIST [STRING_32]
			-- The arguments to the compiler for test `test'.
		local
			l_test_dir: STRING_32
		do
			create Result.make
			from
				compilation_options.start
			until
				compilation_options.after
			loop
				Result.extend (compilation_options.item)
				compilation_options.forth
			end;
				-- Add compilation dir to avoid changing
				-- working directory, which does not work
				-- with multithreaded code
			Result.extend ("-project_path")

			l_test_dir := a_test.file_system.build_target_path (Void)
			Result.extend (l_test_dir)
				-- Ignore user file for testing
			Result.extend ("-local")
				-- Path to configuration file. If none specified, the compiler will use the default one.
			if attached a_test.ecf_name as l_ecf_name then
				Result.extend ("-config")
				Result.extend (a_test.file_system.build_path (l_test_dir, << l_ecf_name >>))
			end
		end

	compilation_options: LIST [STRING]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		deferred
		ensure
			result_exists: Result /= Void
		end

;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
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
