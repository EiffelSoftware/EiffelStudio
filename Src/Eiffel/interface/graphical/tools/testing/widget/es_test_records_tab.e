note
	description: "[
		Notebook widgets which are capable of displaying test session records of a certain type.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_RECORDS_TAB [G -> TEST_SESSION_I, H -> TEST_SESSION_RECORD, J -> ES_TEST_RECORD_GRID_ROW [G, H] create make, make_running end]

inherit
	ES_TEST_SESSION_WIDGET [G]
		rename
			make as make_session_widget
		undefine
			internal_detach_entities
		redefine
			on_test_added,
			on_test_removed,
			on_before_initialize,
			on_after_initialized,
			internal_recycle
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
			on_record_removed,
			on_record_updated,
			on_record_property_updated
		end

feature {NONE} -- Initialization

	make (a_icons_provider: like icons_provider)
			-- Initialize `Current'.
			--
			-- `a_icons_provider': Icons provider for testing tool icons.
		require
			a_icons_provider_attached: a_icons_provider /= Void
		do
			icons_provider := a_icons_provider
			make_session_widget
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
			--l_grid.disable_selection_on_click

			l_grid.set_column_count_to (5)
			l_grid.enable_auto_size_best_fit_column (1)
			l_col := l_grid.column (1)
			l_col.header_item.set_text ("Results")

			l_col := l_grid.column (2)
			l_col.set_width (250)

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
			Precursor {ES_TEST_SESSION_WIDGET}
			create records.make_default
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET}
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

	grid: ES_TESTING_TOOL_GRID
			-- Grid displaying records in root rows

	records: DS_ARRAYED_LIST [J]
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

	record_row (a_record: like record): detachable J
			-- Return grid row for given `a_record' if it has been added yet. Ohterwise return row where
			-- given record should be added according to it's creation date. If Void is returned, the record
			-- should be added to the end of `grid'.
			--
			-- `a_record': Record for which corresponding wor should be returned.
		require
			a_record_attached: a_record /= Void
		local
			l_records: like records
			l_row: J
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
				not records.there_exists (agent (a_row: J; a_r: like record): BOOLEAN
					do
						Result := a_row.record = a_r
					end (?, a_record))
		end

	icons_provider: ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
			-- Icons provider for testing tool icons.

feature {TEST_SUITE_S} -- Events: test suite

	on_test_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		do
			Precursor (a_test_suite, a_test)
			records.do_all (
				agent (a_row: J; a_t: TEST_I)
					do
						a_row.on_test_added (a_t)
					end (?, a_test))
		end

	on_test_removed (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- <Precursor>
		do
			Precursor (a_test_suite, a_test)
			records.do_all (
				agent (a_row: J; a_t: TEST_I)
					do
						a_row.on_test_remove (a_t)
					end (?, a_test))
		end

feature {TEST_RECORD_REPOSITORY_I} -- Events: record repository

	on_record_added (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		local
			l_records: like records
			l_pos: INTEGER
			l_record_row, l_new: J
			l_done: BOOLEAN
		do
			if attached {H} a_record as l_record then
					-- Add record.
				l_records := records
				from
					l_records.start
				until
					l_records.after
				loop
					l_record_row := l_records.item_for_iteration
					if l_record_row.is_expanded and not l_record_row.is_running then
						l_record_row.row.collapse
					end
					l_records.forth
				end
				from
					l_records.start
					l_pos := 1
				until
					l_done
				loop
					if l_records.after then
						l_pos := grid.row_count + 1
						l_done := True
					else
						l_record_row := l_records.item_for_iteration
						if l_record_row.record < l_record then
							l_records.forth
						else
							l_pos := l_record_row.row.index
							l_done := True
						end
					end
				end
				grid.insert_new_row (l_pos)
				if l_record.is_running and then attached {G} l_record.session as l_session then
					create l_new.make_running (l_session, grid.row (l_pos), icons_provider)
				else
					create l_new.make (l_record, grid.row (l_pos), icons_provider)
				end
				l_records.put_left (l_new)
			end
		end

	on_record_removed (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		local
			l_records: like records
			l_row_data: J
		do
			if attached {H} a_record then
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
		end

	on_record_property_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if attached {H} a_record as l_record then
				update_record_row (l_record, False)
			end
		end

	on_record_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if attached {H} a_record as l_record then
				update_record_row (l_record, True)
			end
		end

feature {NONE} -- Implementation

	update_record_row (a_record: H; a_update_content: BOOLEAN)
			-- Update record row in `records' for given record.
			--
			-- `a_record': Record for which row should be updated.
			-- `a_update_content': True if contents (subwrows) should also be updated.
		require
			a_record_attached: a_record /= Void
		local
			l_records: like records
			l_row: J
			l_rebuild_content: BOOLEAN
		do
			from
				l_records := records
				l_records.start
			until
				l_records.after
			loop
				l_row := l_records.item_for_iteration
				if l_row.record = a_record then
					if not a_record.is_running then
							-- As an optimization, even if `a_update_content' is true we assume the row will update
							-- itself through the events of the running session `a_record.session'.
						if l_row.is_running then
							l_row.detach_session
						end
						l_rebuild_content := a_update_content
					end
					l_row.refresh
					if l_rebuild_content and l_row.is_expanded then
						l_row.clear_content
						l_row.show_content
					end
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

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor {ES_TEST_SESSION_WIDGET}
			records.do_all (
				agent (a_row: J)
					do
						a_row.recycle
					end)
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
