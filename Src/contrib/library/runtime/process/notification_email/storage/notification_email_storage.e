note
	description: "Abtract interface of email storage."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NOTIFICATION_EMAIL_STORAGE

feature -- Status report

	is_available: BOOLEAN
			-- Is associated storage available?
		deferred
		end

	has_error: BOOLEAN
			-- Last operation reported an error?
		deferred
		end

feature -- Storage

	put (a_email: NOTIFICATION_EMAIL)
			-- Store `a_email'.
		deferred
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
