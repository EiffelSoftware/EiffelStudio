note
	description:	"[
						Log Writer that writes to a file, which, by default, is a file called
						'system.log' in the application's current working directory (as gathered
						from EXECUTION_ENVIRONMENT.

						If that is not the appropriate place / file name for your application,
						please call `set_file_name' to set it to a different location
					]"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	LOG_WRITER_FILE

inherit
	LOG_WRITER
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Create an instance of {LOG_WRITER_FILE}.
		local
			l_exec_env: EXECUTION_ENVIRONMENT
		do
			create l_exec_env
			create file_name.make_from_string (l_exec_env.current_working_directory)
			file_name.set_file_name ("system.log")
			create log_file.make (file_name)
		end

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize this FILE_LOG_WRITER instance
		require else
			file_name_set: file_name /= Void and then not file_name.is_empty
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

	set_file_name (a_file_name: FILE_NAME)
			-- Set the file name of the log file to `a_file_name'
		require
			valid_a_file_name: a_file_name /= Void and then not a_file_name.is_empty
			not_initialized: not is_initialized
		do
			if not is_initialized then
				file_name := a_file_name.twin
				create log_file.make (file_name)
			end
		ensure
			file_name_set: file_name.is_equal (a_file_name)
		end

feature -- Status Report

	file_name: FILE_NAME;
			-- The name of the log file, including the absolute path to it

feature {LOG_LOGGING_FACILITY} -- Output

	write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to the `log_file' also noting the
			-- current date and time, and adding a newline character if needed
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
			-- The actual log file

feature {NONE} -- Attributes

	date_time: DATE_TIME
			-- Date/time object that is reseeded to now every time `write' is called
		once
			create Result.make_now_utc
		end

feature {NONE} -- Constants

	space_dash_space: STRING = " - "
		-- " - " constant for writing log data.

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
