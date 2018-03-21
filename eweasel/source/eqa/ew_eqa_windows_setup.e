note
	description: "[
			Helper to setup environment values before running eweasel test cases
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_WINDOWS_SETUP

inherit
	EW_STRING_UTILITIES

	EW_OS_ACCESS
		export
			{NONE} all
		end

	EW_PREDEFINED_VARIABLES
		export
			{NONE} all
		end

	EW_EIFFEL_TEST_CONSTANTS
		export
			{NONE} all
		end

	EW_EQA_TEST_CATALOG_INSTRUCTIONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create all_converted_classes.make (100)
			all_converted_classes.compare_objects
		end

feature -- Config

	ise_eiffel: READABLE_STRING_32
			-- ISE_EIFFEL environment variable
		require
			environment_set: is_environment_set
		once
			Result := (create {EXECUTION_ENVIRONMENT}).item ("ISE_EIFFEL")
		ensure
			not_void: Result /= Void
		end

	ise_platform: READABLE_STRING_32
			-- ISE_PLATFORM environment variable
		require
			environment_set: is_environment_set
		once
			Result := (create {EXECUTION_ENVIRONMENT}).item ("ISE_PLATFORM")
		ensure
			not_void: Result /= Void
		end

	output_path: PATH
			-- eweasel output path
		require
			environment_set: is_environment_set
		once
			Result := eweasel_path.extended ("tmp")
		end

	source_directory: PATH
			-- Test case source path
		require
			environment_set: is_environment_set
		once
			Result := eweasel_path.extended ("tests")
		ensure
			not_void: Result /= Void
		end

	eweasel_path: PATH
			-- EWEASEL environment path
		require
			environment_set: is_environment_set
		once
			if attached (create {EXECUTION_ENVIRONMENT}).item ("EWEASEL") as e then
				create Result.make_from_string (e)
			else
				create Result.make_empty
			end
		ensure
			not_void: Result /= Void
		end

	setup_one_test_case (a_test_name, a_test_folder_name, a_arguments: READABLE_STRING_32)
			-- Setup for one test case
		require
			not_void: a_test_name /= Void
			not_void: a_test_folder_name /= Void
			not_void: a_arguments /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
			l_temp_dir: DIRECTORY
		do
			create l_temp_dir.make_with_path (output_path)
			if not l_temp_dir.exists then
				l_temp_dir.create_dir
			end
			if not l_temp_dir.is_closed then
				l_temp_dir.close
			end

			create l_factory
			-- Prepare {EW_EQA_NAMED_EIFFEL_TEST}, so following `' will take effect
			 l_factory.reset_environment_and_test
			 setup
			initial_environment (l_factory.environment, a_test_folder_name)

			test (a_test_name, a_test_folder_name, a_arguments)
		end

feature -- Query

	is_file_exists (a_tcf_file: READABLE_STRING_32): BOOLEAN
			-- If `a_tcf_file' exists
		require
			not_void: a_tcf_file /= Void
		do
			Result := (create {PLAIN_TEXT_FILE}.make_with_name (a_tcf_file)).exists
		end

	is_dir_exists (a_dir: PATH): BOOLEAN
			-- If `a_dir' exists
		require
			not_void: a_dir /= Void
		do
			Result := (create {DIRECTORY}.make_with_path (a_dir)).exists
		end

	is_environment_set: BOOLEAN
			-- If environment set?
		local
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			Result := attached l_env.item ("ISE_EIFFEL") and attached l_env.item ("EWEASEL")
		end

	all_converted_classes: ARRAYED_SET [READABLE_STRING_32]
			-- All converted classes

feature -- Command

	setup
			-- Setup environment for eweasel testing
		local
			l_eweasel_63: EW_EQA_EWEASEL_MT
		do
			create l_eweasel_63.make_empty

			l_eweasel_63.output_arg (output_path.name)

			l_eweasel_63.define ({STRING_32} "ISE_EIFFEL", ise_eiffel)

			l_eweasel_63.init ({STRING_32} "$ISE_EIFFEL\eweasel\control\init")

			l_eweasel_63.define ({STRING_32} "ISE_PLATFORM", ise_platform)
			l_eweasel_63.define ({STRING_32} "EWEASEL", {STRING_32} "$ISE_EIFFEL\eweasel")
			l_eweasel_63.define ({STRING_32} "INCLUDE", {STRING_32} "$EWEASEL\control")
			l_eweasel_63.define ({STRING_32} "EWEASEL_PLATFORM", {STRING_32} "WINDOWS")
			l_eweasel_63.define ({STRING_32} "WINDOWS", {STRING_32} "1")
			l_eweasel_63.define ({STRING_32} "PLATFORM_TYPE", {STRING_32} "$EWEASEL_PLATFORM")
			l_eweasel_63.define ({STRING_32} "EWEASEL_DOTNET_SETTING", {STRING_32} "")

			-- Copy from $EWEASEL\control\windows_platform
			l_eweasel_63.define_file ("EWEASEL_COMPILE", <<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "ec.exe">>)
			l_eweasel_63.define_file ("EWEASEL_EXECUTE", <<"$EWEASEL", "bin", "eiffel_execute.bat">>)
			l_eweasel_63.define_file ("EWEASEL_FREEZE", <<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "finish_freezing.exe">>)

			-- Copy from $EWEASEL\control\standard
			l_eweasel_63.define_file ("PRECOMPILED_BASE", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "base.ecf">>)
			l_eweasel_63.define_file ("PRECOMPILED_BASE_MT", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "base-mt.ecf">>)
			l_eweasel_63.define_file ("PRECOMPILED_STORE", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "store">>)

			-- Copy from $EWEASEL/control/windows_platform
			l_eweasel_63.define ({STRING_32} "KERNEL_CLASSIC", {STRING_32} "<cluster name=%"kernel%" location=%"$ISE_LIBRARY\library\base\elks\kernel%"/><cluster name=%"exceptions%" location=%"$ISE_LIBRARY\library\base\ise\kernel\exceptions%"/><cluster name=%"elks_exceptions%" location=%"$ISE_LIBRARY\library\base\elks\kernel\exceptions%"/>")
			l_eweasel_63.define ({STRING_32} "KERNEL_DOTNET", {STRING_32} "")
			l_eweasel_63.define ({STRING_32} "SUPPORT_DOTNET", {STRING_32} "")
			l_eweasel_63.define ({STRING_32} "EWEASEL_DOTNET_SETTING", {STRING_32} "")
			l_eweasel_63.define ({STRING_32} "KERNEL_DOTNET_NO_EXCEPTION", {STRING_32} "")

			-- Copy from $EWEASEL/control/standard
			l_eweasel_63.define_file ("BASE", <<"$ISE_LIBRARY", "library", "base", "elks">>)
			l_eweasel_63.define_file ("BASE_ISE", <<"$ISE_LIBRARY", "library", "base", "ise">>)
			l_eweasel_63.define_file ("KERNEL",	<<"$BASE", "kernel">>)
			l_eweasel_63.define_file ("EXCEPTIONS",	<<"$BASE", "kernel", "exceptions">>)
			l_eweasel_63.define_file ("EXCEPTIONS_ISE",	<<"$BASE_ISE", "kernel", "exceptions">>)
			l_eweasel_63.define_file ("EXCEPTIONS_ELKS", <<"$BASE", "kernel", "exceptions">>)
			l_eweasel_63.define_file ("REFACTORING", <<"$BASE", "refactoring">>)
			l_eweasel_63.define_file ("SERIALIZATION", <<"$BASE_ISE", "serialization">>)
			l_eweasel_63.define_file ("SUPPORT", <<"$BASE", "support">>)
			l_eweasel_63.define_file ("ACCESS", <<"$BASE", "structures", "access">>)
			l_eweasel_63.define_file ("CURSORS", <<"$BASE", "structures", "cursors">>)
			l_eweasel_63.define_file ("CURSOR_TREE", <<"$BASE", "structures", "cursor_tree">>)
			l_eweasel_63.define_file ("DISPENSER", <<"$BASE", "structures", "dispenser">>)
			l_eweasel_63.define_file ("ITERATION",	<<"$BASE", "structures", "iteration">>)
			l_eweasel_63.define_file ("LIST", <<"$BASE", "structures", "list">>)
			l_eweasel_63.define_file ("OBSOLETE", <<"$BASE", "structures", "obsolete">>)
			l_eweasel_63.define_file ("SET", <<"$BASE", "structures", "set">>)
			l_eweasel_63.define_file ("STRATEGY", <<"$BASE", "structures", "set", "strategies">>)
			l_eweasel_63.define_file ("SORT", <<"$BASE", "structures", "sort">>)
			l_eweasel_63.define_file ("STORAGE", <<"$BASE", "structures", "storage">>)
			l_eweasel_63.define_file ("TABLE", <<"$BASE", "structures", "table">>)
			l_eweasel_63.define_file ("TRAVERSING", <<"$BASE", "structures", "traversing">>)
			l_eweasel_63.define_file ("TREE", <<"$BASE", "structures", "tree">>)
			l_eweasel_63.define_file ("THREAD", <<"$ISE_LIBRARY", "library", "thread">>)
			-- EiffelTime directories
			l_eweasel_63.define_file ("TIME", <<"$ISE_LIBRARY", "library", "time">>)
			l_eweasel_63.define_file ("TIME_FORMAT", <<"$TIME", "format">>)
			l_eweasel_63.define_file ("TIME_ENGLISH", <<"$TIME", "format", "english">>)
			l_eweasel_63.define_file ("TIME_GERMAN", <<"$TIME", "format", "german">>)
			-- EiffelStore directories
			l_eweasel_63.define_file ("STORE", <<"$ISE_LIBRARY", "library", "store">>)
			l_eweasel_63.define_file ("DATE_TIME", <<"$STORE", "date_and_time">>)
			l_eweasel_63.define_file ("RDBMS_ORACLE", <<"$STORE", "dbms", "rdbms", "oracle">>)
			l_eweasel_63.define_file ("RDBMS_SUPPORT", <<"$STORE", "dbms", "rdbms", "support">>)
			l_eweasel_63.define_file ("DBMS_SUPPORT", <<"$STORE", "dbms", "support">>)
			l_eweasel_63.define_file ("STORE_INTERFACE", <<"$STORE", "interface">>)
			l_eweasel_63.define_file ("STORE_SUPPORT", <<"$STORE", "support">>)

			prepare
			source_path (source_directory)
		end

	convert_tcf_in_folder (a_dir: PATH; a_test_name: STRING)
			-- Convert `a_tcf_file' to normal Eiffel class if there is a tcf under `a_dir'
		require
			not_void: a_dir /= Void
