note
	description: "Summary description for {SHARED_TEST_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_SERVICE

inherit
	SHARED_LOCALE

	EC_SHARED_PROJECT_ACCESS

	SHARED_FLAGS
		export
			{NONE} all
		end

feature {NONE} -- Access

	test_suite: SERVICE_CONSUMER [TEST_SUITE_S]
			-- Access to a test suite service {TEST_SUITE_S} consumer
		local
			l_test_suite: detachable like test_suite
			l_etest_suite: like etest_suite
		do
			l_test_suite := test_suite_cell.item
			if l_test_suite = Void then
				create l_test_suite
				test_suite_cell.put (l_test_suite)
				l_etest_suite := etest_suite
			end
			Result := l_test_suite
		end

	test_suite_cell: CELL [detachable SERVICE_CONSUMER [TEST_SUITE_S]]
			-- Cache for `test_suite'
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	etest_suite: ETEST_SUITE
			-- Once instance of `{ETEST_SUITE}
		local
			l_helper: ES_TEST_PROJECT_HELPER
		once
			if is_gui then
				create l_helper
			else
				create {TEST_PROJECT_HELPER} l_helper
			end
			create Result.make (l_helper)
		end

	default_filter_expression: STRING = "^class"
			-- Default tag prefix for `tree_view'
			--
			-- Note: while {ETEST} are the only {TEST_I} instances currently added to the test suite, it is
			--       guaranteed that all tests are shown, since all {ETEST} are tagged with a class tag
			--       starting with "class/".

feature {NONE} -- Basic operations

	perform_with_test_suite (a_procedure: ROUTINE [TEST_SUITE_S])
			-- Call given procedure with usable test suite service.
			--
			-- `a_procedure': Procedure to be called which takes a test suite as the only argument.
		require
			a_procedure_attached: a_procedure /= Void
		local
			l_error: detachable STRING
		do
			if attached test_suite.service as l_service then
				if l_service.is_interface_usable then
					a_procedure.call ([l_service])
				else
					l_error := e_service_not_available
				end
			else
				l_error := e_service_not_available
			end
			if l_error /= Void then
				on_session_launch_error (l_error)
			end
		end

	launch_session_type (a_type: TYPE [TEST_SESSION_I]; a_procedure: detachable PROCEDURE [TEST_SESSION_I])
			-- Instatiate and launch session of given type, optionally calling a procedure before performing
			-- the actualy launch.
			--
			-- `a_type': Type of session to be launched.
			-- `a_procedure': Optional procedure which is called before launching, can be used to configure
			--                the session.
		require
			a_type_attached: a_type /= Void
		do
			perform_with_test_suite (agent (a_ts: TEST_SUITE_S; a_t: TYPE [TEST_SESSION_I]; a_p: detachable PROCEDURE [TEST_SESSION_I])
				do
					if attached a_ts.new_session (a_t, is_gui) as l_session then
						if attached a_p then
							a_p (l_session)
						end
						a_ts.launch_session (l_session)
					end
				end (?, a_type, a_procedure))
		end

	launch_executor (a_list: detachable SEQUENCE [TEST_I]; a_debug: BOOLEAN)
			-- Try to run all tests in a given list through the background executor. If of some reason
			-- the tests can not be executed, show an error message.
			--
			-- `a_list': List of tests to be executed, Void if all tests should be ran.
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		do
			if a_list = Void or else not a_list.is_empty then
				launch_session_type ({TEST_SESSION_I},
					agent (a_session: TEST_SESSION_I; a_dbg: BOOLEAN; a_tests: detachable SEQUENCE [TEST_I])
						do
							if attached {TEST_EXECUTION_I} a_session as a_exec then
								a_exec.set_debugging (a_dbg)
								if a_tests /= Void then
									a_tests.do_all (agent a_exec.queue_test)
								else
									a_exec.test_suite.tests.do_all (agent a_exec.queue_test)
								end
							end
						end (?, a_debug, a_list))
			end
		end

	launch_test_generation (a_generator: TEST_GENERATOR; a_manager: SESSION_MANAGER_S; a_use_temporary: BOOLEAN)
			-- Launch given generator with the settings stored in `a_session'.
			--
			-- Note: if `a_use_temporary' is true, the temporary types in the session settings are used.
		require
			a_generator_usable: a_generator.is_interface_usable
			a_manager_usable: a_manager.is_interface_usable
			not_launched_yet: not a_generator.has_next_step
		local
			l_session, l_global_session: SESSION_I
		do
			l_session := a_manager.retrieve (True)
			l_global_session := a_manager.retrieve (False)
			enumerate_types (
				agent (s: STRING_32; g: TEST_GENERATOR)
					do
						g.add_class_name (s)
					end
				(?, a_generator),
				a_use_temporary,
				l_session
			)

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.time_out,
					{TEST_SESSION_CONSTANTS}.time_out_default) as l_timeout
			then
				a_generator.set_time_out (l_timeout)
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.invocation_count,
					{TEST_SESSION_CONSTANTS}.invocation_count_default) as l_count
			then
				a_generator.set_test_count (l_count)
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.enable_slicing,
					{TEST_SESSION_CONSTANTS}.enable_slicing_default) as l_enable
			then
				if l_enable then
					a_generator.enable_slicing
				end
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.enable_html_statistics,
					{TEST_SESSION_CONSTANTS}.enable_html_statistics_default) as l_enable
			then
				a_generator.set_html_statistics (l_enable)
			end
				-- We always generate text statistics
			a_generator.set_text_statistics (True)

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.proxy_time_out,
					{TEST_SESSION_CONSTANTS}.proxy_time_out_default) as l_timeout
			then
				a_generator.set_proxy_timeout (l_timeout)
			end

			if
				attached {NATURAL} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.seed,
					{TEST_SESSION_CONSTANTS}.seed_default) as l_seed
			then
				a_generator.set_seed (l_seed)
			end

			if
				attached {BOOLEAN} l_global_session.value_or_default ({TEST_SESSION_CONSTANTS}.debugging,
					{TEST_SESSION_CONSTANTS}.debugging_default) as l_debug
			then
				a_generator.set_debugging (l_debug)
			end

				-- Enable when developing
			a_generator.set_debugging (False)

			launch_test_creation (a_generator, a_manager)
		end

	launch_default_test_extraction (a_creation: ETEST_EXTRACTION;
	                                a_manager: SESSION_MANAGER_S;
	                                a_debugger: DEBUGGER_MANAGER)
			-- Launch given extraction with the settings stored in `a_session'.
		require
			a_creation_usable: a_creation.is_interface_usable
			a_manager_usable: a_manager.is_interface_usable
			not_launched_yet: not a_creation.has_next_step
			a_debugger_valid: a_debugger.application_is_executing and then a_debugger.application_is_stopped
		local
			l_session: SESSION_I
			l_count: INTEGER
			l_stack: detachable EIFFEL_CALL_STACK
			l_cse: CALL_STACK_ELEMENT
			l_list: SEARCH_TABLE [INTEGER]
		do
			l_session := a_manager.retrieve (False)
			if
				attached {NATURAL} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.stack_frames,
					{TEST_SESSION_CONSTANTS}.stack_frames_default) as l_frames
			then
				l_count := l_frames.as_integer_32
			else
				l_count := {TEST_SESSION_CONSTANTS}.stack_frames_default.as_integer_32
			end

			create l_list.make (l_count)
			l_stack := a_debugger.application_status.current_call_stack
			if l_stack /= Void then
				from
					l_stack.start
				until
					l_stack.after or l_list.count >= l_count
				loop
					l_cse := l_stack.item
					if a_creation.is_valid_call_stack_element (l_cse.level_in_stack) then
						l_list.force (l_cse.level_in_stack)
					end
					l_stack.forth
				end
			end

			launch_test_extraction (a_creation, a_manager, l_list)
		end

	launch_test_extraction (a_creation: ETEST_EXTRACTION;
	                        a_manager: SESSION_MANAGER_S;
	                        a_stack_frame_list: SEARCH_TABLE [INTEGER])
			-- Launch given extraction with the settings stored in `a_session'.
		require
			a_creation_usable: a_creation.is_interface_usable
			a_manager_usable: a_manager.is_interface_usable
			not_launched_yet: not a_creation.has_next_step
		local
			l_stack_frame: INTEGER
		do
			from
				a_stack_frame_list.start
			until
				a_stack_frame_list.after
			loop
				l_stack_frame := a_stack_frame_list.item_for_iteration
				if a_creation.is_valid_call_stack_element (l_stack_frame) then
					a_creation.add_call_stack_level (l_stack_frame)
				end
				a_stack_frame_list.forth
			end
			launch_test_creation (a_creation, a_manager)
		end

	launch_manual_test_creation (a_creation: ETEST_MANUAL_CREATION; a_manager: SESSION_MANAGER_S)
			-- Launch given creation with the settings stored in `a_session'.
		require
			a_creation_usable: a_creation.is_interface_usable
			a_manager_usable: a_manager.is_interface_usable
			not_launched_yet: not a_creation.has_next_step
		local
			l_session: SESSION_I
		do
			l_session := a_manager.retrieve (True)

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.routine_name,
					{TEST_SESSION_CONSTANTS}.routine_name_default) as l_routine_name
			then
				a_creation.set_test_routine_name (l_routine_name)
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.has_prepare,
					{TEST_SESSION_CONSTANTS}.has_prepare_default) as l_has_prepare
			then
				a_creation.set_has_prepare (l_has_prepare)
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.has_clean,
					{TEST_SESSION_CONSTANTS}.has_clean_default) as l_has_clean
			then
				a_creation.set_has_clean (l_has_clean)
			end

			launch_test_creation (a_creation, a_manager)
		end

	launch_test_creation (a_creation: ETEST_CREATION; a_manager: SESSION_MANAGER_S)
			-- Launch given creation with the settings stored in `a_session'.
		require
			a_creation_usable: a_creation.is_interface_usable
			a_manager_usable: a_manager.is_interface_usable
			not_launched_yet: not a_creation.has_next_step
		local
			l_session: SESSION_I
			l_list: LIST [STRING]
			l_tag: STRING
		do
			l_session := a_manager.retrieve (True)

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.cluster_name,
					{TEST_SESSION_CONSTANTS}.cluster_name_default) as l_cluster
			then
				a_creation.set_cluster_name (l_cluster)
				if
					attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.path,
						{TEST_SESSION_CONSTANTS}.path_default) as l_path
				then
					a_creation.set_path_name (l_path)
				end
			end

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.class_name,
					{TEST_SESSION_CONSTANTS}.class_name_default) as l_name and then not l_name.is_empty
			then
				a_creation.set_class_name (l_name)
			end

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.tags,
					{TEST_SESSION_CONSTANTS}.tags_default) as l_tags
			then
				l_list := l_tags.split (',')
				from
					l_list.start
				until
					l_list.after
				loop
					l_tag := l_list.item_for_iteration
					if not l_tag.is_empty then
						a_creation.add_tag (l_tag)
					end
					l_list.forth
				end
			end
		end

feature {NONE} -- Events

	on_session_launch_error (a_error: STRING_32)
			-- Called when an error occurred when using `test_suite'
			--
			-- `a_error': Error message.
		do
		end

feature {NONE} -- Helpers

	enumerate_types (receiver: PROCEDURE [STRING_32]; temporary: BOOLEAN; session: SESSION_I)
			-- Enumerate (`temporary') type names from `session' passing them to `receiver' one by one.
		local
			v: ANY
			comma_level: NATURAL_32
			i: INTEGER
			j: INTEGER
			n: INTEGER
		do
				-- Retrieve type list depending on whether temporary variant is used or not.
			if temporary then
				v := session.value_or_default ({TEST_SESSION_CONSTANTS}.temporary_types, {TEST_SESSION_CONSTANTS}.temporary_types_default)
			else
				v := session.value_or_default ({TEST_SESSION_CONSTANTS}.types, {TEST_SESSION_CONSTANTS}.types_default)
			end
			if attached {STRING_8} v as s then
					-- Convert from {STRING_8} to {STRING_32}.
				v := s.as_string_32
			end
			if attached {STRING_32} v as types then
					-- Multiple types are delimited with commas,
					-- but the generic types contain commas inside type name,
					-- so "A [X, Y], B [P, Q]" should give 2 types.
				from
					i := 1
					n := types.count
				until
					i > n
				loop
						-- `i' is set at the start of a type name.
						-- Set `j' at the end of it.
						-- The type name indexes are in range `i |..| j - 1'.
					from
						j := i
					until
						j > n or else (types [j] = ',' and then comma_level = 0)
					loop
						inspect types [j]
						when '[' then
								-- Generic parameter list is open.
							comma_level := comma_level + 1
						when ']' then
								-- Generic parameter list is closed.
							comma_level := comma_level - 1
						else
								-- Nothing to do.
						end
						j := j + 1
					end
					if j > i then
							-- The type name is not empty.
						debug ("to_implement")
								-- Verify type name.
								-- This includes 2 checks:
								-- 1) the name is syntactically valid;
								-- 2) the type is present in the system.
							(create {REFACTORING_HELPER}).to_implement ("Check that the type name is valid.")
						end
						receiver.call ([types.substring (i, j - 1)])
					end
						-- Advance to the next element.
					i := j + 1
				variant
					is_tail_shrinking: n + 2 - i
				end
			end
		end

