note
	description: "[
					A Eweasel system test set base on Testing library
					
					For old version, please check {EW_EIFFEL_EWEASEL_TEST}
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_SYSTEM_TEST_SET

inherit
	EQA_SYSTEM_TEST_SET
		export
			{EQA_EW_TEST_INSTRUCTION, EQA_EW_EIFFEL_COMPILATION, EQA_EW_C_COMPILATION, EQA_EW_SYSTEM_EXECUTION,
			EQA_SYSTEM_OUTPUT_PROCESSOR, EQA_EW_SYSTEM_TEST_INSTRUCTIONS} environment
			{EQA_EW_EIFFEL_COMPILATION, EQA_EW_SYSTEM_EXECUTION, EQA_EW_C_COMPILATION} run_system
			{EQA_EW_C_COMPILATION, EQA_EW_SYSTEM_EXECUTION} prepare_system
			{ANY} current_execution
		end

	EQA_EW_OS_ACCESS
		export
			{NONE} all
		undefine
			default_create
		end

	EQA_EW_SYSTEM_TEST_INSTRUCTIONS
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Initialization

	init (a_test_dir_name: STRING)
			-- Same as `init_env', initialize with `environment'
		do
			init_env (environment, a_test_dir_name)
		end

	init_env (a_env: EQA_SYSTEM_ENVIRONMENT; a_test_dir_name: STRING)
			-- Initial environment environment in which to
			-- execute `test'.  The result may be safely
			-- modified by the caller.
			-- Modified base on {EW_EQA_WINDOWS_SETUP}.initial_environment
		require
			test_not_void: a_env /= Void
		local
			l_test_dir, l_gen_dir, l_exec_dir: STRING
			l_info: EQA_EVALUATION_INFO
			l_util: EQA_EW_STRING_UTILITIES
		do
			ecf_name := "Ace"
			create l_info

			-- How to get {EQA_SYSTEM_EXECUTION}.executable_env ?
			-- Following environment vairable would be set by {EQA_EW_EIFFEL_COMPILATION}.make
--			a_env.put ("/usr/local/Eiffel65/studio/spec/linux-x86/bin/ec", "EQA_EXECUTABLE")
			a_env.put ( a_env.substitute_recursive ("$ISE_EIFFEL/precomp/spec/$ISE_PLATFORM/base.ecf"), "PRECOMPILED_BASE")
			a_env.put (a_env.substitute_recursive  ("$ISE_EIFFEL/precomp/spec/$ISE_PLATFORM/base-mt.ecf"), "PRECOMPILED_BASE_MT")
			a_env.put (a_env.substitute_recursive ("$ISE_EIFFEL/experimental/precomp/spec/$ISE_PLATFORM/base-safe.ecf"), "PRECOMPILED_BASE_SAFE")

			a_env.put ("", "EWEASEL_DOTNET_SETTING")

			a_env.put ("/usr/local/Eiffel65/studio/spec/linux-x86/bin/ec", {EQA_EW_PREDEFINED_VARIABLES}.compile_command_name) -- FIXME: This environment value is used by old eweasel, should be removed?

			a_env.set_source_directory (a_env.substitute_recursive ("$EWEASEL/tests"))

			create l_util
			-- l_test_dir := file_system.build_source_path (l_source_dir_name) -- Cannot use {EQA_FILE_SYSTEM}.build_source_path since it adding additional string to path
			l_test_dir := l_util.file_path (<<a_env.source_directory, a_test_dir_name>>)

			associate (a_env, {EQA_EW_PREDEFINED_VARIABLES}.source_dir_name, l_test_dir)
			a_env.set_source_directory (l_test_dir) -- Update {EQA_FILE_SYSTEM}.source_directory

			-- FIXME: Cannot use `a_env.target_directory', since by default, {EQA_SYSTEM_ENVIRONMENT}.target_directory is "/temp" ?

			l_test_dir := l_util.file_path (<<a_env.current_working_directory>>)
			associate (a_env, {EQA_EW_PREDEFINED_VARIABLES}.Test_dir_name, l_test_dir)
			a_env.set_target_directory (l_test_dir)

			associate (a_env, {EQA_EW_PREDEFINED_VARIABLES}.Cluster_dir_name, full_directory_name (l_test_dir, "clusters"))
			associate (a_env, {EQA_EW_PREDEFINED_VARIABLES}.Output_dir_name, full_directory_name (l_test_dir, "output"))

			-- fixme ("set correct directory depending on used target")
			l_gen_dir := full_directory_name (l_test_dir, {EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_gen_directory)
			l_gen_dir := full_directory_name (l_gen_dir, {EQA_EW_EIFFEL_TEST_CONSTANTS}.Default_system_name)
			l_exec_dir := full_directory_name (l_gen_dir, {EQA_EW_EIFFEL_TEST_CONSTANTS}.Work_c_code_directory)
			a_env.put (l_exec_dir, {EQA_EW_PREDEFINED_VARIABLES}.Work_execution_dir_name)
			l_exec_dir := full_directory_name (l_gen_dir, {EQA_EW_EIFFEL_TEST_CONSTANTS}.Final_c_code_directory)
			a_env.put (l_exec_dir, {EQA_EW_PREDEFINED_VARIABLES}.Final_execution_dir_name)

			-- Copy from $EWEASEL\control\unix_platform

			a_env.put (l_util.file_path (<<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "ec">>), {EQA_EW_PREDEFINED_VARIABLES}.Compile_command_name)
			a_env.put (l_util.file_path (<<"$EWEASEL", "bin", "eiffel_freeze">>), {EQA_EW_PREDEFINED_VARIABLES}.Freeze_command_name)
			a_env.put (l_util.file_path (<<"$EWEASEL", "bin", "eiffel_execute">>), {EQA_EW_PREDEFINED_VARIABLES}.Execute_command_name)
		end

	associate (a_env: EQA_SYSTEM_ENVIRONMENT; a_var, a_dir: STRING)
			-- Define an environment variable `a_var' in the
			-- environment `a_env' to have
			-- value `a_dir', which must be a directory name.
			-- Create the directory `a_dir' if it does not exist.
		require
			environment_not_void: a_env /= Void
			var_name_not_void: a_var /= Void
			directory_not_void: a_dir /= Void
		local
			l_d: DIRECTORY
		do
			a_env.put (a_dir, a_var)
			create l_d.make (a_dir)
			if not l_d.exists then
				l_d.create_dir
			end
		end

	full_directory_name (a_path_1, a_path_2:STRING): STRING
			-- Full name of subdirectory `subdir' of directory
			-- `dir_name'
		local
			l_path: EQA_EW_STRING_UTILITIES
		do
			create l_path
			Result := l_path.file_path (<<a_path_1, a_path_2>>)
		end

feature -- Query

	ecf_name: detachable STRING
			-- Name of Ecf (ace) file for Eiffel compilations

	system_name: detachable STRING
			-- Name of executable file specified in Ace

	copy_wait_required: BOOLEAN
			-- Must we wait for one second before copying a
			-- file, in order to avoid a situation where the
			-- compiler does not recognize that a file has been
			-- modified?
		do
			Result := unwaited_compilation and os.current_time_in_seconds <= e_compile_start_time
		end

	e_compile_start_time: INTEGER
			-- Time in seconds since beginning of era
			-- when last Eiffel compilation was started or
			-- resumed

	e_compilation: detachable EQA_EW_EIFFEL_COMPILATION
			-- Eiffel compilation, if any
			-- (possibly suspended and awaiting resumption)

	c_compilation: detachable EQA_EW_C_COMPILATION
			-- Last C compilation, if any

	e_compile_count: INTEGER
			-- Number of Eiffel compilations started

	c_compile_count: INTEGER
			-- Number of C compilations started

	execution_count: INTEGER;
			-- Number of system executions started

	e_compile_output_name: STRING
			-- Name of file for output from current Eiffel
			-- compilation
		do
			create Result.make (0)
			Result.append (Eiffel_compile_output_prefix)
			Result.append_integer (e_compile_count)
		end

	c_compile_output_name: STRING
			-- Name of file for output from current C
			-- compilation
		do
			create Result.make (0)
			Result.append (C_compile_output_prefix)
			Result.append_integer (c_compile_count)
		end

	execution_output_name: STRING
			-- Name of file for output from current system
			-- execution
		do
			create Result.make (0)
			Result.append (Execution_output_prefix)
			Result.append_integer (execution_count)
		end

	e_compilation_result: detachable EQA_EW_EIFFEL_COMPILATION_RESULT
			-- Result of the last Eiffel compilation.

	c_compilation_result: detachable EQA_EW_C_COMPILATION_RESULT
			-- Result of the last C compilation.

	execution_result: detachable EQA_EW_EXECUTION_RESULT
			-- Result of the last Eiffel system execution.

	has_env (a_key: STRING): BOOLEAN
			-- If `a_key' has associate value in `environment'
		do
			Result := attached environment.value (a_key)
		end

feature -- Command

	unset_copy_wait
			-- Change status to indicate that no wait is
			-- needed before a file copy
		do
			unwaited_compilation := False
		ensure
			wait_not_required: not copy_wait_required
		end

	increment_execution_count
			-- Increment `execution_count' by 1
		do
			execution_count := execution_count + 1
		end;

	increment_e_compile_count
			-- Increment `e_compile_count' by 1
		do
			e_compile_count := e_compile_count + 1
		end

	increment_c_compile_count
			-- Increment `c_compile_count' by 1
		do
			c_compile_count := c_compile_count + 1
		end

	set_e_compile_start_time (a_t: INTEGER)
			-- Set start time of last Eiffel compilation to `a_t'
		do
			e_compile_start_time := a_t
			unwaited_compilation := True
		ensure
			time_set: e_compile_start_time = a_t
			wait_required: unwaited_compilation
		end

	set_e_compilation (a_e: EQA_EW_EIFFEL_COMPILATION)
			-- Set `e_compilation' with `a_e'
		do
			e_compilation := a_e
		ensure
			set: e_compilation = a_e
		end

	set_e_compilation_result (a_e: detachable EQA_EW_EIFFEL_COMPILATION_RESULT)
			-- Set `e_compilation_result' with `a_e'
		do
			e_compilation_result := a_e
		ensure
			set: e_compilation_result = a_e
		end

	set_c_compilation (a_c: EQA_EW_C_COMPILATION)
			-- Set `c_compilation' with `a_c'
		do
			c_compilation := a_c
		ensure
			set: c_compilation = a_c
		end

	set_c_compilation_result (a_c: detachable EQA_EW_C_COMPILATION_RESULT)
			-- Set `c_compilation_result' with `a_c'
		do
			c_compilation_result := a_c
		ensure
			set: c_compilation_result = a_c
		end

	set_execution_result (a_e: detachable EQA_EW_EXECUTION_RESULT)
			-- Set `execution_result' with `a_e'
		do
			execution_result := a_e
		end

	set_system_name (a_name: STRING)
			-- Set `system_name' with `a_name'
		do
			system_name := a_name
		end

feature {EQA_EW_EIFFEL_COMPILATION, EQA_EW_SYSTEM_EXECUTION, EQA_EW_C_COMPILATION} -- Internal command

	set_output_path (a_path: STRING)
			-- Set `a_path' as system execution output file name
		require
			not_void: attached a_path
		local
			l_path: EQA_SYSTEM_PATH
			l_execution: like current_execution
		do
			prepare_system_if_needed

			create l_path.make (<<a_path>>)
			l_execution := current_execution
			check attached l_execution end -- Implied by postcondition of `prepare_system_if_needed'			
			l_execution.set_output_path (l_path)
		end

	set_output_processor (a_processor: EQA_SYSTEM_OUTPUT_PROCESSOR)
			-- Set `a_process' as system execution output processor
		require
			not_void: attached a_processor
		local
			l_execution: like current_execution
		do
			prepare_system (create {EQA_SYSTEM_PATH}.make (<<e_compile_output_name>>))

			l_execution := current_execution
			check attached l_execution end -- Implied by postcondition of `prepare_system_if_needed'
			l_execution.set_output_processor (a_processor)
			l_execution.set_error_processor (a_processor)
		end

	prepare_system_if_needed
			-- Prepare system if needed
		local
			l_path: EQA_SYSTEM_PATH
		do
			if not attached current_execution then
				create l_path.make (<<e_compile_output_name>>)
				prepare_system (l_path)
			end
		ensure
			created: attached current_execution
		end

feature {NONE} -- Implementation

	unwaited_compilation: BOOLEAN
			-- Is there a started or resumed compilation
			-- for which we have not yet waited and which
			-- may necessitate a wait?  (Due to the fact that
			-- the Eiffel compiler uses dates which
			-- only have a resolution of one second)

	Eiffel_compile_output_prefix: STRING = "e_compile"
			-- File name prefix for Eiffel compile output

	C_compile_output_prefix: STRING = "c_compile";
			-- File name prefix for C compile output

	Execution_output_prefix: STRING = "execution"
			-- File name prefix for execution output

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
