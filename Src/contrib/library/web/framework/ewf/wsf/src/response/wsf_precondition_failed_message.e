note
	description: "[
				This class is used to report a 412 Precondition Failed page
		]"
	date: "$Date$"
	revision: "$Revision$"

class	WSF_PRECONDITION_FAILED_MESSAGE

inherit

	WSF_RESPONSE_MESSAGE

	SHARED_HTML_ENCODER

create

	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST)
			-- Initialize setting `request' from `req'.
		do
			request := req
			create header.make
		ensure
			req_aliased: request = req
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
			res.set_status_code ({HTTP_STATUS_CODE}.precondition_failed)

			if request.is_content_type_accepted ({HTTP_MIME_TYPES}.text_html) then
				s := "<html lang=%"en%"><head>"
				s.append ("<title>")
				s.append (html_encoder.encoded_string (request.request_uri))
				s.append ("Error 412 (Precondition Failed)")
				s.append ("</title>%N")
				s.append ("[
						<style type="text/css">
						div#header {color: #fff; background-color: #000; padding: 20px; width: 100%; text-align: center; font-size: 2em; font-weight: bold;}
						div#message { margin: 40px; width: 100%; text-align: center; font-size: 1.5em; }
						div#footer {color: #999; background-color: #eee; padding: 10px; width: 100%; text-align: center; }
						div#logo { float: right; margin: 20px; width: 60px height: auto; font-size: 0.8em; text-align: center; }
						div#logo div.outter { padding: 6px; width: 60px; border: solid 3px #500; background-color: #b00;}
						div#logo div.outter div.inner1 { display: block; margin: 10px 15px;  width: 30px; height: 50px; color: #fff; background-color: #fff; border: solid 2px #900; }
						div#logo div.outter div.inner2 { margin: 10px 15px; width: 30px; height: 15px; color: #fff; background-color: #fff; border: solid 2px #900; }
						</style>
						</head>
						<body>
						<div id="header">Error 412 (Precondition Failed)</div>
						]")
				s.append ("<div id=%"logo%">")
				s.append ("<div class=%"outter%"> ")
				s.append ("<div class=%"inner1%"></div>")
				s.append ("<div class=%"inner2%"></div>")
				s.append ("</div>")
				s.append ("Error 412 (Precondition Failed)</div>")
				s.append ("<div id=%"message%">Error 412 (Precondition Failed): <code>" + html_encoder.encoded_string (request.request_uri) + "</code></div>")
				if attached body as b then
					s.append ("<div>")
					s.append (b)
					s.append ("</div>%N")
				end

				s.append ("<div id=%"footer%"></div>")
				s.append ("</body>%N")
				s.append ("</html>%N")

				h.put_content_type_text_html
			else
				s := "Error 412 (Precondition Failed): "
				s.append (request.request_uri)
				s.append_character ('%N')
				if attached body as b then
					s.append ("%N")
					s.append (b)
					s.append ("%N")
				end

				h.put_content_type_text_plain
			end
			h.put_content_length (s.count)
			res.put_header_text (h.string)
			res.put_string (s)
			res.flush
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
