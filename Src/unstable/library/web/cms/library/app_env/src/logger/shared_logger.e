note
	description: "Provides logger information"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

inherit
	LOG_PRIORITY_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

feature -- Logging

	write_debug_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_debug (m)
				end
			end
		rescue
			retried := True
			retry
		end

	write_information_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_information (m)
				end
			end
		rescue
			retried := True
			retry
		end

	write_warning_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_warning (m)
				end
			end
		rescue
			retried := True
			retry
		end

	write_error_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_error (m)
				end
			end
		rescue
			retried := True
			retry
		end

	write_critical_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_critical (m)
				end
			end
		rescue
			retried := True
			retry
		end

	write_alert_log (m: READABLE_STRING_8)
		local
			retried: BOOLEAN
		do
			if not retried and attached logger as l_logger then
				separate l_logger as log do
					log.put_alert (m)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Logger

	logger: detachable separate LOGGER
			-- Logging facilities (once per process)
            -- that could be shared between threads
            -- without reinitializing it.
		do
			separate logger_cell as cl do
				Result := cl.item
			end
		end

	logger_cell: separate CELL [detachable separate LOGGER]
		once ("PROCESS")
			create Result.put (Void) --create {separate LOGGER}.make)
		end

feature {NONE} -- Implementation

	initialize_logger (app: APPLICATION_ENVIRONMENT)
		local
			l_logger: separate LOGGER
		do
			create l_logger.make_with_environment (app)
			separate logger_cell as cl do
				cl.replace (l_logger)
			end
		end
note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
