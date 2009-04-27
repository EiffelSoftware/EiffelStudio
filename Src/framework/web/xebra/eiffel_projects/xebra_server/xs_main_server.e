note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
    XS_MAIN_SERVER

inherit
	XU_DEBUG_OUTPUTTER

create
    make

feature -- Initialization

	make
			-- Creates a server which listens to requests from http servers and from xebra apps
		do
			create compile_service.make

			print ("%N%N%N")
			print ("Starting Xebra Server...%N")
			dprint ("Launching HTTP Connection Server...",1)
			create http_connection_server.make (compile_service)
			http_connection_server.launch
		--	dprint ("Launching Web App Connection Server...",1)
		--	create app_connection_server.make (webapp_handler)
		--	app_connection_server.launch
			print ("Xebra Server ready to rock...%N")

			print ("(enter 'x' to shut down)%N")
			from
				io.read_character
			until
				io.last_character.is_equal ('x')
			loop
				io.read_character
			end

			print ("Shutting down...%N")
			--webapp_handler.close_all
			http_connection_server.shutdown
		--	app_connection_server.shutdown
			print ("Bye!%N")
		end

feature -- Access

	http_connection_server: XS_HTTP_CONN_SERVER
			-- Handles connections to http server requests

--	app_connection_server: XS_APP_CONN_SERVER
--			-- Handles connections to xebra web application requests (for registration)


	compile_service: XS_COMPILE_SERVICE

end
