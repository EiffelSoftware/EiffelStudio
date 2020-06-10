note
	description: "Provides error information"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ERROR

inherit

	SHARED_LOGGER

feature -- Access

	last_error: detachable ERROR_HANDLER
			-- Object represent last error.

	last_error_message: READABLE_STRING_32
			-- Last error string representation.
		do
			if attached last_error as ll_error then
				Result := ll_error.error_message
			else
				Result := {STRING_32}""
			end
		end

feature -- Status Report

	successful: BOOLEAN
			-- Was last operation successful?
			-- If not, `last_error' must be set.

feature -- Element Settings

	set_last_error_from_exception (a_location: READABLE_STRING_GENERAL)
			-- Initialize instance from last exception.
			-- Don't show too much internal details (e.g. stack trace).
			-- We really don't want this to fail since it is called from rescue clauses.
		require
			attached_location: a_location /= Void
		local
			l_exceptions: EXCEPTIONS
			l_message: STRING
			l_tag: detachable STRING
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_exceptions
				create l_message.make (256)
				l_tag := l_exceptions.tag_name
				if l_tag /= Void then
					l_message.append ("The following exception was raised: ")
					l_message.append (l_tag)
				else
					l_message.append ("An unknown exception was raised.")
				end
				set_last_error (l_message, a_location)
				log.write_critical (generator + ".set_last_error_from_exception " + l_message)
			else
				set_last_error ("Generic error", "")
				log.write_critical (generator + ".set_last_error_from_exception Generic Error")
			end
		rescue
			l_retried := True
			retry
		end

	set_last_error (a_message, a_location: READABLE_STRING_GENERAL)
			-- Set `last_error_message' with `a_message',
			-- `last_error_location' with `a_location' and
			-- `successful' to `False'.
		require
			attached_message: a_message /= Void
			attached_location: a_location /= Void
		do
			create last_error.make (a_message, a_location)
			log.write_critical (generator + ".set_last_error " + a_message.to_string_8)
			successful := False
		ensure
			last_error_set: attached last_error
			failed: not successful
		end

	set_last_error_from_handler (a_error: detachable ERROR_HANDLER)
			-- Set `last_error' with `a_error'.
		do
			last_error := a_error
			successful := False
		ensure
			last_error_set: attached last_error
			failed: not successful
		end

	set_successful
			-- Reset `last_error_message' and `last_error_location' and
			-- set `successful' to `True'.
		do
			last_error := Void
			successful := True
		ensure
			last_error__reset: last_error = Void
			successful: successful
		end
end
