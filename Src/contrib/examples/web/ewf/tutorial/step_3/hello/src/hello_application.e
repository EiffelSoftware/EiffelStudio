note
	description: "[
				This class implements the `Hello World' service.

				It inherits from WSF_DEFAULT_RESPONSE_SERVICE to get default EWF connector ready
				only `response' needs to be implemented.
				In this example, it is redefined and specialized to be WSF_PAGE_RESPONSE

				`initialize' can be redefine to provide custom options if needed.

			]"

class
	HELLO_APPLICATION

inherit
	WSF_DEFAULT_RESPONSE_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Execution

	response (req: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Computed response message.
		do
			--| It is now returning a WSF_HTML_PAGE_RESPONSE
			--| Since it is easier for building html page
			create Result.make
			Result.set_title ("EWF tutorial / Hello World!")
			--| Check if the request contains a parameter named "user"
			--| this could be a query, or a form parameter
			if attached req.string_item ("user") as l_user then
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
			--|		 req.query_parameter ("user") to search only in the query string
			--|		 req.form_parameter ("user") to search only in the form parameters
			--| 2) response type
			--| 	it could also have used WSF_PAGE_REPONSE, and build the html in the code
			--|

		end

feature {NONE} -- Initialization

	initialize
		do
				--| Uncomment the following line, to be able to load options from the file ewf.ini
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")

				--| You can also uncomment the following line if you use the Nino connector
				--| so that the server listens on port 9999
				--| quite often the port 80 is already busy
--			set_service_option ("port", 9999)

				--| Uncomment next line to have verbose option if available
--			set_service_option ("verbose", True)

				--| If you don't need any custom options, you are not obliged to redefine `initialize'
			Precursor
		end


end
