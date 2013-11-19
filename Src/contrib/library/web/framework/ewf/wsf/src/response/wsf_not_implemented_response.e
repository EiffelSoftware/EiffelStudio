note
	description: "[
				This class is used to report a 501 not implemented
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_NOT_IMPLEMENTED_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

	SHARED_HTML_ENCODER

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST)
		do
			create header.make
			request := req
		end

feature -- Header

	header: HTTP_HEADER
			-- Response' header

	request: WSF_REQUEST
			-- Associated request.

	body: detachable READABLE_STRING_8
			-- Optional body
			-- Displayed as extra content

feature -- Element change

	set_body (b: like body)
			-- Set `body' to `b'
		do
			body := b
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			s: STRING
			h: like header
		do
			h := header
			res.set_status_code ({HTTP_STATUS_CODE}.not_implemented)

			s := "Error 501 Not Implemented ! "
			s.append (request.request_method)
			s.append (" ")
			s.append (request.request_uri)
			if attached body as b then
				s.append ("%N")
				s.append (b)
				s.append ("%N")
			end
			h.put_content_type_text_plain
			h.put_content_length (s.count)
			res.put_header_text (h.string)
			res.put_string (s)
			res.flush
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
