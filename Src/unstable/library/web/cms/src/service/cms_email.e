note
	description: "CMS interface representing an email to be used with {CMS_API}.process_email (e: CMS_EMAIL)."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EMAIL

inherit
	NOTIFICATION_EMAIL

create
	make

feature -- Status report

	is_sent: BOOLEAN
			-- Current Email is sent.

feature -- Element change

	set_is_sent (b: BOOLEAN)
		do
			is_sent := b
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
