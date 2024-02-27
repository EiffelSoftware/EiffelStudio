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
			if Result = Void then
				if attached application_environment_cell_item (application_environment_cell) as app then
					create Result.make_with_environment (app)
				else
					create Result.make
				end
				set_logger_to (Result, logger_cell)
			end
		end

	logger_cell: separate CELL [detachable separate LOGGER]
		once ("PROCESS")
			create Result.put (Void)
		end

	logger_cell_item (a_cell: like logger_cell): detachable separate LOGGER
		do
			Result := a_cell.item
		end

	application_environment_cell: separate CELL [detachable separate APPLICATION_ENVIRONMENT]
		once ("PROCESS")
			create Result.put (Void)
		end

	application_environment_cell_item (a_cell: like application_environment_cell): detachable separate APPLICATION_ENVIRONMENT
		do
			Result := a_cell.item
		end

feature -- Logging

	write_debug_log (m: READABLE_STRING_8)
		do
			write_debug_log_to (m, logger)
		end

	write_information_log (m: READABLE_STRING_8)
		do
			write_information_log_to (m, logger)
		end

	write_warning_log (m: READABLE_STRING_8)
		do
			write_warning_log_to (m, logger)
		end

	write_error_log (m: READABLE_STRING_8)
		do
			write_error_log_to (m, logger)
		end

	write_critical_log (m: READABLE_STRING_8)
		do
			write_critical_log_to (m, logger)
		end

	write_alert_log (m: READABLE_STRING_8)
		do
			write_alert_log_to (m, logger)
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
--			l_logger: separate LOGGER
		do
			set_application_environment_to (app, application_environment_cell)
--			create l_logger.make_with_environment (app)
--			set_logger_to (l_logger, logger_cell)
		end

	set_logger_to (a_logger: separate LOGGER; a_cell: like logger_cell)
		do
			a_cell.replace (a_logger)
		end

	set_application_environment_to (app: separate APPLICATION_ENVIRONMENT; a_cell: like application_environment_cell)
		do
			a_cell.replace (app)
		end

note
	copyright: "2011-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
