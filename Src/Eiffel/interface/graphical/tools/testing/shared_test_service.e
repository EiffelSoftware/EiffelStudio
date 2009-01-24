note
	description: "Summary description for {SHARED_TEST_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_SERVICE

inherit
	SHARED_LOCALE

feature {NONE} -- Access

	test_suite: !SERVICE_CONSUMER [TEST_SUITE_S]
			-- Access to a test suite service {TEST_SUITE_S} consumer
		local
			l_test_suite: ?like test_suite
		do
			l_test_suite := test_suite_cell.item
			if l_test_suite = Void then
				create l_test_suite
				test_suite_cell.put (l_test_suite)
			end

			Result := l_test_suite
		end

	test_suite_cell: CELL [?SERVICE_CONSUMER [TEST_SUITE_S]]
			-- Cache for `test_suite'
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	background_executor_type: !TYPE [TEST_BACKGROUND_EXECUTOR_I]
			-- Type for executor used to execute tests in background
		do
			Result := {TEST_BACKGROUND_EXECUTOR_I}
		end

	debug_executor_type: !TYPE [TEST_DEBUGGER_I]
			-- Type for executor that runs tests in the debugger
		do
			Result := {TEST_DEBUGGER_I}
		end

	extractor_factory_type: !TYPE [TEST_EXTRACTOR_I]
			-- Factory type for test case extraction
		do
			Result := {TEST_EXTRACTOR_I}
		end

	manual_factory_type: !TYPE [TEST_MANUAL_CREATOR_I]
			-- Type for manual test creation
		do
			Result := {TEST_MANUAL_CREATOR_I}
		end

	generator_factory_type: !TYPE [TEST_GENERATOR_I]
			-- Factory type for test case generation
		do
			Result := {TEST_GENERATOR_I}
		end

feature {NONE} -- Query

	error_message (a_type: !TYPE [TEST_PROCESSOR_I]; a_code: NATURAL): !STRING_32
			-- Translated error message for given error code and corresponding processor.
			--
			-- `a_type': Type of processor
			-- `a_code': Corresponding error code
		local
			l_message: STRING
		do
			inspect
				a_code
			when service_not_available_code then
				l_message := e_service_not_available
			when processor_not_available_code then
				if {l_exec_type: TYPE [TEST_EXECUTOR_I]} a_type then
					l_message := e_execution_unavailable
				elseif {l_debug_type: TYPE [TEST_DEBUGGER_I]} a_type then
					l_message := e_debugging_unavailable
				elseif {l_creator_type: TYPE [TEST_CREATOR_I]} a_type then
					l_message := e_creation_unavailable
				elseif {l_extractor_type: TYPE [TEST_EXTRACTOR_I]} a_type then
					l_message := e_extraction_unavailable
				elseif {l_generator_type: TYPE [TEST_GENERATOR_I]} a_type then
					l_message := e_unkonwn_error
				end
			when processor_not_ready_code then
				if {l_exec_type2: TYPE [TEST_EXECUTOR_I]} a_type then
					l_message := e_execution_not_ready
				elseif {l_debug_type2: TYPE [TEST_DEBUGGER_I]} a_type then
					l_message := e_debugging_not_ready
				elseif {l_creator_type2: TYPE [TEST_CREATOR_I]} a_type then
					l_message := e_creation_not_ready
				elseif {l_extractor_type2: TYPE [TEST_EXTRACTOR_I]} a_type then
					l_message := e_extraction_not_ready
				elseif {l_generator_type2: TYPE [TEST_GENERATOR_I]} a_type then
					l_message := e_unkonwn_error
				end
			when configuration_not_valid_code then
				if {l_exec_type3: TYPE [TEST_EXECUTOR_I]} a_type then
					l_message := e_execution_conf_invalid
				elseif {l_creator_type3: TYPE [TEST_CREATOR_I]} a_type then
					l_message := e_creation_conf_invalid
				elseif {l_extractor_type3: TYPE [TEST_EXTRACTOR_I]} a_type then
					l_message := e_extraction_conf_invalid
				elseif {l_generator_type3: TYPE [TEST_GENERATOR_I]} a_type then
					l_message := e_generation_conf_invalid
				else
					l_message := e_unkonwn_error
				end
			else
				l_message := e_unkonwn_error
			end
			Result := locale.translation (l_message)
		end

feature {NONE} -- Basic operations

	frozen launch_processor (a_type: !TYPE [TEST_PROCESSOR_I]; a_conf: !TEST_PROCESSOR_CONF_I; a_blocking: BOOLEAN)
			-- Launch processor with provided configuration. If unable to launch processor, report errors
			-- through `on_error'.
			--
			-- `a_type': Type of processor to be launched.
			-- `a_conf': Configuration to launch processor.
			-- `a_blocking': True if `launch_processor' should return after processor is stopped, otherwise
			--               it will return immediately.
		local
			l_service: TEST_SUITE_S
			l_registrar: TEST_PROCESSOR_REGISTRAR_I
			l_proc: TEST_PROCESSOR_I
			l_code: NATURAL
		do
			if test_suite.is_service_available and then test_suite.service.is_project_initialized then
				l_service := test_suite.service
				l_registrar := l_service.processor_registrar
				if l_registrar.is_valid_type (a_type, l_service) then
					l_proc := l_registrar.processor (a_type, l_service)
					if l_proc.is_ready then
						if l_proc.is_valid_configuration (a_conf) then
							l_service.launch_processor (l_proc, a_conf, a_blocking)
						else
							l_code := configuration_not_valid_code
						end
					else
						l_code := processor_not_ready_code
					end
				else
					l_code := processor_not_available_code
				end
			else
				l_code := service_not_available_code
			end
			if l_code > 0 then
				on_processor_launch_error (error_message (a_type, l_code), a_type, l_code)
			end
		end

