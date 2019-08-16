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
		redefine
			on_prepare,
			on_clean
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

	on_prepare
			-- <Precursor>
		local
			l_vars: ARRAY [STRING]
			i: INTEGER
			l_env: like environment
			l_exec_env: EXECUTION_ENVIRONMENT
			l_test_name, l_ise_platform: READABLE_STRING_32
			l_path: STRING_32
			l_ew_test_name: STRING_32
		do

			ecf_name := "Ace"

			l_env := environment

				-- Make regular Eiffel environment variables available in `environment'
			from
				create l_exec_env
				l_vars := << "ISE_EIFFEL", "ISE_PLATFORM", "ISE_C_COMPILER", "ISE_LIBRARY", "EWEASEL" >>
				i := l_vars.lower
			until
				i > l_vars.upper
			loop
				if attached l_exec_env.item (l_vars[i]) as l_env_var then
					l_env.put (l_env_var, l_vars[i])
				end
				i := i + 1
			end

			l_ise_platform := l_env.item_not_empty ("ISE_PLATFORM", asserter)

			l_path := file_system.build_path_from_key ("ISE_EIFFEL", << {STRING_32} "precomp", {STRING_32} "spec", l_ise_platform, {STRING_32} "base.ecf" >>)
			l_env.put (l_path, "PRECOMPILED_BASE")
			l_path := file_system.build_path_from_key ("ISE_EIFFEL", << {STRING_32} "precomp", {STRING_32} "spec", l_ise_platform, {STRING_32} "base-mt.ecf" >>)
			l_env.put (l_path, "PRECOMPILED_BASE_MT")
			l_path := file_system.build_path_from_key ("ISE_EIFFEL", << {STRING_32} "precomp", {STRING_32} "spec", l_ise_platform, {STRING_32} "base-safe.ecf" >>)
			l_env.put (l_path, "PRECOMPILED_BASE_SAFE")

			l_path := file_system.build_path_from_key ("ISE_EIFFEL", << {STRING_32} "studio", {STRING_32} "spec", l_ise_platform, {STRING_32} "bin", {STRING_32} "ec" >>)
			l_env.put (l_path, {EQA_SYSTEM_EXECUTION}.system_executable_key)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.Compile_command_name)

			l_path := file_system.build_path_from_key ("EWEASEL", << "bin", "eiffel_freeze" >>)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.Freeze_command_name)
			l_path := file_system.build_path_from_key ("EWEASEL", << "bin", "eiffel_execute" >>)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.Execute_command_name)

				-- Platform specifics?
			l_env.put ("UNIX", "EWEASEL_PLATFORM")
			l_env.put ("1", "UNIX")
			l_env.put ("unix", "PLATFORM_TYPE")
			l_env.put ("", "EWEASEL_DOTNET_SETTING")
			l_env.put ("<cluster name=%"kernel%" location=%"$ISE_LIBRARY\library\base\elks\kernel%"/><cluster name=%"exceptions%" location=%"$ISE_LIBRARY\library\base\ise\kernel\exceptions%"/><cluster name=%"elks_exceptions%" location=%"$ISE_LIBRARY\library\base\elks\kernel\exceptions%"/>", "KERNEL_CLASSIC")
			l_env.put ("", "KERNEL_DOTNET")
			l_env.put ("", "KERNEL_DOTNET_NO_EXCEPTION")
			l_env.put ("", "EWEASEL_DOTNET_SETTING")
			l_env.put ("", "SUPPORT_DOTNET")

			l_env.put (file_system.build_path_from_key ("ISE_LIBRARY", << "library", "base", "elks" >>), "BASE")
			l_env.put (file_system.build_path_from_key ("ISE_LIBRARY", <<"library", "base", "ise">>), "BASE_ISE")
			l_env.put (file_system.build_path_from_key ("BASE", << "kernel" >>), "KERNEL")
			l_env.put (file_system.build_path_from_key ("BASE", << "kernel", "exceptions" >>), "EXCEPTIONS")
			l_env.put (file_system.build_path_from_key ("BASE_ISE", << "kernel", "exceptions" >>), "EXCEPTIONS_ISE")
			l_env.put (file_system.build_path_from_key ("BASE", << "kernel", "exceptions" >>), "EXCEPTIONS_ELKS")
			l_env.put (file_system.build_path_from_key ("BASE", << "refactoring" >>), "REFACTORING")
			l_env.put (file_system.build_path_from_key ("BASE_ISE", << "serialization" >>), "SERIALIZATION")
			l_env.put (file_system.build_path_from_key ("BASE", << "support" >>), "SUPPORT")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "access" >>), "ACCESS")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "cursors" >>), "CURSORS")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "cursor_tree" >>), "CURSOR_TREE")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "dispenser" >>), "DISPENSER")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "iteration" >>), "ITERATION")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "list" >>), "LIST")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "obsolete" >>), "OBSOLETE")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "set" >>), "SET")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "set", "strategies" >>), "STRATEGY")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "sort" >>), "SORT")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "storage" >>), "STORAGE")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "table" >>), "TABLE")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "traversing" >>), "TRAVERSING")
			l_env.put (file_system.build_path_from_key ("BASE", << "structures", "tree" >>), "TREE")
			l_env.put (file_system.build_path_from_key ("ISE_LIBRARY", << "library", "thread" >>), "THREAD")
			-- EiffelTime directories
			l_env.put (file_system.build_path_from_key ("ISE_LIBRARY", << "library", "time" >>), "TIME")
			l_env.put (file_system.build_path_from_key ("TIME", << "format">>), "TIME_FORMAT")
			l_env.put (file_system.build_path_from_key ("TIME", << "format", "english" >>), "TIME_ENGLISH")
			l_env.put (file_system.build_path_from_key ("TIME", << "format", "german" >>), "TIME_GERMAN")
			-- EiffelStore directories
			l_env.put (file_system.build_path_from_key ("ISE_LIBRARY", << "library", "store" >>), "STORE")
			l_env.put (file_system.build_path_from_key ("STORE", << "date_and_time" >>), "DATE_TIME")
			l_env.put (file_system.build_path_from_key ("STORE", << "dbms", "rdbms", "oracle" >>), "RDBMS_ORACLE")
			l_env.put (file_system.build_path_from_key ("STORE", << "dbms", "rdbms", "support" >>), "RDBMS_SUPPORT")
			l_env.put (file_system.build_path_from_key ("STORE", << "dbms", "support" >>), "DBMS_SUPPORT")
			l_env.put (file_system.build_path_from_key ("STORE", << "interface" >>), "STORE_INTERFACE")
			l_env.put (file_system.build_path_from_key ("STORE", << "support" >>), "STORE_SUPPORT")


				-- Note: the following is a workaround to obtain the former Eweasel test name from the current one
				--       e.g. TEST_ATTACH.test_001  --> attach001
			l_test_name := l_env.item_attached (test_name_key, asserter)
			assert("valid_test_name_format", l_test_name.starts_with ("TEST_") and l_test_name.has_substring (".test_"))
			create l_ew_test_name.make_from_string (l_test_name)
			l_ew_test_name.remove_head (5)
			l_ew_test_name.replace_substring_all (".test_", "")
			l_ew_test_name.to_lower

				-- Now we can initialize the source/target directories
			l_path := file_system.build_path_from_key ("EWEASEL", <<{STRING_32} "tests", l_ew_test_name>>)
			l_env.put (l_path, {EQA_SYSTEM_TEST_SET}.source_path_key)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.source_dir_name)

			associate ({EQA_EW_PREDEFINED_VARIABLES}.Test_dir_name, Void)

			associate ({EQA_EW_PREDEFINED_VARIABLES}.Cluster_dir_name, << "clusters" >>)

			associate ({EQA_SYSTEM_EXECUTION}.output_path_key, << "output" >>)
			associate ({EQA_EW_PREDEFINED_VARIABLES}.Output_dir_name, << "output" >>)

			l_path := file_system.build_target_path (
				<< {EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_gen_directory,
				   {EQA_EW_EIFFEL_TEST_CONSTANTS}.Default_system_name,
				   {EQA_EW_EIFFEL_TEST_CONSTANTS}.Work_c_code_directory >>)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.Work_execution_dir_name)

			l_path := file_system.build_target_path (
				<< {EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_gen_directory,
				   {EQA_EW_EIFFEL_TEST_CONSTANTS}.Default_system_name,
				   {EQA_EW_EIFFEL_TEST_CONSTANTS}.Final_c_code_directory >>)
			l_env.put (l_path, {EQA_EW_PREDEFINED_VARIABLES}.Final_execution_dir_name)


		end

	associate (a_key: READABLE_STRING_32; a_path: detachable EQA_SYSTEM_PATH)
			-- Define target directory for `a_path' in environment under `a_key' and make sure
			-- directory exists.
			--
			-- Note: this might be something we want in {EQA_FILE_SYSTEM}
		require
			a_key_attached: a_key /= Void
			a_key_not_empty: not a_key.is_empty
		local
			l_path: STRING_32
			l_dir: DIRECTORY
		do
			l_path := file_system.build_target_path (a_path)
			create l_dir.make (l_path)
			if not l_dir.exists then
				l_dir.recursive_create_dir
			end
			environment.put (l_path, a_key)
		end


	init (a_test_dir_name: STRING)
			-- Same as `init_env', initialize with `environment'
		do

		end

