indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_CLEANUP_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;
	EW_PREDEFINED_VARIABLES;
	EW_EIFFEL_TEST_CONSTANTS;
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
			if args.count /= 0 then
				init_ok := False;
				failure_explanation := "no arguments allowed";
			else
				init_ok := True;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			compilation: EW_EIFFEL_COMPILATION;
			dir, eif_dir: STRING;
		do
			compilation := test.e_compilation;
			if compilation = Void then
				execute_ok := False;
				failure_explanation := "no previous compilation to clean up";
			elseif compilation.suspended then
				execute_ok := False;
				failure_explanation := "suspended compilation - use `abort_compile' instead";
			else
				dir := test.environment.value (Test_dir_name);
				eif_dir := os.full_directory_name (dir, Eiffel_gen_directory);
				os.delete_directory_tree (eif_dir)
				delete_project_files (dir)
				execute_ok := True;
			end
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	delete_project_files (dir_name: STRING) is
			-- Delete all Eiffel project files (.epr files)
			-- found in directory `dir_name'
		local
			dir: DIRECTORY
			dir_entries: ARRAYED_LIST [STRING]
			name, ext: STRING
			len: INTEGER
			f: RAW_FILE
		do
			ext := Eiffel_project_extension;
			len := ext.count
			create dir.make (dir_name)
			dir_entries := dir.linear_representation;
			from
				dir_entries.start
			until
				dir_entries.after
			loop
				name := dir_entries.item.twin
				name.keep_tail (len)
				if name.is_equal (ext) then
					create f.make (os.full_file_name (dir_name, dir_entries.item))
					f.delete
				end
				dir_entries.forth
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
