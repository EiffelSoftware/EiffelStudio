note
	description: "Implementation of {TEST_STATISTICS_I}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STATISTICS

inherit
	TEST_STATISTICS_I
		rename
			connection as statistics_connection
		end

	TEST_SUITE_OBSERVER
		redefine
			on_test_added,
			on_test_removed,
			on_session_launched,
			on_session_finished
		end

	TEST_EXECUTION_OBSERVER
		redefine
			on_test_executed
		end

	DISPOSABLE_SAFE

	SHARED_EIFFEL_PROJECT

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
			--
			-- `a_test_suite': Test suite containing tests.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			test_suite := a_test_suite
			test_suite.test_suite_connection.connect_events (Current)

			create statistics_updated_event
			create test_statistics_updated_event

			create test_statistics.make (0)
			if is_project_initialized then
				retrieve_statistics
			else
				eiffel_project.manager.load_agents.extend_kamikaze (agent retrieve_statistics)
				eiffel_project.manager.compile_stop_agents.extend_kamikaze (agent (s: like {WORKBENCH_I}.compilation_status) do retrieve_statistics end)
			end
		ensure
			test_suite_set: test_suite = a_test_suite
		end

	retrieve_statistics
			-- Retrieve `test_statistics' from hard drive.
		local
			l_file: RAW_FILE
			l_retrieval: FUNCTION [RAW_FILE, detachable ANY]
			l_test_suite: like test_suite
		do
			if not has_retrieved_statistics then

				check
					no_statistics_yet: test_statistics.count = 0
				end

				create l_file.make_with_path (eiffel_project.project_directory.testing_results_path.extended (statistics_file_name + "." + statistics_file_extension))
				if l_file.exists then
					l_retrieval := agent (a_file: RAW_FILE): detachable ANY
						local
							l_retried: BOOLEAN
						do
							if not l_retried then
								a_file.open_read
								if attached retrieved_from_medium (a_file) as l_retrieved then
									Result := l_retrieved
								end
							end
							if not a_file.is_closed then
								a_file.close
							end
						rescue
							l_retried := True
							retry
						end

					if attached {like test_statistics} l_retrieval.item ([l_file]) as l_statistics then
						test_statistics := l_statistics
						from
							l_test_suite := test_suite
							l_statistics.start
						until
							l_statistics.after
						loop
							if l_test_suite.has_test (l_statistics.key_for_iteration) then
								account_result (l_test_suite.test (l_statistics.key_for_iteration),
								                l_statistics.item_for_iteration.last_result)
							end
							l_statistics.forth
						end
					end
				end
				has_retrieved_statistics := True
			end
		end

feature -- Access

	test_suite: TEST_SUITE_S
			-- <Precursor>

feature -- Access: general statistics

	test_count: NATURAL
			-- <Precursor>

	executed_test_count: NATURAL
			-- <Precursor>

	passing_test_count: NATURAL
			-- <Precursor>

	failing_test_count: NATURAL
			-- <Precursor>

	unresolved_test_count: NATURAL
			-- <Precursor>

feature -- Access: test statistics

	execution_count (a_test: TEST_I): NATURAL
			-- <Precursor>
		local
			l_stats: like test_statistics
		do
			l_stats := test_statistics
			if l_stats.has (a_test.name) then
				Result := l_stats.item (a_test.name).execution_count
			end
		end

	last_result (a_test: TEST_I): TEST_RESULT_I
			-- <Precursor>
		do
			Result := test_statistics.item (a_test.name).last_result
		end

feature {NONE} -- Access

	test_statistics: TAG_HASH_TABLE [like new_statistics_data]
			-- Table containing statistics

