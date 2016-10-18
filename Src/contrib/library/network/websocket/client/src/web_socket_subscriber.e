note
	description: "Summary description for {WEB_SOCKET_SUBSCRIBER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_SUBSCRIBER


feature -- Events

	on_websocket_ping (a_message: detachable STRING)
			-- Send a ping in response to a received ping.
		do
		end


	on_websocket_pong (a_message: detachable STRING)
			-- Default implementation do nothing.
		do
		end


	on_websocket_text_message (a_message: detachable STRING)
			-- Default implementation do nothing.
		do
		end

	on_websocket_binary_message (a_message: detachable STRING)
			-- Default implementation do nothing.
		do
		end


	on_websocket_open (a_message: detachable STRING)
		do
		end


	on_websocket_close (a_message: detachable STRING)
		do
		end

	on_websocket_error (a_error: detachable STRING)
		do
		end

feature -- Handshake

	on_websocket_handshake (request: STRING)
			-- Default do nothing
		deferred
		end

feature -- TCP connection

	connection: HTTP_STREAM_SOCKET
		deferred
		end
end
