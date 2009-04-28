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



feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
				if attached server_connection_handler as server  then
					print ("%N%N%N")
					print ("Starting " + name + "%N")

					server.launch

					print ("Xebra Wep Application ready to rock...%N")

					print ("(enter 'x' to shut down)%N")
					from
						io.read_character
					until
						io.last_character.is_equal ('x')
					loop
						io.read_character
					end

					print ("Shutting down...%N")
					server.shutdown
					print ("Bye!%N")
				end
		end

feature -- Access

	server_connection_handler: detachable XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	name: STRING
			-- The name of the web application
		deferred
		end

end
