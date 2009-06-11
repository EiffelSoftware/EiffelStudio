note
	description: "[
			Represents a webapp and provides features to translate, compile and run it
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

inherit
	XS_SHARED_SERVER_OUTPUTTER
	XS_SHARED_SERVER_CONFIG

create
	make

feature {NONE} -- Initialization

	make (a_webapp_config: XS_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		require
			a_webapp_config_attached: a_webapp_config /= Void
		do
			app_config := a_webapp_config

			create translate_action.make (current)
			create compile_action.make (current)
			create run_action.make (current)
			create send_action.make (current)
			create shutdown_action.make (current)

			translate_action.set_next_action (compile_action)
			compile_action.set_next_action (run_action)
			run_action.set_next_action (send_action)

			cleaned := true

		ensure
			config_attached: config /= Void
			translate_action_attached: translate_action /= Void
			compile_action_attached: compile_action /= Void
			run_action_attached: run_action /= Void
			send_action_attached: send_action /= Void
			shutdown_action_attached: shutdown_action /= Void
		end

feature  -- Access

	app_config: XS_WEBAPP_CONFIG
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

	cleaned: BOOLEAN assign set_cleaned
		-- Can be used to force a clean on the first translation/compilation	

feature -- Constans

	onebillionnanoseconds: INTEGER_64 = 1000000000
	fourbillionnanoseconds: INTEGER_64 = 4000000000
	sixbillionnanoseconds: INTEGER_64 = 6000000000

--feature {NONE} -- Access internal

--	server_config: XS_FILE_CONFIG
--			-- The attached server_config
--		require
--			internal_server_config_attached: internal_server_config /= Void
--		do
--			if attached  internal_server_config as c then
--				Result := c
--			else
--				Result := create {XS_FILE_CONFIG}.make_empty
--			end
--		ensure
--			Result_attached: Result /= Void
--		end

--	internal_server_config: detachable XS_FILE_CONFIG
--		-- Internal detachable server_config

feature -- Actions

	start_action_chain: XH_RESPONSE
			-- Executes the first action in the chain		
		do
			if config.file.assume_webapps_are_running.value then
				Result := send_action.execute
			else
				Result := translate_action.execute
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Status Setting

	set_request_message (a_request_message: like request_message)
			-- Sets a_request_message
		do
			request_message := a_request_message
		ensure
			request_message_set: request_message = a_request_message
		end

	set_cleaned (a_cleaned: like cleaned)
			-- Sets
		do
			cleaned := a_cleaned
		ensure
			cleaned_set: cleaned = a_cleaned
		end

	shutdown
			-- Initiates shutdown and waits for termination
		do
			if run_action.is_running then
				shutdown_action.execute.do_nothing;
				run_action.wait_for_exit
			end
		end


	shutdown_all
			-- Shuts the application down and all process (compile and translate)
		do
			shutdown
			compile_action.stop
			translate_action.stop
		end


--	set_server_config (a_config: XS_FILE_CONFIG)
--			-- Setter
--		do
--			internal_server_config := a_config
--			translate_action.set_config (a_config)
--			compile_action.set_config (a_config)
--			run_action.set_config (a_config)
--			send_action.set_config (a_config)
--			shutdown_action.set_config (a_config)
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
