indexing
	description: "An Eiffel test catalog instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

deferred class EW_CATALOG_INSTRUCTION

feature

	execute (tcf: EW_TEST_CATALOG_FILE) is
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		require
			tcf_not_void: tcf /= Void;
		deferred
		ensure
			explain_if_failure: (not execute_ok) implies failure_explanation /= Void
		end;


feature -- Status
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

	failure_explanation: STRING;
			-- Explanation of why last
			-- `execute' which was not OK (Void
			-- if no explanation available)
	
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
