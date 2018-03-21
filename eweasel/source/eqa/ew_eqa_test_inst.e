note
	description: "Summary description for {TEST_INST_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_TEST_INST

inherit
	EW_TEST_INST
		redefine
			execute
		end

	EW_PREDEFINED_VARIABLES
		export
			{NONE} all
		end

feature -- Access

	set_test_control_file (a_control_file: EW_EQA_TEST_CONTROL_INSTRUCTIONS)
			-- Set `control_file' with `a_control_file'
		require
			not_void: a_control_file /= Void
		do
			control_file := a_control_file
		ensure
			set: control_file = a_control_file
		end

	control_file: EW_EQA_TEST_CONTROL_INSTRUCTIONS
			-- Related test control object

	execute (tcf: EW_TEST_CATALOG_FILE)
			-- <Precursor>
		local
			orig_args, dir_name, src_dir: STRING_32
			test_name: READABLE_STRING_32
			-- tcf_name: STRING
			args: LIST [READABLE_STRING_32]
			test: EW_EQA_NAMED_EIFFEL_TEST
			keywords: LINKED_LIST [READABLE_STRING_32]
		do
			create orig_args.make_from_string (tcf.arguments)
			orig_args.adjust
			args := broken_into_words (tcf.environment.substitute (orig_args))
			if args.count < 3 then
				failure_explanation := {STRING_32} "must be at least 3 arguments"
				execute_ok := False
			else
				test_name := args [1]
				src_dir := args [2]
				-- tcf_name := args [3]
				dir_name := os.full_directory_name (tcf.source_path, src_dir)
				-- tcf_name := os.full_file_name (dir_name, tcf_name)
				create keywords.make
				from
					args.go_i_th (4)
				until
					args.after
				loop
					keywords.extend (args.item)
					args.forth
				end

					--	If we use control_file, it should looks like following
					--	check ready: control_file /= Void end
				create test.make_63 (test_name, src_dir, dir_name, control_file, keywords)

				;(create {EW_EQA_TEST_FACTORY}).environment.define (Source_dir_name, dir_name)

				tcf.set_last_test (test)
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
