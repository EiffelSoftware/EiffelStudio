indexing
	description: "Summary description for {TEST_CATALOG_FILE_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EW_EQA_TEST_CATALOG_FILE

inherit
	EW_TEST_CATALOG_FILE
		export
			{ANY} tests
		redefine
			set_last_test,
			parse_line,
			make
		end

create
	make,
	make_eqa

feature {NONE} -- Initialization

	make (a_fn: STRING) is
			-- <Precursor>
		do
			Precursor (a_fn)

			create all_test_instructions.make (300)
		end

	make_eqa is
			-- Creation method
		local
			l_factory: EW_EQA_TEST_FACTORY
		do
			create l_factory
			environment := l_factory.environment

			create tests.make

			create all_test_instructions.make (300)
		end

feature -- Command

	set_argument (a_arg: STRING) is
			-- Set `arguments' with `a_arg'
		do
			arguments := a_arg
		ensure
			set: arguments = a_arg
		end

feature -- Query

	all_test_instructions: HASH_TABLE [TUPLE [a_description, a_arguments: STRING], STRING]
			-- Key is folder name
			-- All parsed test instructions from file

feature {NONE} -- Implementation

	set_last_test (a_test: EW_NAMED_EIFFEL_TEST) is
			-- <Precursor>
		do
			Precursor {EW_TEST_CATALOG_FILE}(a_test)
			tests.extend (a_test)
		end

	parse_line (a_line: STRING) is
			-- <Precursor>
		local
			l_pos: INTEGER;
			l_cmd, l_rest: STRING;
			l_inst: EW_CATALOG_INSTRUCTION;
			l_list: LIST [STRING]
			l_arguments: STRING
		do
			a_line.right_adjust;
			a_line.left_adjust;
			last_test := Void;
			if a_line.count = 0 or is_prefix (Comment_start, a_line) then
				parse_error := False;
			else
				l_pos :=  first_white_position (a_line);
				if l_pos <= 0 then
					l_cmd := a_line;
					create l_rest.make (0);
				else
					l_cmd := a_line.substring (1, l_pos - 1);
					l_rest := a_line.substring (l_pos + 1, a_line.count);

					if l_cmd.as_lower.is_equal ("test") then
						l_list := broken_into_words (l_rest)
						check at_least_three: l_list.count >= 3 end
						from
							l_list.go_i_th (3)
							l_arguments := ""
						until
							l_list.after
						loop
							l_arguments.append (l_list.item + " ")

							l_list.forth
						end
						all_test_instructions.put ([l_list.first, l_arguments], l_list.i_th (2))
					end
				end;
--				l_cmd.to_lower;
--				command := l_cmd;
--				if not test_catalog_command_table.has (l_cmd) then
--					l_cmd := Unknown_keyword
--				end;
--				check
--					known_command: test_catalog_command_table.has (l_cmd)
--				end;
--				l_inst := test_catalog_command_table.item (l_cmd).twin
--				arguments := l_rest;
--				inst.execute (Current);
--				parse_error := not inst.execute_ok;
--				if parse_error then
--					last_failure_explanation := inst.failure_explanation;
--				end
			end
		end

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

