note
	description: "[
		Notebook widgets which are capable of displaying test session records of a certain type.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_RECORDS_TAB [G -> TEST_SESSION_I, H -> TEST_SESSION_RECORD]

inherit
	ES_TEST_SESSION_WIDGET_NEW [G]
		rename
			make as make_session_widget
		undefine
			internal_detach_entities
		redefine
			on_before_initialize,
			on_after_initialized,
			internal_recycle,
			on_typed_session_launched,
			on_typed_session_finished
		end

	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_session_widget
		undefine
			on_before_initialize,
			on_after_initialized,
			internal_recycle
		end

	TEST_RECORD_REPOSITORY_OBSERVER
		redefine
			on_record_added,
			on_record_removed
		end

feature {NONE} -- Initialization

	make (a_icons_provider: like icons_provider)
			-- Initialize `Current'.
			--
			-- `a_icons_provider': Icons provider for testing tool icons.
		require
			a_icons_provider_attached: a_icons_provider /= Void
		do
			make_session_widget
			icons_provider := a_icons_provider
		ensure
			icons_provider_set: icons_provider = a_icons_provider
		end

	build_notebook_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			initialize_grid
			a_widget.extend (grid)
		end

	initialize_grid
			-- Initialize `grid'
		local
			l_grid: like grid
			l_col: EV_GRID_COLUMN
		do
			create l_grid
			l_grid.enable_tree
			l_grid.hide_tree_node_connectors
			l_grid.enable_single_row_selection

			l_grid.set_column_count_to (5)
			l_grid.enable_auto_size_best_fit_column (1)
			l_col := l_grid.column (1)
			l_col.header_item.set_text ("Results")

			l_col := l_grid.column (2)
			l_col.set_width (20)

			l_col := l_grid.column (3)
			l_col.set_width (20)

			l_col := l_grid.column (4)
			l_col.set_width (20)

			l_col := l_grid.column (5)
			l_col.set_width (10)

			grid := l_grid
		end

	on_before_initialize
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET_NEW}
			create records.make_default
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET_NEW}
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					local
						l_repo: TEST_RECORD_REPOSITORY_I
					do
						l_repo := a_test_suite.record_repository
						l_repo.connection.connect_events (Current)
						l_repo.records.do_all (agent on_record_added (l_repo, ?))
					end)
		end

feature {NONE} -- Access

	grid: ES_GRID
			-- Grid displaying records in root rows

	records: DS_ARRAYED_LIST [like create_grid_row]
			-- List containing displayed records in displayed order

	record (a_session: G): H
			-- Retrieve record from session
			--
			-- Note: this routines serves as a type brigde between a session of type {G} providing records
			--       of type {H}.
			--
			-- `a_session': Session providing certain type of record displayed in `Current'.
		require
			a_session_attached: a_session /= Void
		deferred
		ensure
			result_valid: Result = a_session.record
		end

	record_row (a_record: like record): detachable like create_grid_row
			-- Return grid row for given `a_record' if it has been added yet. Ohterwise return row where
			-- given record should be added according to it's creation date. If Void is returned, the record
			-- should be added to the end of `grid'.
			--
			-- `a_record': Record for which corresponding wor should be returned.
		require
			a_record_attached: a_record /= Void
		local
			l_records: like records
			l_row: like create_grid_row
			l_row_record: like record
		do
			from
				l_records := records
				l_records.start
			until
				l_records.after
			loop
				l_row := l_records.item_for_iteration
				l_row_record := l_row.record
				if a_record = l_row_record then
					Result := l_row
					l_records.go_after
				else
					if a_record.creation_date < l_row_record.creation_date then
						if Result = Void or else Result.record.creation_date < l_row_record.creation_date then
							Result := l_row
						end
					end
					l_records.forth
				end
			end
		ensure
			result_valid: (Result = Void or else Result.record /= a_record) implies
				not records.there_exists (agent (a_row: like create_grid_row; a_r: like record): BOOLEAN
					do
						Result := a_row.record = a_r
					end (?, a_record))
		end

	icons_provider: ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
			-- Icons provider for testing tool icons.

	last_found_row: detachable like create_grid_row
			-- Last row found through `find_row'

