note
	description: "Summary description for {WEB_SOCKET_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_EXECUTION

inherit
	WSF_WEBSOCKET_EXECUTION

	WEB_SOCKET_EVENT_I

feature -- Websocket execution

	new_websocket_handler (ws: WEB_SOCKET): WEB_SOCKET_HANDLER
		do
			create Result.make (ws, Current)
		end

end
