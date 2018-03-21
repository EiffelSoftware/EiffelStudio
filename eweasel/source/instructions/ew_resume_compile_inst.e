note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_RESUME_COMPILE_INST

inherit
	EW_COMPILE_INST
	EW_OS_ACCESS

feature

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			compilation: EW_EIFFEL_COMPILATION
		do
			compilation := test.e_compilation
			if compilation = Void then
				execute_ok := False
				failure_explanation := {STRING_32} "no compilation has been started"
			elseif not compilation.suspended then
				execute_ok := False
				failure_explanation := {STRING_32} "compilation not suspended"
			else
				test.set_e_compile_start_time (os.current_time_in_seconds)
				compilation.resume
				test.set_e_compilation_result (compilation.next_compile_result)
				execute_ok := True
			end
		end

note
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
