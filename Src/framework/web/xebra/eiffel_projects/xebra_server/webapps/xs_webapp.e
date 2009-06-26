note
	description: "[
			Represents a webapp and provides features to translate, compile and run it
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

inherit
	XC_WEBAPP_BEAN
		redefine
			make
		end
	XS_SHARED_SERVER_OUTPUTTER
	XS_SHARED_SERVER_CONFIG

create
	make

feature {NONE} -- Initialization

	make (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		do
			Precursor (a_webapp_config)

			create translate_action.make (current)
			create compile_action.make (current)
			create run_action.make (current)
			create send_action.make (current)

			translate_action.set_next_action (compile_action)
			compile_action.set_next_action (run_action)
			run_action.set_next_action (send_action)

			current_request := create {XCWC_EMPTY}.make
			needs_cleaning := False

			dev_mode := True

		ensure then
			config_attached: config /= Void
			translate_action_attached: translate_action /= Void
			compile_action_attached: compile_action /= Void
			run_action_attached: run_action /= Void
			send_action_attached: send_action /= Void

		end

feature  -- Access


	translate_action: XSWA_TRANSLATE
		-- The action to translate the webapp

	compile_action: XSWA_COMPILE
		-- The action to compile the webapp

	run_action: XSWA_RUN
		-- The action to run the webapp

	send_action: XSWA_SEND
		-- The action to send the request to the webapp

	current_request: XC_WEBAPP_COMMAND --assign set_current_request

	needs_cleaning: BOOLEAN assign set_needs_cleaning
		-- Can be used to force a clean on the next translation/compilation	

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- Executes the the actions chain 		
		require
			a_request_attached: a_request /= Void
		do
			current_request := a_request
			if config.args.assume_webapps_are_running.value then
				Result := send_action.execute
			else
				if is_disabled then
					Result := (create {XER_DISABLED}.make(app_config.name)).render_to_command_response
				else
					if dev_mode then
						Result := translate_action.execute
					else
						Result := run_action.execute
					end

				end
			end
		ensure
			Result_attached: Result /= Void
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		do
			Result := True
			if is_running then
				current_request :=  create {XCWC_GET_SESSIONS}.make
				if attached {XCCR_GET_SESSIONS} send_action.execute as l_response then
					sessions := l_response.sessions
				else
					Result := False
				end
			end
		end

feature  -- Status Setting

--	set_current_request (a_current_request: like current_request)
--			-- Sets current_request.
--		require
--			a_current_request_attached: a_current_request /= Void
--		do
--			current_request := a_current_request
--		ensure
--			current_request_set: equal( current_request, a_current_request)
--		end

--	set_request_message (a_request_message: like request_message)
--			-- Sets a_request_message.
--		do
--			request_message := a_request_message
--		ensure
--			request_message_set: request_message = a_request_message
--		end

	set_needs_cleaning (a_cleaned: like needs_cleaning)
			-- Sets needs_cleaning.
		do
			needs_cleaning := a_cleaned
		ensure
			cleaned_set: needs_cleaning = a_cleaned
		end

	shutdown
			-- Initiates shutdown and waits for termination.
		do
			if run_action.is_running then
				o.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", 4)
				current_request := 	create {XCWC_SHUTDOWN}.make
				send_action.execute.do_nothing
				run_action.wait_for_exit
			end
		end

	fire_off
			-- Sends shutdown signal even if the webapp process is not owned by the server
		do
			o.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", 4)
			current_request := 	create {XCWC_SHUTDOWN}.make
			send_action.execute.do_nothing
		end


	shutdown_all
			-- Shuts the application down and all process (compile and translate).
		do
			shutdown
			compile_action.stop
			translate_action.stop
		end

invariant
	config_attached: config /= Void
	translate_action_attached: translate_action /= Void
	compile_action_attached: compile_action /= Void
	run_action_attached: run_action /= Void
	send_action_attached: send_action /= Void

end
