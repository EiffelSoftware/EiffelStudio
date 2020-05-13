note
	description: "[
			Notification mailer based on STMP protocol.

			Note: it is based on EiffelNet {SMTP_PROTOCOL} implementation, and may not be complete.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_SMTP_MAILER

inherit
	NOTIFICATION_MAILER

create
	make,
	make_with_user

feature {NONE} -- Initialization

	make (a_smtp_server: READABLE_STRING_8)
			-- Create with smtp setting `user:password@hostname:port".
		local
			p,q: INTEGER
		do
			p := a_smtp_server.index_of ('@', 1)
			if p > 0 then
				q := a_smtp_server.index_of (':', 1)
				if q < p then
					make_with_user (a_smtp_server.substring (p + 1, a_smtp_server.count), a_smtp_server.substring (1,  q -1), a_smtp_server.substring (q + 1,  p -1))
				else
					make_with_user (a_smtp_server.substring (p + 1, a_smtp_server.count), a_smtp_server.substring (1,  p -1), Void)
				end
			else
				make_with_user (a_smtp_server, Void, Void)
			end
		end

	make_with_user (a_smtp_server: READABLE_STRING_8; a_user: detachable READABLE_STRING_8; a_password: detachable READABLE_STRING_8)
			-- Initialize `Current'.
		local
			i: INTEGER
		do
			i := a_smtp_server.index_of (':', 1)
			if i > 0 then
				smtp_host := a_smtp_server.substring (1, i - 1)
				smtp_port := a_smtp_server.substring (i + 1, a_smtp_server.count).to_integer
			else
				smtp_host := a_smtp_server
				smtp_port := 0
			end
			username := a_user
			initialize
		end

	initialize
			-- Initialize service.
		do
			if attached username as u then
				create smtp_protocol.make (smtp_host, u)
			else
					-- Get local host name needed in creation of SMTP_PROTOCOL.
				create smtp_protocol.make (smtp_host, (create {INET_ADDRESS_FACTORY}).create_localhost.host_name)
			end
			if smtp_port > 0 then
				smtp_protocol.set_default_port (smtp_port)
			end
			reset_errors
		end

	smtp_protocol: SMTP_PROTOCOL
			-- SMTP protocol.

feature -- Access

	smtp_host: READABLE_STRING_8

	smtp_port: INTEGER

	username: detachable READABLE_STRING_8

feature -- Status

	is_available: BOOLEAN
		do
			Result := True
		end

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
			-- Process the sending of `a_email'
		local
			l_email: EMAIL
			h: STRING_8
			i: INTEGER
			lst: LIST [READABLE_STRING_8]
		do
			lst := a_email.to_addresses
			if lst.is_empty then
					-- Error ...
			else
					-- With EMAIL, there should be a unique recipient at creation.
				create l_email.make_with_entry (a_email.from_address, lst.first)
				if lst.count > 1 then
					from
						lst.start
						lst.forth
					until
						lst.off
					loop
						l_email.add_recipient_address (lst.item)
						lst.forth
					end
				end
				if attached a_email.reply_to_address as l_reply_to then
					l_email.add_header_entry ({EMAIL_CONSTANTS}.h_reply_to, l_reply_to)
				end

				if attached a_email.cc_addresses as l_cc_addresses then
					across
						l_cc_addresses as ic
					loop
						l_email.add_recipient_address_in_cc (ic.item)
					end
				end
				if attached a_email.bcc_addresses as l_bcc_addresses then
					across
						l_bcc_addresses as ic
					loop
						l_email.add_recipient_address_in_bcc (ic.item)
					end
				end
				l_email.set_message (a_email.content)
				l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, a_email.subject)

				create h.make_empty
				;(create {HTTP_DATE}.make_from_date_time (a_email.date)).append_to_rfc1123_string (h)
				l_email.add_header_entry ("Date", h)

				if attached a_email.additional_header_lines as l_lines then
					across
						l_lines as ic
					loop
						h := ic.item.to_string_8
						i := h.index_of (':', 1)
						if i > 0 then
							l_email.add_header_entry (h.head (i - 1), h.substring (i + 1, h.count))
						else
							check is_header_line: False end
						end
					end
				end

				smtp_send_email (l_email)

			end
		end

feature {NONE} -- Implementation

	addresses_to_header_line_value (lst: ITERABLE [READABLE_STRING_8]): STRING
		local
			l_need_separator: BOOLEAN
		do
			create Result.make (10)
			l_need_separator := False
			across
				lst as ic
			loop
				if l_need_separator then
					Result.append_character (',')
					Result.append_character (' ')
				else
					l_need_separator := True
				end
				Result.append (ic.item)
			end
		end

	smtp_send_email (a_email: EMAIL)
			-- Send the email represented by `a_email'.
		local
			retried: BOOLEAN
		do
			if not retried then
				smtp_protocol.initiate_protocol
				smtp_protocol.transfer (a_email)
				smtp_protocol.close_protocol
				if smtp_protocol.error then
					report_error ("smtp_protocol reported an error.")
				end
			end
		rescue
			report_error ("smtp_protocol raised an exception.")
			retried := True
			retry
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
