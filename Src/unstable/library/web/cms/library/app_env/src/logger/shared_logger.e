note
	description: "Provides logger information"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

inherit
	LOG_PRIORITY_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

feature -- Logger

	logger: separate LOGGER
			-- `log' facility (once per process)
            -- that could be shared between threads
            -- without reinitializing it.
		do
			Result := logger_cell_item (logger_cell)
		end

	logger_cell: separate CELL [separate LOGGER]
		once ("PROCESS")
			create Result.put (create {separate LOGGER}.make)
		end

	logger_cell_item (a_cell: like logger_cell): separate LOGGER
		do
			Result := a_cell.item
		end

feature -- Logging

	write_debug_log (m: READABLE_STRING_8)
		do
--			write_debug_log_to (m, logger)
		end

	write_information_log (m: READABLE_STRING_8)
		do
--			write_information_log_to (m, logger)
		end

	write_warning_log (m: READABLE_STRING_8)
		do
--			write_warning_log_to (m, logger)
		end

	write_error_log (m: READABLE_STRING_8)
		do
--			write_error_log_to (m, logger)
		end

	write_critical_log (m: READABLE_STRING_8)
		do
--			write_critical_log_to (m, logger)
		end

	write_alert_log (m: READABLE_STRING_8)
		do
--			write_alert_log_to (m, logger)
		end

feature {NONE} -- Logger: separate implementation			

	write_debug_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_debug (m)
			end
		rescue
			retried := True
			retry
		end

	write_information_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_information (m)
			end
		rescue
			retried := True
			retry
		end

	write_warning_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_warning (m)
			end
		rescue
			retried := True
			retry
		end

	write_error_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_error (m)
			end
		rescue
			retried := True
			retry
		end

	write_critical_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_critical (m)
			end
		rescue
			retried := True
			retry
		end

	write_alert_log_to (m: READABLE_STRING_8; a_log: like logger)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_log.put_alert (m)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	initialize_logger (app: APPLICATION_ENVIRONMENT)
		local
			l_logger: separate LOGGER
		do
			create l_logger.make_with_environment (app)
			set_logger_to (l_logger, logger_cell)
		end

	set_logger_to (a_logger: separate LOGGER; a_cell: like logger_cell)
		do
			a_cell.replace (a_logger)
		end
note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