--			is_dir_exists: is_dir_exists (a_dir)
			not_void: a_test_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (a_dir.extended ("tcf"))
			if l_file.exists then
				converter.append_one_test_routine (l_file.path, a_test_name)
			else
				print ("%NError: tcf file not exists in dir: " + a_dir.name)
			end
		end

	convert_all_tcf_in (a_dir: PATH; a_output_file_path: PATH; a_output_file_prefix: READABLE_STRING_32)
			-- Convert all tcf files in `a_dir'
			-- This feature will place all tests under a dir to one Eiffel testing class
		require
			not_void: a_dir /= Void
			is_dir_exists: is_dir_exists (a_dir)
			not_void: a_output_file_path /= Void
			not_void: a_output_file_prefix /= Void
		local
			l_dir: DIRECTORY
			l_sorted_list: SORTED_TWO_WAY_LIST [PATH]
			l_current_test_prefix: READABLE_STRING_32
			l_class_name: READABLE_STRING_32
			p: PATH
			last_test_prefix: READABLE_STRING_32 -- Last test case prefix
		do
			create l_dir.make_with_path (a_dir)
			l_dir.open_read
				-- Sort all items in `l_dir'
				-- Otherwise, on Windows, items in `l_dir' is alphabetical, but not case for Unix platforms.
				-- Un-sorted list will cause eweasel converter contain only one test case in one generated Eiffel class.
			create l_sorted_list.make
			across
				l_dir.entries as e
			loop
				l_sorted_list.extend (e.item)
			end
			create converter.make_default
			converter.set_ignore_non_exist_test_cases (True)
			across
				l_sorted_list as e
			from
				last_test_prefix := test_case_prefix (e.item.name)
			loop
				p := e.item
				l_current_test_prefix := test_case_prefix (p.name)
				if not last_test_prefix.is_equal (l_current_test_prefix) and converter.is_flush_needed then
					check first_time_must_pass: not e.is_first end
					l_class_name := a_output_file_prefix + "_" + last_test_prefix
					converter.flush_to_output_file (file_name (a_output_file_path, a_output_file_prefix, last_test_prefix), l_class_name)
					all_converted_classes.extend (l_class_name)
				end
				last_test_prefix := l_current_test_prefix
				convert_tcf_in_folder (l_dir.path.extended_path (p), p.utf_8_name)
			end

			if converter.is_flush_needed then
				l_class_name := a_output_file_prefix + "_" + last_test_prefix
				-- We flush last one
				converter.flush_to_output_file (file_name (a_output_file_path, a_output_file_prefix, last_test_prefix), a_output_file_prefix + "_" + last_test_prefix)
				all_converted_classes.extend (l_class_name)
			end

				-- Finally, generate a class which contain all class names
			write_all_converted_classes_to_file (a_output_file_path.extended ("all_eweasel_test_cases.e"))
		end

	write_all_converted_classes_to_file (a_output_file: PATH)
			-- Write all cnverted classes to `a_output_file'
		require
			a_output_file_not_void: a_output_file /= Void
			all_converted_classes_not_void: all_converted_classes /= Void
		local
			l_content: STRING_32
			l_item: READABLE_STRING_32
		do
			create l_content.make_empty
			across
				all_converted_classes as c
			loop
				l_item := c.item
				l_content.append ({STRING_32} "%N%T")
				l_content.append (l_item.as_lower)
				l_content.append ({STRING_32} ": ")
				l_content.append (l_item.as_upper)
			end
			converter.write_content_to_file (converter.all_eweasel_test_case_template_content (to_utf_8 (l_content)), a_output_file)
		end

