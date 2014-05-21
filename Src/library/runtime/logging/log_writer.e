note
	description: "Abstract notion of a log writer"
	legal: "See note at the end of this class"
	status: "See notice at the end of this class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOG_WRITER

inherit
	LOG_PRIORITY_CONSTANTS

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize the log writer, set the default log level to ERROR.
		require
			not_is_initialized: not is_initialized
		deferred
		ensure
			is_initialized_or_has_errors: is_initialized or has_errors
		end

feature -- Status Report

	has_errors: BOOLEAN
			-- Did an error occur during initialization?

	is_initialized: BOOLEAN
			-- Is this log writer initialized?

feature {LOG_LOGGING_FACILITY} -- Output

	write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to this log.
		require
			is_initialized: is_initialized
			not_suspended: not suspended
			valid_msg: msg /= Void and then not msg.is_empty
		do
			if priority <= log_level then
				do_write (priority, msg)
			end
		ensure
			is_initialized: is_initialized
		end

	do_write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to this log.	
		deferred
		end

feature -- Log level

	log_level: INTEGER
			-- Possible log levels	UNKNO < EMERG < ALERT < CRIT < ERROR < WARN < NOTIC < INFO < DEBUG
            -- Default UNKNO, no logging at all.

feature -- Access

	enable_unkno_log_level
			-- The lowest possible value and is intended to turn off logging.
		do
			log_level := 0
		ensure
			log_level_set: log_level = 0
		end

	enable_emergency_log_level
			-- System is unnusable.
		do
			log_level := Log_emergency
		ensure
			log_level_set: log_level = Log_emergency
		end

	enable_alert_log_level
			-- Action must be taken immediately.
		do
			log_level := Log_alert
		ensure
			log_level_set: log_level = Log_alert
		end

	enable_critical_log_level
			-- Critical conditions.
		do
			log_level := Log_critical
		ensure
			log_level_set: log_level = Log_critical
		end

	enable_error_log_level
			-- Error conditions.
		do
			log_level := Log_error
		ensure
			log_level_set: log_level = Log_error
		end

	enable_warning_log_level
			-- Warning conditions.
		do
			log_level := Log_warning
		ensure
			log_level_set: log_level = Log_warning
		end

	enable_notice_log_level
			-- Normal but significant condition
		do
			log_level := Log_notice
		ensure
			log_level_set: log_level = Log_notice
		end

	enable_information_log_level
			-- Informational.
		do
			log_level := Log_information
		ensure
			log_level_set: log_level = Log_information
		end

	enable_debug_log_level
			-- Debug-level messages.
		do
			log_level := Log_debug
		ensure
			log_level_set: log_level = Log_debug
		end

feature {LOG_LOGGING_FACILITY} -- Access

	suspend
			-- Suspend output to this log writer
		do
			suspended := True
		end

	resume
			-- Resume output to this log writer
		do
			suspended := False
		end

feature {LOG_LOGGING_FACILITY} -- Status Report

	suspended: BOOLEAN;
			-- Is out to this log writer suspended?

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
