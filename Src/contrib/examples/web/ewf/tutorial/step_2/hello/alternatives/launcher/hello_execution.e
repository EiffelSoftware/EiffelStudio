note
	description: "[
			Request execution for Current application.
			Implement `execute' based on `request' and `response'.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Execution

	execute
		local
			msg: WSF_PAGE_RESPONSE
		do
			create msg.make_with_body ("Hello World")
			response.send (msg)

			--| alternative would have been more low level
			--| by setting the content type, and the content length which is 11 for "Hello World"
			--	response.header.put_content_type_text_plain
			--	response.header.put_content_length (11)
			--	response.put_string ("Hello World")
		end

end
