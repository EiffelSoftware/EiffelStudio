indexing
	description: "An Eiffel source path test catalog instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_SOURCE_PATH_INST

inherit
	EW_CATALOG_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	execute (tcf: EW_TEST_CATALOG_FILE) is
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		local
			orig_args, dir_name: STRING;
			args: LIST [STRING];
			dir: RAW_FILE;
		do
			orig_args := tcf.arguments.twin
			orig_args.left_adjust;
			orig_args.right_adjust;
			args := broken_into_words (tcf.environment.substitute (orig_args));
			if args.count /= 1 then
				failure_explanation := "must be exactly one argument";
				execute_ok := False;
			else
				dir_name := args.first;
				create dir.make (dir_name);
				if not dir.exists then
					failure_explanation := "directory not found";
					execute_ok := False;
				elseif not dir.is_directory then
					failure_explanation := "not a directory";
					execute_ok := False;
				else
					tcf.set_source_path (dir_name);
					execute_ok := True;
				end
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
