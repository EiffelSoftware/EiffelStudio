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

	tests: SEQUENCE [like test]
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

	statistics: TEST_STATISTICS_I
			-- Test statistics
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

feature -- Access: sessions

	running_sessions: ARRAYED_LIST [TEST_SESSION_I]
			-- Sessions which have been launched through `Current' and are still running.
			--
			-- `Result': Running sessions.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			results_valid: Result.for_all (
				agent (a_session: TEST_SESSION_I): BOOLEAN
					do
						Result := a_session.is_interface_usable and then
						          a_session.test_suite = Current
					end)
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
				-- Note: We use `False' as argument for `a_is_gui' but that does not matter,
				-- it is just to show that the type is properly registered.
				--| We cannot instantiate a session now as it relies on other stuff to be initialized.
				--| TODO: Redoe the service system of EiffelStudio to avoid this kind of situation.
			-- factory_registered: new_session (a_factory.type, False) /= Void
		end

feature -- Basic operations

	new_session (a_type: TYPE [TEST_SESSION_I]; a_is_gui: BOOLEAN): detachable TEST_SESSION_I
			-- Create new session of given type.
			--
			-- `a_type': Type specifiying what session should be created.
			-- `a_is_gui': Is session created for a UI or for batch?
		require
			a_type_attached: a_type /= Void
		deferred
		ensure
			result_conforms: Result /= Void implies attached a_type.attempted (Result)
			results_usable: Result /= Void implies Result.is_interface_usable
			result_valid: Result /= Void implies Result.test_suite = Current
			result_not_running: Result /= Void implies not Result.has_next_step
		end

feature {NONE} -- Events

	test_added_event: EVENT_TYPE_I [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- Events called after a test was added to `Current'.
			--
			-- test_suite: `Current'
			-- test: Test added to `Current'
		require
			usable: is_interface_usable
		deferred
		end

	test_removed_event: EVENT_TYPE_I [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- Events called after an item was removed from `items'.
			--
			-- test_suite: `Current'
			-- test: Test removed from `Current'
		require
			usable: is_interface_usable
		deferred
		end

	session_launched_event: EVENT_TYPE_I [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- Events called when a session is launched through `launch_session'.
		require
			usable: is_interface_usable
		deferred
		end

	session_finished_event: EVENT_TYPE_I [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- Events called when a session is finished.
		require
			usable: is_interface_usable
		deferred
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
