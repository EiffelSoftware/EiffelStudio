note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_CLEANUP_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES
	EW_PREDEFINED_VARIABLES
	EW_EIFFEL_TEST_CONSTANTS
	EW_OS_ACCESS

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
		do
			args := broken_into_words (line)
			if args.is_empty then
				init_ok := True
			else
				init_ok := False
				failure_explanation := {STRING_32} "no arguments allowed"
			end
		end

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
				failure_explanation := {STRING_32} "no previous compilation to clean up"
			elseif compilation.suspended then
				execute_ok := False
				failure_explanation := {STRING_32} "suspended compilation - use `abort_compile' instead"
			elseif attached test.environment.value (Test_dir_name) as dir then
				os.delete_directory_tree (os.full_directory_name (dir, Eiffel_gen_directory))
				delete_project_files (dir)
				execute_ok := True
			else
				execute_ok := False
				failure_explanation := {STRING_32} "path to the test directory is not set"
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	delete_project_files (dir_name: READABLE_STRING_32)
			-- Delete all Eiffel project files (.epr files)
			-- found in directory `dir_name`.
		local
			dir_path: PATH
		do
			create dir_path.make_from_string (dir_name)
			across
				(create {DIRECTORY}.make_with_path (dir_path)).entries as d
			loop
				if d.item.has_extension (eiffel_project_extension) then
					(create {RAW_FILE}.make_with_path (dir_path.extended_path (d.item))).delete
				end
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
