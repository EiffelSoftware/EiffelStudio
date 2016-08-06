note
	description: "[
			Request execution based on attributes `request' and `response'.
			Also support Upgrade to Websocket protocol.
			

		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WEBSOCKET_EXECUTION

inherit
	WSF_EXECUTION
		rename
			execute as http_execute
		end

--create
--	make

feature -- Execution

	frozen http_execute
		local
			ws: WEB_SOCKET
			ws_h: like new_websocket_handler
		do
			create ws.make (request, response)
			ws.open_ws_handshake
			if ws.is_websocket then
				if ws.has_error then
						-- Upgrade to websocket raised an error
						-- stay on standard HTTP/1.1 protocol
					execute
				else
					ws_h := new_websocket_handler (ws)
					ws_h.execute
				end
			else
				execute
			end
		end

	execute
			-- Execute Current request,
			-- getting data from `request'
			-- and response to client via `response'.
		deferred
		end

feature -- Factory

	new_websocket_handler (ws: WEB_SOCKET): WEB_SOCKET_HANDLER
			-- Websocket request specific handler on socket `ws'.
			--| For the creation, it requires an instance of `{WEB_SOCKET_EVENT_I}'
			--| to receive the websocket events.
			--| One can inherit from {WEB_SOCKET_EVENT_I} and implement the related
			--|		deferred features.
			--| Or even provide a new class implementing {WEB_SOCKET_EVENT_I}.
		require
			is_websocket: ws.is_websocket
			no_error: not ws.has_error
		deferred
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
