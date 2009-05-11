note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_APPLICATION

inherit
	XU_SHARED_OUTPUTTER


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		local
			l_parser: XWA_ARGUMENT_PARSER
			l_exit_code: INTEGER
		do
			create l_parser.make
			initialize
			l_parser.execute (agent run (l_parser))
			if not l_parser.is_successful then
				l_exit_code := -1
			end
			if l_exit_code /= 0 then
				(create {EXCEPTIONS}).die (l_exit_code)
			end
		end


feature -- Operations

	initialize
			-- Setts webapp specific attributes
		deferred
		end

	run (a_parser: XWA_ARGUMENT_PARSER)
			-- Runs the application
		do
				if attached server_connection_handler as server then

					config.merge (a_parser)

					set_outputter_name (config.name)
					print ("%N%N%N")
					o.iprint ("Starting " + config.name)
					server.launch

					o.iprint ("Xebra Wep Application ready to rock...")

					if config.is_interactive then
						o.iprint ("(enter 'x' to shut down)")
						from
							stop := False
						until
							stop
						loop
							io.read_character
							if io.last_character.is_equal ('x') then
								stop := True
							end
						end
						o.iprint ("Shutting down...")
						server.shutdown
						o.iprint ("Bye!")
					end
					server.join
				end
		end

feature -- Access

	server_connection_handler: detachable XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	stop: BOOLEAN

	config: XWA_CONFIG

feature -- Setter

	set_stop (a_stop: BOOLEAN)
			-- Setter
		do
			stop := a_stop
		ensure
			stop_set: stop = a_stop
		end

end
