
indexing
	
	description: "Generic operating system services";
	author: "David Hollenberg";
	date: "October 7, 1997"

deferred class PROCESS_OPERATING_SYSTEM

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
		deferred
		end;

feature -- Process operations

	my_process_id: INTEGER is
			-- Process id of currently executing process
		deferred
		ensure
			valid_process_id: Result > 0
		end;

feature -- File descriptor operations

	valid_file_descriptor (fd: INTEGER): BOOLEAN is
			-- Is `fd' in the range of valid file descriptors?
		do
			Result := fd >= 0
		end

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

end -- class PROCESS_OPERATING_SYSTEM
