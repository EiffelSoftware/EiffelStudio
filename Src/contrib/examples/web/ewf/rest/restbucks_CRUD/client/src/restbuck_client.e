note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	RESTBUCK_CLIENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			h: NET_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			resp : detachable HTTP_CLIENT_RESPONSE
			l_location : detachable READABLE_STRING_8
			body : STRING
		do
			create h
			sess := h.new_session ("http://127.0.0.1:" + server_port.out)
-- Uncomment the following 2 lines, if you use fiddler2 web debugging tool
--			sess.set_is_debug (True)
--			sess.set_proxy ("127.0.0.1", 8888)

				-- Create Order
			print ("> Create Order %N")
			resp := create_order (sess)
			display_response (resp)


				-- Read the Order
			l_location := resp.header ("Location")
			if l_location /= Void then
				print ("> Read Order from " + l_location + " %N")
				resp := read_order (sess, l_location)
				display_response (resp)
			else
				print ("> Previous order creation failed, no location returned!%N")
			end

				-- Update the Order
			if resp /= Void and then attached resp.body as l_body then
				body := l_body.as_string_8
				body.replace_substring_all ("takeAway", "in Shop")
				print ("> Update Order: change location from [takeAway] to [in Shop] %N")
				resp := update_order (sess, l_location, body)
				display_response (resp)
			end

				-- Pay the Order
			if resp /= Void and then attached resp.body as l_body then
				body := l_body.as_string_8
				body.replace_substring_all ("%"status%":%"submitted%"", "%"status%":%"paid%"")
				print ("> Pay Order: should trigger validation error!%N")
				resp := update_order (sess, l_location, body)
				display_response (resp)
			end
		end

	update_order (sess: HTTP_CLIENT_SESSION; uri: detachable READABLE_STRING_8; a_body: STRING): detachable HTTP_CLIENT_RESPONSE
		local
			context : HTTP_CLIENT_REQUEST_CONTEXT
		do
			if uri /= Void then
				sess.set_base_url (uri)
				create context.make
				context.headers.put ("application/json", "Content-Type")
				Result := sess.put ("", context, a_body )
			end
		end

	read_order (sess: HTTP_CLIENT_SESSION; uri: detachable READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			if uri /= Void then
				sess.set_base_url (uri)
				Result := sess.get ("", Void)
			end
		end

	create_order (sess: HTTP_CLIENT_SESSION) : HTTP_CLIENT_RESPONSE
		local
			s: READABLE_STRING_8
			context : HTTP_CLIENT_REQUEST_CONTEXT
		do
			s := "[
			  	      {
						"location":"takeAway",
						"items":[
						        {
						        "name":"Late",
						        "option":"skim",
						        "size":"Small",
						        "quantity":1
						        }
						    ]
						}
				]"

			create context.make
			context.headers.put ("application/json", "Content-Type")
			Result := sess.post ("/order", context, s)
		end

	display_response (resp: detachable HTTP_CLIENT_RESPONSE)
		do
			io.error.put_string (create {STRING}.make_filled ('-', 40))
			io.error.put_new_line
			if resp = Void then
				io.error.put_string ("ERROR: No response~%N")
			else
				if resp.error_occurred and attached resp.error_message as err_msg then
					io.error.put_string ("[ERROR] ")
					io.error.put_string (err_msg)
					io.error.put_new_line
				end

					-- Display response status and header
				io.error.put_string ("Status code: " + resp.status.out + "%N")
				across
					resp.headers as l_headers
				loop
					io.error.put_string (l_headers.item.name)
					io.error.put_string (":")
					io.error.put_string (l_headers.item.value)
					io.error.put_new_line
				end

					-- Show the Response body
				if not resp.error_occurred and attached resp.body as m then
					io.error.put_string (m)
					io.error.put_new_line
				end
			end
			io.error.put_string (create {STRING}.make_filled ('-', 40))
			io.error.put_new_line
		end

feature {NONE} -- Implementation

	server_port: INTEGER
		local
			f: PLAIN_TEXT_FILE
			p: PATH
			s: STRING
		do
			create p.make_current
			p := p.extended ("..").extended ("server.ini")
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file or Result > 0
				loop
					f.read_line
					s := f.last_string
					if s.starts_with_general ("port=") then
						s.remove_head (5)
						if s.is_integer then
							Result := s.to_integer
						end
					end
				end
				f.close
			end
			if Result <= 0 then
				Result := 80
			end
		end

end
