indexing
	description: "An Eiffel test catalog test instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_TEST_INST

inherit
	EW_CATALOG_INSTRUCTION;
	EW_OS_ACCESS;
	EW_STRING_UTILITIES;

feature

	execute (tcf: EW_TEST_CATALOG_FILE) is
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		local
			orig_args, dir_name, test_name, src_dir: STRING;
			tcf_name: STRING;
			args: LIST [STRING];
			dir, file: RAW_FILE;
			test: EW_NAMED_EIFFEL_TEST;
			keywords: LINKED_LIST [STRING];
		do
			orig_args := tcf.arguments.twin
			orig_args.left_adjust;
			orig_args.right_adjust;
			args := broken_into_words (tcf.environment.substitute (orig_args));
			if args.count < 3 then
				failure_explanation := "must be at least 3 arguments";
				execute_ok := False;
			else
				test_name := args.i_th (1);
				src_dir := args.i_th (2);
				tcf_name := args.i_th (3);
				dir_name := os.full_directory_name (tcf.source_path, src_dir);
				create dir.make (dir_name);
				tcf_name := os.full_file_name (dir_name, tcf_name);
				create file.make (tcf_name);
				create keywords.make;
				from
					args.go_i_th (4);
				until
					args.after
				loop
					keywords.extend (args.item);
					args.forth;
				end;
				create test.make (test_name, src_dir, dir_name, tcf_name, keywords);
				tcf.set_last_test (test);
				execute_ok := True;
			end
		end;


indexing
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
