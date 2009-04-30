note
	description: "Summary description for {XS_COMPILE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_COMPILE_SERVICE

inherit
	XU_SHARED_OUTPUTTER


create
	make

feature {NONE} -- Initialization

	make (a_server_config: XS_SERVER_CONFIG)
			-- Initialization for `Current'.
		do
			server_config := a_server_config
		ensure
			server_config_set: server_config = a_server_config
		end

feature -- Access

	server_config: XS_SERVER_CONFIG


feature -- Status setting

	compile (a_name: STRING): BOOLEAN
			-- Makes sure the webapp is compiled
			-- Returns false if it could not be compiled
		do
			o.dprint ("'XS_COMPILE_SERVICE.compile' not implemented, assuming '" + a_name + "' is compiled!",1)
--			if attached {XS_WEBAPP} webapps[a_name] as webapp then
--				o.dprint ("webapp was found!",3)

--				if webapp.is_running then
--					o.eprint ("cannot recompile running webapp")
--				end
--			end


--			o.dprint ("Checking if webapp exists..",3)
--			o.eprint ("not found")

--			o.dprint ("Has to be recompiled.",3)

--			o.dprint ("Compiling...",3)
--			o.eprint ("could not compile")

			Result := True

		end

	launch_failed (a_name: STRING): BOOLEAN
			-- Checks if a webapp has failed to launch
		do
			Result := False
			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
				Result := webapp.launch_failed
			end
		end


	run (a_name: STRING): BOOLEAN
			-- Makes sure the webapp is running
			-- Returns False if it could not be run
		local
			l_process_factory: PROCESS_FACTORY
			l_args: LIST [STRING]
			l_workdir: STRING
		do
			Result := False
			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
				if webapp.is_launched then
					Result := True
				else
					create {LINKED_LIST [STRING]}l_args.make
					l_args.force (webapp.port.out)
					l_workdir := server_config.webapps_root + "/" + webapp.name + "/EIFGENs/" + webapp.name + "/W_code"
					create l_process_factory
					webapp.process := l_process_factory.process_launcher (webapp.name, l_args , l_workdir )
					webapp.process.set_on_fail_launch_handler (agent set_webapp_failed (webapp.name))
					webapp.process.set_on_successful_launch_handler (agent set_webapp_launched (webapp.name))
					o.dprint("Launching new process '" + l_workdir + "/" + a_name + " " + webapp.port.out + "'",1)
					webapp.process.launch
				end
			end
		end

feature -- Cursor movement

feature -- Element change

	set_webapp_failed (a_name: STRING)
			--
		do
			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
				o.eprint ("Failed to launch process for '" + a_name + "'", generating_type)
				webapp.set_launch_failed
			end
		end

	set_webapp_launched (a_name: STRING)
			--
		do
			if attached {XS_WEBAPP} server_config.webapps[a_name] as webapp then
				o.dprint ("Successfully launched '" + a_name + "'",1)
				webapp.set_launched
			end
		end


feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
