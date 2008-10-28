indexing
	description: "Controller of output.  Write output to `interface' (default is standard output)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EW_EWEASEL_OUTPUT_CONTROL

create
	make

feature -- Creation

	make (a_interface: ANY) is
			-- Create
		require
			interface_not_void: a_interface /= Void
		do
			interface := a_interface
		ensure
			has_interface: interface = a_interface
		end		
		
feature -- Commands

	clear is
			-- Clear the current output
		do			
		end
		
	flush is
			-- Flush
		do
			io.output.flush
		end		

	update is
			-- Update
		do			
			flush
		end		

	append (output: STRING; on_new_line: BOOLEAN) is
			-- Append `output' to current output
		require
			output_not_void: output /= Void
		do
			io.put_string (output)
			if on_new_line then
				io.new_line
			end
		end
		
	append_error (output: STRING; on_new_line: BOOLEAN) is
			-- Append `output' to current output, formatted to indicate error
		require
			output_not_void: output /= Void
		do
			append (output, on_new_line)
		end

	append_new_line is
			-- Append new line
		do
			io.new_line	
		end		

feature {NONE} -- Constants

	new_line: STRING is "%N"
			-- New line character
			
	empty_string: STRING is
			-- Empty string
		once
			create Result.make_empty	
		end		

feature {NONE} -- Implementation
	
	interface: ANY;
			-- Output interface

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


end -- class EWEASEL_OUTPUT_CONTROL
