note
	description: "[
		Objects implementing {TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SUITE

inherit
	TEST_SUITE_S

	DISPOSABLE_SAFE

	ROTA_OBSERVER
		redefine
			on_task_finished
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_rota: ROTA_S
		do
			create test_map.make (10)
			test_map.compare_objects

				-- Events
			create test_added_event
			create test_removed_event
			create session_launched_event
			create session_finished_event

			create record_repository.make

			if rota.is_service_available then
				l_rota := rota.service
				if l_rota.is_interface_usable then
					l_rota.connection.connect_events (Current)
				end
			end
			create factories.make (10)
			create internal_running_sessions.make (10)

				-- register test executor
			register_factory (create {TEST_DEFAULT_SESSION_FACTORY [TEST_EXECUTION]})

			create tag_tree.make (create {TAG_DIRECTORY_FORMATTER}, create {EC_TAG_TREE_NODE_FACTORY [TEST_I]})
			create statistics.make (Current)
		end

feature -- Access

	tests: SEQUENCE [TEST_I]
			-- <Precursor>
		do
			Result := test_map.linear_representation
		end

	test (an_identifier: READABLE_STRING_GENERAL): TEST_I
			-- <Precursor>
		do
			Result := test_map.item (an_identifier)
		end

	record_repository: TEST_RECORD_REPOSITORY
			-- <Precursor>

	tag_tree: TAG_TREE [like test]
			-- <Precursor>

	statistics: TEST_STATISTICS
			-- <Precursor>

feature -- Access: output

	output (a_session: TEST_SESSION_I): detachable OUTPUT_I
			-- <Precursor>
			--
			-- Note: the session does not have to care about clearing the output when launching, since this
			--       is done by `Current'.
		local
			l_output_manager: OUTPUT_MANAGER_S
			l_output: OUTPUT_I
		do
			if a_session = current_output_session then
				Result := internal_output
			end
		end

feature -- Access: sessions

	running_sessions: ARRAYED_LIST [TEST_SESSION_I]
			-- <Precursor>
		local
			l_sessions: like internal_running_sessions
		do
			l_sessions := internal_running_sessions
			create Result.make (l_sessions.count)
			from
				l_sessions.start
			until
				l_sessions.after
			loop
				Result.force (l_sessions.item_for_iteration.session)
				l_sessions.forth
			end
		end

feature -- Access: connection point

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
									[session_finished_event, agent an_observer.on_session_finished]
								>>
						end
					)
				internal_test_suite_connection := l_result
				automation.auto_dispose (l_result)
			end
			Result := l_result
		end

	internal_test_suite_connection: detachable like test_suite_connection
			-- Cached version of `test_suite_connection'.
			-- Note: Do not use directly!

feature {NONE} -- Access

	test_map: TAG_HASH_TABLE [like test]
			-- Table mapping test names to their instances
			--
			-- key: Test name
			-- value: Test instance

feature {NONE} -- Access: sessions

	factories: ARRAYED_LIST [TEST_SESSION_FACTORY [TEST_SESSION_I]]
			-- List containing all registered factories

	internal_running_sessions: ARRAYED_LIST [TUPLE [session: TEST_SESSION_I; record: TEST_SESSION_RECORD]]
			-- List of running sessions

	frozen rota: SERVICE_CONSUMER [ROTA_S]
			-- Access to rota service {ROTA_S}
		do
			create Result
		end

feature {NONE} -- Access: output

	frozen output_manager: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			-- Access to output manager service {OUTPUT_MANAGER_S}
		do
			create Result
		end

	internal_output: like output
			-- Usable OUTPUT_I instance for `output'
		local
			l_output_manager: OUTPUT_MANAGER_S
			l_output: OUTPUT_I
		do
			if output_manager.is_service_available then
				l_output_manager := output_manager.service
				if
					l_output_manager.is_interface_usable and then
					l_output_manager.is_valid_registration_key (output_key) and then
					l_output_manager.is_output_available (output_key)
				then
					l_output := l_output_manager.output (output_key)
					if l_output.is_interface_usable then
						Result := l_output
					end
				end
			end
		ensure
			result_attached_implies_usable: Result /= Void implies Result.is_interface_usable
		end

	output_key: UUID
			-- Key for testing output
		once
			Result := (create {OUTPUT_MANAGER_KINDS}).testing
		end

	current_output_session: detachable TEST_SESSION_I
			-- Session currently using the testing output

feature -- Query

	has_test (an_identifier: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			Result := test_map.has (an_identifier)
		end

feature -- Status setting: tests

	add_test (a_test: like test)
			-- <Precursor>
		do
			test_map.force (a_test, a_test.name)
			test_added_event.publish ([Current, a_test])
		end

	remove_test (a_test: like test)
			-- <Precursor>
		do
			test_map.remove (a_test.name)
			if tag_tree.has_item (a_test) then
				tag_tree.remove_all_tags (a_test)
			end
			test_removed_event.publish ([Current, a_test])
		end

feature -- Status setting: sessions

	launch_session (a_session: TEST_SESSION_I)
			-- <Precursor>
		local
			l_rota: ROTA_S
			l_record: TEST_SESSION_RECORD
		do
			if current_output_session = Void then
				current_output_session := a_session
				if attached internal_output as l_output then
					l_output.clear
					l_output.activate (False)
				end
			end
			a_session.start
			if a_session.has_next_step then
				l_record := a_session.record
				record_repository.append_record (l_record)
				internal_running_sessions.force ([a_session, l_record])
				session_launched_event.publish ([Current, a_session])
				if rota.is_service_available then
					l_rota := rota.service
					if l_rota.is_interface_usable and not l_rota.has_task (a_session) then
						l_rota.run_task (a_session)
					end
				end
			elseif current_output_session = a_session then
				current_output_session := Void
			end
		end

feature -- Element change

	register_factory (a_factory: TEST_SESSION_FACTORY [TEST_SESSION_I])
			-- <Precursor>
		do
			factories.force (a_factory)
		end

feature -- Basic operations

	new_session (a_type: TYPE [TEST_SESSION_I]): detachable TEST_SESSION_I
			-- <Precursor>
		local
			l_list: like factories
			l_factory: TEST_SESSION_FACTORY [TEST_SESSION_I]
		do
			from
				l_list := factories
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_factory := l_list.item_for_iteration
				if l_factory.type.conforms_to (a_type) then
					Result := l_factory.new_session (Current)
				end
				l_list.forth
			end
		end

feature -- Events

	test_added_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	test_removed_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	session_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

	session_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

feature {ROTA_S} -- Events: rota

	on_task_finished (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		local
			l_running: like internal_running_sessions
			l_session: TEST_SESSION_I
		do
			from
				l_running := internal_running_sessions
				l_running.start
			until
				l_running.off
			loop
				l_session := l_running.item_for_iteration.session
				if l_session = a_task then
					if current_output_session = l_session then
						current_output_session := Void
					end
					l_running.remove
					session_finished_event.publish ([Current, l_session])
					l_running.go_i_th (0)
				else
					l_running.forth
				end
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_rota: ROTA_S
		do
			if a_explicit then
				if rota.is_service_available then
					l_rota := rota.service
					if l_rota.is_interface_usable then
						l_rota.connection.disconnect_events (Current)
					end
				end
			end
		end

invariant
	test_map_attached: test_map /= Void
	test_map_contains_usables: test_map.linear_representation.for_all (agent {TEST_I}.is_interface_usable)

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
