note
	description: "ws_client application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			ws_client: EXAMPLE_WS_CLIENT
		do
--			create ws_client.make_with_port ("wss://echo.websocket.org", 443, Void)
--			if ws_client.is_ssl_supported and ws_client.is_tunneled then
--				ws_client.set_ssl_certificate_file ("ca.crt")
--				ws_client.set_ssl_key_file ("ca.key")
--			else
--					-- Not supported!
--			end

			create ws_client.make_with_port ("ws://echo.websocket.org", 80, Void)
--			create ws_client.make_with_port ("ws://127.0.0.1", 9090, Void)
			ws_client.launch
			ws_client.join_all

			execution_environment.sleep (5_000_000)
		end

end
