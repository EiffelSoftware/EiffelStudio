note
	description: "[
			Objects that is used to create dummy web socket client object
			used for void-safety
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_NULL_CLIENT

inherit
	WEB_SOCKET_SUBSCRIBER

feature -- Handshake

	on_websocket_handshake (request: STRING)
			-- Default do nothing
		do
		end

feature -- TCP connection

	connection: HTTP_STREAM_SOCKET
		do
			create Result.make_client_by_port (0, "null")
		end

end
