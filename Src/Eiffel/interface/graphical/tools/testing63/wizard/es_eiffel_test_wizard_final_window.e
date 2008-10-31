indexing
	description: "Summary description for {ES_EIFFEL_TEST_WIZARD_FINAL_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EIFFEL_TEST_WIZARD_FINAL_WINDOW

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			is_final_state,
			wizard_information
		end

	ES_EIFFEL_TEST_WIZARD_WINDOW
		redefine
			is_final_state,
			wizard_information
		end

	EIFFEL_TEST_SUITE_OBSERVER
		redefine
			on_processor_error,
			on_processor_finished
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Access

	wizard_information: ES_EIFFEL_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

	factory_type: !TYPE [EIFFEL_TEST_FACTORY_I]
			-- Factory type used to create tests
		deferred
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Status report

	is_final_state: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	error_occurred: BOOLEAN
			-- Did an error occur during test creation?

feature {NONE} -- Basic operations

	proceed_with_current_info
			-- <Precursor>
		local
			l_ts: EIFFEL_TEST_SUITE_S
			l_factory: !EIFFEL_TEST_PROCESSOR_I
		do
			error_occurred := False
			if test_suite.is_service_available then
				l_ts := test_suite.service
				if l_ts.processor_registrar.is_registered (factory_type) then
					l_factory := l_ts.factory (factory_type)
					if l_factory.is_ready (l_ts) then
						if l_factory.is_valid_argument (wizard_information.as_attached, l_ts) then
							first_window.disable_sensitive
							l_ts.connect_events (Current)
							l_ts.launch_processor (l_factory, wizard_information.as_attached, False)
						else
							show_error_prompt (e_configuration_not_valid, [])
						end
					else
						show_error_prompt (e_factory_not_ready, [])
					end
				else
					show_error_prompt (e_factory_not_available, [])
				end
			else
				show_error_prompt (e_test_suite_not_available, [])
			end
		end

	show_error_prompt (a_message: !STRING; a_tokens: !TUPLE)
			-- Show error prompt with `a_message'.
		do
			prompts.show_error_prompt (local_formatter.formatted_translation (a_message, a_tokens), first_window, Void)
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_processor_finished (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_test_suite.processor_registrar.is_registered (factory_type) then
				if a_processor = a_test_suite.factory (factory_type) then
					if not error_occurred then
						a_test_suite.disconnect_events (Current)
						first_window.enable_sensitive
						if not error_occurred then
							cancel_actions
						end
					end
				end
			end
		end

	on_processor_error (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I; a_error: !STRING; a_token_values: !TUPLE)
			-- <Precursor>
		do
			if a_test_suite.processor_registrar.is_registered (factory_type) then
				if a_processor = a_test_suite.factory (factory_type) then
					error_occurred := True
				end
			end
		end

feature {NONE} -- Constants

	e_test_suite_not_available: STRING = "Testing service currently not available"
	e_factory_not_available: STRING = "Eiffel test factory currently not available"
	e_factory_not_ready: STRING = "Factory is already creating tests"
	e_configuration_not_valid: STRING = "The provided settings can not be used to create new tests"


end
