note
	description: "Summary description for {ESA_API_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_API_ERROR

feature -- Access

	last_error: detachable ESA_ERROR_HANDLER

feature -- Status Report

	successful: BOOLEAN
			-- Was last operation successful?
			-- If not, `last_error' must be set.

feature -- Element Settings

	set_last_error_from_exception (a_location: STRING)
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
			else
				set_last_error ("Generic error", "")
			end
		rescue
			l_retried := True
			retry
		end

	set_last_error (a_message, a_location: STRING)
			-- Set `last_error_message' with `a_message',
			-- `last_error_location' with `a_location' and
			-- `successful' to `False'.
		require
			attached_message: a_message /= Void
			attached_location: a_location /= Void
		do
			create last_error.make (a_message, a_location)
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

invariant
	last_error_set_iff_successful: successful = (last_error = Void)
end
