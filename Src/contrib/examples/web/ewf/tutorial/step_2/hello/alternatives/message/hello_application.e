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
	WSF_DEFAULT_SERVICE [HELLO_EXECUTION]

create
	make_and_launch

end
