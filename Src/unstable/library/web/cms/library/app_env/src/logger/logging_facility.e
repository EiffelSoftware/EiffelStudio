note
	description: "Wrapper class providing synchronize logging access."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGING_FACILITY

create
	make

feature -- Initialization

	make
		do
			create logging.make
		end

feature -- Access

	logging:  LOG_LOGGING_FACILITY


	register_log_writer (a_log_writer: LOG_WRITER)
			-- Register the non-default log writer `a_log_writer'.
		do
			logging.register_log_writer (a_log_writer)
		end

feature -- Output


	write_alert (msg: STRING)
			-- Write `msg' to the log writers as an alert.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_alert (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_critical (msg: STRING)
			-- Write `msg' to the log writers as an critical
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_critical (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_debug (msg: STRING)
			-- Write `msg' to the log writers as an debug.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_debug (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_emergency (msg: STRING)
			-- Write `msg' to the log writers as an emergency.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_emergency (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_error (msg: STRING)
			-- Write `msg' to the log writers as an error.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_error (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_information (msg: STRING)
			-- Write `msg' to the log writers as an information.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_information (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_notice (msg: STRING)
			-- Write `msg' to the log writers as an notice.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_notice (msg)
			end
		rescue
			l_retry := True
			retry
		end

	write_warning (msg: STRING)
			-- Write `msg' to the log writers as an warning.
		local
			l_retry: BOOLEAN
		do
			if not l_retry then
				logging.write_warning (msg)
			end
		rescue
			l_retry := True
			retry
		end
note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
