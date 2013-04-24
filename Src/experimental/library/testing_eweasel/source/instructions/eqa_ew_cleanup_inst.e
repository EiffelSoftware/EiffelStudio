note
	description: "[
					Clean up a previous Eiffel compilation by deleting the entire
					EIFGENs/test directory tree.  The next Eiffel compilation will
					start with a clean slate.  If there is a suspended Eiffel
					compilation awaiting resumption, the `abort_compile'
					instruction must be used instead of this one.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_CLEANUP_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Intialization

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
			l_path: STRING_32
		do
			l_compilation := a_test.e_compilation
			if l_compilation = Void then
				execute_ok := False
				failure_explanation := "no previous compilation to clean up"
			elseif l_compilation.suspended then
				execute_ok := False
				failure_explanation := "suspended compilation - use `abort_compile' instead"
			else

				l_path := a_test.file_system.build_target_path (<< {EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_gen_directory >>)
				a_test.file_system.delete_directory_tree (l_path)
				delete_project_files (a_test.file_system.build_target_path (Void), a_test.file_system)

				execute_ok := True
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	delete_project_files (a_dir_name: STRING_32; a_file_system: EQA_FILE_SYSTEM)
			-- Delete all Eiffel project files (.epr files)
			-- found in directory `a_dir_name'
		local
			l_dir: DIRECTORY
			l_dir_entries: ARRAYED_LIST [PATH]
			l_name: PATH
			l_f: RAW_FILE
		do
			create l_dir.make (a_dir_name)
			l_dir_entries := l_dir.entries
			from
				l_dir_entries.start
			until
				l_dir_entries.after
			loop
				l_name := l_dir_entries.item
				if l_name.has_extension ({EQA_EW_EIFFEL_TEST_CONSTANTS}.Eiffel_project_extension) then
					create l_f.make_with_name (a_file_system.build_path (a_dir_name, create {EQA_SYSTEM_PATH}.make_from_path_object (l_name)))
					l_f.delete
				end
				l_dir_entries.forth
			end
		end

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
