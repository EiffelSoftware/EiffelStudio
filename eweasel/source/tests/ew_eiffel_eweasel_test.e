indexing
	description: "An Eiffel compilation/execution test"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_EIFFEL_EWEASEL_TEST

inherit
	EW_INSTRUCTION_TABLES
	EW_EIFFEL_TEST_CONSTANTS
	EW_STRING_UTILITIES
	EW_OS_ACCESS
	EW_SHARED_OBJECTS

create
	make

feature -- Creation

	make (insts: LIST [EW_TEST_INSTRUCTION]) is
			-- Create `Current' from the test instructions
			-- in `insts'.
		require
			instruction_not_void: insts /= Void
		do
			instructions := insts;
			set_defaults;
		end;

	set_env (env: EW_TEST_ENVIRONMENT) is
			--
		do
			environment := env
		ensure
			set: environment = env
		end

	execute (env: EW_TEST_ENVIRONMENT) is
			-- Execute this test in environment `env'.
			-- Set `last_ok' to indicate whether it
			-- executed correctly.
		local
			inst: EW_TEST_INSTRUCTION;
			err: EW_EXECUTION_ERROR;
			orig_text, subst_text: STRING;
			terminated: BOOLEAN
		do
			environment := env;
			from
				last_ok := True;
				instructions.start;
			until
				instructions.after or not last_ok or terminated
			loop
				inst := instructions.item;
				inst.execute (Current);
				last_ok := inst.execute_ok;
				terminated := inst.test_execution_terminated
				instructions.forth;
			end;
			if not last_ok then
				if not terminated then
					instructions.finish;	-- Test_end instruction
					instructions.item.execute (Current);
				end
				create orig_text.make (0);
				orig_text.append (inst.command);
				orig_text.extend (' ');
				orig_text.append (inst.orig_arguments);
				create subst_text.make (0);
				subst_text.append (inst.command);
				subst_text.extend (' ');
				subst_text.append (inst.subst_arguments);
				create err.make (inst.file_name, inst.line_number, orig_text, subst_text, inst.failure_explanation);
				add_error (err);
			end
		end;

