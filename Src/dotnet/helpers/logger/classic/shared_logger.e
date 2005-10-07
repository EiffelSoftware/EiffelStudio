indexing
	description: "Shared instance of logger, classic version only provides dummy implementation for now"
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
		end

feature -- Basic Operations

	log_last_exception is
			-- Log last exception to Windows event log.
		require
			source_ready: source_ready
		do
		end

	log_message (a_message: STRING) is
			-- Log `a_message' to Windows event log.
		require
			source_ready: source_ready
			attached_message: a_message /= Void
		do
		end

	create_source is
			-- Create event source if not already created.
		do
		end

end -- class SHARED_LOGGER