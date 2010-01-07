note
	description: "[
					Names of predefined environment variables for an Eiffel test
					
					For old version, please check {EW_PREDEFINED_VARIABLES}
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"


class EQA_EW_PREDEFINED_VARIABLES

feature -- Pre-defined environment variable names

	Source_dir_name: STRING = "SOURCE"
			-- Name of environment variable with full name of
			-- source directory

	Test_dir_name: STRING = "TEST"
			-- Name of environment variable with name of
			-- test directory, where test is to be performed.

	Cluster_dir_name: STRING = "CLUSTER"
			-- Name of Environment variable with name of
			-- cluster directory.  All class texts should
			-- be copied to this directory or a direct
			-- subdirectory of it.

	Output_dir_name: STRING = "OUTPUT"
			-- Name of Environment variable with name of
			-- output directory.  All output from
			-- compilations or system executions is placed
			-- in this directory.

	Work_execution_dir_name: STRING = "EXEC_WORK"
			-- Name of environment variable with name of
			-- workbench execution directory.  A system to
			-- be executed in workbench mode is found in
			-- this directory.

	Final_execution_dir_name: STRING = "EXEC_FINAL"
			-- Name of environment variable with name of
			-- final execution directory.  A system to
			-- be executed in final mode is found in
			-- this directory.

	Compile_command_name: STRING = "EWEASEL_COMPILE"
			-- Name of environment variable whose value is the
			-- name of the command to use for compiling

	Freeze_command_name: STRING = "EWEASEL_FREEZE"
			-- Name of environment variable whose value is the
			-- name of the command to use for freezing.

	Execute_command_name: STRING = "EWEASEL_EXECUTE"
			-- Name of environment variable whose value is the
			-- name of the command to use for system execution.

	Eweasel_fast_name: STRING = "EWEASEL_FAST"
			-- Name of environment variable which indicates
			-- that "speed" mode should be used, if variable set

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
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
