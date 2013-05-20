note
	description: "[
				APPLICATION implements the `Hello World' service.

				It inherits from WSF_DEFAULT_SERVICE to get default EWF connector ready
				only `execute' needs to be implemented.
				
				`initialize' can be redefine to provide custom options if needed.

			]"

class
	HELLO_APPLICATION

inherit
	WSF_DEFAULT_SERVICE

create
	make_and_launch

feature {NONE} -- Initialization

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			page: WSF_PAGE_RESPONSE
		do
			create page.make
			page.put_string ("Hello World")
			res.send (page)

			--| another alternative would have been more low level
			--| by setting the status code, the content type, and the content length which is 11 for "Hello World"
			--|		res.put_header ({WSF_HEADER}.ok, <<["Content-Type", "text/plain"], ["Content-Length", "11"]>>)
			--|		res.put_string ("Hello World")
		end



end
