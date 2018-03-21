note
	description: "Controller of output.  Write output to `interface' (default is standard output)."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EW_EWEASEL_OUTPUT_CONTROL

create
	make

feature {NONE} -- Creation

	make (a_interface: ANY)
			-- Create
		require
			interface_not_void: a_interface /= Void
		do
			interface := a_interface
		ensure
			has_interface: interface = a_interface
		end

feature -- Commands

	clear
			-- Clear the current output
		do
		end

	flush
			-- Flush
		do
			io.output.flush
		end

	update
			-- Update
		do
			flush
		end

	append (output: STRING; on_new_line: BOOLEAN)
			-- Append `output' to current output
		require
			output_not_void: output /= Void
		do
			io.put_string (output)
			if on_new_line then
				io.new_line
			end
		end

	append_32 (output: READABLE_STRING_32; on_new_line: BOOLEAN)
			-- Append `output' to current output
		require
			output_not_void: output /= Void
		local
			u: UTF_CONVERTER
		do
			io.put_string (u.string_32_to_utf_8_string_8 (output))
			if on_new_line then
				io.new_line
			end
		end

	append_error (output: STRING; on_new_line: BOOLEAN)
			-- Append `output' to current output, formatted to indicate error.
		require
			output_not_void: output /= Void
		do
			append (output, on_new_line)
		end

	append_error_32 (output: READABLE_STRING_32; on_new_line: BOOLEAN)
			-- Append `output' to current output, formatted to indicate error.
		require
			output_not_void: output /= Void
		do
			append_32 (output, on_new_line)
		end

	append_new_line
			-- Append new line
		do
			io.new_line
		end

feature {NONE} -- Constants

	new_line: STRING = "%N"
			-- New line character

	empty_string: STRING
			-- Empty string
		once
			create Result.make_empty
		end

feature {NONE} -- Implementation

	interface: ANY
			-- Output interface

;note
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
