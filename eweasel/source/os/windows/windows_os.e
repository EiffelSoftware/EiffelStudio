indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOWS_OS
	
inherit
	OPERATING_SYSTEM


feature -- Path name operations

	null_file_name: STRING is
			-- File name which represents null input or output
		do
		end
	
	full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		do
			create Result.make (dir_name.count + f_name.count + 1)
			if not dir_name.is_empty then
				Result.append (dir_name)
				if dir_name.item (dir_name.count) /= Directory_separator then
					Result.extend (Directory_separator)
				end
			end
			Result.append (f_name)
		end

	executable_full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		do
			Result := full_file_name (dir_name, f_name)
			Result.append (".exe")
		end

	full_directory_name (dir_name, subdir: STRING): STRING is
			-- Full name of subdirectory `subdir' of directory 
			-- `dir_name'
		do
			Result := full_file_name (dir_name, subdir)
		end

feature -- Date and time
	
	current_time_in_seconds: INTEGER is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		do
			Result := c_current_time_in_seconds
		end

	c_current_time_in_seconds: INTEGER is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)	
		external
			"C inline use <time.h>"
		alias
			"time(NULL)"
		end

feature -- Sleeping

	sleep_milliseconds (n: DOUBLE) is
			-- Suspend execution for `n' microseconds.
			-- Actual time could be longer or shorter
		external
			"C blocking inline use <windows.h>"
		alias
			"Sleep ((DWORD) $n)"
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


end -- class WINDOWS_OS
