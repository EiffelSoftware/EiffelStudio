note
	description: "Summary description for {NAMED_EIFFEL_TEST_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_NAMED_EIFFEL_TEST

inherit
	EW_NAMED_EIFFEL_TEST

create
	make_63

feature {NONE} -- Initialization

	make_63 (a_name, a_last_directory, a_src_directory: READABLE_STRING_32; a_tcf: EW_EQA_TEST_CONTROL_INSTRUCTIONS; a_keys: LIST [READABLE_STRING_32])
			-- Creation method
		do
			test_name := a_name
			last_source_directory_component := a_last_directory
			full_source_directory := a_src_directory
			tcf := a_tcf
			keywords := a_keys
		end

feature {NONE} -- Implementation

	tcf: EW_EQA_TEST_CONTROL_INSTRUCTIONS
			-- Related test control instructions

;note
	ca_ignore: "CA011", "CA011 — too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
