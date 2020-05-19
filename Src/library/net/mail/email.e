note
	description: "Email Object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "david s"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL

inherit
	MEMORY_RESOURCE

create
	make, make_with_entry

feature {NONE} -- Initialization

	make
			-- Initialize the headers table.
		do
			create headers.make (3)
			mail_message := ""
			mail_signature := ""
		end

	make_with_entry (header_from, header_to: READABLE_STRING_8)
			-- Create an email with the 'header_from' and the 'header_to'.
		require
			needed_info: header_from /= Void and then header_to /= Void
		do
			make
			add_sender_address (header_from)
			add_recipient_address (header_to)
		end

feature {NONE} -- Basic operations.

	transfer (resource: PROTOCOL_RESOURCE)
			-- Used when the mailer will receive an email from 'resource'.
		do

		end

feature -- Sender change

	add_sender_address (a_sender: READABLE_STRING_8)
			-- Added `a_sender' address to "From:" entries.
		do
			add_header_entry (H_from, a_sender)
		end

feature -- Recipient change

	add_recipient_address (a_recipient: READABLE_STRING_8)
			-- Added `a_recipient' address to "To:" entries.
		do
			add_header_entries (H_to, splitted_recipients_from (a_recipient))
		end

	add_recipient_address_in_cc (a_recipient: READABLE_STRING_8)
			-- Added `a_recipient' address to "Cc:" entries.
		do
			add_header_entries (H_cc, splitted_recipients_from (a_recipient))
		end

	add_recipient_address_in_bcc (a_recipient: READABLE_STRING_8)
			-- Added `a_recipient' address to "BCc:" entries.
		do
			add_header_entries (H_bcc, splitted_recipients_from (a_recipient))
		end

feature -- Status report

	has_header_entry (header_key: STRING_8): BOOLEAN
		do
			Result:= headers.has (header_key)
		end

feature -- Entries changes

	add_header_entry (header_key, header_entry: READABLE_STRING_8)
			-- Add 'header_entry' to header 'header_key',
			-- If no such header exists, create it.
		require
			not_void: header_entry /= Void and then header_key /= Void
		do
			if attached headers.item (header_key) as l_h then
				l_h.add_entry (header_entry)
			else
				headers.put (create {HEADER}.make (header_entry), header_key)
			end
		end

	add_header_entries (header_key: STRING_8; header_entries: ITERABLE [READABLE_STRING_8])
			-- Add multiple 'header_entries' at once  to 'header_key',
			-- If not such header exists. create it.
		do
			if attached headers.item (header_key) as l_h then
				l_h.add_entries (header_entries)
			else
				headers.put (create {HEADER}.make_with_entries (header_entries), header_key)
			end
		end

	remove_header_entry (header_key, header_entry: STRING_8)
			-- Remove 'header_entry' from header 'header_key' if present.
		do
			if attached headers.item (header_key) as l_header then
				l_header.entries.prune (header_entry)
			end
		ensure
			header_entry_no_longer_exists:
				attached headers.item (header_key) as l_header_after implies not l_header_after.entries.has (header_entry)
		end

	remove_header_entries (header_key: STRING_8)
			-- Remove all header entries from header 'header_key' if present.	
		do
			if attached headers.item (header_key) as l_header then
				l_header.entries.wipe_out
			end
		ensure
			wiped_out: attached headers.item (header_key) as l_header implies l_header.entries.is_empty
		end

feature -- Basic operations

	send
			-- Send email.
		do

		end

	receive
			-- Receive email.
		do

		end

feature -- Implementation (EMAIL_RESOURCE)

	splitted_recipients_from (a_recipient_value: READABLE_STRING_8): ARRAYED_LIST [READABLE_STRING_8]
			-- List of individual recipients from `a_recipient_value`.
			-- Mainly to support input with multiple recipient addresses.
		local
			i,j,n: INTEGER
			p: INTEGER
			s: READABLE_STRING_8
		do
			create Result.make (1)
			n := a_recipient_value.count
			from
				i := 1
				j := 1
			until
				i > n
			loop
				inspect a_recipient_value[i]
				when '"' then
					p := a_recipient_value.index_of ('%"', i + 1)
					if p > 0 then
						i := p
					end
				when '<' then
					p := a_recipient_value.index_of ('>', i + 1)
					if p > 0 then
						i := p
					end
				when ',' then
					s := a_recipient_value.substring (j, i - 1)
					if not s.is_whitespace then
						Result.force (s)
					end
					from
					until
						i + 1 > n or not a_recipient_value[i + 1].is_space
					loop
						i := i + 1
					end
					j := i + 1
				else
				end
				i := i + 1
			end
			if j < n then
				s := a_recipient_value.substring (j, n)
				if not s.is_whitespace then
					Result.force (s)
				end
			end
		end

	can_be_received: BOOLEAN = True
			-- Can an email received?

	can_be_sent: BOOLEAN
			-- Can an email be send?
		do
			Result := header (h_from) /= Void and header (h_to) /= Void
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
