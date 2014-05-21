note
	description: "Application Logging Facilities"
	legal: "See note at the end of this class"
	status: "See notice at the end of this class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_LOGGING_FACILITY

inherit
	LOG_PRIORITY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the log application
		do
			create log_writer_list.make (0)
			create default_log_writer_file
			create default_log_writer_stderr
			create default_log_writer_system
		ensure
			log_writer_list_created: log_writer_list /= Void
		end

feature -- Access

	disable_all_logs
			-- Permanently remove all of the registered log writers
		require
			log_writer_registered: log_writer_count > 0
		do
			log_writer_list.wipe_out
		ensure
			log_writer_list_empty: log_writer_list.is_empty
		end

	suspend_all_logs
			-- Temporarily suspend all registered log writers
		require
			log_writers_registered: log_writer_count > 0
		local
			l_list: like log_writer_list
		do
			l_list := log_writer_list
			from
				l_list.start
			until
				l_list.after
			loop
				l_list.item.suspend
				l_list.forth
			end
		ensure
			log_writers_registered: log_writer_count > 0
		end

	resume_all_logs
			-- Resume all registered log writers
		require
			log_writers_registered: log_writer_count > 0
		local
			l_list: like log_writer_list
		do
			l_list := log_writer_list
			from
				l_list.start
			until
				l_list.after
			loop
				l_list.item.resume
				l_list.forth
			end
		ensure
			log_writers_registered: log_writer_count > 0
		end

	suspend_i_th_log (an_index: INTEGER)
			-- Suspend the log writer at index `an_index'
		require
			valid_index: an_index > 0 and an_index <= log_writer_count
		do
			log_writer_list [an_index].suspend
		end

	resume_i_th_log (an_index: INTEGER)
			-- Suspend the log writer at index `an_index'
		require
			valid_index: an_index > 0 and an_index <= log_writer_count
		do
			log_writer_list [an_index].resume
		end

	enable_default_file_log
			-- Enable the default file log writer
		do
			default_log_writer_file.initialize
			log_writer_list.extend (default_log_writer_file)
		ensure
			one_more_log_writer: log_writer_count = old log_writer_count + 1
		end

	suspend_default_file_log
			-- Suspend output to the default file log writer
		require
			default_file_logging_enabled: default_log_writer_file /= Void and then
				default_log_writer_file.is_initialized
		do
			if default_log_writer_file /= Void then
				default_log_writer_file.suspend
			end
		end

	resume_default_file_log
			-- Resume output to the default file log writer
		require
			default_file_logging_enabled: default_log_writer_file /= Void and then
				default_log_writer_file.is_initialized
		do
			if default_log_writer_file /= Void then
				default_log_writer_file.resume
			end
		end

	enable_default_stderr_log
			-- Enable the default stderr log writer
		do
			default_log_writer_stderr.initialize
			log_writer_list.extend (default_log_writer_stderr)
		ensure
			one_more_log_writer: log_writer_count = old log_writer_count + 1
		end

	suspend_default_stderr_log
			-- Suspend output to the default stderr log writer
		require
			default_stderr_logging_enabled: default_log_writer_stderr /= Void and then
				default_log_writer_stderr.is_initialized
		do
			default_log_writer_stderr.suspend
		end

	resume_default_stderr_log
			-- Suspend output to the default stderr log writer
		require
			default_stderr_logging_enabled: default_log_writer_stderr /= Void and then
				default_log_writer_stderr.is_initialized
		do
			default_log_writer_stderr.resume
		end

	enable_default_system_log
			-- Enable the default system log writer
		do
			default_log_writer_system.initialize
			log_writer_list.extend (default_log_writer_system)
		ensure
			one_more_log_writer: log_writer_count = old log_writer_count + 1
		end

	suspend_default_system_log
			-- Suspend output to the default system log writer
		require
			default_system_logging_enabled: default_log_writer_system /= Void and then
				default_log_writer_system.is_initialized
		do
			default_log_writer_system.suspend
		end

	resume_default_system_log
			-- Suspend output to the default system log writer
		require
			default_system_logging_enabled: default_log_writer_system /= Void and then
				default_log_writer_system.is_initialized
		do
			default_log_writer_system.resume
		end

	register_log_writer (a_log_writer: LOG_WRITER)
			-- Register the non-default log writer `a_log_writer'
		require
			valid_log_writer: a_log_writer /= Void and then not a_log_writer.is_initialized
		do
			a_log_writer.initialize
			log_writer_list.extend (a_log_writer)
		ensure
			log_writer_is_initialized: a_log_writer.is_initialized or a_log_writer.has_errors
			one_more_log_writer: log_writer_count = old log_writer_count + 1 or else
				a_log_writer.has_errors
		end

	suspend_log_writer (a_log_writer: LOG_WRITER)
			-- Suspend output to `a_log_writer'
		require
			valid_log_writer: a_log_writer /= Void and then a_log_writer.is_initialized
		do
			if a_log_writer /= Void and then a_log_writer.is_initialized then
				a_log_writer.suspend
			end
		end

	resume_log_writer (a_log_writer: LOG_WRITER)
			-- Resume output to `a_log_writer'
		require
			valid_log_writer: a_log_writer /= Void and then a_log_writer.is_initialized
		do
			if a_log_writer /= Void and then a_log_writer.is_initialized then
				a_log_writer.resume
			end
		end

feature -- Output

	write_alert (msg: STRING)
			-- Write `msg' to the log writers as an alert
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_alert, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_critical (msg: STRING)
			-- Write `msg' to the log writers as an critical
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_critical, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_debug (msg: STRING)
			-- Write `msg' to the log writers as an debug
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_debug, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_emergency (msg: STRING)
			-- Write `msg' to the log writers as an emergency
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_emergency, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_error (msg: STRING)
			-- Write `msg' to the log writers as an error
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_error, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_information (msg: STRING)
			-- Write `msg' to the log writers as an information
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_information, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_notice (msg: STRING)
			-- Write `msg' to the log writers as an notice
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_notice, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

	write_warning (msg: STRING)
			-- Write `msg' to the log writers as an warning
		require
			log_writer_registered: log_writer_count > 0
			valid_msg: msg /= Void and then not msg.is_empty
		do
			write (Log_warning, msg)
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

feature -- Status Report

	default_log_writer_file: LOG_WRITER_FILE
			-- Default log writer for file output

	default_log_writer_stderr: LOG_WRITER_STDERR
			-- Default log writer for stderr output

	default_log_writer_system: LOG_WRITER_SYSTEM
			-- Default log writer for system output

	log_writer_count: INTEGER
			-- Number of registered log writers
		do
			Result := log_writer_list.count
		end

feature {NONE} -- Attributes

	log_writer_list: ARRAYED_LIST [LOG_WRITER]
			-- The list of registered log writers

feature {NONE} -- Implementation

	write (priority: INTEGER; msg: STRING)
			-- Write `msg' to the log writers under the given priority
		require
			log_writer_registered: log_writer_count > 0
		local
			l_index: INTEGER
			l_list: like log_writer_list
		do
			l_list := log_writer_list
			from
				l_index := 1
			until
				l_index > log_writer_count
			loop
				if l_list [l_index].is_initialized and not l_list [l_index].suspended then
					l_list [l_index].write (priority, msg)
				end
				l_index := l_index + 1
			end
		ensure
			log_writer_count_unchanged: log_writer_count = old log_writer_count
		end

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
