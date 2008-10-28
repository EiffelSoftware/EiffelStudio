indexing
	description: "Summary description for {TEST_FACTORY_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EW_EQA_TEST_FACTORY

feature -- Query

	environment: EW_TEST_ENVIRONMENT is
			-- Singleton test environment
		do
			if environment_cell.item = Void then
				environment_cell.put (create {EW_TEST_ENVIRONMENT}.make (10))
			end
			Result := environment_cell.item
		ensure
			not_void: Result /= Void
		end

	eweasel_test: EW_EIFFEL_EWEASEL_TEST is
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

	reset_environment_and_test is
			-- Reset `environment' and `eweasel_test'
		do
			environment_cell.put (create {EW_TEST_ENVIRONMENT}.make (10))
			eweasel_test_cell.put (create {EW_EIFFEL_EWEASEL_TEST}.make (create {ARRAYED_LIST [EW_TEST_INSTRUCTION]}.make (1)))
			eweasel_test_cell.item.set_env (environment)
		end

	replace_environments_in_default (a_var: STRING_8): STRING is
			--
		require
			not_void: a_var /= Void and then not a_var.is_empty
		do
			Result := replace_environments (environment, a_var)
		ensure
			not_void: Result /= Void
		end

	replace_environments (a_env: EW_TEST_ENVIRONMENT; a_var: STRING): STRING is
			-- Find proper arugment if possible
			-- If not found, Result is orignal argument
		require
			not_void: a_var /= Void and then not a_var.is_empty
		local
			l_temp: STRING
		do
			if a_var.starts_with ("$") and then a_var.count > 1 then
				l_temp := a_env.value (a_var.substring (2, a_var.count))
				if l_temp /= Void then
					Result := l_temp
				else
					Result := a_var
				end
			else
				Result := a_var
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	environment_cell: CELL [EW_TEST_ENVIRONMENT] is
			--
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	eweasel_test_cell: CELL [EW_EIFFEL_EWEASEL_TEST] is
			--
		once
			create Result
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
