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



-- OBSOLETE

	TEST_PROCESSOR_REGISTRAR_I
		redefine
			is_valid_processor
		end

--	TEST_COLLECTION
--		rename
--			make as make_collection,
--			are_tests_available as is_project_initialized
--		redefine
--			is_interface_usable
--		end

create
	make

feature -- Access

	tests: DS_LINEAR [TEST_I]
			-- <Precursor>
		do
			Result := test_map
		end

	test (an_identifier: READABLE_STRING_GENERAL): TEST_I
			-- <Precursor>
		do
			Result := test_map.item (an_identifier)
		end

feature -- Access: tagging

	tag_tree: TAG_TREE [like test]
			-- <Precursor>

feature {NONE} -- Access

	test_map: DS_HASH_TABLE [like test, READABLE_STRING_GENERAL]
			-- Table mapping test names to their instances
			--
			-- key: Test name
			-- value: Test instance

	frozen rota: SERVICE_CONSUMER [ROTA_S]
			-- Access to rota service {ROTA_S}
		do
			create Result
		end

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
		do
			a_session.start
			session_launched_event.publish ([Current, a_session])
			if rota.is_service_available then
				l_rota := rota.service
				if l_rota.is_interface_usable and not l_rota.has_task (a_session) then
					l_rota.run_task (a_session)
				end
			end
		end

feature -- Events


	test_added_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	test_removed_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	test_result_added_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test; test_result: EQA_TEST_RESULT]]
			-- <Precursor>

	session_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

	session_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

