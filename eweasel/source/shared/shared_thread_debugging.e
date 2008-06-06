indexing
	description: "Shared objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_THREAD_DEBUGGING
inherit
	THREAD_CONTROL
	SHARED_OBJECTS

feature -- Operations

	register
			-- Register current thread and assign it an integer
			-- for display purposes
		local
			n: INTEGER
		do
			debug_mutex.lock
			n := thread_count_cell.item
			n := n + 1
			thread_count_cell.put (n)
			thread_table.put (n, get_current_id)
			debug_mutex.unlock
		end

	print_debug_main (s: STRING)
			-- Display `s' along with thread ID of
			-- current thread, followed by new line.  Intended 
			-- to be called by "main" thread for debugging 
			-- purposes only
		do
			print_debug (s, Main_type)
		end

	print_debug_worker (s: STRING)
			-- Display `s' along with thread ID of
			-- current thread, followed by new line.  Intended 
			-- to be called by "worker" thread for debugging 
			-- purposes only
		do
			print_debug (s, Worker_type)
		end

feature {NONE} -- Implementation

	print_debug (s, a_type: STRING)
			-- Display debugging output `s' from `a_type'
			-- of thread, along with thread ID of current
			-- thread, followed by new line.  Intended to
			-- be called by "worker" thread for debugging
			-- purposes only
		local
			tid: POINTER
			id: STRING
		do
			debug_mutex.lock
			tid := get_current_id
			if a_type.is_equal (Main_type) then
				id := "  "
			else
				id := thread_table.item (tid).out
				if id.count = 1 then
					id.prepend_character (' ')
				end
			end
			output.append (tid.out + "  " + a_type + " " + id + "  " + s, True)
			debug_mutex.unlock
		end

	debug_mutex: MUTEX
			-- Mutex to control access to output facilities
			-- when debugging threaded eweasel
		indexing
            		once_status: global 
		once
			create Result.make
		end		

	thread_table: HASH_TABLE [INTEGER, POINTER]
			-- Thread numbers indexed by thread pointer
		indexing
            		once_status: global 
		once
			create Result.make (100)
		end		

	thread_count_cell: CELL [INTEGER]
			-- Cell with next available thread number
		indexing
            		once_status: global 
		once
			create Result
			Result.put (0)
		end		

	Main_type: STRING = "Main  ";

	Worker_type: STRING = "Worker";


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


end -- class SHARED_OBJECTS