feature -- Status

	last_ok: BOOLEAN;
			-- Was test created or executed without any errors?

	errors: EW_ERROR_LIST;
			-- Errors encountered, in order
			-- (void if `last_ok' is true)

	environment: EW_TEST_ENVIRONMENT;
			-- Environment in which test is executed.
			-- Execution may modify the environment.

	copy_wait_required: BOOLEAN is
			-- Must we wait for one second before copying a
			-- file, in order to avoid a situation where the
			-- compiler does not recognize that a file has been
			-- modified?
		do
			Result := unwaited_compilation and os.current_time_in_seconds <= e_compile_start_time
		end;

feature -- Modification

	unset_copy_wait is
			-- Change status to indicate that no wait is
			-- needed before a file copy
		do
			unwaited_compilation := False;
		ensure
			wait_not_required: not copy_wait_required
		end;

feature -- Display

	display is
			-- Display the test
		do
			output.append ("Test: ", False)
			output.append (test_name, True)
			output.append ("Description: ", False)
			output.append (test_description, True)
			output.append ("System: ", False)
			output.append (system_name, True)
			output.append ("Ace: ", False)
			output.append (ace_name, True)
			output.append ("CPU limit: ", False)
			output.append (cpu_limit.out, True)
		end;


feature -- Test properties

	set_defaults is
			-- Set test properties to default values
			-- where appropriate.
		do
			create system_name.make (0);
			system_name.append (Default_system_name);
			create ace_name.make (0);
			ace_name.append (Default_ace_name);
		end;

	test_name: STRING;
			-- Name of this test

	test_description: STRING;
			-- Description of test

	system_name: STRING;
			-- Name of executable file specified in Ace.

	ace_name: STRING;
			-- Name of Ace file for Eiffel compilations.

	cpu_limit: INTEGER;
			-- CPU limit in seconds of spawned processes.
			-- Zero means no limit.

	e_compile_count: INTEGER;
			-- Number of Eiffel compilations started

	e_compile_start_time: INTEGER;
			-- Time in seconds since beginning of era
			-- when last Eiffel compilation was started or
			-- resumed

	c_compile_count: INTEGER;
			-- Number of C compilations started

	execution_count: INTEGER;
			-- Number of system executions started

	e_compile_output_name: STRING is
			-- Name of file for output from current Eiffel
			-- compilation
		do
			create Result.make (0);
			Result.append (Eiffel_compile_output_prefix);
			Result.append_integer (e_compile_count);
		end;

	c_compile_output_name: STRING is
			-- Name of file for output from current C
			-- compilation
		do
			create Result.make (0);
			Result.append (C_compile_output_prefix);
			Result.append_integer (c_compile_count);
		end;

	execution_output_name: STRING is
			-- Name of file for output from current system
			-- execution
		do
			create Result.make (0);
			Result.append (Execution_output_prefix);
			Result.append_integer (execution_count);
		end;

	e_compilation: EW_EIFFEL_COMPILATION;
			-- Eiffel compilation, if any
			-- (possibly suspended and awaiting resumption)

	e_compilation_result: EW_EIFFEL_COMPILATION_RESULT;
			-- Result of the last Eiffel compilation.

	c_compilation: EW_C_COMPILATION;
			-- Last C compilation, if any

	c_compilation_result: EW_C_COMPILATION_RESULT;
			-- Result of the last C compilation.

	execution_result: EW_EXECUTION_RESULT;
			-- Result of the last Eiffel system execution.

feature {EW_TEST_INSTRUCTION} -- Set test properties

	set_test_name (name: STRING) is
		do
			test_name := name;
		end;

	set_test_description (desc: STRING) is
		do
			test_description := desc;
		end;

	set_system_name (name: STRING) is
		do
			system_name := name;
		end;

	set_ace_name (name: STRING) is
		do
			ace_name := name;
		end;

	set_cpu_limit (limit: INTEGER) is
		do
			cpu_limit := limit;
		end;

	set_e_compilation (e: EW_EIFFEL_COMPILATION) is
		do
			e_compilation := e;
		end;

	set_e_compile_start_time (t: INTEGER) is
			-- Set start time of last Eiffel compilation to `t'
		do
			e_compile_start_time := t;
			unwaited_compilation := True;
		ensure
			time_set: e_compile_start_time = t;
			wait_required: unwaited_compilation;
		end;

	set_c_compilation (c: EW_C_COMPILATION) is
		do
			c_compilation := c;
		end;

	set_e_compilation_result (e: EW_EIFFEL_COMPILATION_RESULT) is
		do
			e_compilation_result := e;
		end;

	set_c_compilation_result (c: EW_C_COMPILATION_RESULT) is
		do
			c_compilation_result := c;
		end;

	set_execution_result (e: EW_EXECUTION_RESULT) is
		do
			execution_result := e;
		end;

	set_instructions (l: LIST [EW_TEST_INSTRUCTION]) is
		do
			instructions := l;
		end;

	increment_e_compile_count is
		do
			e_compile_count := e_compile_count + 1;
		end;

	increment_c_compile_count is
		do
			c_compile_count := c_compile_count + 1;
		end;

	increment_execution_count is
		do
			execution_count := execution_count + 1;
		end;

feature {EW_TEST_INSTRUCTION}  -- Test properties

	instructions: LIST [EW_TEST_INSTRUCTION];
			-- The instructions that make up this test

feature {NONE}  -- Implementation

	unwaited_compilation: BOOLEAN;
			-- Is there a started or resumed compilation
			-- for which we have not yet waited and which
			-- may necessitate a wait?  (Due to the fact that
			-- the Eiffel compiler uses dates which
			-- only have a resolution of one second)

	add_error (err: EW_ERROR) is
		do
			if errors = Void then
				create errors.make;
			end;
			errors.add (err);
		end;

	Eiffel_compile_output_prefix: STRING is "e_compile";

	C_compile_output_prefix: STRING is "c_compile";

	Execution_output_prefix: STRING is "execution";

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