feature {NONE} -- Access: event connection

	statistics_connection: EVENT_CONNECTION_I [TEST_STATISTICS_OBSERVER, TEST_STATISTICS_I]
			-- <Precursor>
		local
			l_result: like internal_statistics_connection
		do
			l_result := internal_statistics_connection
			if l_result = Void then
				create {EVENT_CONNECTION [TEST_STATISTICS_OBSERVER, TEST_STATISTICS_I]} l_result.make (
					agent (an_observer: TEST_STATISTICS_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE]]
						do
							Result := <<
									[statistics_updated_event, agent an_observer.on_statistics_updated],
									[test_statistics_updated_event, agent an_observer.on_test_statistics_updated]
								>>
						end
					)
				internal_statistics_connection := l_result
				automation.auto_dispose (l_result)
			end
			Result := l_result
		end

	internal_statistics_connection: detachable like statistics_connection
			-- Cached version of `statistics_connection'.
			-- Note: Do not use directly!

feature {NONE} -- Status report

	has_retrieved_statistics: BOOLEAN
			-- Have statistics been retrieved from disk?

	is_project_initialized: BOOLEAN
			-- Has project been initialized?
		local
			l_project: like eiffel_project
		do
			l_project := eiffel_project
			if l_project.initialized and then l_project.system_defined then
				if attached l_project.project_directory as l_dir then
					Result := not l_dir.testing_results_path.is_empty
				end
			end
		ensure
			result_implies_valid_testing_directory: Result implies
				(attached eiffel_project.project_directory as l_dir and then not l_dir.testing_results_path.is_empty)
		end

feature {TEST_SUITE_S} -- Events: test suite

	on_test_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		local
			l_name: IMMUTABLE_STRING_32
			l_stats: like test_statistics
		do
			test_count := test_count + 1
			l_name := a_test.name
			l_stats := test_statistics
			if l_stats.has (l_name) then
				account_result (a_test, l_stats.item (l_name).last_result)
				test_statistics_updated_event.publish ([Current, a_test])
			end
			statistics_updated_event.publish ([Current])
		end

	on_test_removed (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		local
			l_name: IMMUTABLE_STRING_32
			l_stats: like test_statistics
		do
			test_count := test_count - 1
			l_name := a_test.name
			l_stats := test_statistics
			if l_stats.has (l_name) then
				discount_result (l_stats.item (l_name).last_result)
				l_stats.remove (l_name)
			end
			statistics_updated_event.publish ([Current])
		end

	on_session_launched (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			if attached {TEST_EXECUTION_I} a_session as l_execution then
				l_execution.execution_connection.connect_events (Current)
			end
		end

	on_session_finished (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			if attached {TEST_EXECUTION_I} a_session as l_execution then
				l_execution.execution_connection.disconnect_events (Current)
			end

			if is_project_initialized then
				store_statistics
			end
		end

feature {TEST_EXECUTION_I} -- Events: test execution

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: TEST_RESULT_I)
			-- <Precursor>
		local
			l_name: IMMUTABLE_STRING_32
			l_stats: like test_statistics
			l_data: like new_statistics_data
		do
			if has_retrieved_statistics then
				l_name := a_test.name
				l_stats := test_statistics
				if not l_stats.has (l_name) then
					l_stats.force (new_statistics_data (a_result), l_name)
				else
					l_data := l_stats.item (l_name)
					discount_result (l_data.last_result)
					l_data.last_result := a_result
				end
				account_result (a_test, a_result)
				test_statistics_updated_event.publish ([Current, a_test])
				statistics_updated_event.publish ([Current])
			end
		end

feature {NONE} -- Events

	statistics_updated_event: EVENT_TYPE [TUPLE [TEST_STATISTICS_I]]
			-- <Precursor>

	test_statistics_updated_event: EVENT_TYPE [TUPLE [TEST_STATISTICS_I, TEST_I]]
			-- <Precursor>

feature {NONE} -- Implementation

	store_statistics
			-- Store statistics to disk
		require
			project_initialized: is_project_initialized
		local
			l_retried: BOOLEAN
			l_raw_file: detachable RAW_FILE
			u: GOBO_FILE_UTILITIES
		do
			if not l_retried then
				u.create_directory_path (eiffel_project.project_directory.testing_results_path)
				create l_raw_file.make_with_path (
					eiffel_project.project_directory.testing_results_path.extended (statistics_file_name + "." + statistics_file_extension))
				l_raw_file.open_write
				store_in_medium (test_statistics, l_raw_file)
			end
			if l_raw_file /= Void and then not l_raw_file.is_closed then
				l_raw_file.close
			end
		rescue
			l_retried := True
			retry
		end

	account_result (a_test: TEST_I; a_result: TEST_RESULT_I)
			-- Account for given result in `*_count' queries.
		local
			l_tag_tree: TAG_TREE [TEST_I]
			l_table: TAG_SEARCH_TABLE
			l_formatter: TAG_FORMATTER
		do
			l_tag_tree := test_suite.tag_tree
			l_formatter := l_tag_tree.formatter
			if l_tag_tree.has_item (a_test) then
				l_table := l_tag_tree.item_suffixes (result_prefix, a_test)
				from
					l_table.start
				until
					l_table.after
				loop
					l_tag_tree.remove_tag (a_test, l_formatter.join_tags (result_prefix, l_table.item_for_iteration))
					l_table.forth
				end
			end
			executed_test_count := executed_test_count + 1
			if a_result.is_pass then
				passing_test_count := passing_test_count + 1
				l_tag_tree.add_tag (a_test, l_formatter.join_tags (result_prefix, pass_suffix))
			elseif a_result.is_fail then
				failing_test_count := failing_test_count + 1
				l_tag_tree.add_tag (a_test, l_formatter.join_tags (result_prefix, fail_suffix))
			else
				unresolved_test_count := unresolved_test_count + 1
				l_tag_tree.add_tag (a_test, l_formatter.join_tags (result_prefix, unresolved_suffix))
			end
		end

	discount_result (a_result: TEST_RESULT_I)
			-- Discount for given result in `*_count' queries.
		do
			executed_test_count := executed_test_count - 1
			if a_result.is_pass then
				passing_test_count := passing_test_count - 1
			elseif a_result.is_fail then
				failing_test_count := failing_test_count - 1
			else
				unresolved_test_count := unresolved_test_count - 1
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			test_suite.test_suite_connection.disconnect_events (Current)
		end

feature {NONE} -- Factory

	new_statistics_data (a_result: TEST_RESULT_I): TUPLE [execution_count: NATURAL; last_result: TEST_RESULT_I]
			-- Create new statistics tuple
		do
			Result := [{NATURAL} 1, a_result]
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	statistics_file_name: STRING = "statistics"
	statistics_file_extension: STRING = "map"
			-- Statistics file name

	result_prefix: STRING = "result"
	pass_suffix: STRING = "pass"
	fail_suffix: STRING = "fail"
	unresolved_suffix: STRING = "unresolved"
			-- Tags for result status

invariant
	collect_stats_after_retrieving: test_statistics.count > 0 implies has_retrieved_statistics

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
