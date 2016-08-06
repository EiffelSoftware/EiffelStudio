note
	description: "[
		Websocket callback events for actions like opening and closing the connection, 
		sending and receiving messages, and listening.
		
		Define the websocket events:
			- on_open
			- on_binary
			- on_text
			- on_close
		
		note: the following features could also be redefined:
			- on_pong
			- on_ping
			- on_unsupported
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_EVENT_I

inherit
	WEB_SOCKET_CONSTANTS

	REFACTORING_HELPER

feature -- Web Socket Interface

	on_event (ws: WEB_SOCKET; a_message: detachable READABLE_STRING_8; a_opcode: INTEGER)
			-- Called when a frame from the client has been receive
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		local
			l_message: READABLE_STRING_8
		do
			debug ("ws")
				ws.log ("%Non_event (ws, a_message, " + opcode_name (a_opcode) + ")%N", {HTTPD_LOGGER_CONSTANTS}.debug_level)
			end
			if a_message = Void then
				create {STRING} l_message.make_empty
			else
				l_message := a_message
			end

			if a_opcode = Binary_frame then
				on_binary (ws, l_message)
			elseif a_opcode = Text_frame then
				on_text (ws, l_message)
			elseif a_opcode = Pong_frame then
				on_pong (ws, l_message)
			elseif a_opcode = Ping_frame then
				on_ping (ws, l_message)
			elseif a_opcode = Connection_close_frame then
				on_connection_close (ws, "")
			else
				on_unsupported (ws, l_message, a_opcode)
			end
		end

feature -- Websocket events

	on_open (ws: WEB_SOCKET)
			-- Called after handshake, indicates that a complete WebSocket connection has been established.
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		deferred
		end

	on_binary (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		deferred
		end

	on_text (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		deferred
		end

	on_close (ws: detachable WEB_SOCKET)
			-- Called after the WebSocket connection is closed.
		deferred
		end

feature -- Websocket events: implemented

	on_pong (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		do
				-- log ("Its a pong frame")
				-- at first we ignore  pong
				-- FIXME: provide better explanation			
		end

	on_ping (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		do
			ws.send (Pong_frame, a_message)
		end

	on_unsupported (ws: WEB_SOCKET; a_message: READABLE_STRING_8; a_opcode: INTEGER)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		do
				-- do nothing
		end

	on_connection_close (ws: WEB_SOCKET; a_message: detachable READABLE_STRING_8)
		require
			ws_attached: ws /= Void
			ws_valid: ws.is_open_read and then ws.is_open_write
		do
			ws.send (Connection_close_frame, "")
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