feature {NONE} -- Constants

	service_not_available_code: NATURAL = 1
	processor_not_available_code: NATURAL = 2
	processor_not_ready_code: NATURAL = 3
	configuration_not_valid_code: NATURAL = 4

	testing_library_uuid: STRING = "B77B3A44-A1A9-4050-8DF9-053598561C33"
	testing_library_path: STRING = "$ISE_LIBRARY/library/testing/testing.ecf"

feature {NONE} -- Internationalization

	e_service_not_available: STRING = "Testing service is currently not available."

	e_execution_unavailable: STRING = "Test execution is currently unavailable"
	e_debugging_unavailable: STRING = "Test debugging is currently unavailable"
	e_creation_unavailable: STRING = "Test creation is currently unavailable"
	e_extraction_unavailable: STRING = "Test extraction is currently unavailable"
	e_generation_unavailable: STRING = "AutoTest is currently unavailable"

	e_execution_not_ready: STRING = "Can not launch test execution because it is currently executing tests."
	e_debugging_not_ready: STRING = "Can not debug test because debugger is currently running."
	e_creation_not_ready: STRING = "Currently unable to create new tests."
	e_extraction_not_ready: STRING = "Can not extract any tests, please check debugger state."
	e_generation_not_ready: STRING = "Can not launch AutoTest because it is already running."

	e_execution_conf_invalid: STRING = "Can not execute selected tests. Make sure none of the tests are already queued or running by a differend executor."
	e_creation_conf_invalid: STRING = "Unable to create new tests."
	e_extraction_conf_invalid: STRING = "Unable to extract tests for selected call stack frames."
	e_generation_conf_invalid: STRING = "Unable to launch AutoTest with provided options."

	e_unkonwn_error: STRING = "Unable to launch processor"

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
