note
	description: "An Eiffel compilation/execution test."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_EIFFEL_EWEASEL_TEST

inherit
	EW_EIFFEL_TEST_CONSTANTS
	EW_INSTRUCTION_TABLES
	EW_OS_ACCESS
	EW_PREDEFINED_VARIABLES
	EW_SHARED_OBJECTS
	EW_STRING_UTILITIES

create
	make

feature {NONE} -- Creation

	make (insts: LIST [EW_TEST_INSTRUCTION])
			-- Create `Current' from the test instructions
			-- in `insts'.
		require
			instruction_not_void: insts /= Void
		do
			instructions := insts
			set_defaults
		end

feature

	set_env (env: EW_TEST_ENVIRONMENT)
			--
		do
			environment := env
		ensure
			set: environment = env
		end

	execute (env: EW_TEST_ENVIRONMENT)
			-- Execute this test in environment `env'.
			-- Set `last_ok' to indicate whether it
			-- executed correctly.
		local
			inst: EW_TEST_INSTRUCTION
			err: EW_EXECUTION_ERROR
			orig_text: STRING_32
			subst_text: STRING_32
			terminated: BOOLEAN
		do
			environment := env
			from
				last_ok := True
				instructions.start
			invariant
				last_ok or attached inst
			until
				instructions.after or not last_ok or terminated
			loop
				inst := instructions.item
				inst.execute (Current)
				last_ok := inst.execute_ok
				terminated := inst.test_execution_terminated
				instructions.forth
			end
			if not last_ok then
				if not terminated then
					instructions.finish	-- Test_end instruction
					instructions.item.execute (Current)
				end
				if not attached inst then
					check from_loop_invariant: False then end
				end
				create orig_text.make_empty
				orig_text.append (inst.command)
				orig_text.extend (' ')
				orig_text.append (inst.orig_arguments)
				create subst_text.make_empty
				subst_text.append (inst.command.as_string_32)
				subst_text.extend (' ')
				subst_text.append (inst.subst_arguments)
				create err.make (inst.file_name, inst.line_number, orig_text, subst_text, inst.failure_explanation)
				add_error (err)
			end
		end

