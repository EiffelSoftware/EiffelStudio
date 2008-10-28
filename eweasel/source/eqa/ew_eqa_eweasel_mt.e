indexing
	description: "Summary description for {EWEASEL_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class
	EW_EQA_EWEASEL_MT

inherit
	EW_EWEASEL_MT

create
	make,
	make_and_execute,
	make_empty

feature {NONE} -- Initialization

	make_empty is
			-- Creation method
		local
			l_factory: EW_EQA_TEST_FACTORY
		do
			create {ARRAYED_LIST [STRING]} test_catalog_names.make (5)

			create l_factory
			environment := l_factory.environment
			create test_suite_options.make
			set_output (create {EW_EWEASEL_OUTPUT_CONTROL}.make (io))
		end

feature -- Command to replace parse arguments

	define (a_var, a_val: STRING) is
			-- Define a environment variable
		require
			not_void: a_val /= Void and a_var /= Void
		do
			environment.define (a_var, a_val);
		end

	define_file (a_var: STRING; a_path: ARRAY [STRING]) is
			-- Define a environment variable
		require
			not_void: a_var /= Void
			not_void: a_path /= Void
		local
			l_item: STRING
			l_index, l_count: INTEGER
			l_file_name: FILE_NAME
			l_factory: EW_EQA_TEST_FACTORY
		do
			from
				create l_factory
				l_count := a_path.upper
				l_index := a_path.lower
			until
				l_index > l_count
			loop
				l_item := a_path.item (l_index)

				a_path.put (l_factory.replace_environments_in_default (l_item), l_index)

				l_index := l_index + 1
			end
			create l_file_name.make
			l_file_name.extend_from_array (a_path)
			environment.define (a_var, l_file_name)
		end

	init (a_file_name: STRING) is
			-- Set initial control file
		require
			not_void: a_file_name /= Void
		do
			initial_control_file := a_file_name
		end

	catalog (a_file_name: STRING) is
			-- Set catalog file
			-- Not used in 6.3
		do
			test_catalog_names.extend (a_file_name)
		end

	output_arg (a_dir: STRING) is
			-- Set output argument
			-- See {EWEASEL}.parse_arguments
		require
			not_void: a_dir /= Void
		do
			test_suite_directory := a_dir
		end

feature -- Start eweasel

	execute_with (a_catalog: ARRAYED_LIST [EW_EQA_TEST_CATALOG_INSTRUCTIONS]) is
			-- Execute all tests in `a_catalog'
			-- Not used in 6.3
		local
			l_suite: EW_EIFFEL_TEST_SUITE;
			l_tests: ARRAYED_LIST [EW_NAMED_EIFFEL_TEST]
		do
			from
				create l_tests.make (100)
				a_catalog.start
			until
				a_catalog.after
			loop
				l_tests.append (a_catalog.item.all_tests)

				a_catalog.forth
			end

			l_suite := new_test_suite (l_tests, test_suite_options)
			l_suite.execute (test_suite_options);
		end

feature -- Not implemented

	keep_all is
			-- Keep all
		do
		end

	keep_passed is
			-- Keep passed
		do
		end

	keep_failed is
			-- Keep failed
		do
		end

	clean is
			-- Clean
		do
		end

	no_clean is
			-- No clean
		do
		end

	help is
			-- Help
		do
		end

	filter is
			-- Filter
		do
		end

	order is
			-- Order
		do
		end

	no_order is
			-- No order
		do
		end

	max_threads is
			-- Max threads
		do
		end

	max_c_processes is
			-- Max c processes
		do
		end

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
