note
	description: "[
			Component responsible to send email
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NOTIFICATION_MAILER

feature -- Status

	is_available: BOOLEAN
			-- Is mailer available to use?
		deferred
		end

feature -- Basic operation

	process_emails (lst: ITERABLE [NOTIFICATION_EMAIL])
			-- Process set of emails `lst'
		require
			is_available
		do
			across
				lst as c
			loop
				process_email (c.item)
			end
		end

	safe_process_email (a_email: NOTIFICATION_EMAIL)
			-- Same as `process_email', but include the check of `is_available'
		do
			if is_available then
				process_email (a_email)
			end
		end

	process_email (a_email: NOTIFICATION_EMAIL)
			-- Process the sending of `a_email'
		require
			is_available
		deferred
		end

feature -- Error

	has_error: BOOLEAN
			-- Previous operation reported error?
			-- Use `reset_errors', to reset this state.
		do
			Result := attached last_errors as lst and then not lst.is_empty
		end

	reset_errors
			-- Reset last errors.
		do
			last_errors := Void
		end

	last_errors: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Last reported errors since previous `reset_errors' call.

	report_error (a_msg: READABLE_STRING_GENERAL)
			-- Report error message `a_msg'.
		local
			lst: like last_errors
		do
			lst := last_errors
			if lst = Void then
				create lst.make (1)
				last_errors := lst
			end
			lst.force (a_msg.to_string_32)
		end


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
