note
	description: "An Eiffel test control file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_TEST_CONTROL_FILE

inherit
	ANY
	EW_STRING_UTILITIES
		export
			{NONE} all
		end
	EW_KEYWORD_CONST
		export
			{NONE} all
		end
create

	make

feature -- Creation

	make (fn: STRING; parent: EW_TEST_CONTROL_FILE;
	  table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING]; needs_end: BOOLEAN)
			-- Create `Current' from file named `fn'
			-- included by `inc_parent' (Void if none) using
			-- `table' as the command to instruction
			-- translation table.  If `needs_end' is true,
			-- it is an error if there is no test_end instruction
			-- in the file
		require
			file_name_not_void: fn /= Void
		do
			file_name := fn;
			include_parent := parent;
			command_table := table;
			test_end_required := needs_end;
		end;

feature -- Status

	last_test: EW_EIFFEL_EWEASEL_TEST;
			-- Last test parsed or executed

	last_ok: BOOLEAN;
			-- Was file parsed and/or executed without any errors?

	errors: EW_ERROR_LIST;
			-- Errors encountered, in order (void if `last_ok'
			-- is true)

	environment: EW_TEST_ENVIRONMENT;
			-- Environment in which test is parsed.
			-- Parsing may modify the environment.

feature -- Parsing and execution

	parse_and_execute (env: EW_TEST_ENVIRONMENT)
			-- Parse `Current' in the environment `env'.
			-- Execute the resulting instructions if
			-- successful.  In either case, `last_ok' is
			-- set to indicate success and `errors' has
			-- any errors.  `Environment' is set with
			-- the test environment after execution, if successful.
		require
			environment_not_void: env /= Void
		local
			test: EW_EIFFEL_EWEASEL_TEST;
		do
			parse (env.deep_twin);
			if last_ok then
				create test.make (instructions);
				test.execute (env);
				last_test := test;
				last_ok := test.last_ok;
				errors := test.errors;
				environment := test.environment;
			else
				last_test := Void;
			end
		end;

	parse (env: EW_TEST_ENVIRONMENT)
			-- Parse `Current' in the environment `env'.
			-- Set `last_ok' to indicate whether parsing
			-- was successful.  If successful, `instructions'
			-- has the test's instructions.  If not successful,
			-- `errors' has errors.
		require
			environment_not_void: env /= Void
		local
			tcf: RAW_FILE;
			err: EW_PARSE_ERROR;
			reason: STRING;
		do
			errors := Void;
			create tcf.make (file_name);
			if not tcf.exists then
				last_ok := False;
				create reason.make (0);
				reason.append ("File not found: ");
				reason.append (file_name);
				create err.make_empty;
				err.set_reason (reason);
				add_error (err);
			elseif not tcf.is_plain then
				last_ok := False;
				create reason.make (0);
				reason.append ("File not a plain file: ");
				reason.append (file_name);
				create err.make_empty;
				err.set_reason (reason);
				add_error (err);
			else
				environment := env;
				parse_existing_file (tcf);
			end
		end;

	instructions: LINKED_LIST [EW_TEST_INSTRUCTION];
			-- The instructions that make up this test


feature {NONE} -- Implementation

	parse_existing_file (tcf: RAW_FILE)
			-- Parse test control file `tcf' and set
			-- `Current' to represent it.  Set `last_ok'
			-- to indicate whether file was parsed
			-- successfully.  If not successful,
			-- `errors' has errors.
		require
			file_exists: tcf.exists
		local
			line: STRING;
			err: EW_PARSE_ERROR;
			missing_newline: BOOLEAN
		do
			from
				tcf.open_read;
				line_number := 0;
				has_test_end := False
				create instructions.make;
			until
				tcf.end_of_file or parse_error
			loop
				tcf.read_line;
				line_number := line_number + 1;
				if not tcf.end_of_file then
					create line.make (tcf.last_string.count);
					line.append (tcf.last_string);
					parse_line (line);
					if not parse_error and last_instruction /= Void then
						instructions.extend (last_instruction);
					end
				elseif not tcf.last_string.is_empty then
					create line.make (tcf.last_string.count);
					line.append (tcf.last_string);
					parse_line (line);
					if not parse_error and last_instruction /= Void then
						instructions.extend (last_instruction);
					end
					missing_newline := True
				end
			end;
			tcf.close;
			if parse_error then
				create err.make (file_name, line_number, line, environment.substitute (line), last_instruction.failure_explanation);
				add_error (err);
				last_ok := False;
			elseif test_end_required and not has_test_end then
				create err.make (file_name, line_number + 1, "", "", "no " + Test_end_keyword + " instruction found");
				add_error (err);
				last_ok := False;
			elseif missing_newline then
				create err.make (file_name, line_number, line, environment.substitute (line), "missing newline at end of file");
				add_error (err);
				last_ok := False;
			else
				last_ok := True;
			end
		end;

	parse_line (line: STRING)
			-- Parse test control file line and set
			-- `last_instruction' with the corresponding
			-- test instruction, if any.  Also, set `parse_error'
			-- to indicate whether the line was OK.
		require
			line_exists: line /= Void;
		local
			pos: INTEGER;
			cmd, rest: STRING;
			inst: EW_TEST_INSTRUCTION;
		do
			line.right_adjust;
			line.left_adjust;
			if line.count = 0 or is_prefix (Comment_start, line) then
				parse_error := False;
				last_instruction := Void;
			else
				pos :=  first_white_position (line);
				if pos <= 0 then
					cmd := line;
					create rest.make (0);
				else
					cmd := line.substring (1, pos - 1);
					rest := line.substring (pos + 1, line.count);
				end;
				cmd.to_lower;
				command := cmd;
				if not command_table.has (cmd) then
					cmd := Unknown_keyword
				end;
				check
					known_command: command_table.has (cmd)
				end;
				if cmd.is_equal (Test_end_keyword) then
					has_test_end := True
				end
				inst := command_table.item (cmd).twin
				arguments := rest;
				inst.initialize (Current);
				parse_error := not inst.init_ok;
				last_instruction := inst;
			end
		end;

	add_error (err: EW_ERROR)
		do
			if errors = Void then
				create errors.make;
			end;
			errors.add (err);
		end;

feature {NONE} -- Constants

	Comment_start: STRING = "--";

feature {EW_TEST_INSTRUCTION} -- Modification

	add_errors (list: EW_ERROR_LIST)
		do
			if errors = Void then
				create errors.make;
			end;
			errors.add_list (list);
		end;

feature {EW_TEST_INSTRUCTION, EW_EQA_TEST_EWEASEL_TCF_CONVERTER} -- State

	command_table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING];
			-- Table for translating commands to test
			-- instructions.

	command: STRING;
			-- Command for which test instruction is being
			-- initialized

	arguments: STRING;
			-- Arguments to command for which test instruction
			-- is being initialized

	include_parent: EW_TEST_CONTROL_FILE;
			-- The file which included `Current', if any

	file_name: STRING;
			-- Name of test control file

	line_number: INTEGER;
			-- Number of line being processed

	has_test_end: BOOLEAN
			-- Has a test_end instruction been encountered
			-- yet while parsing test control file?

feature {NONE} -- State

	test_end_required: BOOLEAN;
			-- Is it an error if the file has no test end
			-- instruction?

feature {EW_TEST_INSTRUCTION} -- State

	parse_error: BOOLEAN;
			-- Was there a parse error on the last line parsed?

	last_instruction: EW_TEST_INSTRUCTION;
			--

note
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
