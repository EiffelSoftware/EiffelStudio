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

	base_make
			-- Initialization for `Current'.
		do
				print ("%N%N%N")
				print ("Starting " + name + "%N")

				server_connection_handler.launch

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
				server_connection_handler.shutdown
				print ("Bye!%N")
		end

feature -- Access

	server_connection_handler: XWA_SERVER_CONN_HANDLER
			-- Returns the applications server conn handler

	name: STRING
			-- The name of the web application
		deferred
		end

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
