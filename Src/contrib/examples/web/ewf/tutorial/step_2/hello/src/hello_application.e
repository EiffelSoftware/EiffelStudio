note
	description: "[
				This class implements the `Hello World' service.

				It inherits from WSF_DEFAULT_RESPONSE_SERVICE to get default EWF connector ready
				only `response' needs to be implemented.
				In this example, it is redefined and specialized to be WSF_PAGE_RESPONSE

				`initialize' can be redefine to provide custom options if needed.

			]"

class
	HELLO_APPLICATION

inherit
	WSF_DEFAULT_RESPONSE_SERVICE

create
	make_and_launch

feature {NONE} -- Initialization

	response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
			-- Computed response message.
		do
			create Result.make
			Result.put_string ("Hello World")
		end

end
