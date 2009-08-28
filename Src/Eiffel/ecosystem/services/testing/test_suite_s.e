note
	description: "[
		Service interface for managing, creating and executing tests.
		
		The test suite provides a registrar containing a number of available test processors. Test
		processors are usedon_ to perform actions on existing tests or to produce new tests. See
		{TEST_PROCESSOR_I} and descendants for more details. Test processors can only be launched
		by the test suite.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SUITE_S

inherit
	SERVICE_I

	EVENT_CONNECTION_POINT_I [TEST_SUITE_OBSERVER, TEST_SUITE_S]
		rename
			connection as test_suite_connection
		end

feature -- Access

	tag_tree: TAG_TREE [like test]
			-- Tag tree containing tagging structure for all tests in `Current'.
		require
			usable: is_interface_usable
			initialized: is_project_initialized
		deferred
		end

	test (an_identifier: READABLE_STRING_GENERAL): TEST_I
			-- Test for given identifier
			--
			-- `an_identifier': Indentifier for which corresponding test should be returned.
			-- `Result': Test for `an_identifier'.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
		end

	tests: DS_LINEAR [like test]
			-- All tests in `Current'
			--
			-- Note: this will be replaced by an arrayed list soon.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

	record_repository: TEST_RECORD_REPOSITORY_I
			-- Repository containing records of previously launched sessions
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
		end

feature -- Access: output

	output (a_session: TEST_SESSION_I): detachable OUTPUT_I
			-- Output for printing log messages for given session.
			--
			-- `a_session': A running session.
		require
			a_session_attached: a_session /= Void
			a_session_usable: a_session.is_interface_usable
		deferred
		ensure
			result_attached_implies_usable: Result /= Void implies Result.is_interface_usable
		end

