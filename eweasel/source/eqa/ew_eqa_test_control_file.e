indexing
	description: "Summary description for {TEST_CONTROL_FILE_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EW_EQA_TEST_CONTROL_FILE

inherit
	EW_TEST_CONTROL_FILE

	EW_INSTRUCTION_TABLES

create
	make_eqa,
	make_for_convertion

feature {NONE} -- Initialization

	make_eqa (a_instructions: LINKED_LIST [EW_TEST_INSTRUCTION]; a_env: EW_TEST_ENVIRONMENT) is
			-- Creation method
		require
			not_void: a_instructions /= Void
			not_void: a_env /= Void
		do
			instructions := a_instructions
			environment := a_env
			file_name := "in_memory" -- FIXIT: Change to class name

			make_for_convertion
		end

	make_for_convertion is
			-- Creation method for {TEST_EWEASEL_TCF_CONVERTER}
		do
			command_table := test_command_table
		end

feature -- Command

	execute (a_env: EW_TEST_ENVIRONMENT) is
			-- Modified base on {TEST_CONTROL_FILE}.parse_and_execute
		require
			environment_not_void: a_env /= Void
		local
			l_test: EW_EIFFEL_EWEASEL_TEST;
		do
			create l_test.make (instructions);

			l_test.execute (a_env);
			last_test := l_test;
			last_ok := l_test.last_ok;
			errors := l_test.errors;
			environment := l_test.environment;
			last_test := l_test
		end

	parse_file (a_filename: STRING): LIST [EW_TEST_INSTRUCTION] is
			-- Parse testing instructions in `a_filename'
			-- Result is list of testing instructions
		require
			not_void: a_filename /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
		do
			file_name := a_filename

			create l_factory
			parse (l_factory.environment)

			Result := instructions
		ensure
			not_void: Result /= Void
		end

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
