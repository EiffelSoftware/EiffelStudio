note
	description: "Implementation of Hello world with form."
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO_EXECUTION

inherit
	WSF_MESSAGE_EXECUTION

create
	make

feature {NONE} -- Execution

	message: WSF_HTML_PAGE_RESPONSE
			-- Computed response message.
		do
			--| It is now returning a WSF_HTML_PAGE_RESPONSE
			--| Since it is easier for building html page
			create Result.make
			Result.set_title ("EWF tutorial / Hello World!")
			--| Check if the request contains a parameter named "user"
			--| this could be a query, or a form parameter
			if attached request.string_item ("user") as l_user then
				--| If yes, say hello world #name
				Result.set_body ("Hello " + l_user + "!")
				--| We should html encode this name
				--| but to keep the example simple, we don't do that for now.
			else
				--| Otherwise, ask for name
				Result.set_body ("[
							<form action="/" method="POST">
								<p>Hello, what is your name?</p>
								<input type="text" name="user"/>
								<input type="submit" value="Validate"/>
							</form>
						]"
					)
			end

			--| note:
			--| 1) Source of the parameter, we could have used
			--|		 request.query_parameter ("user") to search only in the query string
			--|		 request.form_parameter ("user") to search only in the form parameters
			--| 2) response type
			--| 	it could also have used WSF_PAGE_REPONSE, and build the html in the code
			--|

		end

end
