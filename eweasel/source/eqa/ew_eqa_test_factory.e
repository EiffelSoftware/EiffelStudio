note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_TEST_FACTORY

feature -- Query

	environment: EW_TEST_ENVIRONMENT
			-- Singleton test environment
		do
			if environment_cell.item = Void then
				environment_cell.put (create {EW_TEST_ENVIRONMENT}.make (10))
			end
			Result := environment_cell.item
		ensure
			not_void: Result /= Void
		end

	eweasel_test: EW_EIFFEL_EWEASEL_TEST
			-- Singleton eweasel test which is used for execute {EW_TEST_INST}
		do
			if eweasel_test_cell.item = Void then
				eweasel_test_cell.put (create {EW_EIFFEL_EWEASEL_TEST}.make (create {ARRAYED_LIST [EW_TEST_INSTRUCTION]}.make (1)))
				eweasel_test_cell.item.set_env (environment)
			end
			Result := eweasel_test_cell.item
		ensure
			not_void: Result /= Void
		end

feature -- Command

	reset_environment_and_test
			-- Reset `environment' and `eweasel_test'
		do
			environment_cell.put (create {EW_TEST_ENVIRONMENT}.make (10))
			eweasel_test_cell.put (create {EW_EIFFEL_EWEASEL_TEST}.make (create {ARRAYED_LIST [EW_TEST_INSTRUCTION]}.make (1)))
			eweasel_test_cell.item.set_env (environment)
		end

	replace_environments_in_default (a_var: STRING_8): STRING
			--
		require
			not_void: a_var /= Void and then not a_var.is_empty
		do
			Result := environment.replaced_variable (a_var)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	environment_cell: CELL [EW_TEST_ENVIRONMENT]
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

	eweasel_test_cell: CELL [EW_EIFFEL_EWEASEL_TEST]
		once
			create Result.put (Void)
		ensure
			not_void: Result /= Void
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2017, University of Southern California, Eiffel Software and contributors.
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
