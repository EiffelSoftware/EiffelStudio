indexing
	description: "Summary description for {NAMED_EIFFEL_TEST_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EW_EQA_NAMED_EIFFEL_TEST

inherit
	EW_NAMED_EIFFEL_TEST
		redefine
			execute
		end

create
	make_63

feature {NONE} -- Initialization

	make_63 (a_name, a_last_directory, a_src_directory: STRING; a_tcf: EW_EQA_TEST_CONTROL_INSTRUCTIONS; a_keys: LIST [STRING]) is
			-- Creation method
		do
			test_name := a_name
			last_source_directory_component := a_last_directory
			full_source_directory := a_src_directory
			tcf := a_tcf
			keywords := a_keys
		end

feature -- Command

	execute (a_env: EW_TEST_ENVIRONMENT) is
			-- Execute `Current' in the environment `env'.
		local
			l_tcf: EW_EQA_TEST_CONTROL_FILE
			l_factory: EW_EQA_TEST_FACTORY
		do
--			a_env.define (Source_dir_name, full_source_directory);

--			create l_factory
--			create l_tcf.make_63 (tcf.instructions, l_factory.environment)
--			l_tcf.execute (a_env)

--			last_test := l_tcf.last_test;
--			last_ok := l_tcf.last_ok;
--			errors := l_tcf.errors;
		end

feature {NONE} -- Implementation

	tcf: EW_EQA_TEST_CONTROL_INSTRUCTIONS
			-- Related test control instructions

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
