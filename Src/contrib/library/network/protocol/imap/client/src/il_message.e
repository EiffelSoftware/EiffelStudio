note
	description: "A message"
	author: "Basile Maret"

class
	IL_MESSAGE

inherit
	IL_CONSTANTS

create
	make_from_fetch

feature {NONE} -- Initialization

	make_from_fetch (a_fetch: IL_FETCH)
			-- Create a message from `a_fetch'
		require
			a_fetch_not_void: a_fetch /= Void
		local
			l_parser: IL_MESSAGE_PARSER
			l_number_of_lines: STRING
		do
			create l_parser.make_from_fetch (a_fetch)
			sequence_number := a_fetch.sequence_number
			uid := a_fetch.value (uid_data_item).to_integer
			body_text := a_fetch.value (text_data_item)
			body_size := a_fetch.size (text_data_item)
			size := a_fetch.value (size_data_item).to_integer
			flags := a_fetch.value (flags_data_item).split (' ')

			header_text := a_fetch.value (header_data_item)
			create header_parser.make_from_text (header_text)

			from_address := l_parser.get_from
			reply_to := l_parser.get_addresses_from_envelope (3)
			to_address := l_parser.get_addresses_from_envelope (4)
			cc := l_parser.get_addresses_from_envelope (5)
			bcc := l_parser.get_addresses_from_envelope (6)
			subject := l_parser.subject
			date := l_parser.date
			date_string := l_parser.date_string
			internaldate := l_parser.internaldate

			mailbox_name := current_mailbox.name

			body_type := l_parser.body_field (2)
			body_subtype := l_parser.body_field (4)
			body_id := l_parser.body_field (12)
			body_description := l_parser.body_field (14)
			body_encoding := l_parser.body_field (16)
			l_number_of_lines := l_parser.body_field (18)
			if l_number_of_lines /~ "NIL" and not l_number_of_lines.is_empty then
				body_number_of_lines := l_number_of_lines.to_integer
			else
				body_number_of_lines := -1
			end

		end

feature -- Access

	mailbox_name: STRING
			-- The name of the mailbox in which the message is stored

	uid: INTEGER
			-- The uid of the message

	sequence_number: NATURAL
			-- The sequence number of the message

	header_text: STRING
			-- The raw text of the header

	body_type: STRING
			-- The type of the body
			-- This field is not supported for multipart messages
	body_subtype: STRING
			-- The subtype of the body
			-- This field is not supported for multipart messages
	body_id: STRING
			-- The content id
			-- This field is not supported for multipart messages
	body_description: STRING
			-- The content description
			-- This field is not supported for multipart messages
	body_encoding: STRING
			-- The content transfer encding
			-- This field is not supported for multipart messages
	body_number_of_lines: INTEGER
			-- The number of lines of the body
			-- This field is not supported for multipart messages

	body_text: STRING
			-- The text of the body

	body_size: INTEGER
			-- The size of the body

	size: INTEGER
			-- The total size of the message

	flags: LIST [STRING]
			-- The flags of the message

	date: DATE_TIME
			-- The date of the message

	date_string: STRING
			-- The date of the message as stored in the envelope

	internaldate: DATE_TIME
			-- The internal date of the message

	subject: STRING
			-- The subject of the message

	from_address: IL_ADDRESS
			-- The address the message comes from

	to_address: LIST [IL_ADDRESS]
			-- The addresses the message was sent to

	cc: LIST [IL_ADDRESS]
			-- The addresses of the cc field

	bcc: LIST [IL_ADDRESS]
			-- The addresses of the bcc field

	reply_to: LIST [IL_ADDRESS]
			-- The addresses of the reply to field

feature -- Basic operation

	header_field (a_field_name: STRING): STRING
			-- Return the data for the field `a_field_name'
			-- It is recommended that `a_field_name' starts with an upper case char
		require
			a_field_name_not_empty: a_field_name /= Void and then not a_field_name.is_empty
		do
			Result := header_parser.field (a_field_name)
		end

feature {NONE} -- Implementation

	header_parser: IL_HEADER_PARSER
			-- A parser for the header

;note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
