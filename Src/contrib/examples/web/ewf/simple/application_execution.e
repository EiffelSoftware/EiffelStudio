note
	description : "simple application execution"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Basic operations

	execute
		local
			s: STRING
		do
			-- To send a response we need to setup, the status code and
			-- the response headers.
			s := "Hello World!"
			response.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/html"], ["Content-Length", s.count.out]>>)
			response.set_status_code ({HTTP_STATUS_CODE}.ok)
			response.header.put_content_type_text_html
			response.header.put_content_length (s.count)
			if attached request.http_connection as l_connection and then l_connection.is_case_insensitive_equal_general ("keep-alive") then
				response.header.put_header_key_value ("Connection", "keep-alive")
			end
			response.put_string (s)
		end

end
