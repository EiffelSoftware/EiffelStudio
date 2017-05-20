note
	description: "[
			Log Writer that writes to a file, which, by default, is a file called
			'system.log' in the application's current working directory (as gathered
			from EXECUTION_ENVIRONMENT.

			If that is not the appropriate place / path for your application,
			please call `set_path' to set it to a different location
		]"
	legal: "See note at the end of this class"
	status: "See notice at the end of this class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_WRITER_FILE

inherit
	LOG_WRITER
		redefine
			default_create
		end

create
	make_at_location,
	default_create

feature {NONE} -- Creation

	default_create
			-- Create an instance of {LOG_WRITER_FILE}.
			-- Create a default log file called `system.log' using the current working location `a_path'.
		local
			l_path: PATH
		do
			create l_path.make_current
			l_path := l_path.extended ("system.log")
			make_at_location (l_path)
		ensure then
			default_log_level_set: log_level = Log_error
		end

	make_at_location (a_file: PATH)
			-- Create log file using the location `a_file'.
		do
			log_level := Log_error
			path := a_file
			create log_file.make_with_path (a_file)

				-- Date/time object that is reseeded to now every time `write' is called.
			create date_time.make_now_utc
		ensure
			default_log_level_set: log_level = Log_error
		end

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize this FILE_LOG_WRITER instance.
		require else
			path_set: path /= Void and then not path.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				log_file.open_append
				is_initialized := log_file.is_writable
			else
				is_initialized := False
			end
			has_errors := not is_initialized
		rescue
			retried := True
			retry
		end

feature -- Access

	set_path (a_path: PATH)
			-- Set the `path' name of the log file to `a_path'.
		require
			valid_a_path: a_path /= Void and then not a_path.is_empty
			not_initialized: not is_initialized
		do
			if not is_initialized then
				path := a_path
				create log_file.make_with_path (path)
			end
		ensure
			path_set: path.is_same_file_as (a_path)
		end

	set_file_name (a_file_name: FILE_NAME)
			-- Set the file name of the log file to `a_file_name'.
		obsolete
			"Use unicode compliant `set_path' instead. [2017-05-31]"
		require
			valid_a_file_name: a_file_name /= Void and then not a_file_name.is_empty
			not_initialized: not is_initialized
		do
			set_path (create {PATH}.make_from_string (a_file_name.string))
		ensure
			file_name_set: file_name.is_equal (a_file_name)
		end

feature -- Status Report

	path: PATH
			-- The path name of the log file.

	file_name: FILE_NAME
			-- The name of the log file, including the absolute path to it.
		obsolete
			"Use unicode compliant `path' instead. [2017-05-31]"
		do
			create Result.make_from_string (path.utf_8_name)
		end

feature {LOG_LOGGING_FACILITY} -- Output

	do_write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to the `log_file' also noting the
			-- current date and time, and adding a newline character if needed.
		do
			date_time.make_now_utc

			log_file.put_string (date_time.out)
			log_file.put_string (space_dash_space)
			log_file.put_string (priority_tag (priority))
			log_file.put_string (space_dash_space)
			log_file.put_string (msg)
			if msg [msg.count] /= '%N' then
					-- Append a new line if not present.
				log_file.put_character ('%N')
			end
			log_file.flush
		end

feature {LOG_LOGGING_FACILITY} -- Status Report

	log_file: PLAIN_TEXT_FILE
			-- The actual log file.

	date_time: DATE_TIME
			-- Date/time object that is reseeded to now every time `write' is called.

feature {NONE} -- Constants

	space_dash_space: STRING = " - "
			-- " - " constant for writing log data.

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
