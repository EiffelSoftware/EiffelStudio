note
	description: "Summary description for {REQUEST_HANDLER}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REQUEST_HANDLER

feature -- Access

	servlets: TABLE [SERVLET, STRING]

	run
			-- Starts the web application.
            -- Accept communication with client and exchange messages.
        local
            server_socket: NETWORK_STREAM_SOCKET
        do
            create server_socket.make_server_by_port (3491)
            from
                server_socket.listen (5)
            until
                false
            loop
                process (server_socket) -- See below
            end
            server_socket.cleanup
        end

    process (server_socket: NETWORK_STREAM_SOCKET)
            -- Receive a message, extend it, and send it back
        local
            request: REQUEST
        do
            server_socket.accept
            if attached {NETWORK_STREAM_SOCKET} server_socket.accepted as thread_socket then
	            if attached {STRING} thread_socket.retrieved as message then
	            	request := build_request (message)
	            	thread_socket.independent_store (handle_request(request))
	            end
            	thread_socket.close
            end
        end

feature -- Processing

	build_request (message: STRING): REQUEST
			-- Transforms a plain text message into a {REQUEST} object
			-- for further use in on the page
		do
			--TODO
			create Result.make
		end

	handle_request (request: REQUEST): RESPONSE
			-- Routes the request to the appropriate controller
		do
			-- TODO: Check, wether request.get_file is in the table or not
			Result := servlets [request.file_identifier].handle_request (request)
		end

end
