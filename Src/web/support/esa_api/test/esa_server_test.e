note
	description: "Summary description for {ESA_SERVER_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

 class
	ESA_SERVER_TEST

inherit
	ESA_SERVER
		redefine
			launch
		end
	ESA_HTTP_CLIENT_HELPER


create
	  {ESA_SERVER} make_and_launch

--	  make_with_port

--feature {NONE} --Initialization
--	make_with_port (a_port :INTEGER)
--		do
--			port_number := a_port
--			custom_port := True
--			make
--		end


feature -- Launch
	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_launcher: WSF_DEFAULT_SERVICE_LAUNCHER
			app: NINO_SERVICE
			wt: WORKER_THREAD
			e: EXECUTION_ENVIRONMENT
		do
--			if not custom_port then
--				if attached opts as l_opts and then attached {STRING} l_opts.option ("port") as l_port and then l_port.is_integer then
--					port_number := l_port.to_integer
--				else
--					port_number := 0
--				end
--			end
			port_number := 0
			create app.make_custom (a_service.to_wgi_service, "")
			web_app := app

			create wt.make (agent app.listen (port_number))
			wt.launch
			create e
			e.sleep (1_000_000_000 * 5)
			port_number := app.port
		end

feature -- Element Change
--	set_port (new_port : INTEGER)
--			-- Set `port' to `new_port'
--		do
--			port_number := new_port
--		ensure
--			port_set : port_number = new_port
--		end

--feature {NONE} -- implementation
--	custom_port : BOOLEAN


feature -- Shutdown
	shutdown
		do
			if attached web_app as app then
				app.shutdown
			end
		end

feature -- Access
	web_app: detachable NINO_SERVICE


	context_executor: HTTP_CLIENT_REQUEST_CONTEXT
		local
			l_ctx_factory: ESA_CONTEXT_FACTORY
		do
			 create l_ctx_factory
			 Result := l_ctx_factory.cj_context_executor
		end

end
