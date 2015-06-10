note
	description: "[
				This class implements the `Hello World' service.

				It inherits from WSF_DEFAULT_SERVICE to get default EWF connector ready.
				And implement HELLO_EXECUTION.

				`initialize' can be redefine to provide custom options if needed, 
				such as specific port number.
			]"

class
	HELLO_APPLICATION

inherit
	WSF_DEFAULT_SERVICE [HELLO_EXECUTION]

create
	make_and_launch

end
