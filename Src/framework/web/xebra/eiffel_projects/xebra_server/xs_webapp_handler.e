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

			webapps.put (create {XS_WEBAPP}.make ("demoapplication", "localhost", 3491), "demoapplication")
			webapps.put (create {XS_WEBAPP}.make ("xebrawebapp", "localhost", 3491), "xebrawebapp")
		end

feature -- Access

	webapps: HASH_TABLE [XS_WEBAPP, STRING]

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

	forward_request_to_app (l_request_message: STRING; a_webapp_socket: NETWORK_STREAM_SOCKET): STRING
			--Sends a request to the correct webserver.
		require
			a_webapp_connected: not a_webapp_socket.is_closed
		local
			l_soc1: NETWORK_STREAM_SOCKET
			l_request_factory: XU_REQUEST_FACTORY
			l_uri_webapp_name: STRING
		--	l_request:  XH_REQUEST
		--	l_webapp:  XS_WEBAPP

		do
			create Result.make_empty
			create l_request_factory.make

            	-- Decode only uri of request (TODO)

            if attached {XH_REQUEST} l_request_factory.get_request (l_request_message) as l_request then
				l_uri_webapp_name := l_request.target_uri.substring (2, l_request.target_uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)

						-- Find correct webapp and conntect to it
				if attached webapps[l_uri_webapp_name] as l_webapp then
					create l_soc1.make_client_by_port (l_webapp.port, l_webapp.host)
		            l_soc1.connect
		            if  l_soc1.is_connected then
			            l_soc1.independent_store (l_request_message)
						if attached {XH_RESPONSE} l_soc1.retrieved as l_response then
			            	Result := l_response.render_to_string
			            else
			            	Result := (create {XER_BAD_RESPONSE}.make (l_uri_webapp_name)).render_to_response.render_to_string
			            end
			            l_soc1.cleanup
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
