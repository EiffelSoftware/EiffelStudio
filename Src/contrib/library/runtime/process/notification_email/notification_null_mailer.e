note
	description: "Mailer that does nothing."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_NULL_MAILER

inherit
	NOTIFICATION_MAILER

feature -- Status

	is_available: BOOLEAN = True
			-- <Precursor>

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
			-- <Precursor>
		do
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