feature {ROTA_S} -- Events: rota

	on_task_finished (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			if
				attached {TEST_SESSION_I} a_task as l_session and then
				l_session.test_suite = Current
			then
				session_finished_event.publish ([Current, l_session])
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






-- OBSOLETE FEATURES

feature {NONE} -- Initialization

	make (a_project_helper: like eiffel_project_helper)
			-- Initialize `Current'.
		local
			l_rota: ROTA_S


			l_project: E_PROJECT
			l_project_factory: SHARED_EIFFEL_PROJECT
		do
			create test_map.make_default
			test_map.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [READABLE_STRING_GENERAL]})

				-- Events
			create test_added_event
			create test_removed_event
			create test_result_added_event
			create session_launched_event
			create session_finished_event

			if rota.is_service_available then
				l_rota := rota.service
				if l_rota.is_interface_usable then
					l_rota.connection.connect_events (Current)
				end
			end



			-- OBOLETE CREATIONS
			--make_collection

				-- Create registrar
			create internal_processors.make

				-- Create events
			create processor_launched_event
			create processor_proceeded_event
			create processor_finished_event
			create processor_stopped_event
			create processor_error_event

			create l_project_factory
			internal_project := l_project_factory.eiffel_project
			eiffel_project_helper := a_project_helper

			if (create {SHARED_FLAGS}).is_gui then
				create {EV_TEST_PROCESSOR_SCHEDULER} scheduler.make (Current)
			else
				create {TTY_TEST_PROCESSOR_SCHEDULER} scheduler.make (Current)
			end

				-- Create tree
			create tag_tree.make (create {TAG_DIRECTORY_FORMATTER},
			                      create {EC_TAG_TREE_NODE_FACTORY [TEST_I]})

		end

feature -- Access

	eiffel_project_helper: TEST_PROJECT_HELPER_I
			-- <Precursor>

	eiffel_project: E_PROJECT
			-- <Precursor>
		do
			Result := internal_project
		end

	processor_registrar: TEST_PROCESSOR_REGISTRAR_I
			-- <Precursor>
		do
			Result := Current
		end

	processor_instances (a_test_suite: TEST_SUITE_S): DS_LINEAR [TEST_PROCESSOR_I]
			-- <Precursor>
		do
			if a_test_suite = Current then
				Result := internal_processors
			else
				Result := empty_processor_list
			end
		end

	scheduler: TEST_PROCESSOR_SCHEDULER_I
			-- <Precursor>

feature {NONE} -- Access

	internal_project: like eiffel_project

	internal_processors: DS_LINKED_LIST [TEST_PROCESSOR_I]
			-- Internal storage for `processor_instances'

	empty_processor_list: DS_LINEAR [TEST_PROCESSOR_I]
			-- Empty list for `processor_instances'
		once
			create {attached DS_LINKED_LIST [TEST_PROCESSOR_I]} Result.make
		end

feature -- Status report

	is_project_initialized: BOOLEAN
			-- <Precursor>
		do
			Result := 	internal_project.initialized and then
				internal_project.workbench.universe_defined and then
				internal_project.system_defined and then
				internal_project.system.universe.target /= Void
		end

	is_registered (a_processor: TEST_PROCESSOR_I): BOOLEAN
			-- <Precursor>
		do
			Result := internal_processors.has (a_processor)
		end

	count_executed: NATURAL
			-- <Precursor>

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature {TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: STRING; a_token_values: TUPLE; a_processor: TEST_PROCESSOR_I)
			-- <Precursor>
		do
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			processor_error_event.publish ([as_attached, a_processor.as_attached, a_error.as_attached, a_token_values.as_attached])
		end

feature {TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: TEST_I; a_executor: TEST_EXECUTOR_I)
			-- <Precursor>
		do
			a_test.set_queued (a_executor)
		end

	set_test_running (a_test: TEST_I)
			-- <Precursor>
		do
			a_test.set_running
		end

	add_outcome_to_test (a_test: TEST_I; a_outcome: EQA_TEST_RESULT)
			-- <Precursor>
		local
			l_old, l_new: NATURAL_8
		do
			if a_test.is_outcome_available then
				l_old := a_test.last_outcome.status
			else
				count_executed := count_executed + 1
			end
			l_new := a_outcome.status
			if l_old /= l_new then
				if l_new = {EQA_TEST_RESULT_STATUS_TYPES}.failed then
					count_failing := count_failing + 1
				elseif l_new = {EQA_TEST_RESULT_STATUS_TYPES}.passed then
					count_passing := count_passing + 1
				end
				if l_old = {EQA_TEST_RESULT_STATUS_TYPES}.failed then
					count_failing := count_failing - 1
				elseif l_old = {EQA_TEST_RESULT_STATUS_TYPES}.passed then
					count_passing := count_passing - 1
				end
			end
			a_test.add_outcome (a_outcome)
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_result_added_event.publish ([Current, a_test, a_outcome])
			a_test.clear_changes
		end

	set_test_aborted (a_test: TEST_I)
			-- <Precursor>
		do
			a_test.abort
		end

feature -- Query

	is_valid_type (a_type: TYPE [TEST_PROCESSOR_I]; a_test_suite: TEST_SUITE_S): BOOLEAN
			-- <Precursor>
		local
			l_start: BOOLEAN
		do
			from
			until
				Result or (l_start and internal_processors.after)
			loop
				if not internal_processors.off then
					Result := a_type.attempt (internal_processors.item_for_iteration) /= Void
				end
				if not Result then
					if l_start then
						internal_processors.forth
					else
						internal_processors.start
						l_start := True
					end
				end
			end
		end

	is_valid_processor (a_processor: TEST_PROCESSOR_I): BOOLEAN
			-- <Precursor>
		do
			Result := a_processor.test_suite = Current
		end

	processor (a_type: TYPE [TEST_PROCESSOR_I]; a_test_suite: TEST_SUITE_S): TEST_PROCESSOR_I
			-- <Precursor>
		local
			l_start: BOOLEAN
			l_result: detachable like processor
		do
			from
			until
				l_result /= Void or (l_start and internal_processors.after)
			loop
				if not internal_processors.off then
					l_result := a_type.attempt (internal_processors.item_for_iteration)
				end
				if l_result = Void then
					if l_start then
						internal_processors.forth
					else
						internal_processors.start
						l_start := True
					end
				end
			end
			check l_result /= Void end
			Result := l_result
		end

feature -- Element change

	register (a_processor: TEST_PROCESSOR_I)
			-- <Precursor>
		do
			internal_processors.force_last (a_processor)
		end

	unregister (a_processor: TEST_PROCESSOR_I)
			-- <Precursor>
		do
			internal_processors.start
			internal_processors.search_forth (a_processor)
			if not internal_processors.off then
				internal_processors.remove_at
			end
		end

feature {NONE} -- Element change

feature -- Events

	processor_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_proceeded_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_stopped_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_error_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; processor: TEST_PROCESSOR_I; error: STRING; token_values: TUPLE]]
			-- <Precursor>

invariant
	test_map_attached: test_map /= Void
	test_map_contains_usables: test_map.for_all (agent {TEST_I}.is_interface_usable)

-- OBSOLETE INVARIANTS

	internal_processors_usable: internal_processors.for_all (agent {attached TEST_PROCESSOR_I}.is_interface_usable)

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
