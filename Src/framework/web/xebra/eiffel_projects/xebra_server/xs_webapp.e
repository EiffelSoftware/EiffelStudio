note
	description: "[
			Represents a webapp and provides features to translate, compile and run it
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

inherit
	XU_SHARED_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make (a_webapp_config: XS_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		require
			a_webapp_config_attached: a_webapp_config /= Void
		do
			config := a_webapp_config

			create translate_action.make (current)
			create compile_action.make (current)
			create run_action.make (current)
			create send_action.make (current)
			create shutdown_action.make (current)

			translate_action.set_next_action (compile_action)
			compile_action.set_next_action (run_action)
			run_action.set_next_action (send_action)

		ensure
			config_attached: config /= Void
			translate_action_attached: translate_action /= Void
			compile_action_attached: compile_action /= Void
			run_action_attached: run_action /= Void
			send_action_attached: send_action /= Void
			shutdown_action_attached: shutdown_action /= Void
		end

feature  -- Access

	config: XS_WEBAPP_CONFIG
		-- Contains info about the webapp

	translate_action: XSWA_TRANSLATE
		-- The action to translate the webapp

	compile_action: XSWA_COMPILE
		-- The action to compile the webapp

	run_action: XSWA_RUN
		-- The action to run the webapp

	send_action: XSWA_SEND
		-- The action to send the request to the webapp

	shutdown_Action: XSWA_SHUTDOWN
		-- The action to shut down a webapp	

	request_message: detachable STRING
		-- The current request_message

feature -- Constans

	fourbillionnanoseconds: INTEGER_64 = 4000000000
	sixbillionnanoseconds: INTEGER_64 = 6000000000

feature {NONE} -- Access internal

	server_config: XS_CONFIG
			-- The attached server_config
		require
			internal_server_config_attached: internal_server_config /= Void
		do
			if attached  internal_server_config as c then
				Result := c
			else
				Result := create {XS_CONFIG}.make_empty
			end
		end

	internal_server_config: detachable XS_CONFIG
		-- Internal detachable server_config

feature -- Actions

	start_action_chain: XH_RESPONSE
			-- Executes the first action in the chain		
		do
			Result := translate_action.execute
		end

feature -- Status Setting

	set_request_message (a_request_message: STRING)
			-- Sets a_request_message
		do
			request_message := a_request_message
		ensure
			request_message_set: request_message = a_request_message
		end

	shutdown
			-- Shuts the application down
		local
			l_dummy: XH_RESPONSE
		do
			if run_action.is_running then
				l_dummy := shutdown_action.execute;
				(create {EXECUTION_ENVIRONMENT}).sleep (sixbillionnanoseconds)
			end
			send_action.stop
			run_action.stop
			compile_action.stop
			translate_action.stop
		end

	set_server_config (a_config: XS_CONFIG)
			-- Setter
		do
			internal_server_config := a_config
			translate_action.set_config (a_config)
			compile_action.set_config (a_config)
			run_action.set_config (a_config)
			send_action.set_config (a_config)
			shutdown_action.set_config (a_config)
		end




--	translate_process: detachable PROCESS
--			-- Used to translate the xeb files

--	gen_compile_process: detachable PROCESS
--			-- Used to compile the servlet_gen

--	generate_process: detachable PROCESS
--			-- Used to run the servlet_gen

--	compile_process: detachable PROCESS
--			-- USed to compile the webapp

--	process: detachable PROCESS
--			-- Used to run the webapp

--feature {NONE} -- Paths and Args

--	compiler_args: STRING
--			-- The arguments that are passed to compile the webapp
--		do
--			Result  := " -config " + name + "-voidunsafe.ecf -target " + name + " -c_compile -stop"
----			if config.finalize_webapps then
----				Result := Result + " -finalize"
----			end
--		end

--	gen_compiler_args: STRING
--			-- The arguments that are passed to compile the servlet_gen	
--		do
--			Result  := " -config " + config.servlet_gen_ecf + " -target servlet_gen -c_compile -stop"
--		end

--	translator_args: STRING
--			-- The arguments that are passed to the translator
--		do
--			Result := " " + name + " ./ ./ ./" + config.servlet_gen_path + "/ ./"
--		end

--	generate_args: STRING
--			-- The arguments that are passed to the servlet_gen
--		do
--			Result :=  " ./"
--		end

--	run_workdir_w : STRING
--			-- The working directory to execute the application W_CODE
--		do
--			Result := app_dir  + "/EIFGENs/" + name + "/W_code"
--		end

--	app_dir: STRING
--			-- The directory to the application
--		do
--			Result := config.webapps_root + "/" + name
--		end

--	melted_file_path: STRING
--			-- Returns the path to the melted file
--		do
--			Result := run_workdir_w  + "/" + name + ".melted"
--		end

--feature -- Status Report

--	is_compiling: BOOLEAN

--	is_running: BOOLEAN

--	is_translating: BOOLEAN

--	file_exists (a_filename: STRING): BOOLEAN
--			-- Checks if a file exists
--		local
--			l_file: RAW_FILE
--		do
--			Result := False
--			create l_file.make (a_filename)
--			Result := l_file.exists
--		end

--	can_compile: BOOLEAN
--			-- Checks if there is a valid compiler available
--		do
--			Result := file_exists (config.compiler)
--		end

--	can_translate: BOOLEAN
--			-- Checks if there is a valid translator available
--		do
--			Result := file_exists (config.translator)
--		end


--	is_translating_necessary: BOOLEAN
--			-- Check if the webapps has to be (re)translated
--			-- (which includes, executing translator, compiling servlet_gen and executing servlet_gen)
--			-- Returns True iff for every *.xeb in app_dir a corresponding g_* does is older or does not exist.
--		local
--			l_dir: DIRECTORY
--			l_files: LIST [STRING]
--			l_xeb_file: RAW_FILE
--			l_e_file: RAW_FILE
--			l_s_name: STRING
--		do
--			Result := False
--			create l_dir.make (app_dir)
--			l_files := l_dir.linear_representation
--			from
--				l_files.start
--			until
--				l_files.after or Result
--			loop
--				if l_files.item_for_iteration.ends_with (".xeb") then
--					create l_xeb_file.make (app_dir + "/" + l_files.item_for_iteration)
--					l_files.item_for_iteration.remove_tail (4)
--					l_s_name := "g_" + l_files.item_for_iteration + "_servlet.e"
--					create l_e_file.make (app_dir + "/" + l_s_name)
--					if l_e_file.exists then
--						if (l_e_file.date < l_xeb_file.date) then
--							Result := True
--						end
--					else
--						Result := True
--					end
--				end
--				l_files.forth
--			end




--		--	Result := file_is_newer_multiple (app_dir, "*.xeb",
--		--									  app_dir, "*.e")

--		--	Result := Result or not file_exists (app_dir + "/g_" + name + "_application.e")

--			if Result then
--				o.dprint ("Translating is necessary", 5)
--			else
--				o.dprint ("Translating is not necessary", 5)
--			end
--		end

--	file_is_newer_multiple (a_dir1, a_ext1, a_dir2, a_ext2: STRING): BOOLEAN
--				-- Returns True iff inside a_dir1 there is a file with a_ext1
--				-- that is newer than all files in a_dir2 with a_ext2
--				-- or no file in a_dir2 with a_ext2 exists
--		local
--			l_dir1: DIRECTORY
--			l_dir2: DIRECTORY
--			l_files1: LIST [STRING]
--			l_files2: LIST [STRING]
--			l_file: RAW_FILE
--			l_newest2: INTEGER
--		do
--			Result := False

--			create l_dir1.make (a_dir1)
--			l_files1 := l_dir1.linear_representation
--			create l_dir2.make (a_dir2)
--			l_files2 := l_dir2.linear_representation

--			if l_files2.count > 0 then
--				l_newest2 := 0
--				from
--					l_files2.start
--				until
--					l_files2.after
--				loop
--					if l_files2.item_for_iteration.ends_with (a_ext2) then
--						create l_file.make (a_dir2 + "/" + l_files2.item_for_iteration)
--						if (l_file.date > l_newest2) then
--							l_newest2 := l_file.date
--						end
--					end
--					l_files2.forth
--				end
--				from
--					l_files1.start
--				until
--					l_files1.after or Result
--				loop
--					if l_files1.item_for_iteration.ends_with (a_ext1) then
--						create l_file.make (a_dir1 + "/" + l_files1.item_for_iteration)
--						if (l_file.date > l_newest2) then
--							Result := True
--						end
--					end
--					l_files1.forth
--				end
--			else
--				Result := True
--			end
--		end


--	file_is_newer (a_file, a_dir, a_ext1, a_ext2: STRING): BOOLEAN
--				-- Returns True iff there is a file in a_dir with a_ext1 or a_ext2
--				-- that is newer than a_file or a_file does not exist
--		local
--			l_dir: DIRECTORY
--			l_files: LIST [STRING]
--			l_file: RAW_FILE
--			l_exec_access_date: INTEGER
--		do
--			Result := False
--			if file_exists (a_file) then
--				l_exec_access_date := (create {RAW_FILE}.make (a_file)).date
--				create l_dir.make (a_dir)
--				l_files := l_dir.linear_representation
--				from
--					l_files.start
--				until
--					l_files.after or Result
--				loop
--					if l_files.item_for_iteration.ends_with (a_ext1) or l_files.item_for_iteration.ends_with (a_ext2) then
--						create l_file.make (a_dir + "/" + l_files.item_for_iteration)
--						if (l_file.date > l_exec_access_date) then
--							Result := True
--							o.dprint ("File '" + l_file.name + "' is newer (" + l_file.date.out + ")  than  (" + l_exec_access_date.out + ")",5)
--						end
--					end
--					l_files.forth
--				end
--			else
--				Result := True
--				o.dprint ("File '" + a_file + "' does not exist.", 5)
--			end
--		end

--	is_compiling_necessary: BOOLEAN
--			-- Check if the webapps has to be (re)compiled
--		do
--			Result := file_is_newer (melted_file_path,
--											app_dir,
--											"*.e",
--											"*.ecf")
--			if Result then
--				o.dprint ("Compiling is necessary", 5)
--			else
--				o.dprint ("Compiling is not necessary", 5)
--			end
--		end

--	can_run: BOOLEAN
--			-- Checks if the webapp executable has been generated
--		do
--			Result := file_exists (run_workdir_w  + "/" + name)
--		end

--feature -- Status setting

--	shutdown_all
--			-- Terminate the compile process and send shutdown signal to webapp.
--		do
--			shutdown
--			kill_translate
--			kill_compile
--		end

--	shutdown
--			-- Send shutdown signal to webapp.
--		local
--				l_webapp_socket: NETWORK_STREAM_SOCKET
--			do
--				if is_running then
--					create l_webapp_socket.make_client_by_port (port, host)
--					o.dprint ("Shutdown connect to " + name + "@" + port.out, 4)
--					l_webapp_socket.connect
--		            if  l_webapp_socket.is_connected then
--						o.dprint ("Sending shutdown signal", 2)
--			            l_webapp_socket.independent_store (Shutdown_message)
--			         else
--			         	o.eprint ("Cannot shutdown connect to '" + name + "'", generating_type)
--					end
--					(create {EXECUTION_ENVIRONMENT}).sleep (2000000000)
--				end
--				kill_process
--			end

--	kill_process
--			-- Terminates the process.
--		do
--			if attached {PROCESS} process as p then
--				o.dprint ("Terminating " + name  + "", 2)
--				p.terminate
--				is_running := False
--			end
--		end

--	kill_compile
--			-- Terminates the compile process.		
--		do
--			if attached {PROCESS} compile_process as p then
--				o.dprint ("Terminating compile process of " + name  + "", 2)
--				p.terminate
--			end
--		end

--	kill_translate
--		-- Terminates the translate process.		
--		do
--			if attached {PROCESS} translate_process as p then
--				o.dprint ("Terminating translate process of " + name  + "", 2)
--				p.terminate
--			end
--		end

--feature  {NONE} -- Operations internal

--	compile_servlet_gen
--			-- Launches the process to compile the servlet_gen
--		do
--			gen_compile_process := launch_process (config.compiler,
--													gen_compiler_args,
--													app_dir,
--													agent gen_compile_process_exited,
--													agent compiler_output_handler)
--		end

--	generate
--			-- Launches the process to execute servlet_gen
--		do
--			generate_process := launch_process (app_dir + "/" + config.servlet_gen_exe,
--												generate_args,
--												app_dir,
--												agent generate_process_exited,
--												agent generator_output_handler)
--		end

--	launch_process (a_exe: STRING; a_args: STRING; a_dir: STRING; a_exit_handler: PROCEDURE [XS_WEBAPP, detachable TUPLE]; a_output_handler: PROCEDURE [XS_WEBAPP, detachable TUPLE [detachable STRING]]): PROCESS
--			-- Launches a process
--		local
--			l_process_factory: PROCESS_FACTORY
--			l_file: RAW_FILE
--		do
--			create l_file.make (a_exe)
--			if l_file.exists then
--				l_file.make (a_dir)
--				if l_file.exists and l_file.is_directory then
--					create l_process_factory
--					Result  := l_process_factory.process_launcher_with_command_line (a_exe + " " + a_args, a_dir)
--					Result.set_on_exit_handler (a_exit_handler)
--					Result.redirect_output_to_agent (a_output_handler)
--					o.dprint("Launching new process '" + a_exe + " " + a_args + "' in '" + a_dir + "'", 3)
--					Result.launch
--				else
--					o.eprint ("Invalid directory for launching process: '" + a_dir + "'", generating_type)
--				end
--			else
--				o.eprint ("File does not exist for launching process: '" + a_exe + " " + a_args + "'", generating_type)
--			end
--		end

feature -- Operatins

--	translate: BOOLEAN
--			-- Return true if the webapp is translated
--			-- Initiates translating (and compiling and executing servlet_gen) otherwise
--		require
--			can_translate: can_translate
--		local
--			l_process_factory: PROCESS_FACTORY
--			l_cmd: STRING
--		do
--			Result := False
--			if is_translating_necessary   then
--					-- Stop the process
--				if is_running then
--					shutdown
--				end
--					-- Launch translating
--				if not is_translating then
--					translate_process := launch_process (config.translator,
--														translator_args,
--														app_dir,
--														agent translate_process_exited,
--														agent translator_output_handler)
--					is_translating := True
--				end
--			else
--				Result := True
--			end
--		end

--	run: BOOLEAN
--			-- Returns true if the webapp is running
--			-- Initiates launching the webapp if its not running
--		do
--			Result := False

--			if is_running then
--				Result := True
--			else
--				process := launch_process (app_dir + "/EIFGENs/"+ name + "/W_code/" + name,
--											port.out,
--											run_workdir_w,
--											agent process_exited,
--											agent translator_output_handler)
--				is_running := True
--			end
--		end

--	compile: BOOLEAN
--			-- Returns true if the webapp is compiled
--			-- Initiates compiling if its not compiled and if necessair
--		require
--			can_compile: can_compile
--		do
--			Result := False
--			if is_compiling_necessary   then
--					-- Stop the process
--				if is_running then
--					shutdown
--				end
--					-- Launch compiling
--				if not is_compiling then
--					compile_process := launch_process (config.compiler,
--														compiler_args,
--														app_dir,
--														agent compile_process_exited,
--														agent compiler_output_handler)
--					is_compiling := True
--				end
--			else
--				Result := True
--			end
--		end


--feature {NONE} -- Agents

--	translator_output_handler (a_ouput: STRING)
--			-- Forwards output to console
--		do
--			o.set_name ("TRANSLATOR")
--			o.dprintn (a_ouput, 3)
--			o.set_name ({XS_MAIN_SERVER}.name)
--		end

--	generator_output_handler (a_ouput: STRING)
--			-- Forwards output to console
--		do
--			o.set_name ("SERVLET_GEN")
--			o.dprintn (a_ouput, 3)
--			o.set_name ({XS_MAIN_SERVER}.name)
--		end

--	compiler_output_handler (a_ouput: STRING)
--			-- Forwards output to console
--		do
--			o.set_name ("COMPILER")
--			o.dprintn (a_ouput, 3)
--			o.set_name ({XS_MAIN_SERVER}.name)
--		end

--	compile_process_exited
--			-- Sets is_compiling := False
--		do
--			is_compiling := False
--		end

--	process_exited
--			-- Sets is_running := False
--		do
--			is_running := False
--		end

--	translate_process_exited
--			-- Launch compiling of servlet_gen in gen_compile_process
--		do
--			set_outputter_name ({XS_MAIN_SERVER}.Name)
--			compile_servlet_gen
--		end

--	gen_compile_process_exited
--			-- Launch executing of servlet_gen in genrate_process
--		do
--			set_outputter_name ({XS_MAIN_SERVER}.Name)
--			generate

--		end

--	generate_process_exited
--			-- Sets is_translating := False
--		do
--			is_translating := False
--		end

--feature {NONE} -- Constants

--	Shutdown_message: STRING = "#KAMIKAZE#"

--feature -- Setters

--	set_config (a_config: XS_CONFIG)
--			-- Setter
--		do
--			internal_server_config := a_config
--		end

--	set_name (a_name: STRING)
--			-- Setter
--		require
--			name_not_empty: not a_name.is_empty
--		do
--			name := a_name
--		ensure
--			name_set: name = a_name
--		end

----	set_root (a_root: STRING)
----			-- Setter
----		require
----			root_not_empty: not a_root.is_empty
----		do
----			root := a_root
----		ensure
----			root_set: root = a_root
----		end

--	set_port (a_port: INTEGER)
--			-- Setter
--		require
--			a_port_pos: a_port >= 0
--		do
--			port := a_port
--		ensure
--			port_set: port = a_port
--		end

--	set_host (a_host: STRING)
--			-- Setter
--		require
--			host_not_empty: not a_host.is_empty
--		do
--			host := a_host
--		ensure
--			host_set: host = a_host
--		end

invariant
	config_attached: config /= Void
	translate_action_attached: translate_action /= Void
	compile_action_attached: compile_action /= Void
	run_action_attached: run_action /= Void
	send_action_attached: send_action /= Void
	shutdown_action_attached: shutdown_action /= Void
	request_message_not_empty_when_attached: request_message /= Void implies not request_message.is_empty
end
