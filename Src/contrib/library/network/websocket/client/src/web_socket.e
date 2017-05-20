note
	description: "[
		API to perform actions like opening and closing the connection, sending and receiving messages, and listening
		for events triggered by the server
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET

inherit
	WEB_SOCKET_CONSTANTS

feature -- Access

	uri: READABLE_STRING_GENERAL
			-- WebSocket Protocol defines two URI schemes, ws and wss for
			-- unencrypted and encrypted traffic between the client and the server.

	port: INTEGER
			-- Current WebSocket protocol.

	ws_port_default: INTEGER = 80
			-- WebSocket Protocol uses port 80 for regular WebSocket connections.

	wss_port_default: INTEGER = 443
			--  WebSocket connections tunneled over Transport Layer Security (TLS) use port 443.

	protocols: detachable LIST [STRING]
			-- List of protocol names that the client supports.

	protocol: STRING
			-- Client-Server protocol selected.
			-- Has the result fo protocol negotiation between client and the server
			-- By default it's an empty string.

	is_secure: BOOLEAN
			-- Is the current connection tunneled over TLS/SSL?
		local
			l_uri: STRING
		do
			l_uri := uri.as_lower.as_string_8
			Result := l_uri.starts_with ("wss") -- TODO extract to ws_constants.
		end

	ready_state: WEB_SOCKET_READY_STATE
			-- Connection state

feature -- Methods

	send (a_message: STRING)
			-- Send a message `a_message'
		require
			is_open: ready_state.is_open
		deferred
		end

	close (a_id: INTEGER)
			-- Close a websocket connection with a close id : `a_id'
		deferred
		ensure
			is_closed: ready_state.is_closed
		end

	close_with_description (a_id: INTEGER; a_description: READABLE_STRING_GENERAL)
			-- Close a websocket connection with a close id : `a_id' and a description `a_description'
		deferred
		ensure
			is_closed: ready_state.is_closed
		end

feature -- Change Element

	set_protocol (a_protocol: STRING)
			-- Set `protocol' with `a_protocol'
		do
			protocol := a_protocol
		ensure
			protocol_set: protocol = a_protocol
		end

	set_protocols (a_protocols: detachable ITERABLE [STRING])
		local
			l_protocols: LIST [STRING]
		do
			if a_protocols /= Void then
				create {ARRAYED_LIST [STRING]} l_protocols.make (0)
				across
					a_protocols as ic
				loop
					l_protocols.force (ic.item)
				end
				protocols := l_protocols
			end
		end

end
