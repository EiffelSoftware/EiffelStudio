note
	description: "Generated code!"
	author: "XEB Code Generation"

class
	HELLO_WORLD

inherit
	SERVLET

create
	make

feature-- Access

	my_var: STRING

feature-- Implementation

	handle_request (request: REQUEST): RESPONSE
		local
			my_var: STRING
			response: RESPONSE
		do
			create response.make
			response.append ("[
				<html><body /> </html>
			]")
			Result := response
		end

end
