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
			h: LIBCURL_HTTP_CLIENT
			sess: HTTP_CLIENT_SESSION
			resp : detachable HTTP_CLIENT_RESPONSE
			l_location : detachable READABLE_STRING_8
			body : STRING
		do
			create h.make
			sess := h.new_session ("http://127.0.0.1:9090")
-- Uncomment the following 2 lines, if you use fiddler2 web debugging tool
--			sess.set_is_debug (True)
--			sess.set_proxy ("127.0.0.1", 8888)

			-- Create Order
			print ("%N Create Order %N")
			resp := create_order (sess)


			-- Read the Order
			print ("%N Read Order %N")
			l_location := resp.header ("Location")
			resp := read_order (sess, l_location)


			-- Update the Order
			if resp /= Void and then attached resp.body as l_body then
				body := l_body.as_string_8
				body.replace_substring_all ("takeAway", "in Shop")
				print ("%N Update Order %N")
				resp := update_order (sess, l_location, body)
			end
		end

	update_order ( sess: HTTP_CLIENT_SESSION; uri : detachable READABLE_STRING_8; a_body : STRING): detachable HTTP_CLIENT_RESPONSE
		local
			context : HTTP_CLIENT_REQUEST_CONTEXT
		do
			if attached uri as l_uri then
				sess.set_base_url (l_uri)
				create context.make
				context.headers.put ("application/json", "Content-Type")
				Result := sess.put ("", context, a_body )
				-- Show headers
				across
 					Result.headers as l_headers
				loop
					print (l_headers.item.name)
					print (":")
					print (l_headers.item.value)
					io.put_new_line
				end

				-- Show body
				print (Result.body)
				io.put_new_line
			end
		end


	read_order ( sess: HTTP_CLIENT_SESSION; uri : detachable READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			if attached uri as l_uri then
				sess.set_base_url (l_uri)
				Result := sess.get ("", Void)
					-- Show headers
				across
					Result.headers as l_headers
				loop
					print (l_headers.item.name)
					print (":")
					print (l_headers.item.value)
					io.put_new_line
				end

				-- Show body
				print (Result.body)
				io.put_new_line
			end
		end



	create_order (sess: HTTP_CLIENT_SESSION) : HTTP_CLIENT_RESPONSE
		local
			s: READABLE_STRING_8
			j: JSON_PARSER
			id: detachable STRING
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
			-- Show the Headers
			across
				Result.headers as l_headers
			loop
				print (l_headers.item.name)
				print (":")
				print (l_headers.item.value)
				io.put_new_line
			end


			-- Show the Response body
			if attached Result.body as m then
				create j.make_with_string (m)
				j.parse_content
				if j.is_valid and then attached j.parsed_json_object as j_o then
					if attached {JSON_STRING} j_o.item ("id") as l_id then
						id := l_id.item
					end
					print (m)
					io.put_new_line
				end
			end
		end


feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
