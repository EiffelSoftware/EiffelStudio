note
	description: "[
		Handles communication to Xebra Web Applications
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create webapps.make (1)
	end

feature -- Access

	webapps: HASH_TABLE [NETWORK_SOCKET, STRING]


feature -- Status Change

	register (a_name: STRING; a_socket: NETWORK_SOCKET)
			-- Registers a new webapp in webapps
		do
			webapps.extend (a_socket, a_name)
		end

	close_all
			-- Closes all connections to webapps
		do
			from
				webapps.start
			until
				webapps.after
			loop
				webapps.item_for_iteration.cleanup
				webapps.forth
			end
		end

feature -- Basic operations

	forward_request_to_app (l_request_message: STRING; a_webapp_socket: NETWORK_STREAM_SOCKET): STRING
			--Sends a request to the correct webserver.
		require
			a_webapp_connected: not a_webapp_socket.is_closed
		local
			l_request_factory: XU_REQUEST_FACTORY
			l_uri_webapp_name: STRING
		do
			create Result.make_empty
			create l_request_factory.make

            	-- Decode only uri of request (TODO)
            if attached {XH_REQUEST} l_request_factory.get_request (l_request_message) as l_request then
				l_uri_webapp_name := l_request.target_uri.substring (2, l_request.target_uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)

						-- Find correct webapp and conntect to it
				if attached webapps[l_uri_webapp_name] as l_webapp_socket then

		            if  l_webapp_socket.is_connected then
			            l_webapp_socket.independent_store (l_request_message)
						if attached {XH_RESPONSE} l_webapp_socket.retrieved as l_response then
			            	Result := l_response.render_to_string
			            else
			            	Result := (create {XER_BAD_RESPONSE}.make (l_uri_webapp_name)).render_to_response.render_to_string
			            end
			        else
			        	Result := (create {XER_CANNOT_CONNECT}.make (l_uri_webapp_name)).render_to_response.render_to_string
			        end
	            else
					Result := (create {XER_CANNOT_FIND_APP}.make (l_uri_webapp_name)).render_to_response.render_to_string
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_response.render_to_string
            end
		end
end
