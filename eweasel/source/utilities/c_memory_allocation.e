indexing
	date:	"November 22, 1995"
	description: "Facilities for allocating C memory, which is not %
		%subject to garbage collection by the Eiffel garbage %
		%collector"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class C_MEMORY_ALLOCATION

feature -- Memory allocation

	allocate_nongc_memory (size_in_bytes: INTEGER): POINTER is
			-- Allocate `size_in_bytes' bytes of memory which
			-- is not subject to garbage collection and
			-- return a pointer to it.  Raise an exception
			-- if no memory is available.
		require
			positive_size: size_in_bytes > 0
		external
			"C"
		end;
			
	free_nongc_memory (memptr: POINTER) is
			-- Free previously allocated memory pointed to
			-- by `memptr'.
		external
			"C"
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


end -- class C_MEMORY_ALLOCATION
