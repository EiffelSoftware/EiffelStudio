note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_DELETE_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES
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
			if args.count = 2 then
				del_directory := args [1]
				del_file := args [2]
				init_ok := True
			else
				failure_explanation := {STRING_32} "argument count is not 2"
				init_ok := False
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			del_name: READABLE_STRING_32
			dir, file: RAW_FILE
		do
			execute_ok := False

			del_directory := test.environment.substitute (del_directory)

			del_name := os.full_file_name (del_directory, del_file)
			create dir.make_with_name (del_directory)
			create file.make_with_name (del_name)
			if
				(dir.exists and then dir.is_directory) and
				(file.exists and then file.is_plain)
			then
				from
				until
					not test.copy_wait_required
				loop
					os.sleep_milliseconds (100)
				end
				test.unset_copy_wait
				file.delete
				execute_ok := True
			elseif not dir.exists then
				failure_explanation := {STRING_32} "delete directory not found"
			elseif not dir.is_directory then
				failure_explanation := {STRING_32} "delete directory not a directory"
			elseif not file.exists then
				failure_explanation := {STRING_32} "delete file not found"
			elseif not file.is_plain then
				failure_explanation := {STRING_32} "delete file not a plain file"
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE}

	del_file: READABLE_STRING_32
			-- Name of file to be deleted.

	del_directory: READABLE_STRING_32
			-- Name of directory in which file to be deleted resides.

;note
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
