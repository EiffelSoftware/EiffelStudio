note
	description: "An Eiffel test catalog file"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_TEST_CATALOG_FILE

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
	EW_INSTRUCTION_TABLES
		export
			{EW_CATALOG_IF_INST} test_catalog_command_table
			{NONE} all
		end

create

	make

feature {NONE} -- Creation

	make (fn: like file_name)
			-- Create `Current' from test catalog file named `fn'.
		require
			file_name_not_void: fn /= Void
		do
			file_name := fn
		end

feature -- Status

	last_catalog: detachable EW_EIFFEL_TEST_CATALOG
			-- Catalog from last test catalog file parsed successfully.

	last_ok: BOOLEAN
			-- Was file parsed without any errors?

	errors: detachable EW_ERROR_LIST
			-- Errors encountered, in order (void if `last_ok' is true).

	environment: EW_TEST_ENVIRONMENT
			-- Environment in which catalog file is parsed.
			-- Parsing does not modify the environment.

feature -- Parsing

	parse (env: EW_TEST_ENVIRONMENT)
			-- Parse `Current' in the environment `env'.
			-- Set `last_ok' to indicate whether parsing
			-- was successful.  If successful, `last_catalog'
			-- has the file's catalog.  If not successful,
			-- `errors' has errors.
		require
			environment_not_void: env /= Void
		local
			tcf: RAW_FILE
		do
			errors := Void
			last_catalog := Void
			create tcf.make_with_path (file_name)
			if tcf.exists then
				environment := env
				parse_existing_file (tcf)
			else
				last_ok := False
				add_error (create {EW_PARSE_ERROR}.make_with_reason ({STRING_32} "File not found: " + file_name.name))
			end
		end

feature {NONE} -- Implementation

	tests: LINKED_LIST [EW_NAMED_EIFFEL_TEST]

	parse_existing_file (tcf: RAW_FILE)
			-- Parse test control file `tcf' and set
			-- `Current' to represent it.  Set `last_ok'
			-- to indicate whether file was parsed
			-- successfully.  If not successful,
			-- `errors' has errors.
		require
			file_exists: tcf.exists
		local
			line: READABLE_STRING_32
			err: EW_PARSE_ERROR
		do
			from
				source_path := {STRING_32} ""
				tcf.open_read
				line_number := 0
				create tests.make
			until
				tcf.end_of_file or parse_error
			loop
				tcf.read_line
				if not tcf.end_of_file then
					line_number := line_number + 1
					line := from_utf_8 (tcf.last_string)
					parse_line (line.as_string_32)
					if not parse_error and attached last_test as t then
						tests.extend (t)
					end
				end
			end
			tcf.close
			if parse_error then
				create err.make (file_name.name, line_number, line, environment.substitute (line), last_failure_explanation)
				add_error (err)
				last_ok := False
			else
				create last_catalog.make (tests)
				last_ok := True
			end
		end

	parse_line (line: STRING_32)
			-- Parse test catalog file line and set
			-- `last_test' with the corresponding
			-- test, if any.  Also, set `parse_error'
			-- to indicate whether the line was OK and
			-- if false set `last_failure_explanation'.
		require
			line_exists: line /= Void
		local
			pos: INTEGER
			cmd, rest: STRING_32
			inst: EW_CATALOG_INSTRUCTION
		do
			line.adjust
			last_test := Void
			if line.is_empty or line.starts_with (comment_start) then
				parse_error := False
			else
				pos :=  first_white_position (line)
				if pos <= 0 then
					cmd := line
					create rest.make_empty
				else
					cmd := line.substring (1, pos - 1)
					rest := line.substring (pos + 1, line.count)
				end
				cmd.to_lower
				command := cmd
				if not test_catalog_command_table.has (cmd) then
					cmd := Unknown_keyword
				end
				check
					known_command: test_catalog_command_table.has (cmd)
				end
				inst := test_catalog_command_table.item (cmd).twin
				arguments := rest
				inst.execute (Current)
				parse_error := not inst.execute_ok
				if parse_error then
					last_failure_explanation := inst.failure_explanation
				end
			end
		end

	add_error (err: EW_ERROR)
		do
			if errors = Void then
				create errors.make
			end
			errors.add (err)
		end

feature {NONE} -- Constants

	Comment_start: STRING_32 = "--"

feature {EW_CATALOG_INSTRUCTION} -- Modification

	set_command (s: like command)
		do
			command := s
		end

	set_arguments (s: like arguments)
		do
			arguments := s
		end

	set_source_path (p: READABLE_STRING_32)
		do
			source_path := p
		end

	set_last_test (t: EW_NAMED_EIFFEL_TEST)
		do
			last_test := t
		end

feature {EW_CATALOG_INSTRUCTION} -- State

	command: READABLE_STRING_32
			-- Command for which test instruction is being
			-- initialized

	arguments: READABLE_STRING_32
			-- Arguments to command for which test instruction
			-- is being initialized

	source_path: READABLE_STRING_32
			-- Current source path where directories for
			-- tests reside

	file_name: PATH
			-- Name of test control file

	line_number: INTEGER
			-- Number of line being processed

feature {NONE} -- State

	parse_error: BOOLEAN
			-- Was there a parse error on the last line parsed?

	last_test: detachable EW_NAMED_EIFFEL_TEST
			-- Test parsed from last line parsed

	last_failure_explanation: READABLE_STRING_32
			-- Explanation of last parsing failure

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
