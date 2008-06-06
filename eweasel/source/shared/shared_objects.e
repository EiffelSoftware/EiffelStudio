indexing
	description: "Shared objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_OBJECTS

feature -- Access

	output: EWEASEL_OUTPUT_CONTROL is
			-- Output interface
		indexing
            		once_status: global 
		do
			Result := output_cell.item
		end

feature -- Status Setting

	set_output (a_output: like output) is
			-- Set the output dispatcher
		require
			output_not_void: a_output /= Void
		once
			output_cell.put (a_output)
		ensure
			output_set: output = a_output
		end		

feature {NONE} -- Implementation

	output_cell: CELL [EWEASEL_OUTPUT_CONTROL] is
			-- Output cell
		indexing
            		once_status: global 
		once
			create Result	
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


end -- class SHARED_OBJECTS
