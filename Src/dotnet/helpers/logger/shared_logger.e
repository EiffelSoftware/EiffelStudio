indexing
	description: "Shared instance of logger"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGGER

feature -- Access

	Log_source: STRING is "Eiffel Metadata Consumer"
			-- Windows event log source

	Log_name: STRING is "Application"
			-- Name of log where to log events

feature -- Status Report

	source_ready: BOOLEAN is
			-- Is log source initialized?
		do
			Result := {SYSTEM_DLL_EVENT_LOG}.source_exists (Log_source)
		end

feature -- Basic Operations

	log_last_exception is
			-- Log last exception to Windows event log.
		require
			source_ready: source_ready
		local
			l_log: SYSTEM_DLL_EVENT_LOG
		do
			create l_log.make (Log_name, ".", Log_source)
			l_log.write_entry ({ISE_RUNTIME}.last_exception.to_string, {SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE}.error)
			l_log.close
		end

	log_message (a_message: STRING) is
			-- Log `a_message'.
		require
			source_ready: source_ready
			attached_message: a_message /= Void
		local
			l_log: SYSTEM_DLL_EVENT_LOG
		do
			create l_log.make (Log_name, ".", Log_source)
			l_log.write_entry (a_message.to_cil, {SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE}.information)
			l_log.close
		end

	create_source is
			-- Create event source if not already created.
		require
			source_not_ready: not source_ready
		local
			l_retried: BOOLEAN
		once
			if not l_retried then
				{SYSTEM_DLL_EVENT_LOG}.create_event_source (Log_source, Log_name)
			end
		rescue
			l_retried := True
			retry
		end

end -- class SHARED_LOGGER