feature {NONE} -- Implementation

	initial_environment (a_env: EW_TEST_ENVIRONMENT; a_test_dir_name: READABLE_STRING_32)
			-- Initial environment environment in which to
			-- execute `test'.  The result may be safely
			-- modified by the caller.
			-- Modified base on {EW_EIFFEL_TEST_SUITE}.initial_environment
		require
			test_not_void: a_env /= Void
		local
			l_test_dir, l_gen_dir, l_exec_dir: READABLE_STRING_32
		do
			l_test_dir := os.full_directory_name (output_path.name, a_test_dir_name) -- See {EWEASEL_TEST_CATALOG_SAMPLE}
			associate (a_env, Test_dir_name, l_test_dir)
			associate (a_env, Cluster_dir_name, os.full_directory_name (l_test_dir, {STRING_32} "clusters"))
			associate (a_env, Output_dir_name, os.full_directory_name (l_test_dir, {STRING_32} "output"))
			-- fixme ("set correct directory depending on used target")
			l_gen_dir := os.full_directory_name (l_test_dir, Eiffel_gen_directory)
			l_gen_dir := os.full_directory_name (l_gen_dir, Default_target_name)
			l_exec_dir := os.full_directory_name (l_gen_dir, Work_c_code_directory)
			a_env.define (Work_execution_dir_name, l_exec_dir)
			l_exec_dir := os.full_directory_name (l_gen_dir, Final_c_code_directory)
			a_env.define (Final_execution_dir_name, l_exec_dir)
		end

	associate (env: EW_TEST_ENVIRONMENT; var, dir: READABLE_STRING_32)
			-- Define an environment variable `var' in the
			-- environment `env' to have
			-- value `dir', which must be a directory name.
			-- Create the directory `dir' if it does not exist.
		require
			environment_not_void: env /= Void
			var_name_not_void: var /= Void
			directory_not_void: dir /= Void
		local
			d: DIRECTORY
		do
			env.define (var, dir)
			create d.make_with_name (dir)
			if not d.exists then
				d.create_dir
			end
		end

	converter: EW_EQA_TEST_EWEASEL_TCF_CONVERTER
			-- For convert all tests under a folder

	file_name (a_output_file_path: PATH; a_output_file_prefix: READABLE_STRING_32; a_test_prefix: READABLE_STRING_32): PATH
			-- Join `a_output_file_path', `a_output_file_prefix' and `a_test_prefix' as a file name
		require
			not_void: a_output_file_path /= Void
			not_void: a_output_file_prefix /= Void
			not_void: a_test_prefix /= Void
		do
			Result := a_output_file_path.extended (a_output_file_prefix + "_" + a_test_prefix).appended_with_extension ("e")
		ensure
			not_void: Result /= Void
		end

	test_case_prefix (a_full_test_case_name: READABLE_STRING_32): STRING_32
			-- Find test case prefix in `a_full_test_case_name'
		require
			not_void: a_full_test_case_name /= Void
		local
			l_count: INTEGER
			l_char: CHARACTER_32
		do
				-- We find digit here.
			from
				l_count := 1
				create Result.make_empty
			until
				l_count > a_full_test_case_name.count
			loop
				l_char := a_full_test_case_name.item (l_count)
				if not l_char.is_digit then
					Result.append_character (l_char)
				end
				l_count := l_count + 1
			end
		ensure
			not_void: Result /= Void
		end

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
