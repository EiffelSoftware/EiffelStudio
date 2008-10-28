indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_DELETE_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;
	EW_OS_ACCESS;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
		do
			args := broken_into_words (line);
			if args.count /= 2 then
				failure_explanation := "argument count is not 2";
				init_ok := False;
			else
				del_directory := args.i_th (1);
				del_file := args.i_th (2);
				init_ok := True;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			del_name: STRING;
			dir, file: RAW_FILE;
		do
			execute_ok := False;
			del_name := os.full_file_name (del_directory,
				del_file);
			create dir.make (del_directory);
			create file.make (del_name);
			if (dir.exists and then dir.is_directory) and
			   (file.exists and then file.is_plain) then
				from
				until
					not test.copy_wait_required
				loop
					os.sleep_milliseconds (100)
				end;
				test.unset_copy_wait;
				file.delete;
				execute_ok := True;
			elseif not dir.exists then
				failure_explanation := "delete directory not found";
			elseif not dir.is_directory then
				failure_explanation := "delete directory not a directory";
			elseif not file.exists then
				failure_explanation := "delete file not found";
			elseif not file.is_plain then
				failure_explanation := "delete file not a plain file";
			end
			
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE}
	
	del_file: STRING;
			-- Name of file to be deleted
	
	del_directory: STRING;
			-- Name of directory in which file to be deleted
			-- resides
	
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
