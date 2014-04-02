note
	description: "Summary description for {ESA_CONTEXT_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONTEXT_FACTORY


feature -- Factories

	cj_context_executor: HTTP_CLIENT_REQUEST_CONTEXT
			-- request context for each request
		do
			create Result.make
			Result.headers.put ("application/vnd.collection+json", "Content-Type")
			Result.headers.put ("application/vnd.collection+json", "Accept")
		end

	text_context_executor: HTTP_CLIENT_REQUEST_CONTEXT
			-- request context for each request
		do
			create Result.make
			Result.headers.put ("text/html", "Content-Type")
			Result.headers.put ("text/html", "Accept")
		end

	unknown_context_executor: HTTP_CLIENT_REQUEST_CONTEXT
			-- request context for each request
		do
			create Result.make
			Result.headers.put ("unknown", "Content-Type")
			Result.headers.put ("unknown", "Accept")
		end

end
