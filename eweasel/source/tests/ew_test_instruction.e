note
	description: "An Eiffel test instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class EW_TEST_INSTRUCTION

inherit
	EW_STRING_UTILITIES

feature

	initialize (tcf: EW_TEST_CONTROL_FILE)
			-- Initialize instruction from information in
			-- `tcf'.
			-- Set `init_ok' to indicate whether
			-- initialization was successful.
		require
			tcf_not_void: tcf /= Void
		local
			s: STRING_32
		do
			command := tcf.command
			if attached tcf.arguments as a then
				create s.make_from_string (a)
				s.adjust
				orig_arguments := s
			else
				orig_arguments := Void
			end
			set_arguments (tcf)
			inst_initialize (subst_arguments)
		end

	initialize_for_conditional (a_tcf: EW_TEST_CONTROL_FILE; a_cmd: READABLE_STRING_32; a_args: READABLE_STRING_32)
			-- Initialize instruction from information in
			-- `tcf', but use the given `cmd' and `args' instead
			-- of getting them indirectly from `tcf'
		require
			tcf_not_void: a_tcf /= Void
			cmd_not_void: a_cmd /= Void
			args_not_void: a_args /= Void
		local
			s: STRING_32
		do
			command := a_cmd
			create s.make_from_string (a_args)
			s.adjust
			orig_arguments := s
			set_arguments (a_tcf)
			inst_initialize (s)
		end

	inst_initialize (args: READABLE_STRING_32)
			-- Do initialization specific to this particular
			-- instruction, with substituted arguments `args'.
		require
			arguments_not_void: args /= Void
		deferred
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate
			-- whether execution was successful.
			-- Set `test_execution_terminated' to indicate
			-- whether execution of test should be terminated
			-- after this instruction
		require
			test_not_void: test /= Void
		deferred
		ensure
			explain_if_failure: (not execute_ok) implies failure_explanation /= Void
		end

feature -- Status

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?
		deferred
		end

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?
		deferred
		end

	test_execution_terminated: BOOLEAN
			-- Did last call to `execute' indicate that
			-- execution of test should be terminated?
		do
			Result := False
		end

	failure_explanation: STRING_32
			-- Explanation of why last `initialize' or
			-- `execute' which was not OK failed (Void
			-- if no explanation available)

feature -- Properties

	test_control_file: EW_TEST_CONTROL_FILE;
			-- Test control file object in which instruction
			-- is being parsed

	command_table: STRING_TABLE [EW_TEST_INSTRUCTION]
			-- Table for translating commands to test
			-- instructions.
		require
			tcf_not_void: test_control_file /= Void
		do
			Result := test_control_file.command_table
		end

	init_environment: EW_TEST_ENVIRONMENT
			-- Environment during initialization of instruction.
		require
			tcf_not_void: test_control_file /= Void
		do
			Result := test_control_file.environment
		end

	command: READABLE_STRING_32
			-- Name of test instruction command

	orig_arguments: detachable READABLE_STRING_32
			-- Rest of test instruction line, as it originally
			-- appeared

	subst_arguments: STRING_32
			-- Rest of test instruction line, after substitution
			-- of environment variables

	file_name: READABLE_STRING_32
			-- Name of test control file from which instruction
			-- came, if not void.

	line_number: INTEGER
			-- Line number of `file_name' instruction is on,
			-- if `file_name' is not void.

feature -- Utilities

	executable_file_error (s: READABLE_STRING_32): detachable READABLE_STRING_32
			-- If file `s' does not exist or is not a file or
			-- is not executable, string describing the
			-- problem.  Void otherwise
		local
			f: RAW_FILE
		do
			if attached s then
				create f.make_with_name (s)
				if not f.exists then
					Result := {STRING_32} "file " + s + {STRING_32} " not found"
				elseif not f.is_plain then
					Result := {STRING_32} "file " + s + {STRING_32} " not a plain file"
				elseif not f.is_executable then
					Result := {STRING_32} "file " + s + {STRING_32} " not executable"
				end
			else
				Result := {STRING_32} "file not specified"
			end
		end

feature {NONE} -- Implementation

	set_arguments (a_tcf: EW_TEST_CONTROL_FILE)
			-- Set `subst_arguments' and get other info from `a_tcf'
		require
			tcf_not_void: a_tcf /= Void;
		do
			test_control_file := a_tcf
			subst_arguments := init_environment.substitute (orig_arguments)
			subst_arguments.adjust
			file_name := a_tcf.file_name
			line_number := a_tcf.line_number
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
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
