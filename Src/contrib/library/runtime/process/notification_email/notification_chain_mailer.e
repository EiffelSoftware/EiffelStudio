note
	description: "Summary description for {NOTIFICATION_CHAIN_MAILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_CHAIN_MAILER

inherit
	NOTIFICATION_MAILER

create
	make

feature {NONE} -- Initialization

	make (a_mailer: like active)
		do
			active := a_mailer
		end

feature -- Access

	active: NOTIFICATION_MAILER

	next: detachable NOTIFICATION_MAILER

feature -- Status

	is_available: BOOLEAN
		do
			Result := active.is_available
			if not Result and attached next as l_next then
				Result := l_next.is_available
			end
		end

feature -- Change

	set_next (m: like next)
		do
			next := m
		end

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
		do
			if active.is_available then
				active.process_email (a_email)
			end
			if attached next as l_next and then l_next.is_available then
				l_next.process_email (a_email)
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
