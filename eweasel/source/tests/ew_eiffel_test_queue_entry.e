indexing
	description: "An entry in queue of named Eiffel tests"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "September 13, 2001"

class EW_EIFFEL_TEST_QUEUE_ENTRY

create
	make

feature -- Creation

	make (t: EW_NAMED_EIFFEL_TEST) is
			-- Create `Current' as test awaiting execution
		do
			test := t
			waiting := True
		end

feature -- Properties

	test: EW_NAMED_EIFFEL_TEST
			-- Test
	
	waiting: BOOLEAN
			-- Is test awaiting execution?
	
	in_use: BOOLEAN
			-- Is test in use (being processed by
			-- a test executor)?
	
feature -- Modification

	set_waiting (b: BOOLEAN) is
			-- Set `waiting' to `b'
		do
			waiting := b
		end

	set_in_use (b: BOOLEAN) is
			-- Set `in_use' to `b'
		do
			in_use := b
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
