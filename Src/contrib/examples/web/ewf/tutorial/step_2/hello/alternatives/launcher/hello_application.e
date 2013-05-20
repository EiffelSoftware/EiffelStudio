note
	description: "[
				APPLICATION implements the "Hello World" service.

				It inherits from WSF_DEFAULT_SERVICE to get default EWF connector ready
				only `execute' needs to be implemented.

			]"

class
	HELLO_APPLICATION

inherit
	WSF_RESPONSE_SERVICE

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			launcher: WSF_DEFAULT_SERVICE_LAUNCHER
			opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS
		do
			--| Uncomment the following line, to read options from "ewf.ini" configuration file
			--	create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} opts.make_from_file ("ewf.ini")

			create launcher.make_and_launch (Current, opts)
		end

feature {NONE} -- Initialization

	response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
		do
			create Result.make
			Result.put_string ("Hello World")
		end

end
