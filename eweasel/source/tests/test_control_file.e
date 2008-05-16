indexing
	description: "An Eiffel test control file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class TEST_CONTROL_FILE

inherit
	ANY
	STRING_UTILITIES
		export
			{NONE} all
		end
	KEYWORD_CONST
		export
			{NONE} all
		end
create
	
	make

feature -- Creation

	make (fn: STRING; parent: TEST_CONTROL_FILE; 
	  table: HASH_TABLE [TEST_INSTRUCTION, STRING]; add_end: BOOLEAN) is
			-- Create `Current' from file named `fn'
			-- included by `inc_parent' (Void if none) using
			-- `table' as the command to instruction
			-- translation table.  If `add_end' is true,
			-- add an implicit test_end instruction to the
			-- end of the file if one is not present
		require
			file_name_not_void: fn /= Void
		do
			file_name := fn;
			include_parent := parent;
			command_table := table;
			implicit_end := add_end;
		end;

feature -- Status
	
	last_test: EIFFEL_TEST;
			-- Last test parsed or executed

	last_ok: BOOLEAN;
			-- Was file parsed and/or executed without any errors?

	errors: ERROR_LIST;
			-- Errors encountered, in order (void if `last_ok' 
			-- is true)

	environment: TEST_ENVIRONMENT;
			-- Environment in which test is parsed.
			-- Parsing may modify the environment.
	
feature -- Parsing and execution

	parse_and_execute (env: TEST_ENVIRONMENT) is
			-- Parse `Current' in the environment `env'.
			-- Execute the resulting instructions if
			-- successful.  In either case, `last_ok' is
			-- set to indicate success and `errors' has
			-- any errors.  `Environment' is set with
			-- the test environment after execution, if successful.
		require
			environment_not_void: env /= Void
		local
			test: EIFFEL_TEST;
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
	
	parse (env: TEST_ENVIRONMENT) is
			-- Parse `Current' in the environment `env'.
			-- Set `last_ok' to indicate whether parsing
			-- was successful.  If successful, `instructions'
			-- has the test's instructions.  If not successful,
			-- `errors' has errors.
		require
			environment_not_void: env /= Void
		local
			tcf: RAW_FILE;
			err: PARSE_ERROR;
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

	instructions: LINKED_LIST [TEST_INSTRUCTION];
			-- The instructions that make up this test


feature {NONE} -- Implementation

	parse_existing_file (tcf: RAW_FILE) is
			-- Parse test control file `tcf' and set
			-- `Current' to represent it.  Set `last_ok'
			-- to indicate whether file was parsed
			-- successfully.  If not successful,
			-- `errors' has errors.
		require
			file_exists: tcf.exists
		local
			line: STRING;
			err: PARSE_ERROR;
		do
			from
				tcf.open_read;
				line_number := 0;
				create instructions.make;
			until
				tcf.end_of_file or parse_error
			loop
				tcf.readline;
				if not tcf.end_of_file then
					line_number := line_number + 1;
					create line.make (tcf.laststring.count);
					line.append (tcf.laststring);
					parse_line (line);
					if not parse_error and last_instruction /= Void then
						instructions.extend (last_instruction);
					end
				end
			end;
			tcf.close;
			if parse_error then
				create err.make (file_name, line_number, line, environment.substitute (line), last_instruction.failure_explanation);
				add_error (err);
				last_ok := False;
			else
				if implicit_end and not equal (tcf.laststring, Test_end_name) then
					create line.make (Test_end_name.count);
					line.append (Test_end_name);
					parse_line (line);
					instructions.extend (last_instruction);
				end;
				last_ok := True;
			end
		end;


	parse_line (line: STRING) is
			-- Parse test control file line and set
			-- `last_instruction' with the corresponding
			-- test instruction, if any.  Also, set `parse_error' 
			-- to indicate whether the line was OK.
		require
			line_exists: line /= Void;
		local
			pos: INTEGER;
			cmd, rest: STRING;
			inst: TEST_INSTRUCTION;
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
				inst := command_table.item (cmd).twin
				arguments := rest;
				inst.initialize (Current);
				parse_error := not inst.init_ok;
				last_instruction := inst;
			end
		end;

	add_error (err: ERROR) is
		do
			if errors = Void then
				create errors.make;
			end;
			errors.add (err);
		end;

feature {NONE} -- Constants
	
	Comment_start: STRING is "--";

	Test_end_name: STRING is "test_end";

feature {TEST_INSTRUCTION} -- Modification
	
	add_errors (list: ERROR_LIST) is
		do
			if errors = Void then
				create errors.make;
			end;
			errors.add_list (list);
		end;
	
feature {TEST_INSTRUCTION} -- State
	
	command_table: HASH_TABLE [TEST_INSTRUCTION, STRING];
			-- Table for translating commands to test
			-- instructions.
	
	command: STRING;
			-- Command for which test instruction is being
			-- initialized
	
	arguments: STRING;
			-- Arguments to command for which test instruction 
			-- is being initialized
	
	include_parent: TEST_CONTROL_FILE;
			-- The file which included `Current', if any
	
	file_name: STRING;
			-- Name of test control file
			
	line_number: INTEGER;
			-- Number of line being processed

	
feature {NONE} -- State
	
	implicit_end: BOOLEAN;
			-- Should an implicit test end instruction be added 
			-- as the last instruction if not already present?
	
feature {TEST_INSTRUCTION} -- State
	
	parse_error: BOOLEAN;
			-- Was there a parse error on the last line parsed?

	last_instruction: TEST_INSTRUCTION;
			--

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
