note
	description: "Summary description for {EWEASEL_63}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_EWEASEL_MT

inherit
	EW_EWEASEL_MT

create
	make,
	make_and_execute,
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Creation method
		do
			create {ARRAYED_LIST [like test_catalog_names.item]} test_catalog_names.make (5)
			environment := (create {EW_EQA_TEST_FACTORY}).environment
			create test_suite_options.make
			set_output (create {EW_EWEASEL_OUTPUT_CONTROL}.make (io))
		end

feature -- Command to replace parse arguments

	define (a_var, a_val: READABLE_STRING_32)
			-- Define a environment variable
		require
			not_void: a_val /= Void and a_var /= Void
		do
			environment.define (a_var, a_val)
		end

	define_file (a_var: STRING; a_path: ARRAY [STRING])
			-- Define a environment variable
		require
			not_void: a_var /= Void
			not_void: a_path /= Void
		local
			l_factory: EW_EQA_TEST_FACTORY
			p: PATH
		do
			create p.make_empty
			create l_factory
			across
				a_path as i
			loop
				p := p.extended (l_factory.environment.substitute_recursive (i.item))
			end
			environment.define (a_var.as_string_32, p.name)
		end

	init (a_file_name: READABLE_STRING_32)
			-- Set initial control file
		require
			not_void: a_file_name /= Void
		do
			initial_control_file := a_file_name
		end

	catalog (a_file_name: PATH)
			-- Set catalog file
			-- Not used in 6.3
		do
			test_catalog_names.extend (a_file_name)
		end

	output_arg (a_dir: READABLE_STRING_32)
			-- Set output argument
			-- See {EWEASEL}.parse_arguments
		require
			not_void: a_dir /= Void
		do
			test_suite_directory := a_dir
		end

feature -- Start eweasel

	execute_with (a_catalog: ARRAYED_LIST [EW_EQA_TEST_CATALOG_INSTRUCTIONS])
			-- Execute all tests in `a_catalog'
			-- Not used in 6.3
		local
			l_tests: ARRAYED_LIST [EW_NAMED_EIFFEL_TEST]
		do
			create l_tests.make (100)
			across
				a_catalog as c
			loop
				l_tests.append (c.item.all_tests)
			end
			new_test_suite (l_tests, test_suite_options).execute (test_suite_options)
		end

feature -- Not implemented

	keep_all
			-- Keep all
		do
		end

	keep_passed
			-- Keep passed
		do
		end

	keep_failed
			-- Keep failed
		do
		end

	clean
			-- Clean
		do
		end

	no_clean
			-- No clean
		do
		end

	help
			-- Help
		do
		end

	filter
			-- Filter
		do
		end

	order
			-- Order
		do
		end

	no_order
			-- No order
		do
		end

	max_threads
			-- Max threads
		do
		end

	max_c_processes
			-- Max c processes
		do
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
