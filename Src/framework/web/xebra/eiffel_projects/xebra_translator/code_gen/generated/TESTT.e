note
	description: "Generated code!"
	author: "XEB Code Generation"

class
	TESTT

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

	controller: testt_controller

feature -- Implementation

	handle_request (request: REQUEST): RESPONSE
		local
			response: RESPONSE
		do
			create response.make
			response.append ("[
				petersilie
			]")
			controller.333
			response.put_string (controller.222)
			response.append ("[
				test
			]")
			controller.111
			response.append ("[
				fabio
			]")
			Result := response
		end

end
