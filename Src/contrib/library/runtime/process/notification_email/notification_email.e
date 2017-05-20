note
	description : "[
			Email message handled by notification mailer.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_EMAIL

create
	make

feature {NONE} -- Initialization

	make (a_from: like from_address; a_to_address: READABLE_STRING_8; a_subject: like subject; a_content: like content)
			-- Initialize `Current'.
		require
			well_formed_from_address: is_valid_address (a_from)
			well_formed_to_address: is_valid_address (a_to_address)
		do
			initialize
			from_address := a_from
			subject := a_subject
			content := a_content
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

	reply_to_address: detachable READABLE_STRING_8

	to_addresses: ARRAYED_LIST [READABLE_STRING_8]

	cc_addresses: detachable ARRAYED_LIST [READABLE_STRING_8]

	bcc_addresses: detachable ARRAYED_LIST [READABLE_STRING_8]

	subject: READABLE_STRING_8

	content: READABLE_STRING_8

	additional_header_lines: detachable ARRAYED_LIST [READABLE_STRING_8]
			-- Additional header lines.

	body: like content
		obsolete
			"Use `content'. [2017-05-31]"
		do
			Result := body
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is current email ready to be sent?
		do
			Result := 	is_valid_address (from_address) and
						across to_addresses as ic all is_valid_address (ic.item) end
		end

	has_header (a_header_name: READABLE_STRING_8): BOOLEAN
			-- Has additional header `a_header_name'?
			-- Warning: it checks only `additional_header_lines'!
		local
			h_colon: STRING
		do
			if attached additional_header_lines as lst then
				create h_colon.make_from_string (a_header_name)
				h_colon.append_character (':')
				Result := across lst as ic some ic.item.starts_with (h_colon) end
			end
		end

feature -- Change	

	set_date (d: like date)
		do
			date := d
		end

	set_subject (s: READABLE_STRING_8)
			-- Set `subject' to `s'.
		do
			subject := s
		end

	set_content (s: READABLE_STRING_8)
			-- Set `content' to `s'.
		do
			content := s
		end

	set_from_address (add: READABLE_STRING_8)
		require
			well_formed_address: is_valid_address (add)
		do
			from_address := add
		end

	set_reply_to_address (add: like reply_to_address)
		require
			well_formed_address: add = Void or else is_valid_address (add)
		do
			reply_to_address := add
		end

	add_cc_address (add: READABLE_STRING_8)
		require
			well_formed_address: is_valid_address (add)
		local
			lst: like cc_addresses
		do
			lst := cc_addresses
			if lst = Void then
				create lst.make (1)
				cc_addresses := lst
			end
			lst.force (add)
		end

	add_bcc_address (add: READABLE_STRING_8)
		require
			well_formed_address: is_valid_address (add)
		local
			lst: like bcc_addresses
		do
			lst := bcc_addresses
			if lst = Void then
				create lst.make (1)
				bcc_addresses := lst
			end
			lst.force (add)
		end

	reset_cc_addresses
			-- Clear Cc: addresses.
		do
			cc_addresses := Void
		end

	reset_bcc_addresses
			-- Clear Bcc: addresses.
		do
			bcc_addresses := Void
		end

feature -- Header manipulation		

	add_header_line (a_line: READABLE_STRING_8)
		require
			well_formed_header_line: a_line.has (':')
		local
			lst: like additional_header_lines
		do
			lst := additional_header_lines
			if lst = Void then
				create lst.make (1)
				additional_header_lines := lst
			end
			lst.force (a_line)
		end

feature -- Reset

	reset
		do
			reset_addresses
			additional_header_lines := Void
		end

	reset_addresses
			-- Reset all addresses.
		do
			to_addresses.wipe_out
			cc_addresses := Void
			bcc_addresses := Void
		end

feature -- Conversion

	message: STRING_8
		local
			l_content: like content
		do
			Result := header
			Result.append_character ('%N')
			l_content := content
			if l_content.is_empty then
				Result.append_character ('%N')
			else
				Result.append (l_content)
				if l_content[l_content.count] /= '%N' then
					Result.append_character ('%N')
				end
			end
		end

	header: STRING_8
		do
			create Result.make (20)
			if attached reply_to_address as l_reply_to then
				Result.append ("Reply-To: ")
				Result.append (l_reply_to)
				Result.append_character ('%N')
			end
			Result.append ("From: ")
			Result.append (from_address)
			Result.append_character ('%N')
			Result.append ("To: ")
			across
				to_addresses as c
			loop
				Result.append (c.item)
				Result.append_character (';')
			end
			Result.append_character ('%N')
			if
				attached cc_addresses as l_cc and then
				not l_cc.is_empty
			then
				Result.append ("Cc: ")
				across
					l_cc as c
				loop
					Result.append (c.item)
					Result.append_character (';')
				end
				Result.append_character ('%N')
			end
			if
				attached bcc_addresses as l_bcc and then
				not l_bcc.is_empty
			then
				Result.append ("Bcc: ")
				across
					l_bcc as c
				loop
					Result.append (c.item)
					Result.append_character (';')
				end
				Result.append_character ('%N')
			end
			Result.append ("Subject: ")
			Result.append (subject)
			Result.append_character ('%N')
			Result.append ("Date: ")
			;(create {HTTP_DATE}.make_from_date_time (date)).append_to_rfc1123_string (Result)
			Result.append_character ('%N')
			if attached additional_header_lines as l_lines and then
				not l_lines.is_empty
			then
				across
					l_lines as ic
				loop
					Result.append (ic.item)
					Result.append_character ('%N')
				end
			end
		ensure
			Result.ends_with ("%N")
		end

feature -- Helpers

	is_valid_address (add: READABLE_STRING_8): BOOLEAN
			-- Is `add' a valid email address?
		do
				-- FIXME: improve email validation
			Result := add.has ('@')
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
