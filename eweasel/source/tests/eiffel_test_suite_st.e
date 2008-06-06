indexing
	description: "An Eiffel test suite - single-threaded version"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/09/14"

class EIFFEL_TEST_SUITE_ST

inherit
	EIFFEL_TEST_SUITE

create

	make

feature -- Execution

	execute (opts: TEST_SUITE_OPTIONS) is
			-- Execute `Current' as modified by options `opts'
			-- and display the results
			-- of each test and pass/fail statistics on all tests.
			-- Leave the number of tests which passed in
			-- `pass_count' and the number which failed in
			-- `fail_count'.
		local
			test: NAMED_EIFFEL_TEST;
			test_dir, compiler_dir: STRING;
		do
			from
				test_list.start;
			until
				test_list.after
			loop
				test := test_list.item;
				if opts.filter.selects (test) then
					announce_start (test);
					if test.execution_allowed then
						test.execute (initial_environment (test));
						test_dir := os.full_directory_name (test_suite_directory, test.last_source_directory_component);
						if opts.keep_all or (opts.keep_passed and test.last_ok) or (opts.keep_failed and not test.last_ok) then
							if opts.is_cleanup_requested then
								compiler_dir := os.full_directory_name (test_dir, Eiffel_gen_directory)
								os.delete_directory_tree (compiler_dir)
							end
						else
							os.delete_directory_tree (test_dir)
						end
					end;
					update_statistics (test);
					display_results (test);
				end;
				test_list.forth;
				output.update
			end;
			display_summary;
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
