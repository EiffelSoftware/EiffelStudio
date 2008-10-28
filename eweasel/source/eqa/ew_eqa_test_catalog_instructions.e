indexing
	description: "Summary description for {TEST_CATALOG_INST_ADAPTER}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

deferred class
	EW_EQA_TEST_CATALOG_INSTRUCTIONS

inherit
	EW_INSTRUCTION_TABLES

feature {NONE} -- Initialization

	prepare is
			-- Creation method
		do
			create catalog_file.make_eqa
		end

feature -- Command

	If_ (a_name, a_controlled_instruction: STRING)
			--	If the substitution variable <name> has a value (or does not
			--	have a value, for an "if not" instruction), execute
			--	<controlled_instruction>.  Otherwise, skip controlled
			--	instruction and do not even attempt to parse it or determine
			--	whether it is a known instruction.  The controlled instruction
			--	of an `if' instruction may also be an `if instruction', with
			--	depth of nesting limited only by available memory.
		require
			not_void: a_name /= Void
			not_void: a_controlled_instruction /= Void
		local
			l_inst: EW_CATALOG_INSTRUCTION
		do
			l_inst := test_catalog_command_table.item (If_keyword)
			catalog_file.set_argument (a_name + " " + a_controlled_instruction)
			l_inst.execute (catalog_file)
		end

	if_not (a_name, a_controlled_instruction: STRING)
			-- Similiar to `If_' except if the substitution variable <name>
			-- does not have a value execute <controlled_instruction>.
		require
			not_void: a_name /= Void
			not_void: a_controlled_instruction /= Void
		local
			l_inst: EW_CATALOG_INSTRUCTION
		do
			l_inst := test_catalog_command_table.item (If_keyword)
			catalog_file.set_argument ("not " + a_name + " " + a_controlled_instruction)
			l_inst.execute (catalog_file)
		end

	source_path (a_path: STRING) is
			--	Specifies that <directory-name> is the full path name of the
			--	directory in which the source directories for subsequent tests
			--	reside.  Remains effective until another `source_path' occurs.
		require
			not_void: a_path /= Void
		local
			l_inst: EW_CATALOG_INSTRUCTION

		do
			l_inst := test_catalog_command_table.item (source_path_keyword)
			catalog_file.set_argument (a_path)
			l_inst.execute (catalog_file)
		end

	test (a_test_name, a_test_folder_name, a_arguments: STRING) is
			--	Defines a test, giving it the name <test-name> and specifying
			--	the last component of the source directory path name.  This
			--	test name is not required to match the test name specified in
			--	<ctrl-file>.  The test control file is named <ctrl-file> and
			--	resides in the source directory.
		require
			not_void: a_test_name /= Void
			not_void: a_test_folder_name /= Void
		local
			l_inst: EW_EQA_TEST_INST
		do
			l_inst ?= test_catalog_command_table.item (test_63_keyword)
			if l_inst /= Void then
				if a_arguments /= Void then
					catalog_file.set_argument (a_test_name + " " + a_test_folder_name + " " + a_arguments)
				else
					catalog_file.set_argument (a_test_name + " " + a_test_folder_name)
				end
				l_inst.execute (catalog_file)
			else
				check not_possible: False end
			end
		end

feature -- Query

	all_tests: LINKED_LIST [EW_NAMED_EIFFEL_TEST] is
			-- Convert new test to old test
		require
			ready: all_tests /= Void and then not all_tests.is_empty
		local
			l_item: EW_EQA_NAMED_EIFFEL_TEST
			l_info: TUPLE [test_name: STRING; last_dir_name: STRING; tcf_name: STRING; keywords: ARRAYED_LIST [STRING]]
		do
			Result := catalog_file.tests
		end

feature -- Implementation

	catalog_file: EW_EQA_TEST_CATALOG_FILE
			-- Catalog file which contain all tests after `execute'

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

