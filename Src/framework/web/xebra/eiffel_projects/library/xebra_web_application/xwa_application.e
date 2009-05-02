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
		do
				if attached server_connection_handler as server  then
					set_outputter_name (name)
					print ("%N%N%N")
					o.iprint ("Starting " + name)
					server.launch


					o.iprint ("Xebra Wep Application ready to rock...")

				--	o.iprint ("(enter 'x' to shut down)")

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
		end

feature -- Access

	server_connection_handler: detachable XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	name: STRING
			-- The name of the web application
		deferred
		end

	stop: BOOLEAN

feature -- Setter

	set_stop (a_stop: BOOLEAN)
			-- Setter
		do
			stop := a_stop
		ensure
			stop_set: stop = a_stop
		end

end
