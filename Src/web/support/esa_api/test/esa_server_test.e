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
			launch,
			setup_config
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
			port_number := 5050
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

	port_number: INTEGER

feature -- Shutdown
	shutdown
		do
			if attached web_app as app then
				app.shutdown
			end
		end

feature -- Access
	web_app: detachable NINO_SERVICE


feature -- ESA configuration

 	setup_config
 		do
 			create esa_config.make_with_database ("Driver={SQL Server Native Client 11.0};Server=" + server_name + ";Database=" + database_name + ";Trusted_Connection=Yes;", database_name)
		end

	server_name: STRING = "JVELILLA\SQLEXPRESS"
		-- Server Name.

	database_name: STRING = "EiffelDBIntegration"
		-- Database Name.

	schema : STRING = "eiffeldbintegration"
	 	-- Database schema.


	db_connection: ESA_DATABASE_CONNECTION
		do
			if attached esa_config as l_config then
				Result := l_config.database
			else
				check False then end
			end
		end


end
