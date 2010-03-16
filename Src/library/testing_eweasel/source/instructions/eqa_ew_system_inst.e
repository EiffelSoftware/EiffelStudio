note
	description: "[
					Set the name of the system, to be used to execute it.  Must
					match the system name in the Ace file or unexpected results
					will occur.  Defaults to `test' before it has been set in the
					current test control file.  Case is not changed since the
					system name is really a file name.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_SYSTEM_INST

inherit
	EQA_EW_TEST_INSTRUCTION
--	EW_STRING_UTILITIES

create
	make

feature {NONE} -- Initialization

	make (a_sys_name: STRING)
			-- Creation method
		do
			inst_initialize (a_sys_name)
		end

	inst_initialize (sys: STRING)
			-- Initialize instruction from `sys'.
			-- Set `init_ok' to indicate whether initialization
			-- was successful.
		local
			l_failure_explanation: like failure_explanation
		do
			if sys.count = 0 or string_util.first_white_position (sys) > 0 then
				init_ok := False
				failure_explanation := "zero or more than one system name supplied"
			else
				init_ok := True
				system_name := sys
			end

			if not init_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, False)
			end
		end

feature -- Command

	execute (test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `test'.
		local
			l_name: like system_name
		do
			l_name := system_name
			check attached l_name end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'
			test.set_system_name (l_name)
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' always succeed.

feature {NONE} -- Implementation

	system_name: detachable STRING
			-- Name of executable file specified in Ace.
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
