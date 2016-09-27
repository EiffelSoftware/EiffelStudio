note
	description: "[
			 Instance of HTTPD_REQUEST_HANDLER will process the incoming connection
			 and extract information on the request and the server
		 ]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_REQUEST_HANDLER

inherit
	HTTPD_REQUEST_HANDLER_I
		redefine
			release
		end

feature {HTTPD_CONNECTION_HANDLER_I} -- Basic operation		

	release
			-- <Precursor>
		local
			d: detachable STRING
		do
			debug ("dbglog")
				if 
					attached internal_client_socket as l_socket and then
					l_socket.descriptor_available
				then
					d := l_socket.descriptor.out
				else
					d := "N/A"
				end
				dbglog (generator + ".release: ENTER {" + d + "}")
			end
			Precursor {HTTPD_REQUEST_HANDLER_I}
			debug ("dbglog")
				if d /= Void then
					dbglog (generator + ".release: LEAVE {" + d + "}")
				else
					dbglog (generator + ".release: LEAVE {N/A}")
				end
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