feature {NONE} -- Element change

	add_record (a_record: like record; an_index: INTEGER)
			-- Add grid row for given record.
			--
			-- `a_record': New record to be displayed in `grid'.
			-- `an_index': Index in `grid' where new row should be located.
		require
			a_record_attached: a_record /= Void
			an_index_valid: 1 <= an_index and an_index <= grid.row_count + 1
			an_index_not_subrow: an_index <= grid.row_count implies grid.row (an_index).parent_row = Void
		local
			l_grid: like grid
			l_row: EV_GRID_ROW
			l_row_data: like create_grid_row
		do
			l_grid := grid
			l_grid.insert_new_row (an_index)
			l_row := l_grid.row (an_index)
			l_row_data := create_grid_row (a_record, l_row)
			records.force_last (l_row_data)
			l_row_data.rebuild
			last_found_row := l_row_data
		end

feature {NONE} -- Basic operations

	find_row (a_record: like record)
			-- Find grid row for `a_record' or add now row can be found. Store result in `last_found_row'.
			--
			-- `a_record': Record for which corresponding grid row shoul be stored in `last_found_row'.
		require
			a_record_attached: a_record /= Void
		local
			l_row: like record_row
		do
			l_row := record_row (a_record)
			if l_row = Void then
				add_record (a_record, grid.row_count + 1)
			elseif l_row.record /= a_record then
				add_record (a_record, l_row.row.index)
			else
				last_found_row := l_row
			end
		ensure
			last_found_row_valid: attached last_found_row as l_r and then l_r.record = a_record
		end

feature {TEST_SUITE_S} -- Events: test sutie

	on_typed_session_launched (a_test_suite: TEST_SUITE_S; a_session: G)
			-- <Precursor>
		local
			l_row: like last_found_row
		do
			Precursor (a_test_suite, a_session)
			if attached {G} a_session as l_session then
				find_row (record (l_session))
				l_row := last_found_row
				last_found_row := Void
				check l_row /= Void end
				if not l_row.is_running then
					l_row.attach_session (l_session)
				end
			end
		end

	on_typed_session_finished (a_test_suite: TEST_SUITE_S; a_session: G)
			-- <Precursor>
		local
			l_records: like records
			l_row: like create_grid_row
		do
			Precursor (a_test_suite, a_session)
			if attached {G} a_session as l_session then
				from
					l_records := records
					l_records.start
				until
					l_records.after
				loop
					l_row := l_records.item_for_iteration
					if l_row.is_running and then l_row.session = l_session then
						l_row.detach_session
						l_records.go_after
					else
						l_records.forth
					end
				end
			end
		end

feature {TEST_RECORD_REPOSITORY_I} -- Events: record repository

	on_record_added (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if attached {like record} a_record as l_record then
					-- Add record if not done yet.
				find_row (l_record)
				last_found_row := Void
			end
		end

	on_record_removed (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		local
			l_records: like records
			l_row_data: like create_grid_row
		do
			from
				l_records := records
				l_records.start
			until
				l_records.after
			loop
				l_row_data := l_records.item_for_iteration
				if l_row_data.record = a_record then
					grid.remove_row (l_row_data.row.index)
					l_records.remove_at
					l_records.go_after
				else
					l_records.forth
				end
			end
		end

feature {NONE} -- Factory

	create_notebook_widget: like widget
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

	create_grid_row (a_record: like record; a_row: EV_GRID_ROW): ES_TEST_RECORD_GRID_ROW [G, H]
			-- Create new grid row data
		require
			a_record_attached: a_record /= Void
			a_row_attached: a_row /= Void
		deferred
		ensure
			result_attached: Result /= Void
			result_uses_a_record: Result.record = a_record
			result_uses_a_row: Result.row = a_row
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET_NEW}
			records.do_all (agent {ES_TEST_RECORD_GRID_ROW [G, H]}.recycle)
		end

note
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
