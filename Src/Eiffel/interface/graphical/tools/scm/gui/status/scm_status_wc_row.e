note
	description: "Summary description for {SCM_STATUS_WC_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_STATUS_WC_ROW

inherit
	ANY

	SCM_SHARED_RESOURCES
		undefine
			default_create, copy
		end

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

convert
	row: {EV_GRID_ROW}

feature {NONE} -- Initialization

	make (a_parent_grid: like parent_grid; a_root: like root_location; a_groups: STRING_TABLE [SCM_GROUP])
		do
			root_location := a_root
			groups := a_groups
		end

feature -- Access

	root_location: SCM_LOCATION

	groups: STRING_TABLE [SCM_GROUP]

	sorted_group_locations: detachable ARRAYED_LIST [PATH]
		local
			p: PATH
			l_sorter: QUICK_SORTER [PATH]
		do
			if attached groups as l_groups and then not l_groups.is_empty then
				create Result.make (l_groups.count)
				across
					l_groups as ic
				loop
					if ic.item.is_included then
						p := ic.item.location
						if across Result as ric some p.same_as (ric.item) end then
								-- Already in the list
						else
							Result.force (p)
						end
					end
				end
				if Result.is_empty then
					Result := Void
				elseif Result.count > 1 then
					create l_sorter.make (create {COMPARABLE_COMPARATOR [PATH]})
					l_sorter.sort (Result)
				end
			end
		end

	unversioned_files_included (a_grid: SCM_STATUS_GRID; a_location: PATH): BOOLEAN
		local
			g: SCM_GROUP
		do
			if a_grid.unversioned_files_included or repo_unversioned_files_included then
				Result := True
			elseif attached groups as l_groups and then not l_groups.is_empty then
				across
					l_groups as ic
				until
					Result
				loop
					g := ic.item
					if g.location.same_as (a_location) then
						Result := g.unversioned_files_included
					end
				end
			end
		end

	all_content_included: BOOLEAN

	repo_unversioned_files_included: BOOLEAN

feature {SCM_STATUS_CHANGE_ROW} -- Internal

	parent_grid: SCM_STATUS_GRID

	row: detachable EV_GRID_ROW

	scm_rows: detachable ARRAYED_LIST [EV_GRID_ROW]

feature -- Factory

	new_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			Result := parent_grid.new_label_item (a_text)
		end

	add_new_span_label_item_to (a_text: detachable READABLE_STRING_GENERAL; a_master_column: INTEGER; a_span_columns: ITERABLE [INTEGER]; a_row: EV_GRID_ROW)
		require
			a_row /= Void and then not a_row.is_destroyed
		do
			parent_grid.add_new_span_label_item_to (a_text, a_master_column, a_span_columns, a_row)
		end

	new_label_ellipsis_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ELLIPSIS_ITEM
		do
			if a_text /= Void then
				create Result.make_with_text (a_text)
			else
				create Result
			end
			parent_grid.set_label_item (Result)
		end

	new_checkable_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_CHECKABLE_LABEL_ITEM
		do
			Result := parent_grid.new_checkable_label_item (a_text)
		end

feature -- Execution

	attach_to_grid_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		do
			parent_grid := a_grid
			row := a_row
			a_row.set_data (Current)
			if a_row.parent /= Void then
				a_row.clear
--				a_row.set_background_color (Void)
			end
			populate_row (a_grid, a_row)
		end

	update
		do
			if attached parent_grid as g and attached row as r then
				if r.parent = g then
					g.remove_and_clear_subrows_from (r)
				end
				scm_rows := Void
				populate_row (g, r)
			end
		end

	populate_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		deferred
		end

	reset
		do
			if attached row as r and attached parent_grid as l_grid then
				r.set_item (l_grid.info_column, new_label_item (scm_names.label_resetting))
				l_grid.grid_remove_and_clear_subrows_from (r)
			end
		end

	update_statuses
		local
			r: EV_GRID_ROW
		do
			if attached row as l_row and attached parent_grid as l_grid then
				reset_changes_count
				across
					scm_rows as ic
				loop
					r := ic.item
					r.set_item (l_grid.info_column, new_label_item (scm_names.label_checking))
					l_grid.refresh_now
				end

				across
					scm_rows as ic
				loop
					r := ic.item
					ev_application.add_idle_action_kamikaze (agent  (i_row: EV_GRID_ROW; i_grid: SCM_STATUS_GRID)
						local
							sr: EV_GRID_ROW
							ch_row: SCM_STATUS_CHANGE_ROW
							st: SCM_STATUS
							s: STRING_32
							nb, unb: INTEGER
						do
							if
								attached parent_grid.scm_s.service as scm_service and then
								attached root_location as l_scm_root and then
								attached {PATH} i_row.data as l_scm_location and then
								attached l_scm_root.changes (l_scm_location, scm_service.config) as l_chgs
							then
								nb := l_chgs.changes_count
								if nb = 0 then
									i_row.hide
								elseif nb = 1 then
									i_row.show
								else
									i_row.show
								end
								s := scm_names.label_changes_count (nb)
								unb := l_chgs.unversioned_count
								if unb > 0 then
									s.append_string_general (" (")
									s.append_string (scm_names.label_unversioned)
									s.append_string_general (" ")
									s.append_string (unb.out)
									s.append_string_general (")")
								end
								i_row.set_item (i_grid.info_column, new_label_item (s))

								i_grid.grid_remove_and_clear_subrows_from (i_row)
								if
									nb > 0 or (unversioned_files_included (i_grid, l_scm_location) and unb > 0)
								then
									across
										l_chgs as ch_ic
									loop
										st := ch_ic.item
										if
											not attached {SCM_STATUS_UNVERSIONED} st
											or unversioned_files_included (i_grid, l_scm_location)
										then
											i_row.insert_subrow (i_row.subrow_count + 1)
											sr := i_row.subrow (i_row.subrow_count)
											create ch_row.make (Current, root_location, st)
											ch_row.attach_to_grid_row (i_grid, sr)
--											sr.set_data (st)

--											cb_lab := new_checkable_label_item (Void)
--											sr.set_item (i_grid.checkbox_column, cb_lab)

--											if attached st.location.entry as e then
--												rel_loc := e.name
--											else
--												rel_loc := l_scm_root.relative_location (st.location)
--											end
--											lab := new_label_item (rel_loc)
--											lab.set_data (st)

--											lab.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
--													do
--														if attached parent_grid as pg then
--															pg.open_file_location (i_loc)
--														end
--													end(st.location, ?,?,?,?,?,?,?,?)
--												)
--											sr.set_item (i_grid.filename_column, lab)

