note
	description: "Generated code!"
	author: "XEB Code Generation"

class
	HELLO_WORLD

inherit
	SERVLET

create
	make

feature {NONE}-- Access

	controller: MY_CONTROLLER

	make
		do
			response.append ("[
				<html><body /> </html>
			]")
			controller.do_something
			buffer.put_string (controller.return_something)
		end

feature-- Implementation

	handle_request (request: REQUEST): RESPONSE
		local
			response: RESPONSE
		do
			create response.make
			response.append ("[
				<html><body /> </html>
			]")
			controller.do_something
			buffer.put_string (controller.return_something)
			Result := response
		end

end