feature -- Query

	ecf_name: detachable STRING
			-- Name of Ecf (ace) file for Eiffel compilations

	system_name: detachable READABLE_STRING_32
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

	has_env (a_key: READABLE_STRING_GENERAL): BOOLEAN
			-- If `a_key' has associate value in `environment'
		do
			Result := attached environment.item (a_key)
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

	set_system_name (a_name: like system_name)
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
		do
			prepare_system_if_needed

			create l_path.make (<<a_path>>)
				-- Implied by postcondition of `prepare_system_if_needed'.
			check attached current_execution as l_execution then
				l_execution.set_output_path (l_path)
			end
		end

	set_output_processor (a_processor: EQA_SYSTEM_OUTPUT_PROCESSOR)
			-- Set `a_process' as system execution output processor
		require
			not_void: attached a_processor
		do
			prepare_system (create {EQA_SYSTEM_PATH}.make (<<e_compile_output_name>>))
				-- Implied by postcondition of `prepare_system'.
			check attached current_execution as l_execution then
				l_execution.set_output_processor (a_processor)
			end
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

feature {NONE} -- Clean up

	on_clean
			-- <Precursor>
		do
			if attached e_compilation as l_compilation then
				if l_compilation.suspended then
					l_compilation.abort
				end
			end
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
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
