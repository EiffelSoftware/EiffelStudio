indexing
	description: "Log information with time of execution in a file."

class
	LOG

inherit
	MEMORY
		redefine
			dispose
		end

create
	make,
	make_in

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			last_date := feature {SYSTEM_DATE_TIME}.now
			create given_log_path.make_empty
		ensure
			non_void_last_date: last_date /= Void
			non_void_log_file: log_file /= Void
			log_file_open_append: log_file.is_open_append
			non_void_given_log_path: given_log_path /= Void
		end

	make_in (a_path: STRING) is
			-- Initialization with path
		require
			non_void_a_path: a_path /= Void
			not_empty_a_path: not a_path.is_empty
		do
			last_date := feature {SYSTEM_DATE_TIME}.now
			given_log_path := a_path
		ensure
			non_void_last_date: last_date /= Void
			non_void_given_log_path: given_log_path /= Void
		end

feature -- Access

	last_date: SYSTEM_DATE_TIME
			-- date of last loged operation.

	log_file: PLAIN_TEXT_FILE is
			-- log file.
		once
			if given_log_path.is_empty then
				create Result.make_open_append (default_log_path)
			else
				create Result.make_open_append (given_log_path)
			end
		ensure
			non_void_log_file: Result /= Void
		end

feature {NONE} -- Redefine

	dispose is
			-- Redefine to close `log_file'.
		do
			Precursor {MEMORY}
			if not Log_file.is_closed then
				log_file.flush
				log_file.close
			end
		end

feature -- Basic operation

	log (descriptive: STRING) is
			-- log with elapsed time, and `descriptive'.
		require
			non_void_descriptive: descriptive /= Void
			not_stopped: not log_file.is_closed and log_file.is_writable
		local
			l_date: SYSTEM_DATE_TIME
			l_time: TIME_SPAN
			l_elapsed_time: SYSTEM_DATE_TIME
			l_milliseconds: DOUBLE
			l_out: STRING
		do
			if log_file.is_closed then
				log_file.reopen_append (Log_path)
			end
			l_date := feature {SYSTEM_DATE_TIME}.now
			l_time := l_date.subtract_date_time (last_date)
			last_date := l_date
			l_out := descriptive + " :  " --+ l_time.total_milliseconds.out
			l_milliseconds := l_time.total_milliseconds
			l_out.append_double (l_milliseconds)
			log_file.put_string (l_out)
			log_file.put_new_line
			log_file.flush
			log_file.close 
		end

	start is
			-- start log.
		do
			last_date := feature {SYSTEM_DATE_TIME}.now
			if log_file.is_closed then
				log_file.reopen_append (log_path)
			end
		ensure
			non_void_last_date: last_date /= Void
			not_stopped: not log_file.is_closed and log_file.is_writable
		end

	stop is
			-- stop log.
		do
			if not Log_file.is_closed then
				log_file.flush
				log_file.close
			end
		end

feature {NONE} -- Implementation

	log_path: STRING is
			-- log path.
		once
			if given_log_path.is_empty then
				Result := default_log_path
			else
				Result := given_log_path
			end
		end

	default_log_path: STRING is "e:\log.txt"
			-- Default log file path.

	given_log_path: STRING
			-- Path to log information.

invariant
	non_void_last_date: last_date /= Void
	non_void_log_file: log_file /= Void

end -- class LOG
