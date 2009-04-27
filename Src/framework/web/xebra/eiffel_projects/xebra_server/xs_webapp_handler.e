note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER

inherit
	XU_DEBUG_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make (a_compile_service: XS_COMPILE_SERVICE)
			-- Initialization for `Current'.
		do
		--	create webapps_mutex.make
			compile_service := a_compile_service
		ensure
			compile_service_set: compile_service = a_compile_service
		end

feature -- Constants

	Default_app_server_host: STRING = "localhost"


feature -- Access

	compile_service: XS_COMPILE_SERVICE


--	webapps_mutex: MUTEX

feature -- Status Change

--	register (a_name: STRING; a_socket: NETWORK_SOCKET): BOOLEAN
--			-- Registers a new webapp in webapps
--		do
--			webapps_mutex.lock
--			if not webapps.has (a_name) then
--				webapps.extend (a_socket, a_name)
--				Result := True
--			else
--				Result := False
--			end
--			webapps_mutex.unlock
--		end

--	close_all
--			-- Closes all connections to webapps
--		do
--			webapps_mutex.lock
--			from
--				webapps.start
--			until
--				webapps.after
--			loop
--				webapps.item_for_iteration.cleanup
--				webapps.forth
--			end
--			webapps_mutex.unlock
--		end

feature -- Basic operations



feature  -- Implementation


	forward_request_to_app (l_request_message: STRING): XH_RESPONSE
			--Sends a request to the correct webserver.
		local
			l_request_factory: XH_REQUEST_FACTORY
			l_uri_webapp_name: STRING

		do
			--webapps_mutex.lock
			create Result.make_empty
			create l_request_factory.make

            	-- Decode only uri of request (TODO)
            if attached {XH_REQUEST} l_request_factory.get_request (l_request_message) as l_request then
				l_uri_webapp_name := l_request.target_uri.substring (2, l_request.target_uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)


				if compile_service.compile (l_uri_webapp_name) then
					if compile_service.run (l_uri_webapp_name) then
						Result :=  send (l_uri_webapp_name, l_request_message)
					else
						Result := (create {XER_CANNOT_RUN_APP}.make (l_uri_webapp_name)).render_to_response
					end
				else
					Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_response
				end
            else
            	Result := (create {XER_CANNOT_COMPILE_APP}.make ("")).render_to_response
            end
           	--webapps_mutex.unlock
		end


feature {NONE} -- Implementation

		send (a_webapp_name: STRING; a_request_message: STRING): XH_RESPONSE
				-- Sends the request to the webapp
			local
				l_webapp_socket: NETWORK_STREAM_SOCKET
			do
				if attached {XS_WEBAPP} compile_service.webapps[a_webapp_name] as l_app then

					create l_webapp_socket.make_client_by_port (l_app.port, Default_app_server_host)
					dprint ("Connecting to " + a_webapp_name + "@" + l_app.port.out,2)
					l_webapp_socket.connect
		            if  l_webapp_socket.is_connected then
						dprint ("Forwarding request", 2)
			            l_webapp_socket.independent_store (a_request_message)
			            dprint ("Waiting for response", 2)
						if attached {XH_RESPONSE} l_webapp_socket.retrieved as l_response then
							dprint ("Response retrieved", 2)
			            	Result := l_response
			            else
			            	Result := (create {XER_BAD_RESPONSE}.make (a_webapp_name)).render_to_response
			            end
			        else
			        	Result := (create {XER_CANNOT_CONNECT}.make (a_webapp_name)).render_to_response
			        end
	            else
					Result := (create {XER_CANNOT_FIND_APP}.make (a_webapp_name)).render_to_response
				end
			end



end
