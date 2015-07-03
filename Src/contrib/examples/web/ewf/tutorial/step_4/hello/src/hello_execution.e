note
	description: "[
				This class implements the `Hello World' execution service.

				It inherits from WSF_ROUTED_EXECUTION to use the router service
				and from WSF_ROUTED_URI_TEMPLATE_HELPER to use help feature to map
					uri-template routes
			]"

class
	HELLO_EXECUTION

inherit
	WSF_ROUTED_EXECUTION

	WSF_ROUTED_URI_HELPER
	WSF_ROUTED_URI_TEMPLATE_HELPER

create
	make

feature {NONE} -- Initialization

	setup_router
		do
--			router.map (create {WSF_URI_MAPPING}.make ("/hello", create {WSF_AGENT_URI_HANDLER}.make (agent execute_hello)))
			map_uri_agent ("/hello", agent execute_hello, Void)

--			router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/users/{user}/message/{mesgid}", create {USER_MESSAGE_HANDLER}), router.methods_HEAD_GET_POST)
			map_uri_template ("/users/{user}/message/{mesgid}", create {USER_MESSAGE_HANDLER}, router.methods_HEAD_GET_POST)

--			router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/users/{user}/message/", create {USER_MESSAGE_HANDLER}), router.methods_GET_POST)
			map_uri_template ("/users/{user}/message/", create {USER_MESSAGE_HANDLER}, router.methods_GET_POST)

--			router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/users/{user}/{?op}", create {WSF_AGENT_URI_TEMPLATE_RESPONSE_HANDLER}.make (agent response_user)), router.methods_GET)
			map_uri_template_response_agent ("/users/{user}/{?op}", agent response_user, router.methods_GET)
		end

feature -- Execution

	execute_hello (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Computed response message.
		local
			mesg: WSF_HTML_PAGE_RESPONSE
			s: STRING_8
			l_user_name: READABLE_STRING_32
		do
			--| It is now returning a WSF_HTML_PAGE_RESPONSE
			--| Since it is easier for building html page
			create mesg.make
			mesg.set_title ("EWF tutorial / Hello World!")
			--| Check if the request contains a parameter named "user"
			--| this could be a query, or a form parameter
			if attached {WSF_STRING} req.item ("user") as u then
				--| If yes, say hello world #name

				l_user_name := (create {HTML_ENCODER}).decoded_string (u.value)

				s := "<p>Hello " + mesg.html_encoded_string (l_user_name) + "!</p>"
				s.append ("Display a <a href=%"/users/" + u.url_encoded_value + "/message/%">message</a></p>")
				s.append ("<p>Click <a href=%"/users/" + u.url_encoded_value + "/?op=quit%">here</a> to quit.</p>")
				mesg.set_body (s)
				--| We should html encode this name
				--| but to keep the example simple, we don't do that for now.
			else
				--| Otherwise, ask for name
				s := (create {HTML_ENCODER}).encoded_string ({STRING_32} "Hello / ahoj / नमस्ते / Ciào / مرحبا / Hola / 你好 / Hallo / Selam / Bonjour ")
				s.append ("[
							<form action="/hello" method="GET">
								What is your name?</p>
								<input type="text" name="user"/>
								<input type="submit" value="Validate"/>
							</form>
						]"
					)
				mesg.set_body (s)
			end

			--| note:
			--| 1) Source of the parameter, we could have used
			--|		 req.query_parameter ("user") to search only in the query string
			--|		 req.form_parameter ("user") to search only in the form parameters
			--| 2) response type
			--| 	it could also have used WSF_PAGE_REPONSE, and build the html in the code
			--|

			res.send (mesg)
		end

	response_user (req: WSF_REQUEST): WSF_RESPONSE_MESSAGE
			-- Computed response message.
		local
			html: WSF_HTML_PAGE_RESPONSE
			redir: WSF_HTML_DELAYED_REDIRECTION_RESPONSE
			s: STRING_8
			l_username: STRING_32
		do
			if attached {WSF_STRING} req.path_parameter ("user") as u then
				l_username := (create {HTML_ENCODER}).general_decoded_string (u.value)
				if
					attached {WSF_STRING} req.query_parameter ("op") as l_op
				then
					if l_op.is_case_insensitive_equal ("quit") then
						create redir.make (req.script_url ("/hello"), 3)
						create html.make
						redir.set_title ("Bye " + html.html_encoded_string (l_username))
						redir.set_body ("Bye " + html.html_encoded_string (l_username) + ",<br/> see you soon.<p>You will be redirected to " +
										redir.url_location + " in " + redir.delay.out + " second(s) ...</p>"
								)
						Result := redir
					else
						create html.make
						html.set_title ("Bad request")
						html.set_body ("Bad request: unknown operation '" + l_op.url_encoded_value + "'.")
						Result := html
					end
				else
					create html.make

					s := "<p>User <em>'" + html.html_encoded_string (l_username)  + "'</em>!</p>"
					s.append ("Display a <a href=%"/users/" + u.url_encoded_value + "/message/%">message</a></p>")
					s.append ("<p>Click <a href=%"/users/" + u.url_encoded_value + "/?op=quit%">here</a> to quit.</p>")
					html.set_title ("User '" + u.url_encoded_value + "'")
					html.set_body (s)
					Result := html
				end
			else
				create html.make
				html.set_title ("Bad request")
				html.set_body ("Bad request: missing user parameter")
				Result := html
			end
		end

end
