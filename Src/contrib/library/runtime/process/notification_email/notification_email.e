note
	description : "[
			Component representing an email
			]"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	NOTIFICATION_EMAIL

create
	make

feature {NONE} -- Initialization

	make (a_from: like from_address; a_to_address: READABLE_STRING_8; a_subject: like subject; a_body: like body)
			-- Initialize `Current'.
		do
			initialize
			from_address := a_from
			subject := a_subject
			body := a_body
			to_addresses.extend (a_to_address)

		end

	initialize
		do
			create date.make_now_utc
			create to_addresses.make (1)
		end

feature -- Access

	date: DATE_TIME

	from_address: READABLE_STRING_8

	to_addresses: ARRAYED_LIST [READABLE_STRING_8]

	subject: READABLE_STRING_8

	body: READABLE_STRING_8

feature -- Change	

	set_date (d: like date)
		do
			date := d
		end

feature -- Conversion

	message: STRING_8
		do
			Result := header
			Result.append_character ('%N')
			Result.append (body)
			Result.append_character ('%N')
			Result.append_character ('%N')
		end

	header: STRING_8
		local
			hdate: HTTP_DATE
		do
			create Result.make (20)
			Result.append ("From: ")
			Result.append (from_address)
			Result.append_character ('%N')
			Result.append ("Date: ")
			create hdate.make_from_date_time (date)
			hdate.append_to_rfc1123_string (Result)
			Result.append (" GMT%N")
			Result.append ("To: ")
			across
				to_addresses as c
			loop
				Result.append (c.item)
				Result.append_character (';')
			end
			Result.append_character ('%N')
			Result.append ("Subject: ")
			Result.append (subject)
			Result.append_character ('%N')
		ensure
			Result.ends_with ("%N")
		end

invariant
--	invariant_clause: True

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