--											l_parent_lab := new_label_item (parent_path_name (rel_loc))
--											l_parent_lab.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
--													do
--														if attached parent_grid as pg then
--															pg.open_directory_location (i_loc)
--														end
--													end(st.location.parent, ?,?,?,?,?,?,?,?)
--												)
--											sr.set_item (i_grid.parent_column, l_parent_lab)

--											if attached {SCM_STATUS_UNVERSIONED} st then
--												lab.set_foreground_color (colors.disabled_foreground_color)
--												l_parent_lab.set_foreground_color (colors.disabled_foreground_color)
--											else
--												sr.set_item (i_grid.scm_column, new_label_item (st.status_as_string))
--												cb_lab.set_is_checked (True)
--												changes_count := changes_count + 1
--											end

--											cb_lab.set_data (st)
--											cb_lab.checked_changed_actions.extend (agent on_checkbox_change_checked (i_grid, ?))
											i_grid.fill_empty_grid_items (sr)
										end
									end
								end
								i_row.expand
							else
								i_row.set_item (i_grid.info_column, new_label_item ("..."))
							end
							on_change_checked (i_grid)
						end (r, l_grid))
				end
			end
		end

	on_checkbox_change_checked (a_grid: SCM_STATUS_GRID; a_cb: EV_GRID_CHECKABLE_LABEL_ITEM)
		do
			if a_cb.is_checked then
				increment_changes_count
			else
				decrement_changes_count
			end
			if attached a_cb.row as r and then attached {SCM_STATUS} r.data as st then
				if attached {EV_GRID_LABEL_ITEM} r.item (a_grid.filename_column) as glab then
					if a_cb.is_checked then
						if attached {SCM_STATUS_UNVERSIONED} st then
							glab.set_foreground_color (a_grid.stock_colors.dark_red)
						else
							glab.set_foreground_color (a_grid.foreground_color)
						end
					else
						glab.set_foreground_color (colors.disabled_foreground_color)
					end
				end
			end
			a_grid.on_changes_updated (Current)
		end

	on_change_checked (a_grid: SCM_STATUS_GRID)
		local
			i,n: INTEGER
			l_row: EV_GRID_ROW
		do
			reset_changes_count
			if attached parent_grid as l_grid then
				across
					scm_rows as ic
				loop
					l_row := ic.item
					from
						i := 1
						n := l_row.subrow_count
					until
						i > n
					loop
						if
							attached l_row.subrow (i) as l_subrow and then
							attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_subrow.item (l_grid.checkbox_column) as cb and then
							cb.is_checked
						then
							increment_changes_count
						end
						i := i + 1
					end
				end
			end
			a_grid.on_changes_updated (Current)
		end

	changes_count: INTEGER

	reset_changes_count
		do
			changes_count := 0
		end

	increment_changes_count
		do
			changes_count := changes_count + 1
		end

	decrement_changes_count
		do
			changes_count := changes_count - 1
		end

	changes: detachable SCM_CHANGELIST
			-- Last change list
		local
			i,n: INTEGER
			l_row: EV_GRID_ROW
		do
			if attached parent_grid as l_grid then
				create Result.make_with_location (root_location)
				across
					scm_rows as ic
				loop
					l_row := ic.item
					from
						i := 1
						n := l_row.subrow_count
					until
						i > n
					loop
						if
							attached l_row.subrow (i) as l_subrow and then
							attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_subrow.item (l_grid.checkbox_column) as cb and then
							cb.is_checked and then
							attached {SCM_STATUS} l_subrow.data as l_status
						then
							Result.extend_path (l_status.location)
						end
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- Implementation

	propagate_checkbox_state_to_subrows (cb: EV_GRID_CHECKABLE_LABEL_ITEM; a_opt_col: INTEGER)
		local
			i, n, j, k: INTEGER
			b: BOOLEAN
		do
			if attached cb.row as r then
				n := r.subrow_count
				if n > 0 then
					b := cb.is_checked
					from
						i := 1
					until
						i > n
					loop
						if attached r.subrow (i) as sr then
							if
								a_opt_col > 0 and then
								attached {EV_GRID_CHECKABLE_LABEL_ITEM} sr.item (a_opt_col) as sub_cb
							then
								sub_cb.set_is_checked (b)
							else
								from
									j := 1
									k := sr.count
								until
									j > k
								loop
									if attached {EV_GRID_CHECKABLE_LABEL_ITEM} sr.item (j) as sub_cb then
										sub_cb.set_is_checked (b)
									end
								end
								j := j + 1

							end
						end
						i := i + 1
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
