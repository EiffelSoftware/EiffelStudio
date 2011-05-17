note
	description: "Test instruction for source code formatting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "$Date$"
	revision: "$Revision$"

class EW_PRETTIFY_INST

inherit
	EW_START_COMPILE_INST
		redefine
			compiler_arguments,
			execute,
			inst_initialize
		end

feature -- Initialization

	inst_initialize (line: STRING)
			-- <Precursor>
		local
			args: LIST [STRING]
		do
			args := broken_into_words (line)
			if args.count < 2 or args.count > 3 then
				init_ok := False
				failure_explanation := "expected arguments: input_file_before_format output_file_after_format [compiler_output]"
			else
				file_name_before_format := args [1]
				file_name_after_format := args [2]
				init_ok := True
				if args.count > 2 then
					output_file_name := args [3]
				end
			end
		end;

	compiler_arguments (test: EW_EIFFEL_EWEASEL_TEST; env: EW_TEST_ENVIRONMENT): LINKED_LIST [STRING]
			-- <Precursor>
		do
			Result := Precursor (test, env)
			Result.extend ("-pretty")
			Result.extend (os.full_file_name (test.environment.value (Cluster_dir_name), file_name_before_format))
			Result.extend (os.full_file_name (test.environment.value (Output_dir_name), file_name_after_format))
		end

	compilation_options: LIST [STRING]
			-- <Precursor>
		once
			create {LINKED_LIST [STRING]} Result.make
		end

feature -- Execution

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- <Precursor>
		do
			Precursor (test)
				-- Update compiler result if compiler output is empty that is OK.
			if
				execute_ok and then
				attached test.e_compilation_result as r and then
				not r.is_status_known and then
				r.raw_compiler_output.is_empty
			then
				r.set_compilation_finished
			end
		end

feature -- Access

	file_name_before_format: STRING;
			-- Name of the source file to be formatted.

	file_name_after_format: STRING;
			-- Name of the file for the formatted code.

note
	copyright: "[
			Copyright (c) 2011, University of Southern California and contributors.
			All rights reserved.
		]"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
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
