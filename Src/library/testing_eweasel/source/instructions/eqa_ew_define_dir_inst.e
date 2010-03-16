note
	description: "[
					Similar to `define', except that <name> is defined to have the
					value which is the name of the directory specified by <path>
					and the subdirectories (which are components of the path name
					to be added onto <path> in an OS-dependent fashion).  This
					allows directory name construction to be (more or less)
					OS-independent.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_DEFINE_DIR_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Initialization

	make (a_line: STRING)
			-- Creation method
		do
			inst_initialize (a_line)
		end

	inst_initialize (a_line: STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [STRING]
			l_count: INTEGER
			l_failure_explanation: like failure_explanation
		do
			l_args := string_util.broken_into_words (a_line)
			l_count := l_args.count
			if l_count < 3 then
				failure_explanation := "argument count must be at least 3"
				init_ok := False
			elseif l_args.first.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Substitute_char then
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("variable being defined cannot start with ")
				l_failure_explanation.extend ({EQA_EW_SUBSTITUTION_CONST}.Substitute_char)
				init_ok := False
			else
				variable := l_args.first
				value := make_dir_value (l_args)
				init_ok := True
			end
			if init_ok then
--				init_environment.define (variable, value)
			end

			if not init_ok then
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, False)
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.  Always successful.
		local
			l_var, l_val: like variable
		do
			l_var := variable
			check attached l_var end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'

			l_val := value
			check attached l_val end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'

			a_test.environment.put (l_var, l_val)
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' are always successful.

feature {NONE} -- Implementation

	variable: detachable STRING
			-- Name of environment value

	value: detachable STRING
			-- Value to be given to environment value

	make_dir_value (a_args: LIST [STRING]): STRING
			-- Directory name derived from arguments of `a_args'
		do
			from
				create Result.make (0)
				a_args.start
				a_args.forth
				Result.append (a_args.item)
				a_args.forth
			until
				a_args.after
			loop
				Result := string_util.file_path (<<Result, a_args.item>>)
				a_args.forth
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
