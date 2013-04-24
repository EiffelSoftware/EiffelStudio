note
	description: "[
					Ancestor for all eweasel test instructions
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EW_TEST_INSTRUCTION

feature -- Query

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?
		deferred
		end

	failure_explanation: detachable STRING_32
			-- Explanation of why last `initialize' or
			-- `execute' which was not OK failed (Void
			-- if no explanation available)

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate
			-- whether execution was successful.
			-- Set `test_execution_terminated' to indicate
			-- whether execution of test should be terminated
			-- after this instruction
		require
			test_not_void: attached a_test
		deferred
		ensure
			explain_if_failure: (not execute_ok) implies failure_explanation /= Void
		end

feature {NONE} -- Utilities

	assert: EQA_COMMONLY_USED_ASSERTIONS
			-- Assert utilities
		once
			create Result
		end

	string_util: EQA_EW_STRING_UTILITIES
			-- String utilities
		once
			create Result
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
