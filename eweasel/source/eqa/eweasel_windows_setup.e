indexing
	description: "Summary description for {EWEASEL_WINDOWS_SETUP}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EWEASEL_WINDOWS_SETUP

inherit
	ANY

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

	make is
			-- Creation method
		do
		end

feature -- Config

	ise_eiffel: STRING is "e:\PROGRA~1\EIFFEL~1\EIFFEL~1.3GP"
			-- ISE_EIFFEL environment variable

	output_path: STRING is "e:\temp_del_it"
			-- eweasel output path

	source_directory: STRING is "e:\eweasel\tests"
			-- Test case source path

	setup_one_test_case (a_test_name, a_test_folder_name, a_arguments: STRING) is
			-- Setup for one test case
		require
			not_void: a_test_name /= Void
			not_void: a_test_folder_name /= Void
			not_void: a_arguments /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
			l_test: EW_EQA_NAMED_EIFFEL_TEST
		do

			create l_factory
			-- Prepare {EW_EQA_NAMED_EIFFEL_TEST}, so following `' will take effect
			 l_factory.reset_environment_and_test
			 setup
			initial_environment (l_factory.environment, a_test_folder_name)

					test (a_test_name, a_test_folder_name, a_arguments)
		end

feature -- Query

	is_file_exists (a_tcf_file: STRING): BOOLEAN is
			-- If `a_tcf_file' exists
		require
			not_void: a_tcf_file /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_tcf_file)
			Result := l_file.exists
		end

	is_dir_exists (a_dir: STRING): BOOLEAN is
			-- If `a_dir' exists
		require
			not_void: a_dir /= Void
		local
			l_dir: DIRECTORY
		do
			create l_dir.make (a_dir)
			Result := l_dir.exists
		end

feature -- Util

	convert_tcf_in_folder (a_dir: STRING; a_test_name: STRING) is
			-- Convert `a_tcf_file' to normal Eiffel class if there is a tcf under `a_dir'
		require
			not_void: a_dir /= Void
--			is_dir_exists: is_dir_exists (a_dir)
			not_void: a_test_name /= Void
		local
--			l_temp_file: STRING
			l_file_name: FILE_NAME
			l_file: RAW_FILE
		do
--			l_temp_file := "ew_eqa_temp_testing_control_file.e"

			create l_file_name.make_from_string (a_dir)
			l_file_name.set_file_name ("tcf")
			create l_file.make (l_file_name)
			if l_file.exists then


				converter.append_one_test_routine (l_file_name, a_test_name)
			else
				print ("%NError: tcf file not exists in dir: " + a_dir)
			end

		end

	convert_all_tcf_in (a_dir: STRING; a_output_file: STRING) is
			-- Convert all tcf files in `a_dir'
			-- This feature will place all tests under a dir to one Eiffel testing class
		require
			not_void: a_dir /= Void
			is_dir_exists: is_dir_exists (a_dir)
			not_void: a_output_file /= Void
		local
			l_dir: DIRECTORY
			l_list: ARRAYED_LIST [STRING_8]
			l_dir_name: DIRECTORY_NAME
		do
			create l_dir.make (a_dir)
			l_dir.open_read

			from
				create converter.make_default
				l_list := l_dir.linear_representation

				l_list.start
			until
				l_list.after
			loop
				create l_dir_name.make_from_string (a_dir)
				l_dir_name.extend (l_list.item)

				convert_tcf_in_folder (l_dir_name, l_list.item)

				l_list.forth
			end

			converter.flush_to_output_file (a_output_file)

		end

feature -- Command

	setup is
			-- Start eweasel testing
		local
			l_eweasel_63: EW_EQA_EWEASEL_MT
			l_list: ARRAYED_LIST [EW_EQA_TEST_CATALOG_INSTRUCTIONS]
		do
			create l_eweasel_63.make_empty

			l_eweasel_63.output_arg (output_path)

			l_eweasel_63.define ("ISE_EIFFEL", ise_eiffel)

			l_eweasel_63.init ("$ISE_EIFFEL\eweasel\control\init")

			l_eweasel_63.define ("ISE_PLATFORM", "windows")
			l_eweasel_63.define ("EWEASEL", "$ISE_EIFFEL\eweasel")
			l_eweasel_63.define ("INCLUDE", "$EWEASEL\control")
			l_eweasel_63.define ("EWEASEL_PLATFORM", "WINDOWS")
			l_eweasel_63.define ("WINDOWS", "1")
			l_eweasel_63.define ("PLATFORM_TYPE", "$EWEASEL_PLATFORM")
l_eweasel_63.define ("EWEASEL_DOTNET_SETTING", "")

			l_eweasel_63.define_file ("EWEASEL_COMPILE", <<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "ec.exe">>)
			l_eweasel_63.define_file ("EWEASEL_EXECUTE", <<"$EWEASEL", "bin", "eiffel_execute.bat">>)
			l_eweasel_63.define_file ("EWEASEL_FREEZE", <<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "finish_freezing.exe">>)

			-- Copy from $EWEASEL\control\standard
			l_eweasel_63.define_file ("PRECOMPILED_BASE", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "base.ecf">>)
			l_eweasel_63.define_file ("PRECOMPILED_BASE_MT", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "base-mt.ecf">>)


--			l_eweasel_63.define_file ("PRECOMPILED_BASE", <<"$ISE_EIFFEL", "precomp", "spec", "$ISE_PLATFORM", "base.ecf">>)

			prepare
			source_path (source_directory)
		end

feature {NONE} -- Implementation

	initial_environment (a_env: EW_TEST_ENVIRONMENT; a_test_dir_name: STRING)  is
			-- Initial environment environment in which to
			-- execute `test'.  The result may be safely
			-- modified by the caller.
			-- Modified base on {EW_EIFFEL_TEST_SUITE}.initial_environment
		require
			test_not_void: a_env /= Void
		local
			l_test_dir, l_gen_dir, l_exec_dir: STRING
			l_path: DIRECTORY_NAME
		do
			create l_path.make_from_string (output_path)
--			l_path.extend ("testing_tool_tmp")
			l_test_dir := os.full_directory_name (l_path, a_test_dir_name) -- See {EWEASEL_TEST_CATALOG_SAMPLE}
			associate (a_env, Test_dir_name, l_test_dir)
			associate (a_env, Cluster_dir_name, os.full_directory_name (l_test_dir, "clusters"))
			associate (a_env, Output_dir_name, os.full_directory_name (l_test_dir, "output"))
			-- fixme ("set correct directory depending on used target")
			l_gen_dir := os.full_directory_name (l_test_dir, Eiffel_gen_directory)
			l_gen_dir := os.full_directory_name (l_gen_dir, Default_system_name)
			l_exec_dir := os.full_directory_name (l_gen_dir, Work_c_code_directory)
			a_env.define (Work_execution_dir_name, l_exec_dir)
			l_exec_dir := os.full_directory_name (l_gen_dir, Final_c_code_directory)
			a_env.define (Final_execution_dir_name, l_exec_dir)
		end

	associate (env: EW_TEST_ENVIRONMENT; var, dir: STRING) is
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
			create d.make (dir)
			if not d.exists then
				d.create_dir
			end
		end

	converter: EW_EQA_TEST_EWEASEL_TCF_CONVERTER
			-- For convert all tests under a folder

;indexing
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
