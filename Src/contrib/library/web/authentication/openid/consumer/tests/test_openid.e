note
	description: "Summary description for {TEST_OPENID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OPENID

create
	make

feature

	make
		local
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION
			id: READABLE_STRING_8
		do
			id := "https://www.google.com/accounts/o8/id"
			create o.make ("http://localhost")
			if attached o.auth_url (id) as l_url then
				check o.error = Void end
				get_openid_response_uri (l_url)
				if attached openid_response_uri as u and then u.is_valid then
					create v.make_from_items (o, u.decoded_query_items)
					v.validate
					if v.is_valid then
						print ("Succeed ...%N")
					else
						print ("Failed !!!%N")
					end
				else
					print ("Failed !!!%N")
				end
			elseif attached o.error as l_err then
				print (l_err)
			else
				print ("???")
			end
		end

	get_openid_response_uri	(a_auth_url: READABLE_STRING_8)
		local
			f: RAW_FILE
			e: EXECUTION_ENVIRONMENT
		do
			openid_response_uri := Void

			create f.make_create_read_write ("openid_tmp.html")
			f.put_string ("<a href=%"" + a_auth_url + "%">Click to authenticate with openid</a>")
			f.put_new_line
			f.close

			create e
			e.system ("start " + f.name)

			io.put_string ("Returned URL (copy/paste the url from your browser's address bar )?%N")
			io.read_line

			create openid_response_uri.make_from_string (io.last_string)
		end

	openid_response_uri: detachable URI

feature -- Access

end
