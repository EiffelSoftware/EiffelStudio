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
				Fabio1
			]")
			controller.Sandro
			response.append ("[
				Janus
			]")
			controller.=Hermann
			response.append ("[
				Tepter
			]")
			response.append ("[
				Fabio1JanusTepter
			]")
			Result := response
		end

end
