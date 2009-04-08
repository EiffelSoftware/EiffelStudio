class
    XS_MAIN_SERVER

create
    make

feature -- Initialization

	make
			-- Creates a server which listens to requests from http servers and from xebra apps
		do
			create webapp_handler.make

			print ("Starting Xebra Server...%N")
			print ("--Launching HTTP Connection Server...%N")
			create http_connection_server.make (webapp_handler)
			http_connection_server.launch
			print ("--Launching Web App Connection Server...%N")
			create app_connection_server.make (webapp_handler)
			app_connection_server.launch
			print ("Xebra Server ready to rock...%N")

			print ("(enter 's' to shut down)%N")
			from
				io.read_character
			until
				io.last_character.is_equal ('s')
			loop
				io.read_character
			end

			print ("Shutting down...%N")
			webapp_handler.close_all
			http_connection_server.do_stop
			app_connection_server.do_stop
			print ("Bye!%N")
		end

feature -- Access

	http_connection_server: XS_HTTP_CONN_SERVER
			-- Handles connections to http server requests

	app_connection_server: XS_APP_CONN_SERVER
			-- Handles connections to xebra web application requests (for registration)

	webapp_handler: XS_WEBAPP_HANDLER
			-- Stores registered Webapps and is able to send/receive request and responses

end
