note
	description: "Wrapper class providing synchronize logging access."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGGING_FACILITY

create
	make
feature -- Initialization

	make
		do
			create logging.make
			create logging_mutex.make
		end

feature -- Access

	logging:  LOG_LOGGING_FACILITY


	register_log_writer (a_log_writer: LOG_WRITER)
			-- -- Register the non-default log writer `a_log_writer'.
		do
			logging.register_log_writer (a_log_writer)
		end

feature -- Output


	write_alert (msg: STRING)
			-- Write `msg' to the log writers as an alert
		do
			logging_mutex.lock
			logging.write_alert (msg)
			logging_mutex.unlock
		end

	write_critical (msg: STRING)
			-- Write `msg' to the log writers as an critical
		do
			logging_mutex.lock
			logging.write_critical (msg)
			logging_mutex.unlock
		end

	write_debug (msg: STRING)
			-- Write `msg' to the log writers as an debug.
		do
			logging_mutex.lock
			logging.write_debug (msg)
			logging_mutex.unlock
		end

	write_emergency (msg: STRING)
			-- Write `msg' to the log writers as an emergency.
		do
			logging_mutex.lock
			logging.write_emergency (msg)
			logging_mutex.unlock
		end

	write_error (msg: STRING)
			-- Write `msg' to the log writers as an error.
		do
			logging_mutex.lock
			logging.write_error (msg)
			logging_mutex.unlock
		end

	write_information (msg: STRING)
			-- Write `msg' to the log writers as an information.
		do
			logging_mutex.lock
			logging.write_information (msg)
			logging_mutex.unlock
		end

	write_notice (msg: STRING)
			-- Write `msg' to the log writers as an notice.
		do
			logging_mutex.lock
			logging.write_notice (msg)
			logging_mutex.unlock
		end

	write_warning (msg: STRING)
			-- Write `msg' to the log writers as an warning.
		do
			logging_mutex.lock
			logging.write_warning (msg)
			logging_mutex.unlock
		end

feature --

	logging_mutex: MUTEX
			-- Mutex for the logging.


end
