note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_WEBAPP_ACTION

inherit
	XU_SHARED_OUTPUTTER

feature {NONE} -- Initialization

	make (a_webapp: XS_WEBAPP)
			-- Initialization for `Current'.
		require
			a_webapp_attached: a_webapp /= Void
		do
			webapp := a_webapp
		ensure
			a_webapp_set: equal (a_webapp, webapp)
		end

feature -- Access

	webapp: XS_WEBAPP
		-- The webapp

	is_running: BOOLEAN
		-- True if the action has to wait e.g. for a process to terminate

--	stop_action: detachable XS_WEBAPP_ACTION
--		-- Is used to stop an other action before the action is executed

	next_action: detachable XS_WEBAPP_ACTION
		-- Is executed after the action has executed

	config: XS_CONFIG
			-- The attached server_config
		require
			internal_server_config_attached: internal_server_config /= Void
		do
			if attached  internal_server_config as c then
				Result := c
			else
				Result := create {XS_CONFIG}.make_empty
			end
		ensure
			Result_attached: Result /= Void
		end

	internal_server_config: detachable XS_CONFIG
		-- Internal detachable server_config

feature -- Paths

	app_dir: STRING
			-- The directory to the application
		do
			Result := config.webapps_root + "/" + webapp.config.name.out
		end

	run_workdir_w : STRING
			-- The working directory to execute the application W_CODE
		do
			Result := app_dir  + "/EIFGENs/" + webapp.config.name.out + "/W_code"
		end

feature -- Operations

	execute: XH_RESPONSE
			-- Executes the action if necessary and stops the stop_action if attached.
			-- Returns a XH_RESPONSE which can be sent to the http server
		require
			config_set: internal_server_config /= Void
		--	not_necessary_implies_hasnext: not is_necessary implies next_action /= Void
		do
			if is_necessary then
--				if attached stop_action then
--					stop_action.stop
--				end
				Result := internal_execute
			else
				Result := next_action.execute
			end
		ensure
			Result_attached: Result /= Void
		end

feature  -- Status report internal

	is_necessary: BOOLEAN
			-- Tests if the action is necessairy
		deferred
		end

	file_exists (a_filename: STRING): BOOLEAN
			-- Checks if a file exists
		local
			l_file: RAW_FILE
		do
			Result := False
			create l_file.make (a_filename)
			Result := l_file.exists
		end

feature -- Status setting

--	set_stop_action (a_action: XS_WEBAPP_ACTION)
--			-- Sets a stop action
--		do
--			stop_action := a_action
--		ensure
--			action_set: stop_action = a_action
--		end

	set_next_action (a_action: XS_WEBAPP_ACTION)
			-- Setts a next action
		do
			next_action := a_action
		ensure
			action_set: next_action = a_action
		end

	stop
			-- Stops the action
		deferred
		ensure
			not_running: is_running = False
		end

	set_config (a_config: XS_CONFIG)
			-- Setter
		do
			internal_server_config := a_config
		ensure
			config_attached: internal_server_config /= Void
		end

feature {NONE} -- Implementation

	internal_execute: XH_RESPONSE
			-- The actual implementation of an action
		deferred
		ensure
			Result_attached: Result /= Void
		end
	--launch_process (a_exe: STRING; a_args: STRING; a_dir: STRING; a_exit_handler: PROCEDURE [XS_WEBAPP_ACTION, detachable TUPLE];  a_output_handler: detachable PROCEDURE [XS_WEBAPP_ACTION, detachable TUPLE [detachable STRING]]): detachable PROCESS
	launch_process (a_exe: STRING; a_args: STRING; a_dir: STRING; a_exit_handler: PROCEDURE [XS_WEBAPP_ACTION, detachable TUPLE]): detachable PROCESS
			-- Launches a process
		local
			l_process_factory: PROCESS_FACTORY
			l_file: RAW_FILE
		do
			create l_file.make (a_exe)
			if l_file.exists then
				l_file.make (a_dir)
				if l_file.exists and l_file.is_directory then
					create l_process_factory
					Result  := l_process_factory.process_launcher_with_command_line (a_exe + " " + a_args, a_dir)
					Result.set_on_exit_handler (a_exit_handler)
--					if a_output_handler /= Void then
--						Result.redirect_output_to_agent (a_output_handler)
--					end
					o.dprint("Launching new process '" + a_exe + " " + a_args + "' in '" + a_dir + "'", 3)
					Result.launch
				else
					o.eprint ("Invalid directory for launching process: '" + a_dir + "'", generating_type)
				end
			else
				o.eprint ("File does not exist for launching process: '" + a_exe + " " + a_args + "'", generating_type)
			end
		end
invariant
	webapp_attached: webapp /= Void
	config_attached: config /= Void
end

