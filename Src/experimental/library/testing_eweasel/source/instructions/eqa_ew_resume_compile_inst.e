note
	description: "[
					Resume an Eiffel compilation which was suspended due to
					detection of a syntax or validity error.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_RESUME_COMPILE_INST

inherit
	EQA_EW_COMPILE_INST

	EQA_EW_OS_ACCESS
		export
			{NONE} all
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- <Precursor>
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_compilation: detachable EQA_EW_EIFFEL_COMPILATION
		do
			l_compilation := a_test.e_compilation
			if l_compilation = Void then
				execute_ok := False
				failure_explanation := "no compilation has been started"
			elseif not l_compilation.suspended then
				execute_ok := False
				failure_explanation := "compilation not suspended"
			else
				a_test.set_e_compile_start_time (os.current_time_in_seconds)
				l_compilation.resume
				a_test.set_e_compilation_result (l_compilation.last_result)
				execute_ok := True
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"







end