feature -- Status

	last_ok: BOOLEAN
			-- Was test created or executed without any errors?

	errors: EW_ERROR_LIST
			-- Errors encountered, in order
			-- (void if `last_ok' is true)

	environment: EW_TEST_ENVIRONMENT
			-- Environment in which test is executed.
			-- Execution may modify the environment.

	copy_wait_required: BOOLEAN
			-- Must we wait for one second before copying a
			-- file, in order to avoid a situation where the
			-- compiler does not recognize that a file has been
			-- modified?
		do
			Result := unwaited_compilation and os.current_time_in_seconds <= e_compile_start_time
		end

feature -- Modification

	unset_copy_wait
			-- Change status to indicate that no wait is
			-- needed before a file copy
		do
			unwaited_compilation := False
		ensure
			wait_not_required: not copy_wait_required
		end

feature -- Display

	display
			-- Display the test
		do
			output.append ("Test: ", False)
			output.append_32 (test_name, True)
			output.append ("Description: ", False)
			output.append_32 (test_description, True)
			output.append ("System: ", False)
			output.append_32 (system_name, True)
			output.append ("Ace: ", False)
			output.append_32 (ace_name, True)
			output.append ("CPU limit: ", False)
			output.append (cpu_limit.out, True)
		end

feature -- Test properties

	set_defaults
			-- Set test properties to default values
			-- where appropriate.
		do
			create preferences.make (0)
			system_name := Default_system_name
			ace_name := Default_ace_name
		end

	test_name: READABLE_STRING_32
			-- Name of this test

	test_description: READABLE_STRING_32
			-- Description of test

	system_name: READABLE_STRING_32
			-- Name of executable file specified in Ace.

	ace_name: READABLE_STRING_32
			-- Name of Ace file for Eiffel compilations.

	target_name: READABLE_STRING_32
			-- Name of target of current project config file

	preferences: STRING_TABLE [READABLE_STRING_32]
			-- Preferences to be explicitly passed to the compiler.

	cpu_limit: INTEGER
			-- CPU limit in seconds of spawned processes.
			-- Zero means no limit.

	e_compile_count: INTEGER
			-- Number of Eiffel compilations started

	e_compile_start_time: INTEGER
			-- Time in seconds since beginning of era
			-- when last Eiffel compilation was started or
			-- resumed

	c_compile_count: INTEGER
			-- Number of C compilations started

	execution_count: INTEGER
			-- Number of system executions started

	e_compile_output_name: STRING_32
			-- Name of file for output from current Eiffel
			-- compilation
		do
			create Result.make (0)
			Result.append (Eiffel_compile_output_prefix)
			Result.append_integer (e_compile_count)
		end

	c_compile_output_name: STRING_32
			-- Name of file for output from current C
			-- compilation
		do
			create Result.make (0)
			Result.append (C_compile_output_prefix)
			Result.append_integer (c_compile_count)
		end

	execution_output_name: STRING_32
			-- Name of file for output from current system
			-- execution
		do
			create Result.make (0)
			Result.append (Execution_output_prefix)
			Result.append_integer (execution_count)
		end

	e_compilation: EW_EIFFEL_COMPILATION
			-- Eiffel compilation, if any
			-- (possibly suspended and awaiting resumption)

	e_compilation_result: detachable EW_EIFFEL_COMPILATION_RESULT
			-- Result of the last Eiffel compilation.

	c_compilation: EW_C_COMPILATION
			-- Last C compilation, if any

	c_compilation_result: detachable EW_C_COMPILATION_RESULT
			-- Result of the last C compilation.

	execution_result: detachable EW_EXECUTION_RESULT
			-- Result of the last Eiffel system execution.

feature {EW_TEST_INSTRUCTION} -- Set test properties

	set_test_name (name: like test_name)
		do
			test_name := name
		end

	set_test_description (desc: like test_description)
		do
			test_description := desc
		end

	set_system_name (name: READABLE_STRING_32)
		do
			system_name := name
		end

	set_ace_name (name: READABLE_STRING_32)
		do
			ace_name := name
		end

	set_target_name (a_target: READABLE_STRING_32)
			-- Set `target_name' with `a_target'
		local
			dir: READABLE_STRING_32
		do
			target_name := a_target
			dir := environment.value (test_dir_name)
			dir := os.full_directory_name (dir, Eiffel_gen_directory)
			dir := os.full_directory_name (dir, a_target)
			environment.define (Work_execution_dir_name, os.full_directory_name (dir, Work_c_code_directory))
			environment.define (Final_execution_dir_name, os.full_directory_name (dir, Final_c_code_directory))
		ensure
			set: target_name = a_target
		end

	set_preference (name, value: READABLE_STRING_32)
			-- Add/override a preference of name `name` with value `value`.
		do
			preferences [name] := value
		end

	set_cpu_limit (limit: INTEGER)
		do
			cpu_limit := limit
		end

	set_e_compilation (e: EW_EIFFEL_COMPILATION)
		do
			e_compilation := e
		end

	set_e_compile_start_time (t: INTEGER)
			-- Set start time of last Eiffel compilation to `t'
		do
			e_compile_start_time := t
			unwaited_compilation := True
		ensure
			time_set: e_compile_start_time = t
			wait_required: unwaited_compilation
		end

	set_c_compilation (c: EW_C_COMPILATION)
		do
			c_compilation := c
		end

	set_e_compilation_result (e: detachable EW_EIFFEL_COMPILATION_RESULT)
		do
			e_compilation_result := e
		end

	set_c_compilation_result (c: detachable EW_C_COMPILATION_RESULT)
		do
			c_compilation_result := c
		end

	set_execution_result (e: detachable EW_EXECUTION_RESULT)
		do
			execution_result := e
		end

	set_instructions (l: LIST [EW_TEST_INSTRUCTION])
		do
			instructions := l
		end

	increment_e_compile_count
		do
			e_compile_count := e_compile_count + 1
		end

	increment_c_compile_count
		do
			c_compile_count := c_compile_count + 1
		end

	increment_execution_count
		do
			execution_count := execution_count + 1
		end

feature {EW_TEST_INSTRUCTION}  -- Test properties

	instructions: LIST [EW_TEST_INSTRUCTION]
			-- The instructions that make up this test

feature {NONE}  -- Implementation

	unwaited_compilation: BOOLEAN
			-- Is there a started or resumed compilation
			-- for which we have not yet waited and which
			-- may necessitate a wait?  (Due to the fact that
			-- the Eiffel compiler uses dates which
			-- only have a resolution of one second)

	add_error (err: EW_ERROR)
		do
			if errors = Void then
				create errors.make
			end
			errors.add (err)
		end

	Eiffel_compile_output_prefix: STRING_32 = "e_compile"

	C_compile_output_prefix: STRING_32 = "c_compile"

	Execution_output_prefix: STRING_32 = "execution"

;note
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
