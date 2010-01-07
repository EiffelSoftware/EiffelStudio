note
	description: "[
					Abort a suspended Eiffel compilation so that another
					compilation can be started from scratch.  There can be at most
					one Eiffel compilation in progress at a time.  This
					instruction does a `cleanup' after aborting the compilation,
					which deletes the entire EIFGENs/test directory tree.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_ABORT_COMPILE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

	EQA_ACCESS
	
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
		do
			l_args := string_util.broken_into_words (a_line)
			if l_args.count /= 0 then
				init_ok := False
				failure_explanation := "no arguments allowed"
			else
				init_ok := True
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_compilation: detachable EQA_EW_EIFFEL_COMPILATION
			l_dir: detachable STRING
		do
			l_compilation := a_test.e_compilation
			if l_compilation = Void then
				execute_ok := False
				failure_explanation := "no compilation has been started"
			elseif not l_compilation.suspended then
				execute_ok := False
				failure_explanation := "compilation not suspended"
			else
--				l_compilation.abort -- FIXME: not implemented, add `abort' to {EQA_EW_SYSTEM_TEST_SET}?
				l_dir := a_test.environment.target_directory
				check attached l_dir end -- Implied by environment values have been set before executing tests
				l_dir := string_util.file_path (<<l_dir, {EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_gen_directory>>)
				a_test.file_system.delete_directory_tree (l_dir)
				execute_ok := True
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
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
