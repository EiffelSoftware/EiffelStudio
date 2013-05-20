
class HTTP_RESPONSE

inherit
	HTTP_CONSTANTS
		redefine
			default_create
		end

create
	default_create

feature -- creation

	default_create
		do
			Precursor
			set_defaults
		end

	set_defaults
			-- Set default values for the reply	
		do
			status_code := ok
			create content_length_data.make_empty
			reason_phrase := ok_message
			content_type_data := text_html
			set_reply_text (Void)
		end

feature -- Recycle

	reset
		do
			set_defaults
		end

feature -- response header fields

	status_code: STRING
			-- status

	content_length_data : STRING
			-- length		

	reason_phrase: STRING
			-- message, if any

	content_type_data: STRING
			-- type of content in this reply (eg. text/html)

feature -- Element change

	set_content_length (new_content_length: INTEGER)
		require
			positive_or_zero: new_content_length >= 0
		do
			content_length_data := new_content_length.out
		end

	set_status_code (new_status_code: STRING)
		require
			not_void: new_status_code /= Void
		do
			status_code := new_status_code
		end

	set_reason_phrase (new_reason_phrase: STRING)
		require
			not_void: new_reason_phrase /= Void
		do
			reason_phrase := new_reason_phrase
		end

	set_content_type (new_content_type: STRING)
		require
			not_void: new_content_type /= Void
		do
			content_type_data := new_content_type
		end

feature -- Access: send reply

	reply_header: STRING
			-- header
		do
			Result := http_version_1_1.twin
			Result.extend (' ')
			Result.append (status_code)
			Result.extend (' ')
			Result.append (reason_phrase)
			Result.append (crlf)
			Result.append ({HTTP_SERVER_CONFIGURATION}.Server_details)
			Result.append (crlf)
			Result.append (Content_type + ": ")
			Result.append (content_type_data)
			Result.append (crlf)
			Result.append (Content_length + ": ")
			Result.append (content_length_data)
			Result.append (crlf)
			Result.append (crlf)
			-- TODO: could add the size of data being sent here and
			-- then keep the connection alive
		end

	reply_header_continue: STRING
			-- header
		do
			Result := http_version_1_1.twin
			Result.extend (' ')
			Result.append (status_code)
			Result.extend (' ')
			Result.append (continue_message)
			Result.append (crlf)
			Result.append (crlf)
			-- TODO: could add the size of data being sent here and
			-- then keep the connection alive
		end

	reply_text: STRING
			-- reply text

feature -- Change element: send reply

	set_reply_text (new_text: detachable STRING)
			-- text could be Void
		do
			if new_text = Void then
				create reply_text.make_empty
			else
				reply_text := new_text
			end
		end

	append_reply_text (more_text: STRING)
			-- add more text to the reply
		require
			reply_text /= Void
			more_text /= Void
		do
			reply_text.append (more_text)
		end

note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
