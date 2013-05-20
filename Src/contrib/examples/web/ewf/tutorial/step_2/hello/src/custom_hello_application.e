note
	description: "[
				This class implements the `Hello World' service.

				It inherits from WSF_DEFAULT_RESPONSE_SERVICE to get default EWF connector ready
				only `response' needs to be implemented.
				In this example, it is redefined and specialized to be WSF_PAGE_RESPONSE

				`initialize' can be redefine to provide custom options if needed.

			]"

class
	CUSTOM_HELLO_APPLICATION

inherit
	WSF_DEFAULT_RESPONSE_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
		do
				--| Uncomment the following line, to be able to load options from the file ewf.ini
--			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")

				--| You can also uncomment the following line if you use the Nino connector
				--| so that the server listens on port 9999
				--| quite often the port 80 is already busy
--			set_service_option ("port", 9999)

				--| Uncomment next line to have verbose option if available
--			set_service_option ("verbose", True)

				--| If you don't need any custom options, you are not obliged to redefine `initialize'
			Precursor
		end

feature {NONE} -- Initialization

	response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
			-- Computed response message.
		do
			create Result.make
			Result.put_string ("Hello World")
		end

end
