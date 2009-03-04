note
	description: "Generated code!"
	author: "XEB Code Generation"

class
	HELLO_WORLD

inherit
	SERVLET

create
	make

feature -- Initialization
	make
		do
			create controller.make
		end

feature {NONE} -- Access

	controller: MY_CONTROLLER

feature -- Implementation

	handle_request (request: REQUEST): RESPONSE
		local
			response: RESPONSE
		do
			response.append ("[
				<html><body /> </html>
			]")
			controller.do_something
			buffer.put_string (controller.return_something)
		end

end
