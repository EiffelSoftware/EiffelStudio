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
			create shutdown_action.make (current)

			translate_action.set_next_action (compile_action)
			compile_action.set_next_action (run_action)
			run_action.set_next_action (send_action)

			needs_cleaning := false

		ensure then
			config_attached: config /= Void
			translate_action_attached: translate_action /= Void
			compile_action_attached: compile_action /= Void
			run_action_attached: run_action /= Void
			send_action_attached: send_action /= Void
			shutdown_action_attached: shutdown_action /= Void
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

	shutdown_Action: XSWA_SHUTDOWN
		-- The action to shut down a webapp	

	request_message: detachable STRING
		-- The current request_message

	needs_cleaning: BOOLEAN assign set_needs_cleaning
		-- Can be used to force a clean on the next translation/compilation	

feature -- Constans

	onebillionnanoseconds: INTEGER_64 = 1000000000
	fourbillionnanoseconds: INTEGER_64 = 4000000000
	sixbillionnanoseconds: INTEGER_64 = 6000000000

feature -- Actions

	start_action_chain: XH_RESPONSE
			-- Executes the appropriate action in the chain		
		do
			if config.args.assume_webapps_are_running.value then
				Result := send_action.execute
			else
				if is_disabled then
					Result := (create {XER_DISABLED}.make(app_config.name)).render_to_response
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

feature -- Status Setting

	set_request_message (a_request_message: like request_message)
			-- Sets a_request_message.
		do
			request_message := a_request_message
		ensure
			request_message_set: request_message = a_request_message
		end

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
				shutdown_action.execute.do_nothing
				run_action.wait_for_exit
			end
		end

	fire_off
			-- Sends shutdown signal even if the webapp process is not owned by the server
		do
			shutdown_action.execute.do_nothing;
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
	shutdown_action_attached: shutdown_action /= Void
	request_message_not_empty_when_attached: request_message /= Void implies not request_message.is_empty
end
