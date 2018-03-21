note
	description: "An Eiffel test catalog test instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_TEST_INST

inherit
	EW_CATALOG_INSTRUCTION
	EW_OS_ACCESS
	EW_STRING_UTILITIES

feature

	execute (tcf: EW_TEST_CATALOG_FILE)
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		local
			dir_name: READABLE_STRING_32
			src_dir: READABLE_STRING_32
			orig_args: STRING_32
			test_name: READABLE_STRING_32
			args: LIST [READABLE_STRING_32]
			keywords: LINKED_LIST [READABLE_STRING_32]
		do
			create orig_args.make_from_string (tcf.arguments)
			orig_args.adjust
			args := broken_into_words (orig_args)
			if args.count < 3 then
				failure_explanation := {STRING_32} "must be at least 3 arguments"
				execute_ok := False
			else
				test_name := tcf.environment.substitute (args [1])
				src_dir := tcf.environment.substitute (args [2])
				dir_name := os.full_directory_name (tcf.source_path, src_dir)
				create keywords.make
				from
					args.go_i_th (4)
				until
					args.after
				loop
					keywords.extend (tcf.environment.substitute (args.item))
					args.forth
				end
				tcf.set_last_test (create {EW_NAMED_EIFFEL_TEST}.make (test_name, src_dir, dir_name, os.full_file_name (dir_name, tcf.environment.substitute (args [3])), keywords))
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
