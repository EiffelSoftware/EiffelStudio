note
	description: "[
			Request execution for Current application.
			Implement `message' based on `request' and `response'.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO_EXECUTION

inherit
	WSF_MESSAGE_EXECUTION

create
	make

feature -- Execution

	message: WSF_PAGE_RESPONSE
		do
			create Result.make_with_body ("Hello World")
			response.send (Result)
		end

end