feature {NONE} -- Events

	on_processor_launch_error (a_error: like error_message; a_type: !TYPE [TEST_PROCESSOR_I]; a_code: NATURAL)
			-- Called when an error occurred launching processor.
			--
			-- `a_error': Error message
			-- `a_type': Type of processor attempted to launch.
			-- `a_code': Error code
		do
		end

feature {NONE} -- Constants

	service_not_available_code: NATURAL = 1
	processor_not_available_code: NATURAL = 2
	processor_not_ready_code: NATURAL = 3
	configuration_not_valid_code: NATURAL = 4

	testing_library_uuid: !STRING = "B77B3A44-A1A9-4050-8DF9-053598561C33"
	testing_library_path: !STRING = "$ISE_LIBRARY/library/testing/testing.ecf"

feature {NONE} -- Internationalization

	e_service_not_available: !STRING = "Testing service is currently not available."

	e_execution_unavailable: !STRING = "Test execution is currently unavailable"
	e_debugging_unavailable: !STRING = "Test debugging is currently unavailable"
	e_creation_unavailable: !STRING = "Test creation is currently unavailable"
	e_extraction_unavailable: !STRING = "Test extraction is currently unavailable"
	e_generation_unavailable: !STRING = "AutoTest is currently unavailable"

	e_execution_not_ready: !STRING = "Can not launch test execution because it is currently executing tests."
	e_debugging_not_ready: !STRING = "Can not debug test because debugger is currently running."
	e_creation_not_ready: !STRING = "Currently unable to create new tests."
	e_extraction_not_ready: !STRING = "Can not extract any tests, please check debugger state."
	e_generation_not_ready: !STRING = "Can not launch AutoTest because it is already running."

	e_execution_conf_invalid: !STRING = "Can not execute selected tests. Make sure none of the tests are already queued or running by a differend executor."
	e_creation_conf_invalid: !STRING = "Unable to create new tests."
	e_extraction_conf_invalid: !STRING = "Unable to extract tests for selected call stack frames."
	e_generation_conf_invalid: !STRING = "Unable to launch AutoTest with provided options."

	e_unkonwn_error: !STRING = "Unable to launch processor"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
