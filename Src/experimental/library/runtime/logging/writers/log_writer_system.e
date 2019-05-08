note
	description: "[
			Log Writer that writes to the system log, using syslog on Unix and the Event.
			Log on Windows.
		]"
	legal: "See note at the end of this class"
	status: "See notice at the end of this class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_WRITER_SYSTEM

inherit
	DISPOSABLE
		undefine
			default_create
		end

	LOG_FACILITY_CONSTANTS
		undefine
			default_create
		end

	LOG_OPTION_CONSTANTS
		undefine
			default_create
		end

	LOG_WRITER
		redefine
			default_create
		end

	PLATFORM
		undefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Create system logger.
		do
			log_level := Log_error
				-- This is the default name for logging.
			application_name := "EiffelSyslog"
			options := Log_ndelay + Log_pid
			if is_windows then
				facility := Log_application_event_log
			else
				facility := Log_local6
			end
		ensure then
			default_log_level_set: log_level = Log_error
		end

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize this LOG_WRITER_SYSTEM instance.
		require else
			valid_application_name: application_name /= Void and then not application_name.is_empty
			valid_options: is_windows or else options > 0
			valid_facility: facility > 0
		local
			l_application_name: C_STRING
			l_data: POINTER
		do
			create l_application_name.make (application_name)
			is_initialized := c_logging_open_log (l_application_name.item, options, facility, $l_data)
			logger_data := l_data
			has_errors := not is_initialized
		end

feature {NONE} -- Garbage Collector

	dispose
			-- The Garbage Collector is claiming this instance.
		do
			c_logging_close_log (logger_data)
		end

feature -- Access

	set_application_name (an_application_name: STRING)
			-- Set `application_name' to `an_application_name'.
		require
			valid_an_application_name: an_application_name /= Void and then not
				an_application_name.is_empty
			not_is_initialized: not is_initialized
		do
			if not is_initialized then
				application_name := an_application_name.twin
			end
		ensure
			application_name_set: attached application_name as l and then
				l ~ an_application_name
		end

	set_facility (a_facility: INTEGER)
			-- Set `facility' to `a_facility'.
		require
			valid_a_facility: a_facility > 0
			not_is_initialized: not is_initialized
		do
			if not is_initialized then
				facility := a_facility
			end
		ensure
			facility_set: facility = a_facility
		end

	set_options (some_options: INTEGER)
			-- Set `options' to `some_options'.
		require
			valid_some_options: some_options > 0
			not_is_initialized: not is_initialized
		do
			if not is_initialized then
				options := some_options
			end
		ensure
			options_set: options = some_options
		end

feature -- Status Report

	application_name: STRING
			-- Name of the application under which the system's log will record messages.

	facility: INTEGER
			-- The logging facility to be used. See LOG_FACILITY_CONST.

	options: INTEGER
			-- Logging options. See LOG_OPTION_CONST.

feature {LOG_LOGGING_FACILITY} -- Output

	do_write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to `io.error' also noting the
			-- current date and time, and adding a newline character if needed.
		do
			c_message.set_string (msg)
			c_logging_write_log (priority, c_message.item, logger_data)
		end

feature {NONE} -- Attributes

	c_message: C_STRING
			-- A C_STRING used to interact with the C Library.
		once
			create Result.make_empty (0)
		end

	logger_data: POINTER
			-- Handle for logger reference if needed.

feature {NONE} -- Externals

	c_logging_close_log (l_data: POINTER)
			-- External C call to `eif_logging_close_log'.
		external
			"C inline use %"eif_logging.h%""
		alias
			"[
			#if EIF_OS == EIF_OS_WINNT
				DeregisterEventSource($l_data);

			#elif EIF_OS == EIF_OS_LINUX
				closelog();

			#else
				/* Nothing to be done here. */
			#endif
			]"
		end

	c_logging_open_log (identifier: POINTER; option: INTEGER; log_fac: INTEGER; l_data: TYPED_POINTER [POINTER]): BOOLEAN
			-- External C call to `eif_logging_open_log'.
		external
			"C inline use %"eif_logging.h%""
		alias
			"[
			#if EIF_OS == EIF_OS_WINNT
				const char *event_log;

				if($log_fac == EIF_LOGGING_APP_EVENT_LOG) {
					event_log = "Application";
				} else if($log_fac == EIF_LOGGING_SEC_EVENT_LOG) {
					event_log = "Security";
				} else if($log_fac == EIF_LOGGING_SYS_EVENT_LOG) {
					event_log = "System";
				} else {
					event_log = "Unknown";
				}

					/* We use the ASCII version since we are given a C string. */
				*($l_data) = RegisterEventSourceA(NULL, $identifier);

				if ($l_data) {
					return EIF_TRUE;
				} else {
					return EIF_FALSE;
				}

			#elif EIF_OS == EIF_OS_LINUX

				openlog($identifier, $option, $log_fac);

				return EIF_TRUE;

			#else
					/* Not supported platform. */
				return EIF_FALSE;
			#endif
			]"
		end

	c_logging_write_log (priority: INTEGER; msg: POINTER; l_data: POINTER)
			-- External C call to `eif_logging_write_log'.
		external
			"C inline use %"eif_logging.h%""
		alias
			"[
			#if EIF_OS == EIF_OS_WINNT
				LPCSTR lpStrings[2] = {NULL, NULL};
				WORD wType = 0;
				DWORD dwEventId = 0;

				lpStrings[0] = $msg;

				if($priority == EIF_LOGGING_DEBUG || $priority == EIF_LOGGING_INFORMATION) {
					wType = EVENTLOG_INFORMATION_TYPE;
					dwEventId = EIF_LOGGING_INFO_MESSAGE;
				} else if ($priority == EIF_LOGGING_NOTICE || $priority == EIF_LOGGING_WARNING) {
					wType = EVENTLOG_WARNING_TYPE;
					dwEventId = EIF_LOGGING_WARN_MESSAGE;
				} else {
					wType = EVENTLOG_ERROR_TYPE;
					dwEventId = EIF_LOGGING_ERRO_MESSAGE;
				}

					/* We use the ASCII version since we are given a C string. */
				ReportEventA($l_data, wType, (WORD) $priority, dwEventId, NULL, 1, 0, lpStrings, NULL);

			#elif EIF_OS == EIF_OS_LINUX
				syslog($priority, "%s", (char *) $msg);
			#else
				/* Nothing to be done here. */
			#endif
			]"
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
