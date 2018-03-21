note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EW_WINDOWS_OS

inherit
	EW_OPERATING_SYSTEM

feature -- Path name operations

	null_file_name: STRING_32 = "nul"
			-- File name which represents null input or output

	executable_full_file_name (dir_name, f_name: READABLE_STRING_32): READABLE_STRING_32
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		do
			Result := full_file_name (dir_name, f_name) + ".exe"
		end

	full_directory_name (dir_name, subdir: READABLE_STRING_32): READABLE_STRING_32
			-- Full name of subdirectory `subdir' of directory
			-- `dir_name'
		do
			Result := full_file_name (dir_name, subdir)
		end

feature -- Date and time

	current_time_in_seconds: INTEGER
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		do
			Result := c_current_time_in_seconds
		end

	c_current_time_in_seconds: INTEGER
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)	
		external
			"C inline use <time.h>"
		alias
			"time(NULL)"
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
