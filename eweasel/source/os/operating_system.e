indexing
	description: "Generic operating system services"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "October 7, 1997"

deferred class OPERATING_SYSTEM

inherit
	OPERATING_ENVIRONMENT

feature -- Path name operations

	null_file_name: STRING is
			-- File name which represents null input or output
		deferred
		end
	
	full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		require
			dir_name_not_void: dir_name /= Void;
			file_name_not_void: f_name /= Void;
		deferred
		ensure
			result_exists: Result /= Void
		end;

	executable_full_file_name (dir_name, f_name: STRING): STRING is
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		require
			dir_name_not_void: dir_name /= Void;
			file_name_not_void: f_name /= Void;
		deferred
		ensure
			result_exists: Result /= Void
		end;

	full_directory_name (dir_name, subdir: STRING): STRING is
			-- Full name of subdirectory `subdir' of directory 
			-- `dir_name'
		require
			dir_name_not_void: dir_name /= Void;
			subdir_not_void: subdir /= Void;
		deferred
		ensure
			result_exists: Result /= Void
		end;

feature -- File operations
	
	delete_directory_tree (dir_name: STRING) is
			-- Try to delete the directory tree rooted at 
			-- `dir_name'.  Ignore any errors
		require
			directory_not_void: dir_name /= Void;
		local
			l_dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create l_dir.make (dir_name)
				l_dir.recursive_delete
			end
		rescue
			retried := True
			retry
		end;

feature -- Process operations

	my_process_id: INTEGER is
			-- Process id of currently executing process
		deferred
		ensure
			valid_process_id: Result > 0
		end;

feature -- Date and time
	
	current_time_in_seconds: INTEGER is
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		deferred
		end

feature -- Sleeping

	sleep_milliseconds (n: DOUBLE) is
			-- Suspend execution for `n' microseconds.
			-- Actual time could be longer or shorter
		require
			nonnegative_time: n >= 0;
		deferred
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


end -- class OPERATING_SYSTEM
