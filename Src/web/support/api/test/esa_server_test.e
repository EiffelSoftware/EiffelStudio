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
--			setup_config
		end

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

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			app: WSF_STANDALONE_SERVICE_LAUNCHER [ESA_SERVICE_EXECUTION]
--			wt: WORKER_THREAD
			e: EXECUTION_ENVIRONMENT
			l_opts: WSF_STANDALONE_SERVICE_OPTIONS
		do
--			if not custom_port then
--				if attached opts as l_opts and then attached {STRING} l_opts.option ("port") as l_port and then l_port.is_integer then
--					port_number := l_port.to_integer
--				else
--					port_number := 0
--				end
--			end
			if opts /= Void then
				create l_opts.make_from_iterable (opts)
			else
				create l_opts
			end

			l_opts.set_port (5050)
			port_number := 5050
			create app.make (l_opts)
			web_app := app

			app.launch

--			create wt.make (agent app.listen (port_number))
--			wt.launch
			create e
			e.sleep (1_000_000_000 * 5)
			port_number := app.connector.port
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

	port_number: INTEGER

feature -- Shutdown

	shutdown
		do
			if attached web_app as app then
				if attached app.connector as conn then
					conn.shutdown_server
				end
--				app.shutdown
			end
		end

feature -- Access

	web_app: detachable WSF_STANDALONE_SERVICE_LAUNCHER [ESA_SERVICE_EXECUTION]

	server_name: STRING = ""

	database_name: STRING = ""

	schema: STRING=""

end
