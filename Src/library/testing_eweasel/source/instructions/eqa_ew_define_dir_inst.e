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

	make (a_test_set: EQA_EW_SYSTEM_TEST_SET; a_line: STRING)
			-- Creation method
		do
			inst_initialize (a_test_set, a_line)
		end

	inst_initialize (a_test_set: EQA_EW_SYSTEM_TEST_SET; a_line: STRING)
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
				value := make_dir_value (l_args, a_test_set.file_system)
				init_ok := True
			end

			if not init_ok then
				print (failure_explanation)
				a_test_set.assert ("Invalid define instruction", False)
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.  Always successful.
		do
			if attached variable as l_var and attached value as l_val then
				a_test.environment.put (l_val, l_var)
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' are always successful.

feature {NONE} -- Implementation

	variable: detachable STRING
			-- Name of environment value

	value: detachable STRING_32
			-- Value to be given to environment value

	make_dir_value (a_args: LIST [READABLE_STRING_GENERAL]; l_file_system: EQA_FILE_SYSTEM): STRING_32
			-- Directory name derived from arguments of `a_args'
		do
			from
				create Result.make_empty
				a_args.start
				a_args.forth
				Result.append_string_general (a_args.item)
				a_args.forth
			until
				a_args.after
			loop
				Result := l_file_system.build_path (Result, << a_args.item >>)
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
