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
			response.append ("[
				fabio
			]")
			controller.sandro
			response.append ("[
				monic
			]")
		end

end
