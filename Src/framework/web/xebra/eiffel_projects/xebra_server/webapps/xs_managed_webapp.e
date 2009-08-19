note
	description: "[
			Represents a managed webapp and provides features to translate, compile and run it.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_MANAGED_WEBAPP

inherit
	XS_WEBAPP
		redefine
			make_with_config
		end

create
	make_with_config

feature {NONE} -- Initialization

	make_with_config (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
			--
			-- Initializes the actions. The action chain is:
			-- TRANSLATE -> COMPILE_SERVLET_GENERATOR -> GENERATE -> COMPILE_WEBAPP -> RUN -> SEND
		do
			Precursor (a_webapp_config)
			current_request := create {XCWC_EMPTY}.make

			create action_translate.make
			create action_compile_sgen.make
			create action_generate.make
			create action_compile_webapp.make
			create action_run.make
			create action_send.make

			action_translate.set_webapp (current)
			action_compile_sgen.set_webapp (current)
			action_generate.set_webapp (current)
			action_compile_webapp.set_webapp (current)
			action_run.set_webapp (current)
			action_send.set_webapp (current)

			action_translate.set_next_action (action_compile_sgen)
			action_compile_sgen.set_next_action (action_generate)
			action_generate.set_next_action (action_compile_webapp)
			action_compile_webapp.set_next_action (action_run)
			action_run.set_next_action (action_send)
				-- Set dev mode by default to true
			dev_mode := True
		ensure then
			config_attached: config /= Void
			action_translate_attached: action_translate /= Void
			action_compile_webapp_attached: action_compile_webapp /= Void
			action_compile_sgen_attached: action_compile_sgen /= Void
			action_generate_attached: action_generate /= Void
			action_run_attached: action_run /= Void
			action_send_attached: action_send /= Void
		end

feature  -- Access

	action_translate: XSWA_TRANSLATE
		-- The action to translate the webapp

	action_compile_sgen: XSWA_COMPILE_SGEN
		-- The action to compile the servlet_generator		

	action_compile_webapp: XSWA_COMPILE_WEBAPP
		-- The action to compile the webapp

	action_generate: XSWA_GENERATE
		-- The action to generate the webapp

	action_run: XSWA_RUN
		-- The action to run the webapp

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			current_request := a_request
			if is_disabled then
					Result := (create {XER_DISABLED}.make(app_config.name)).render_to_command_response
			else
				if config.args.unmanaged.value then
					Result := action_send.execute
				else
					if dev_mode then
						Result := action_translate.execute
					else
						Result := action_run.execute
					end
				end
			end
		end

	force_translate
			-- Forces to retranslate the webapp
		do
			action_translate.force := True
			action_translate.execute.do_nothing
		end

	force_clean
			-- Forces translation and cleaning of the webapp
		do
			action_compile_webapp.needs_cleaning := True
			action_compile_sgen.needs_cleaning := True
			force_translate
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		do
			Result := True
			if is_running then
				current_request :=  create {XCWC_GET_SESSIONS}.make
				if attached {XCCR_GET_SESSIONS} action_send.execute as l_response then
					sessions := l_response.sessions
				else
					Result := False
				end
			end
		end

feature  -- Status Setting

	set_needs_cleaning
			-- Sets needs_cleaning to all cleanable actions.
		do
			action_translate.set_force (True)
			action_compile_webapp.set_needs_cleaning (True)
			action_compile_sgen.set_needs_cleaning (True)
			action_generate.set_needs_cleaning (True)
		end

	shutdown
			-- Initiates shutdown and waits for termination.
		do
			if action_run.is_running then
				o.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", o.Debug_tasks)
				current_request := 	create {XCWC_SHUTDOWN}.make
				action_send.execute.do_nothing
				action_run.wait_for_exit
			end
		end

	fire_off
			-- Sends shutdown signal even if the webapp process is not owned by the server
		do
			o.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", o.Debug_tasks)
			current_request := 	create {XCWC_SHUTDOWN}.make
			action_send.execute.do_nothing
		end

	shutdown_all
			-- Shuts the application down and all process (compile and translate).
		do
			shutdown
			action_compile_webapp.stop
			action_generate.stop
			action_compile_sgen.stop
			action_translate.stop
		end

invariant
	config_attached: config /= Void
	action_translate_attached: action_translate /= Void
	action_compile_webapp_attached: action_compile_webapp /= Void
	action_compile_sgen_attached: action_compile_sgen /= Void
	action_generate_attached: action_generate /= Void
	action_run_attached: action_run /= Void
end