feature -- Query

	has_test (an_identifier: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `Current' have a test for given identifier?
			--
			-- `an_identifier': Name of a test.
			-- `Result': True if `Current' contains a test with that name, False otherwise.
		require
			usable: is_interface_usable
			an_identifier_attached: an_identifier /= Void
		deferred
		end

feature -- Status setting: tests

	add_test (a_test: like test)
			-- Add test to `Current'.
			--
			-- `a_test': Test to be added.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			test_not_added: not has_test (a_test.name)
		deferred
		end

	remove_test (a_test: like test)
			-- Remove test from `Current'.
			--
			-- Note: there is no need to remove tags from `tag_tree' since that is done automatically.
			--
			-- `a_test': Test to be removed.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			test_added: has_test (a_test.name) and then test (a_test.name) = a_test
		deferred
		end

feature -- Status setting: sessions

	launch_session (a_session: TEST_SESSION_I)
			-- Launch new testing related session.
			--
			-- `a_session': Session to be launched.
		require
			a_session_attached: a_session /= Void
			usable: is_interface_usable
			a_session_usable: a_session.is_interface_usable
			not_running: not a_session.has_next_step
		deferred
		ensure
			record_added_to_repo: a_session.has_next_step implies
				record_repository.has_record (a_session.record)
		end

feature -- Element change

	register_factory (a_factory: TEST_SESSION_FACTORY [TEST_SESSION_I])
			-- Register factory for creating a new session
			--
			-- `a_factory': New factory.
		require
			a_factory_attached: a_factory /= Void
		deferred
		ensure
				-- Note: this will instanciate a new session
			factory_registered: new_session (a_factory.type) /= Void
		end

feature -- Basic operations

	new_session (a_type: TYPE [TEST_SESSION_I]): detachable TEST_SESSION_I
			-- Create new session of given type.
			--
			-- `a_type': Type specifiying what session should be created.
		require
			a_type_attached: a_type /= Void
		deferred
		ensure
			result_conforms: Result /= Void implies a_type.attempt (Result) /= Void
			result_valid: Result /= Void implies Result.test_suite = Current
			result_not_running: Result /= Void implies not Result.has_next_step
		end

feature {NONE} -- Events

	test_added_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- Events called after a test was added to `Current'.
			--
			-- test_suite: `Current'
			-- test: Test added to `Current'
		require
			usable: is_interface_usable
		deferred
		end

	test_removed_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- Events called after an item was removed from `items'.
			--
			-- test_suite: `Current'
			-- test: Test removed from `Current'
		require
			usable: is_interface_usable
		deferred
		end

	session_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- Events called when a session is launched through `launch_session'.
		require
			usable: is_interface_usable
		deferred
		end

	session_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- Events called when a session is finished.
		require
			usable: is_interface_usable
		deferred
		end




-- OBSOLETE FEATURES


feature -- Access

	eiffel_project_helper: TEST_PROJECT_HELPER_I
			-- Project helper for compiling, debugging and adding new classes.
		require
			usable: is_interface_usable
			initialized: is_project_initialized
		deferred
		end

	eiffel_project: E_PROJECT
			-- Project containing actual eiffel classes
		require
			usable: is_interface_usable
			initialized: is_project_initialized
		deferred
		ensure
			project_initialized: Result.initialized and Result.workbench.universe_defined and
			                     Result.system_defined and then Result.universe.target /= Void
		end

	executor (a_type: TYPE [TEST_OBSOLETE_EXECUTOR_I]): TEST_OBSOLETE_EXECUTOR_I
			-- Test executor registered under `a_type'.
			--
			-- `a_type': Type under which executor is registered.
			-- `Result': Executor registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if attached {like executor} processor_registrar.processor (a_type, Current) as l_executor then
				Result := l_executor
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	factory (a_type: TYPE [TEST_CREATOR_I]): TEST_CREATOR_I
			-- Test factory registered under `a_type'.
			--
			-- `a_type': Type under which factory is registered.
			-- `Result': Factory registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if attached {like factory} processor_registrar.processor (a_type, Current) as l_factory then
				Result := l_factory
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	processor_registrar: TEST_PROCESSOR_REGISTRAR_I
			-- Registrar managing available test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

	scheduler: TEST_PROCESSOR_SCHEDULER_I
			-- Scheduler for launching test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			schduler_usable: Result.is_interface_usable
		end

feature -- Status report

	is_project_initialized: BOOLEAN
			-- Has `eiffel_project' been successfully compiled yet?
		deferred
		end

	count_executed: NATURAL
			-- Number of tests in `test' which have been executed
		require
			usable: is_interface_usable
		deferred
		end

	count_passing: NATURAL
			-- Number of passing tests in `tests'
		require
			usable: is_interface_usable
		deferred
		end

	count_failing: NATURAL
			-- Number of failing tests in `tests'
		require
			usable: is_interface_usable
		deferred
		end

feature {TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: STRING; a_token_values: TUPLE; a_processor: TEST_PROCESSOR_I)
			-- Propagate error message raised by processor
		require
			usable: is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
		deferred
		end

feature {TEST_OBSOLETE_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: TEST_I; a_executor: TEST_OBSOLETE_EXECUTOR_I)
			-- Set status of test to queued and notify observers.
			--
			-- `a_test': Test being queued.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
		deferred
		ensure
			a_test_queued: a_test.is_queued
			a_executor_queues_a_test: a_test.executor = a_executor
		end

	set_test_running (a_test: TEST_I)
			-- Set status of test to running and notify observers.
			--
			-- `a_test': Test being executed.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_queued: a_test.is_queued
		deferred
		ensure
			a_test_running: a_test.is_running
		end

	add_outcome_to_test (a_test: TEST_I; a_outcome: EQA_RESULT)
			-- Add outcome to test being executed and notify observers.
			--
			-- `a_test': Test for which outcome is available.
			-- `a_outcome': Outcome received from last execution.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_running: a_test.is_running
		deferred
		ensure
			a_test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
			a_test_has_outcome: a_test.is_outcome_available
			a_outcome_is_last_outcome: a_test.last_outcome = a_outcome
		end

	set_test_aborted (a_test: TEST_I)
			-- Abort execution of test and notify observers.
			--
			-- `a_test': Test which was not completely executed.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_queued_or_running: (a_test.is_queued or a_test.is_running)
		deferred
		ensure
			a_test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
		end

feature -- Events

	processor_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- Events called when `Current' launches a processor.
			--
			-- test_suite: `Current'
			-- processor: Processor which was launched by `Current'
		require
			usable: is_interface_usable
		deferred
		end

	processor_proceeded_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- Events called after some processor has proceeded with its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that proceeded with its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_stopped_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- Events called when a processor has completely stopped
			--
			-- Note: It is not guaranteed that all observers will receive this notification. This is because
			--       any observer in the list can restart the processor during the notification.
			--
			-- test_suite: `Current'
			-- processor: Processor that has just stopped
		require
			usable: is_interface_usable
		deferred
		end

	processor_error_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I; error: STRING; token_values: TUPLE]]
			-- Events called when a processor raises an error message
			--
			-- test_suite: `Current'
			-- processor: Processor raising error
			-- error: Readable error message containing tokens
			-- token_values: Values for tokens in error message
		require
			usable: is_interface_usable
		deferred
		end

feature -- Event: Connection point

	test_suite_connection: EVENT_CONNECTION_I [TEST_SUITE_OBSERVER, TEST_SUITE_S]
			-- <Precursor>
		local
			l_result: like internal_test_suite_connection
		do
			l_result := internal_test_suite_connection
			if l_result = Void then
				create {EVENT_CONNECTION [TEST_SUITE_OBSERVER, TEST_SUITE_S]} l_result.make (
					agent (an_observer: TEST_SUITE_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
									[test_added_event, agent an_observer.on_test_added],
									[test_removed_event, agent an_observer.on_test_removed],
									[session_launched_event, agent an_observer.on_session_launched],
									[session_finished_event, agent an_observer.on_session_finished],
									[processor_launched_event, agent an_observer.on_processor_launched],
									[processor_proceeded_event, agent an_observer.on_processor_proceeded],
									[processor_finished_event, agent an_observer.on_processor_finished],
									[processor_stopped_event, agent an_observer.on_processor_stopped],
									[processor_error_event, agent an_observer.on_processor_error]
								>>
						end
					)
				internal_test_suite_connection := l_result
				automation.auto_dispose (l_result)
			end
			Result := l_result
		end

feature {NONE} -- Implementation: Internal cache

	internal_test_suite_connection: detachable like test_suite_connection
			-- Cached version of `test_suite_connection'.
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
