note
	description: "[
					Command to specify project config file name and its target name.
					First parameter is the config file name (such as "Ace" or "test.ecf")
					and second parameter, if present, is the name of the target within 
					that configuration file.
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	EW_CONFIG_INST

inherit
	EW_TEST_INSTRUCTION

	EW_STRING_UTILITIES

feature

	inst_initialize (a_parameter: STRING)
			-- Initialize instruction from `a_parameter'.
			-- Set `init_ok' to indicate whether initialization
			-- was successful.
		local
			l_args: LIST [STRING]
		do
			l_args := broken_into_words (a_parameter)
			if l_args.count >= 1 and l_args.count <= 2 then
				init_ok := True
				ace_name := l_args.i_th (1)
				if l_args.count = 2 then
					target_name := l_args.i_th (2)
				end
			else
				failure_explanation := "argument count is not 1 (config file name) or 2 (config file name and target name) "
				init_ok := False
			end
		end

	execute (a_test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.  Always successful.
		do
			a_test.set_ace_name (ace_name)
			if attached target_name as l_target_name then
				a_test.set_target_name (l_target_name)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' always succeed.

feature {NONE}

	ace_name: STRING
			-- Name of Ace file for Eiffel compilations.

	target_name: STRING
			-- Target name within config file `ace_name'
;note
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
