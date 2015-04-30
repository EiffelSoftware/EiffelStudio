note
	description: "Logger for CMS based on the logger provided by the Application Environment library"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ENV_LOGGER

inherit
	CMS_LOGGER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Logging

	put_information (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_information_log (log_message (a_message, a_data))
		end

	put_error (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_error_log (log_message (a_message, a_data))
		end

	put_warning (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_warning_log (log_message (a_message, a_data))
		end

	put_critical (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_critical_log (log_message (a_message, a_data))
		end

	put_alert (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_alert_log (log_message (a_message, a_data))
		end

	put_debug (a_message: READABLE_STRING_8; a_data: detachable ANY)
		do
			write_debug_log (log_message (a_message, a_data))
		end

end
